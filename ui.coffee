elementChosenByUserToBeAddedToWorld = 0

chooseElementByName = (name) ->
  elementChosenByUserToBeAddedToWorld = elementName.indexOf name

updateChosenItemBasedOnSelect = ->
  chooseElementByName elementSelectList.item(elementSelectList.selectedIndex).text

userManuallyClickedOnSelectListEntry = ->
  updateChosenItemBasedOnSelect()

addElementButton = (idNumber, name) ->
  element = document.createElement "input"
  element.setAttribute "type", "button"
  element.setAttribute "value", name
  element.setAttribute "name", idNumber
  element.setAttribute "onclick", "chooseElementByName(this.value);"
  document.getElementById("buttons-container").appendChild(element)

addTagButton = (idNumber, name) ->
  element = document.createElement "input"
  element.setAttribute "type", "button"
  element.setAttribute "value", name
  element.setAttribute "name", idNumber
  element.setAttribute "onclick", "tagButtonPressed(this.value);"
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

  currentElementList = name


tagButtonPressed = (name) ->
  bringUpElementList name

initUI = ->
  for i in [0...elementName.length]
    addElementButton i, elementName[i]

  i = 0
  for eachTag from tags
    addTagButton i, eachTag
    i++
