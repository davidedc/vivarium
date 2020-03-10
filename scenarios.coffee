clearAllSlots = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Void"

scenario1 = ->
  particleAt[2][0][0] = elementName.indexOf "Wall"
  particleAt[0][4][0] = elementName.indexOf "Wall"
  particleAt[0][0][8] = elementName.indexOf "Wall"

scenario2 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][0] = elementName.indexOf "Fire"


scenario3 = ->
  particleAt[Math.round gridSizeX/2][Math.round gridSizeY/2][Math.round gridSizeZ/2] = elementName.indexOf "WaterFountain"

scenario4 = ->
  particleAt[Math.round gridSizeX/2][Math.round gridSizeY/2][Math.round gridSizeZ/2] = elementName.indexOf "OilFountain"

scenario5 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][0] = elementName.indexOf "Steam"

scenario6 = ->
  particleAt[0][0][Math.round gridSizeZ/2] = elementName.indexOf "WaterFountain"
  particleAt[gridSizeX-1][gridSizeX-1][Math.round gridSizeZ/2] = elementName.indexOf "OilFountain"

scenario7 = ->
  particleAt[0][0][Math.round gridSizeZ/2] = elementName.indexOf "WaterFountain"
  particleAt[gridSizeX-1][gridSizeX-1][Math.round gridSizeZ/2] = elementName.indexOf "OilFountain"
  particleAt[Math.round gridSizeX/2][Math.round gridSizeY/2][5] = elementName.indexOf "Torch"

scenario8 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...Math.round(gridSizeZ/2)]
        particleAt[x][y][z] = elementName.indexOf "Oil"

  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [Math.round(gridSizeZ/2)...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Water"

scenario9 = ->
  for x in [0...gridSizeX]
    for y in [0...Math.round(gridSizeY/2)]
      for z in [0...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Oil"

  for x in [0...gridSizeX]
    for y in [Math.round(gridSizeY/2)...gridSizeY]
      for z in [0...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Water"

scenario10 = ->
  for x in [0...gridSizeX]
    for y in [Math.round(gridSizeY/3)...Math.round(2*gridSizeY/3)]
      for z in [0...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Water"

scenario11 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...gridSizeZ]
        particleAt[x][y][z] = Math.floor(Math.random() * 10)

scenario12 = ->
  for x in [0...gridSizeX]
    for y in [0...Math.round(gridSizeY/2)]
      particleAt[x][y][Math.round(gridSizeY/3)] = elementName.indexOf "Wall"

  for x in [0...gridSizeX]
    for y in [Math.round(gridSizeY/2)...gridSizeY]
      particleAt[x][y][Math.round(2*gridSizeY/3)] = elementName.indexOf "Wall"

  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][0] = elementName.indexOf "Steam"

scenario13 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][0] = elementName.indexOf "Steam"

  for y in [0...gridSizeY]
    for x in [0...gridSizeX]
      particleAt[x][y][y] = elementName.indexOf "Wall"

scenario14 = ->
  for y in [0...Math.round(gridSizeY/2)]
    for x in [0...gridSizeX]
      for z in [0...y]
        particleAt[x][y][z] = elementName.indexOf "Steam"

  for y in [0...gridSizeY]
    for x in [0...gridSizeX]
      particleAt[x][y][y] = elementName.indexOf "Wall"

scenario15 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][gridSizeZ-1] = elementName.indexOf "Water"

  for y in [0...gridSizeY]
    for x in [0...gridSizeX]
      particleAt[x][y][y] = elementName.indexOf "Wall"

scenario16 = ->
  for y in [Math.round(gridSizeY/2)...gridSizeY]
    for x in [0...gridSizeX]
      for z in [y...gridSizeZ]
        particleAt[x][y][z] = elementName.indexOf "Water"

  for y in [0...gridSizeY]
    for x in [0...gridSizeX]
      particleAt[x][y][y] = elementName.indexOf "Wall"

scenario17 = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      particleAt[x][y][gridSizeZ-1] = elementName.indexOf "Water"

  for y in [0...Math.round(gridSizeY/2)-1]
    for x in [0...gridSizeX]
      particleAt[x][y][gridSizeY-y-1] = elementName.indexOf "Wall"

  for y in [Math.round(gridSizeY/2)+1...gridSizeY]
    for x in [0...gridSizeX]
      particleAt[x][y][y] = elementName.indexOf "Wall"

scenario18 = ->
  gridSpacing = 4
  for x in [1...gridSizeX]
    for y in [1...gridSizeY]
      for z in [1...gridSizeZ]
        if x % gridSpacing == 0 and y % gridSpacing == 0
          particleAt[x][y][z] = elementName.indexOf "Fuse"
        if x % gridSpacing == 0 and z % gridSpacing == 0
          particleAt[x][y][z] = elementName.indexOf "Fuse"
        if y % gridSpacing == 0 and z % gridSpacing == 0
          particleAt[x][y][z] = elementName.indexOf "Fuse"

  # just to check that the origin is perfectly in the middle
  # for x in [1...gridSizeX]
  #   particleAt[x][Math.round(gridSizeY/2)][Math.round(gridSizeZ/2)] = elementName.indexOf "Wall"

  particleAt[Math.round(gridSizeX/2)][Math.round(gridSizeY/2)][Math.round(gridSizeZ/2)] = elementName.indexOf "BurntFuse"

scenario19 = ->
  theMaterial = elementName.indexOf "Fuse"
  # the commented ifs below create a pattern that makes it easy to count
  # that the axes are completely symmetrical
  for x in [1...gridSizeX]
    #if x%2 then theMaterial = elementName.indexOf "Fuse" else theMaterial = elementName.indexOf "Wall"
    particleAt[x][Math.round(gridSizeY/2)][Math.round(gridSizeZ/2)] = theMaterial

  for y in [1...gridSizeY]
    #if y%2 then theMaterial = elementName.indexOf "Fuse" else theMaterial = elementName.indexOf "Wall"
    particleAt[Math.round(gridSizeX/2)][y][Math.round(gridSizeZ/2)] = theMaterial

  for z in [1...gridSizeY]
    #if z%2 then theMaterial = elementName.indexOf "Fuse" else theMaterial = elementName.indexOf "Wall"
    particleAt[Math.round(gridSizeX/2)][Math.round(gridSizeY/2)][z] = theMaterial

  # just to check that the origin is perfectly in the middle
  # for x in [1...gridSizeX]
  #   particleAt[x][Math.round(gridSizeY/2)][Math.round(gridSizeZ/2)] = elementName.indexOf "Wall"

  particleAt[Math.round(gridSizeX/2)][Math.round(gridSizeY/2)][Math.round(gridSizeZ/2)] = elementName.indexOf "BurntFuse"
