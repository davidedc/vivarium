perspective = (fov, aspect, near, far) ->
  if arguments.length == 0
    #in case canvas is resized
    cameraY = canvasElement.height / 2
    cameraZ = cameraY / Math.tan(cameraFOV / 2)
    cameraNear = cameraZ / 10
    cameraFar = cameraZ * 10
    cameraAspect = canvasWidth / canvasHeight
    fov = cameraFOV
    aspect = cameraAspect
    near = cameraNear
    far = cameraFar
  yMax = undefined
  yMin = undefined
  xMax = undefined
  xMin = undefined
  yMax = near * Math.tan(fov / 2)
  yMin = -yMax
  xMax = yMax * aspect
  xMin = yMin * aspect
  frustum xMin, xMax, yMin, yMax, near, far

frustum = (left, right, bottom, top, near, far) ->
  frustumMode = true
  projection = new Matrix4x4
  projection.set 2 * near / (right - left), 0, (right + left) / (right - left), 0, 0, 2 * near / (top - bottom), (top + bottom) / (top - bottom), 0, 0, 0, -(far + near) / (far - near), -(2 * far * near) / (far - near), 0, 0, -1, 0
  proj = new Matrix4x4
  proj.set projection
  proj.transpose()
  curContext.useProgram programObjectLines
  uniformMatrix 'projectionLine', programObjectLines, 'uProjection', false, proj.array()
  curContext.useProgram programObjectRects
  uniformMatrix 'projectionRect', programObjectRects, 'uProjection', false, proj.array()
  curContext.useProgram programObjectFaces
  uniformMatrix 'projectionFace', programObjectFaces, 'uProjection', false, proj.array()
