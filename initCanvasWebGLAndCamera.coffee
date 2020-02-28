elementChosenByUserToBeAddedToWorld = 0

render_t0 = 0
render_tf = 0
particlesReactions_t0 = 0
particlesReactions_tf = 0
particlesMotion_t0 = 0
particlesMotion_tf = 0
instrumentation_countParticles_t0 = 0
instrumentation_countParticles_tf = 0
last_fps_count_time = 0

canvasWidth = 640
canvasHeight = 480

rayCastSlot = [0,0,0]
justInFrontOfRayCastSlot = [0,0,0]


particleAt = newArray gridSizeX, gridSizeY, gridSizeZ, 0
particleNextTickAt = newArray gridSizeX, gridSizeY, gridSizeZ, 0

pauseRendering = false
pauseReactionsAndMotion = false

FACE_RIGHT = 0
FACE_LEFT = 1
FACE_BOTTOM = 2
FACE_TOP = 3
FACE_FRONT = 4
FACE_BACK = 5

initCanvasWebGLAndCamera = ->
  # kicking things off
  size canvasWidth, canvasHeight
  fov = Math.PI / 3.0
  cameraZ = canvasHeight / 2.0 / Math.tan(fov / 2.0)
  perspective fov, canvasWidth / canvasHeight, cameraZ / 105.0, cameraZ * 15.0

  # pick some reasonable initial positioning of the camera
  # in this case it's a frontal view looking up the x axis  
  cameraX = -29
  cameraY = 15.5
  cameraZ = 16
  pitch = 0
  yaw = 0
