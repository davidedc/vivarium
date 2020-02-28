currentStrokeColor = 0xFF000000
doStroke = true
strokeStyle = [0.0, 0.0, 0.0, 1.0]

stroke = ->
  color = colorIntFromRGB.apply(this, arguments)
  if color == currentStrokeColor and doStroke
    return
  doStroke = true
  currentStrokeColor = color
  strokeStyle = colorIntToGLArray(currentStrokeColor)
  return

noStroke = ->
  doStroke = false
  return
