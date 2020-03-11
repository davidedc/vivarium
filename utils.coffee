# -------------------------------------------------------
# Routine to smooth values, used for camera movement
# it's a subtle change but it makes controls feel far more
# dynamic and polished.
# (adapted from http://phrogz.net/js/framerate-independent-low-pass-filter.html )
# -------------------------------------------------------

# To keep things simple and not drown in abstraction, we baked-in
# in this code that we are only smoothing six variables
# i.e. camera position and orientation vectors. It would be easy to
# make the code more generic, and yet it would be of no use and
# more opaque

smoothed = [0,0,0,0,0] # or some likely initial value
smoothing = [200,200,70,50,50] # or whatever is desired
smoothThreshold = [0.1,0.1,0.1,0,0] # or whatever is desired
startingTime = new Date
lastUpdate = [startingTime,startingTime,startingTime,startingTime,startingTime,startingTime]

smoothedValue = (newValue, whichVariable) ->
  now = new Date
  elapsedTime = now - lastUpdate[whichVariable]
  if Math.abs(smoothed[whichVariable]) < smoothThreshold[whichVariable]
    smoothed[whichVariable] = newValue
  else
    smoothed[whichVariable] += elapsedTime * (newValue - smoothed[whichVariable]) / smoothing[whichVariable]
  lastUpdate[whichVariable] = now
  smoothed[whichVariable]

smoothed_FWD = (newValue) ->
  smoothedValue newValue, 0

smoothed_SIDE = (newValue) ->
  smoothedValue newValue, 1

smoothed_UP = (newValue) ->
  smoothedValue newValue, 2

smoothed_YAW = (newValue) ->
  smoothedValue newValue, 3

smoothed_PITCH = (newValue) ->
  smoothedValue newValue, 4

# ------------------------------------------------------------

getGLContext = (canvas) ->
  ctxNames = [
    'experimental-webgl'
    'webgl'
    'webkit-3d'
  ]
  for eachCtxName in ctxNames
    gl = canvas.getContext(eachCtxName,
      antialias: false
      preserveDrawingBuffer: true)
    if gl
      break
  gl

curContext = null
curContextCache = { attributes: {}, locations: {} }

# These verts are used for the fill using TRIANGLE_FAN
rectVerts = new Float32Array([0,0,0, 0,1,0, 1,1,0, 1,0,0])

VERTS_PER_FACE = 6
MAX_FACES_PER_BATCH = 100
faceVerts = new Float32Array(Array.from(Array(MAX_FACES_PER_BATCH * VERTS_PER_FACE), (e, i)=>i))

size = (aWidth, aHeight) ->
  # Get the 3D rendering context.

  # If the HTML <canvas> dimensions differ from the
  # dimensions specified in the size() call in the sketch, for
  # 3D sketches, browsers will either not render or render the
  # scene incorrectly. To fix this, we need to adjust the
  # width and height attributes of the canvas.
  canvasElement.width = aWidth or 100
  canvasElement.height = aHeight or 100
  curContext = getGLContext(canvasElement)

  if !curContext
    throw 'WebGL context is not supported on this browser.'
  # Set defaults
  curContext.viewport 0, 0, canvasElement.width, canvasElement.height
  curContext.enable curContext.DEPTH_TEST
  curContext.enable curContext.BLEND
  curContext.blendFunc curContext.SRC_ALPHA, curContext.ONE_MINUS_SRC_ALPHA
  # Create the program objects to render 2D (lines) and
  # 3D (rect) shapes. Because 2D shapes are not lit,
  # lighting calculations are ommitted from this program object.
  programObjectLines = createProgramObject(curContext, vertexShaderSrcLines, fragmentShaderSrcLines)
  # used to draw the rectangle
  programObjectRects = createProgramObject(curContext, vertexShaderSrcRects, fragmentShaderSrcRects)
  curContext.useProgram programObjectRects
  rectBuffer = curContext.createBuffer()
  curContext.bindBuffer curContext.ARRAY_BUFFER, rectBuffer
  curContext.bufferData curContext.ARRAY_BUFFER, rectVerts, curContext.STATIC_DRAW
  programObjectFaces = createProgramObject(curContext, vertexShaderSrcFaces, fragmentShaderSrcFaces)
  curContext.useProgram programObjectFaces
  # used to draw faces
  faceBuffer = curContext.createBuffer()
  curContext.bindBuffer curContext.ARRAY_BUFFER, faceBuffer
  curContext.bufferData curContext.ARRAY_BUFFER, faceVerts, curContext.STATIC_DRAW
  # Set some defaults.
  # used to draw the lines
  lineBuffer = curContext.createBuffer()
  cam = new Matrix4x4
  modelView = new Matrix4x4
  projection = new Matrix4x4
  camera()
  perspective()
  # remove the style width and height properties to ensure that the canvas gets set to
  # aWidth and aHeight coming in
  if canvasElement.style.length > 0
    canvasElement.style.removeProperty 'width'
    canvasElement.style.removeProperty 'height'
  canvasElement.width = aWidth or 100
  canvasElement.height = aHeight or 100
