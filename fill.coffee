currentFillColor = 0xFFFFFFFF
doFill = true
fillStyle = [1.0, 1.0, 1.0, 1.0]

fill = ->
  color = colorIntFromRGB.apply(this, arguments)
  if color == currentFillColor and doFill
    return
  doFill = true
  currentFillColor = color
  fillStyle = colorIntToGLArray(currentFillColor)

noFill = ->
  doFill = false
