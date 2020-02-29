elementColor = newArray elementsCount, null
elementDensity = newArray elementsCount, 0.0
reactionOptions = newArray elementsCount, elementsCount, -1
neighborProbability = newArray elementsCount, elementsCount, 0.0
transmutationProbability = newArray elementsCount, 0.0
transmutationTo = newArray elementsCount, 0
verticalMotionProbability = newArray elementsCount, 0.0
horizontalMotionProbability = newArray elementsCount, 0.0
elementName = newArray elementsCount, ""
uElementsColors = new Int32Array(new Array(elementsCount*3).fill(0))

tags = new Set
elementsInTag = {}

initMainDataStructures = (elementColor, elementDensity, reactionOptions, neighborProbability, transmutationProbability, verticalMotionProbability, horizontalMotionProbability, elementName) ->
  i = 0
  for own key, value of elements
    elementName[i] = key
    elementColor[i] = value.rgb
    elementDensity[i] = value.density

    # take care of elemements' tags
    if value.tags?
      for eachTag in value.tags
        tags.add eachTag
        if !elementsInTag[eachTag]?
          elementsInTag[eachTag] = new Set
        elementsInTag[eachTag].add key

    if i > 0
      uElementsColors[3*(i-1) + 0] = elementColor[i][0]
      uElementsColors[3*(i-1) + 1] = elementColor[i][1]
      uElementsColors[3*(i-1) + 2] = elementColor[i][2]
    i++

  for own key, value of elements
    if value.nextToThese?
      neighborArg1 = elementName.indexOf key
      for i in [0...value.nextToThese.length]
        neighborArg2 = elementName.indexOf value.nextToThese[i]
        neighborArg3 = elementName.indexOf value.becomesRespectivelyThis[i]
        neighborArg4 = value.withRespectiveProbs[i]
        reactionOptions[neighborArg1][neighborArg2] = neighborArg3
        neighborProbability[neighborArg1][neighborArg2] = neighborArg4

    if value.transmutatesTo?
      transmutatingElement = elementName.indexOf key
      transmutationProbability[transmutatingElement] = value.transmutationProb
      transmutationTo[transmutatingElement] = elementName.indexOf value.transmutatesTo
 
    if value.verticalMoveProb?
      movingElement = elementName.indexOf key
      verticalMotionProbability[movingElement] = value.verticalMoveProb
      horizontalMotionProbability[movingElement] = value.horizontalMoveProb

initMainDataStructures elementColor, elementDensity, reactionOptions, neighborProbability, transmutationProbability, verticalMotionProbability, horizontalMotionProbability, elementName
initUI()
