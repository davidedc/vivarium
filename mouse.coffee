canvasElement.addEventListener 'contextmenu', (e) ->
  e.preventDefault()
  e.stopPropagation()

previousMouseX = 0
previousMouseY = 0
mouseX = 0
mouseY = 0

canvasElement.addEventListener 'mousemove', (e) ->
  previousMouseX = mouseX
  previousMouseY = mouseY

  mouseX = e.offsetX
  mouseY = e.offsetY

  if e.buttons == 1 then mouseDraggedLeftButton()
  return

canvasElement.addEventListener 'mousedown', (e) ->
  if e.buttons == 2
    if justInFrontOfRayCastSlot[0] != -1 and elementChosenByUserToBeAddedToWorld != 0
      particleAt[justInFrontOfRayCastSlot[0]][justInFrontOfRayCastSlot[1]][justInFrontOfRayCastSlot[2]] = elementChosenByUserToBeAddedToWorld

mouseDraggedLeftButton = ->
  deltaX = (previousMouseX - mouseX) * invertHorizMouseDrag
  deltaY = (previousMouseY - mouseY) * invertHorizMouseDrag * -1

  yaw = yaw + deltaX * mouseSensitivity 
  pitch = pitch + deltaY * mouseSensitivity
