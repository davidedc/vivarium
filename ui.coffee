addButton = (idNumber, name) ->
  element = document.createElement "input"
  element.setAttribute "type", "button"
  element.setAttribute "value", name
  element.setAttribute "name", idNumber
  element.setAttribute "onclick", "elementChosenByUserToBeAddedToWorld = parseInt(this.name);"
  document.getElementById("buttons-container").appendChild(element);
