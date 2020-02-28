line = (x1, y1, z1, x2, y2, z2) ->
  lineVerts = [ x1, y1, z1, x2, y2, z2]
  view = new Matrix4x4
  view.apply modelView.array()
  view.transpose()
  if doStroke
    curContext.useProgram programObjectLines
    uniformMatrix 'uView2d', programObjectLines, 'uView', false, view.array()
    uniformf 'uColor2d', programObjectLines, 'uColor', strokeStyle, 4
    vertexAttribPointer 'aVertex2d', programObjectLines, 'aVertex', 3, lineBuffer
    # STREAM_DRAW means you are going to create it once, set it once, use it once
    curContext.bufferData curContext.ARRAY_BUFFER, new Float32Array(lineVerts), curContext.STREAM_DRAW
    curContext.drawArrays curContext.LINES, 0, 2
  return

dottedLine = (segments, extremeSegments, x1, y1, z1, x2, y2, z2) ->
  prevDotX = x1
  prevDotY = y1
  prevDotZ = z1
  for i in [0...segments]
    newDotX = (x1+i*(x2-x1)/(segments))
    newDotY = (y1+i*(y2-y1)/(segments))
    newDotZ = (z1+i*(z2-z1)/(segments))
    if i%2 or i < extremeSegments or i > segments - extremeSegments
      line prevDotX, prevDotY, prevDotZ, newDotX, newDotY, newDotZ
    prevDotX = newDotX
    prevDotY = newDotY
    prevDotZ = newDotZ

  line prevDotX, prevDotY, prevDotZ, x2,y2,z2

  return

