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

# When the user clicks on the button, open the modal
openKeyboardMouseHelpModal = ->
  keyboardMouseHelpModal.style.display = 'block'
  currentlyOpenModal = keyboardMouseHelpModal
  return

dismissNavigationHelpModal = ->
  dismissModal keyboardMouseHelpModal

# ------------------------------------------------------------------------------

# Get the modal
examplesModal = document.getElementById('examplesModal')

openExamplesModal = ->
  examplesModal.style.display = 'block'
  currentlyOpenModal = examplesModal
  document.getElementById("examplesSelectList").focus()
  return

startSelectedExample = ->
  examplesSelectList = document.getElementById("examplesSelectList").options
  window[examplesSelectList.item(examplesSelectList.selectedIndex).value].call()

dismissExamplesModal = ->
  dismissModal examplesModal

startSelectedExampleAndDismissExamplesModal = ->
  startSelectedExample()
  dismissExamplesModal()  


# common to all modals ------------------------------------------

# When the user clicks anywhere outside of the modal, close it

window.onclick = (event) ->
  if event.target == keyboardMouseHelpModal or event.target == examplesModal
    dismissModal event.target

dismissModal = (whichModal) ->
  whichModal.style.display = 'none'
  currentlyOpenModal = null
