background = (arg1, arg2, arg3) ->
  if arg1 instanceof Array
    backgroundObj = colorIntFromRGB(arg1[0], arg1[1], arg1[2])
  else
    backgroundObj = colorIntFromRGB(arg1, arg2, arg3)
  c = colorIntToGLArray(backgroundObj)
  curContext.clearColor c[0], c[1], c[2], c[3]
  curContext.clear curContext.COLOR_BUFFER_BIT | curContext.DEPTH_BUFFER_BIT
  curContext.disable curContext.CULL_FACE
