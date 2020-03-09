# Keyboard Events - in particular keeping track
# of which keys are _being_ pressed since we look
# at those in the tick loop

isKeyPressed = {}

handleKeydown = (e) ->
  isKeyPressed[e.which + ""] = true
  return true


handleKeyup = (e) ->
  if isKeyPressed[e.which + ""]
    delete isKeyPressed[e.which + ""]

  # All of these keys don't trigger a keypress event,
  # so we'll have to handle them here

  # Backspace or delete
  if e.key == 'Backspace' or e.key == 'Delete'
    if rayCastSlot[0] != -1
      particleAt[rayCastSlot[0]][rayCastSlot[1]][rayCastSlot[2]] = 0

  return true

keyPressed = (e) ->
  key = e.key

  if key == 'o'
    pitch = 0
    yaw = 0
    cameraX = 0
    cameraY = 0
    cameraZ = 0
  if key == 'p'
    pauseReactionsAndMotion = !pauseReactionsAndMotion

  if key == '1'
    bringUpElementList "gas"

  if key == '2'
    bringUpElementList "liquid"

  if key == '3'
    bringUpElementList "solid"

  if key == '4'
    bringUpElementList "flammable"

  if key == 'e'
    if currentlyOpenModal == examplesModal
      examplesSelectList.selectedIndex = (examplesSelectList.selectedIndex + examplesSelectList.length - 1) % examplesSelectList.length
    else
      elementSelectList.selectedIndex = (elementSelectList.selectedIndex + elementSelectList.length - 1) % elementSelectList.length
      updateChosenItemBasedOnSelect()

  if key == 'r'
    if currentlyOpenModal == examplesModal
      examplesSelectList.selectedIndex = (examplesSelectList.selectedIndex + 1) % examplesSelectList.length
    else
      elementSelectList.selectedIndex = (elementSelectList.selectedIndex + 1) % elementSelectList.length
      updateChosenItemBasedOnSelect()



window.addEventListener 'keydown', handleKeydown
window.addEventListener 'keypress', keyPressed
window.addEventListener 'keyup', handleKeyup
