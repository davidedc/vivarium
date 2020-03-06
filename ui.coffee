elementChosenByUserToBeAddedToWorld = 0
lastSelectedForTag = {}

chooseElementByName = (name) ->
  elementChosenByUserToBeAddedToWorld = elementName.indexOf name

updateChosenItemBasedOnSelect = ->
  selectedTag = elementSelectList.item(elementSelectList.selectedIndex).text
  lastSelectedForTag[currentElementList] = elementSelectList.selectedIndex
  chooseElementByName selectedTag

userManuallyClickedOnSelectListEntry = ->
  updateChosenItemBasedOnSelect()

addElementButton = (idNumber, name) ->
  element = document.createElement "input"
  element.setAttribute "type", "button"
  element.setAttribute "value", name
  element.setAttribute "name", idNumber
  element.setAttribute "onclick", "chooseElementByName(this.value);"
  document.getElementById("buttons-container").appendChild(element)

addTagButton = (name, label) ->
  element = document.createElement "input"
  element.setAttribute "type", "button"
  element.setAttribute "value", label
  element.setAttribute "name", name
  element.setAttribute "onclick", "tagButtonPressed(this.name);"
  element.setAttribute("class", "myButton")
  document.getElementById("buttons-container").appendChild(element)

currentElementList = null
elementSelectList = document.getElementById("elementSelectList").options

bringUpElementList = (name) ->

  # don't fiddle with the select if there is no need to
  if currentElementList == name then return

  for i in [0...elementSelectList.length]
    elementSelectList.remove 0

  for i from elementsInTag[name]
    newOption = document.createElement("option")
    newOption.text = i
    elementSelectList.add newOption

  if lastSelectedForTag[name]?
    elementSelectList.selectedIndex = lastSelectedForTag[name]

  currentElementList = name

  if elementSelectList.selectedIndex == -1
    elementSelectList.selectedIndex = 0
  updateChosenItemBasedOnSelect()


tagButtonPressed = (name) ->
  bringUpElementList name

initUI = ->
  if DEBUG_UI
    for i in [0...elementName.length]
      addElementButton i, elementName[i]

  addTagButton "gas", "gases [1]"
  addTagButton "liquid", "liquids [2]"
  addTagButton "solid", "solids [3]"
  addTagButton "flammable", "flammables [4]"

# ------------------------------------------------------------------------------
#        the modals
# ------------------------------------------------------------------------------

currentlyOpenModal = null

# Get the modal
keyboardMouseHelpModal = document.getElementById('keyboardMouseHelpModal')
# Get the button that opens the modal
navigationHelpButton = document.getElementById('navigationHelpButton')
# Get the <span> element that closes the modal
closeSpan = document.getElementsByClassName('close')[0]

# When the user clicks on the button, open the modal
navigationHelpButton.onclick = ->
  keyboardMouseHelpModal.style.display = 'block'
  currentlyOpenModal = keyboardMouseHelpModal
  return

# A button in the navigation help to close the modal:
navigationHelpCloseButton = document.getElementById('navigationHelpCloseButton')
navigationHelpCloseButton.onclick = ->
  keyboardMouseHelpModal.style.display = 'none'
  currentlyOpenModal = null
  return


# When the user clicks on <span> (x), close the modal

closeSpan.onclick = ->
  keyboardMouseHelpModal.style.display = 'none'
  currentlyOpenModal = null
  return

# ------------------------------------------------------------------------------

# Get the modal
examplesModal = document.getElementById('examplesModal')
# Get the button that opens the modal
examplesButton = document.getElementById('examplesButton')
# Get the <span> element that closes the modal
closeSpan = document.getElementsByClassName('close')[1]

# When the user clicks on the button, open the modal
examplesButton.onclick = ->
  examplesModal.style.display = 'block'
  currentlyOpenModal = examplesModal
  return

# A button in the navigation help to close the modal:
examplesModalCloseButton = document.getElementById('examplesModalCloseButton')
examplesModalCloseButton.onclick = ->
  examplesModal.style.display = 'none'
  currentlyOpenModal = null
  return


# When the user clicks on <span> (x), close the modal

closeSpan.onclick = ->
  examplesModal.style.display = 'none'
  currentlyOpenModal = null
  return

# common to all modals ------------------------------------------

# When the user clicks anywhere outside of the modal, close it

window.onclick = (event) ->
  if event.target == keyboardMouseHelpModal
    keyboardMouseHelpModal.style.display = 'none'
    currentlyOpenModal = null
  else if event.target == examplesModal
    examplesModal.style.display = 'none'
    currentlyOpenModal = null
  return
