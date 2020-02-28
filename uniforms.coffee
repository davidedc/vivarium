###
# Sets a uniform variable in a program object to a particular
# value. Before calling this function, ensure the correct
# program object has been installed as part of the current
# rendering state by calling useProgram.
#
# On some systems, if the variable exists in the shader but isn't used,
# the compiler will optimize it out and this function will fail.
#
# @param {String} cacheId
# @param {WebGLProgram} programObj program object returned from
# createProgramObject
# @param {String} varName the name of the variable in the shader
# @param {float | Array} varValue either a scalar value or an Array
#
# @returns none
#
# @see uniformi
# @see uniformMatrix
###

uniformf = (cacheId, programObj, varName, varValue, eachVectorLength) ->
  varLocation = curContextCache.locations[cacheId]
  if !varLocation?
    varLocation = curContext.getUniformLocation(programObj, varName)
    curContextCache.locations[cacheId] = varLocation
  # the variable won't be found if it was optimized out.
  if varLocation != null
    if eachVectorLength == 4
      curContext.uniform4fv varLocation, varValue
    else if eachVectorLength == 3
      curContext.uniform3fv varLocation, varValue
    else if eachVectorLength == 2
      curContext.uniform2fv varLocation, varValue
    else
      curContext.uniform1f varLocation, varValue
  return

###*
# Sets a uniform int or int array in a program object to a particular
# value. Before calling this function, ensure the correct
# program object has been installed as part of the current
# rendering state.
#
# On some systems, if the variable exists in the shader but isn't used,
# the compiler will optimize it out and this function will fail.
#
# @param {String} cacheId
# @param {WebGLProgram} programObj program object returned from
# createProgramObject
# @param {String} varName the name of the variable in the shader
# @param {int | Array} varValue either a scalar value or an Array
#
# @returns none
#
# @see uniformf
# @see uniformMatrix
###

uniformi = (cacheId, programObj, varName, varValue, eachVectorLength) ->
  varLocation = curContextCache.locations[cacheId]
  if !varLocation?
    varLocation = curContext.getUniformLocation(programObj, varName)
    curContextCache.locations[cacheId] = varLocation
  # the variable won't be found if it was optimized out.
  if varLocation != null
    if eachVectorLength == 4
      curContext.uniform4iv varLocation, varValue
    else if eachVectorLength == 3
      curContext.uniform3iv varLocation, varValue
    else if eachVectorLength == 2
      curContext.uniform2iv varLocation, varValue
    else
      curContext.uniform1i varLocation, varValue
  return

vertexAttribPointer = (cacheId, programObj, varName, size, VBO) ->
  varLocation = curContextCache.attributes[cacheId]
  if !varLocation?
    varLocation = curContext.getAttribLocation(programObj, varName)
    curContextCache.attributes[cacheId] = varLocation
  if varLocation != -1
    curContext.bindBuffer curContext.ARRAY_BUFFER, VBO
    curContext.vertexAttribPointer varLocation, size, curContext.FLOAT, false, 0, 0
    curContext.enableVertexAttribArray varLocation
  return