containerBox = (origX, origY, origZ, sizeX, sizeY, sizeZ) ->

  # Bottom rect #######################################
  fill 10,10,10
  rect origX+1, origY+1, origZ, sizeX-2, sizeY-2
  noFill()
  rect origX, origY, origZ, sizeX, sizeY

  if doStroke

    noFill()
    segments = 100
    extremeSegments = 10

    # Top rect #########################################
    if (cameraZ < (origZ+sizeZ) or !( cameraX < 0 ) )
      dottedLine segments, extremeSegments, origX, origY, (origZ+sizeZ), origX, (origY+sizeY), (origZ+sizeZ) # Z Y
    if (cameraZ < (origZ+sizeZ) or !( cameraX > origX+sizeX ) )
      dottedLine segments, extremeSegments, (origX+sizeX), origY, (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Z Y
    if (cameraZ < (origZ+sizeZ) or !( cameraY > origY+sizeY ) )
      dottedLine segments, extremeSegments, origX, (origY+sizeY), (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # Y Z X
    if (cameraZ < (origZ+sizeZ) or !( cameraY < 0 ) )
      dottedLine segments, extremeSegments, origX, origY, (origZ+sizeZ), (origX+sizeX), origY, (origZ+sizeZ) # Z X

    # The four remaining vertical lines ################
    if !(cameraX < 0 and cameraY < 0)
      dottedLine segments, extremeSegments, origX, origY, origZ, origX, origY, (origZ+sizeZ) # Z
    if !(cameraX < 0 and cameraY > origY+sizeY)
      dottedLine segments, extremeSegments, origX, (origY+sizeY), origZ, origX, (origY+sizeY), (origZ+sizeZ) # Y Z
    if !(cameraX > origX+sizeX and cameraY < 0 )
      dottedLine segments, extremeSegments, (origX+sizeX), origY, origZ, (origX+sizeX), origY, (origZ+sizeZ) # X Z
    if !(cameraX > origX+sizeX and cameraY > origY+sizeY)
      dottedLine segments, extremeSegments, (origX+sizeX), (origY+sizeY), origZ, (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Y Z

boxDottedStroke = (segments, origX, origY, origZ, sizeX, sizeY, sizeZ) ->
  if doStroke

    noFill()

    extremeSegments = 0

    # Bottom rect #######################################
    dottedLine segments, extremeSegments, origX, origY, origZ, (origX+sizeX), origY, origZ # X
    dottedLine segments, extremeSegments, origX, origY, origZ, origX, (origY+sizeY), origZ # Y
    dottedLine segments, extremeSegments, origX, (origY+sizeY), origZ, (origX+sizeX), (origY+sizeY), origZ # Y X
    dottedLine segments, extremeSegments, (origX+sizeX), origY, origZ, (origX+sizeX), (origY+sizeY), origZ # X Y

    # Top rect #########################################
    dottedLine segments, extremeSegments, origX, origY, (origZ+sizeZ), origX, (origY+sizeY), (origZ+sizeZ) # Z Y
    dottedLine segments, extremeSegments, (origX+sizeX), origY, (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Z Y
    dottedLine segments, extremeSegments, origX, (origY+sizeY), (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # Y Z X
    dottedLine segments, extremeSegments, origX, origY, (origZ+sizeZ), (origX+sizeX), origY, (origZ+sizeZ) # Z X

    # The four remaining vertical lines ################
    dottedLine segments, extremeSegments, origX, origY, origZ, origX, origY, (origZ+sizeZ) # Z
    dottedLine segments, extremeSegments, origX, (origY+sizeY), origZ, origX, (origY+sizeY), (origZ+sizeZ) # Y Z
    dottedLine segments, extremeSegments, (origX+sizeX), origY, origZ, (origX+sizeX), origY, (origZ+sizeZ) # X Z
    dottedLine segments, extremeSegments, (origX+sizeX), (origY+sizeY), origZ, (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Y Z


boxStroke = (origX, origY, origZ, sizeX, sizeY, sizeZ) ->
  if doStroke

    noFill()

    # Bottom rect #######################################
    rect origX, origY, origZ, sizeX, sizeY
    # equivalent to
    # line origX, origY, origZ, (origX+sizeX), origY, origZ # X
    # line origX, origY, origZ, origX, (origY+sizeY), origZ # Y
    # line origX, (origY+sizeY), origZ, (origX+sizeX), (origY+sizeY), origZ # Y X
    # line (origX+sizeX), origY, origZ, (origX+sizeX), (origY+sizeY), origZ # X Y

    # Top rect #########################################
    rect origX, origY, origZ + sizeZ, sizeX, sizeY
    # equivalent to
    # line origX, origY, (origZ+sizeZ), origX, (origY+sizeY), (origZ+sizeZ) # Z Y
    # line (origX+sizeX), origY, (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Z Y
    # line origX, (origY+sizeY), (origZ+sizeZ), (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # Y Z X
    # line origX, origY, (origZ+sizeZ), (origX+sizeX), origY, (origZ+sizeZ) # Z X

    # The four remaining vertical lines ################
    line origX, origY, origZ, origX, origY, (origZ+sizeZ) # Z
    line origX, (origY+sizeY), origZ, origX, (origY+sizeY), (origZ+sizeZ) # Y Z
    line (origX+sizeX), origY, origZ, (origX+sizeX), origY, (origZ+sizeZ) # X Z
    line (origX+sizeX), (origY+sizeY), origZ, (origX+sizeX), (origY+sizeY), (origZ+sizeZ) # X Y Z

rect = (x, y, z, width, height) ->
  # Modeling transformation
  model = new Matrix4x4
  model.translate x, y, z
  model.scale width, height, 1
  model.transpose()

  view = new Matrix4x4
  view.apply modelView.array()
  view.transpose()
  curContext.useProgram programObjectRects
  uniformMatrix 'uModelRect', programObjectRects, 'uModel', false, model.array()
  uniformMatrix 'uViewRect', programObjectRects, 'uView', false, view.array()

  if doFill
    uniformf 'colorRect', programObjectRects, 'uColor', fillStyle, 4
  else if doStroke
    uniformf 'colorRect', programObjectRects, 'uColor', strokeStyle, 4

  vertexAttribPointer 'vertexRect', programObjectRects, 'aVertex', 3, rectBuffer

  if doFill
    curContext.drawArrays curContext.TRIANGLE_FAN, 0, rectVerts.length / 3
  else if doStroke
    curContext.drawArrays curContext.LINE_LOOP, 0, rectVerts.length / 3

  return

facesInBatchSoFar = 0
uElementIDAndSide = new Int32Array(new Array(MAX_FACES_PER_BATCH*2).fill(0))
XYZs = new Int32Array(new Array(MAX_FACES_PER_BATCH*3).fill(0))

face = (element, whichSide, x, y, z) ->
  #return this.rect(width,height);
  uElementIDAndSide[facesInBatchSoFar * 2] = element
  uElementIDAndSide[facesInBatchSoFar * 2 + 1] = whichSide
  XYZs[facesInBatchSoFar * 3] = x
  XYZs[facesInBatchSoFar * 3 + 1] = y
  XYZs[facesInBatchSoFar * 3 + 2] = z
  facesInBatchSoFar++
  if facesInBatchSoFar == MAX_FACES_PER_BATCH
    @flushFaces()
  return

flushFaces = ->
  if facesInBatchSoFar == 0
    return
  #return this.rect(width,height);

  view = new Matrix4x4
  view.apply modelView.array()
  view.transpose()
  curContext.useProgram programObjectFaces
  uniformMatrix 'uViewFace', programObjectFaces, 'uView', false, view.array()
  uniformi 'uElementIDAndSide', programObjectFaces, 'uElementIDAndSide', uElementIDAndSide, 2
  uniformi 'uXYZ', programObjectFaces, 'uXYZ', XYZs, 3
  uniformi 'uElementsColors', programObjectFaces, 'uElementsColors', uElementsColors, 3
  vertexAttribPointer 'vertexFace', programObjectFaces, 'aVertex', 1, faceBuffer
  curContext.drawArrays curContext.TRIANGLES, 0, facesInBatchSoFar * 6
  i = 0
  while i < 2 * facesInBatchSoFar
    uElementIDAndSide[i] = 0
    i++
  facesInBatchSoFar = 0
  return
