programObjectFaces = null
programObjectRects = null
programObjectLines = null
rectBuffer = null
faceBuffer = null
lineBuffer = null


createProgramObject = (curContext, vetexShaderSource, fragmentShaderSource) ->
  vertexShaderObject = curContext.createShader(curContext.VERTEX_SHADER)
  curContext.shaderSource vertexShaderObject, vetexShaderSource
  curContext.compileShader vertexShaderObject
  if !curContext.getShaderParameter(vertexShaderObject, curContext.COMPILE_STATUS)
    throw curContext.getShaderInfoLog(vertexShaderObject)
  fragmentShaderObject = curContext.createShader(curContext.FRAGMENT_SHADER)
  curContext.shaderSource fragmentShaderObject, fragmentShaderSource
  curContext.compileShader fragmentShaderObject
  if !curContext.getShaderParameter(fragmentShaderObject, curContext.COMPILE_STATUS)
    throw curContext.getShaderInfoLog(fragmentShaderObject)
  programObject = curContext.createProgram()
  curContext.attachShader programObject, vertexShaderObject
  curContext.attachShader programObject, fragmentShaderObject
  curContext.linkProgram programObject
  if !curContext.getProgramParameter(programObject, curContext.LINK_STATUS)
    throw 'Error linking shaders.'
  programObject

uniformMatrix = (cacheId, programObj, varName, transpose, matrix) ->
  varLocation = curContextCache.locations[cacheId]
  if !varLocation?
    varLocation = curContext.getUniformLocation(programObj, varName)
    curContextCache.locations[cacheId] = varLocation
  # The variable won't be found if it was optimized out.
  if varLocation != -1
    if matrix.length == 16
      curContext.uniformMatrix4fv varLocation, transpose, matrix
    else if matrix.length == 9
      curContext.uniformMatrix3fv varLocation, transpose, matrix
    else
      curContext.uniformMatrix2fv varLocation, transpose, matrix
  return
