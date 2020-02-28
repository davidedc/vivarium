particlesMotion = ->

  if Math.random() < 0.5
    xOrder = [0...gridSizeX]
  else
    xOrder = [gridSizeX-1..0]

  if Math.random() < 0.5
    yOrder = [0...gridSizeY]
  else
    yOrder = [gridSizeY-1..0]

  if Math.random() < 0.5
    zOrder = [0...gridSizeZ]
  else
    zOrder = [gridSizeZ-1..0]

  for x in xOrder
    for y in yOrder
      for z in zOrder
        particleNextTickAtXYZ = particleNextTickAt[x][y][z]
        if particleNextTickAtXYZ > 0

          # todo check whether skipping particles surrounded by equal particles
          # helps with performance

          rand1 = Math.random()
          rand2 = Math.random()
          horizChance = horizontalMotionProbability[particleNextTickAtXYZ]
          vertChance = Math.abs verticalMotionProbability[particleNextTickAtXYZ]

          if rand1 < horizChance && rand2 < vertChance
            perm = perm5[Math.floor(Math.random() * perm5.length)]
          else if rand1 < horizChance && rand2 > vertChance
            perm = perm4[Math.floor(Math.random() * perm4.length)]
          else if rand1 > horizChance && rand2 < vertChance
            perm = [4]
          else if rand1 > horizChance && rand2 > vertChance
            continue

          elementDensityXYZ = elementDensity[particleNextTickAtXYZ]
          exitFor = false
          for i in perm
            if exitFor then break
            switch i
              when 0
                if x > 0 and elementDensityXYZ > elementDensity[particleNextTickAt[x - 1][y][z]]
                  tmp = particleNextTickAtXYZ
                  particleNextTickAt[x][y][z] = particleNextTickAt[x - 1][y][z]
                  particleNextTickAt[x - 1][y][z] = tmp
                  exitFor = true
              when 1
                if x < gridSizeX - 1 and elementDensityXYZ > elementDensity[particleNextTickAt[x + 1][y][z]]
                  tmp = particleNextTickAtXYZ
                  particleNextTickAt[x][y][z] = particleNextTickAt[x + 1][y][z]
                  particleNextTickAt[x + 1][y][z] = tmp
                  exitFor = true
              when 2
                if y > 0 and elementDensityXYZ > elementDensity[particleNextTickAt[x][y-1][z]]
                  tmp = particleNextTickAtXYZ
                  particleNextTickAt[x][y][z] = particleNextTickAt[x][y-1][z]
                  particleNextTickAt[x][y-1][z] = tmp
                  exitFor = true
              when 3
                if y < gridSizeY - 1 and elementDensityXYZ > elementDensity[particleNextTickAt[x][y+1][z]]
                  tmp = particleNextTickAtXYZ
                  particleNextTickAt[x][y][z] = particleNextTickAt[x][y+1][z]
                  particleNextTickAt[x][y+1][z] = tmp
                  exitFor = true
              when 4
                if verticalMotionProbability[particleNextTickAtXYZ] > 0
                  if z > 0 and elementDensity[particleNextTickAtXYZ] > elementDensity[particleNextTickAt[x][y][z-1]]
                    tmp = particleNextTickAtXYZ
                    particleNextTickAt[x][y][z] = particleNextTickAt[x][y][z-1]
                    particleNextTickAt[x][y][z-1] = tmp
                    exitFor = true
                else if verticalMotionProbability[particleNextTickAtXYZ] < 0
                  if z < gridSizeZ - 1 and elementDensity[particleNextTickAtXYZ] > elementDensity[particleNextTickAt[x][y][z+1]]
                    tmp = particleNextTickAtXYZ
                    particleNextTickAt[x][y][z] = particleNextTickAt[x][y][z+1]
                    particleNextTickAt[x][y][z+1] = tmp
                    exitFor = true

  return


# these we can make global because we only want them
# to declare the size and the type of the content,
# the actual content we are going to overwrite
# in the innermost loop
shuffledProbs = [0.0,0.0,0.0,0.0,0.0,0.0]
shuffledDirections = [0,0,0,0,0,0]

particlesReactions = ->
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...gridSizeZ]
        currentParticle = particleAt[x][y][z]

        if currentParticle == 0
          if x == 0 or particleAt[x - 1][y][z] == 0
            if y == 0 or particleAt[x][y - 1][z] == 0
              if z == 0 or particleAt[x][y][z - 1] == 0
                if x == gridSizeX - 1 or particleAt[x + 1][y][z] == 0
                  if y == gridSizeY - 1 or particleAt[x][y+1][z] == 0
                    if z == gridSizeZ - 1 or particleAt[x][y][z+1] == 0
                      particleNextTickAt[x][y][z] = currentParticle
                      continue


        if Math.random() <= transmutationProbability[currentParticle]
          particleAt[x][y][z] = transmutationTo[currentParticle]
          particleNextTickAt[x][y][z] = particleAt[x][y][z]
          continue

        particleNextTickAt[x][y][z] = currentParticle

        sixProbs = [0.0,0.0,0.0,0.0,0.0,0.0]
        sixDirections = [0,1,2,3,4,5]

        reactionOptionsOfCurrentParticleWith = reactionOptions[currentParticle]
        reactionProbabilityOfCurrentParticleWith = neighborProbability[currentParticle]

        howManyPossibleReactions = 0
        if x > 0
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x - 1][y][z]]
          if checkVal != -1
            sixProbs[0] = reactionProbabilityOfCurrentParticleWith[particleAt[x - 1][y][z]]
            howManyPossibleReactions++
        if y > 0
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x][y - 1][z]]
          if checkVal != -1
            sixProbs[1] = reactionProbabilityOfCurrentParticleWith[particleAt[x][y - 1][z]]
            howManyPossibleReactions++
        if z > 0
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x][y][z - 1]]
          if checkVal != -1
            sixProbs[2] = reactionProbabilityOfCurrentParticleWith[particleAt[x][y][z - 1]]
            howManyPossibleReactions++
        if x < gridSizeX - 1
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x + 1][y][z]]
          if checkVal != -1
            sixProbs[3] = reactionProbabilityOfCurrentParticleWith[particleAt[x + 1][y][z]]
            howManyPossibleReactions++
        if y < gridSizeY - 1
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x][y + 1][z]]
          if checkVal != -1
            sixProbs[4] = reactionProbabilityOfCurrentParticleWith[particleAt[x][y + 1][z]]
            howManyPossibleReactions++
        if z < gridSizeZ - 1
          checkVal = reactionOptionsOfCurrentParticleWith[particleAt[x][y][z + 1]]
          if checkVal != -1
            sixProbs[5] = reactionProbabilityOfCurrentParticleWith[particleAt[x][y][z + 1]]
            howManyPossibleReactions++

        if howManyPossibleReactions == 0
          particleNextTickAt[x][y][z] = particleAt[x][y][z]
          continue

        shuffle = perm6[Math.floor(Math.random() * perm6.length)]

        shuffledProbs[0] = sixProbs[shuffle[0]]
        shuffledProbs[1] = sixProbs[shuffle[1]]
        shuffledProbs[2] = sixProbs[shuffle[2]]
        shuffledProbs[3] = sixProbs[shuffle[3]]
        shuffledProbs[4] = sixProbs[shuffle[4]]
        shuffledProbs[5] = sixProbs[shuffle[5]]

        shuffledDirections[0] = sixDirections[shuffle[0]]
        shuffledDirections[1] = sixDirections[shuffle[1]]
        shuffledDirections[2] = sixDirections[shuffle[2]]
        shuffledDirections[3] = sixDirections[shuffle[3]]
        shuffledDirections[4] = sixDirections[shuffle[4]]
        shuffledDirections[5] = sixDirections[shuffle[5]]


        # using the Sorting Networks (Daniel Stutzbach) algorithm as per
        # https://stackoverflow.com/questions/2786899/fastest-sort-of-fixed-length-6-int-array
        # SWAP(1, 2);
        if shuffledProbs[2] > shuffledProbs[1]
          tmp = shuffledProbs[1]; shuffledProbs[1] = shuffledProbs[2]; shuffledProbs[2] = tmp
          tmp = shuffledDirections[1]; shuffledDirections[1] = shuffledDirections[2]; shuffledDirections[2] = tmp
        # SWAP(0, 2);
        if shuffledProbs[2] > shuffledProbs[0]
          tmp = shuffledProbs[0]; shuffledProbs[0] = shuffledProbs[2]; shuffledProbs[2] = tmp
          tmp = shuffledDirections[0]; shuffledDirections[0] = shuffledDirections[2]; shuffledDirections[2] = tmp
        # SWAP(0, 1);
        if shuffledProbs[1] > shuffledProbs[0]
          tmp = shuffledProbs[0]; shuffledProbs[0] = shuffledProbs[1]; shuffledProbs[1] = tmp
          tmp = shuffledDirections[0]; shuffledDirections[0] = shuffledDirections[1]; shuffledDirections[1] = tmp
        # SWAP(4, 5);
        if shuffledProbs[5] > shuffledProbs[4]
          tmp = shuffledProbs[4]; shuffledProbs[4] = shuffledProbs[5]; shuffledProbs[5] = tmp
          tmp = shuffledDirections[4]; shuffledDirections[4] = shuffledDirections[5]; shuffledDirections[5] = tmp
        # SWAP(3, 5);
        if shuffledProbs[5] > shuffledProbs[3]
          tmp = shuffledProbs[3]; shuffledProbs[3] = shuffledProbs[5]; shuffledProbs[5] = tmp
          tmp = shuffledDirections[3]; shuffledDirections[3] = shuffledDirections[5]; shuffledDirections[5] = tmp
        # SWAP(3, 4);
        if shuffledProbs[4] > shuffledProbs[3]
          tmp = shuffledProbs[3]; shuffledProbs[3] = shuffledProbs[4]; shuffledProbs[4] = tmp
          tmp = shuffledDirections[3]; shuffledDirections[3] = shuffledDirections[4]; shuffledDirections[4] = tmp
        # SWAP(0, 3);
        if shuffledProbs[3] > shuffledProbs[0]
          tmp = shuffledProbs[0]; shuffledProbs[0] = shuffledProbs[3]; shuffledProbs[3] = tmp
          tmp = shuffledDirections[0]; shuffledDirections[0] = shuffledDirections[3]; shuffledDirections[3] = tmp
        # SWAP(1, 4);
        if shuffledProbs[4] > shuffledProbs[1]
          tmp = shuffledProbs[1]; shuffledProbs[1] = shuffledProbs[4]; shuffledProbs[4] = tmp
          tmp = shuffledDirections[1]; shuffledDirections[1] = shuffledDirections[4]; shuffledDirections[4] = tmp
        # SWAP(2, 5);
        if shuffledProbs[5] > shuffledProbs[2]
          tmp = shuffledProbs[2]; shuffledProbs[2] = shuffledProbs[5]; shuffledProbs[5] = tmp
          tmp = shuffledDirections[2]; shuffledDirections[2] = shuffledDirections[5]; shuffledDirections[5] = tmp
        # SWAP(2, 4);
        if shuffledProbs[4] > shuffledProbs[2]
          tmp = shuffledProbs[2]; shuffledProbs[2] = shuffledProbs[4]; shuffledProbs[4] = tmp
          tmp = shuffledDirections[2]; shuffledDirections[2] = shuffledDirections[4]; shuffledDirections[4] = tmp
        # SWAP(1, 3);
        if shuffledProbs[3] > shuffledProbs[1]
          tmp = shuffledProbs[1]; shuffledProbs[1] = shuffledProbs[3]; shuffledProbs[3] = tmp
          tmp = shuffledDirections[1]; shuffledDirections[1] = shuffledDirections[3]; shuffledDirections[3] = tmp
        # SWAP(2, 3);
        if shuffledProbs[3] > shuffledProbs[2]
          tmp = shuffledProbs[2]; shuffledProbs[2] = shuffledProbs[3]; shuffledProbs[3] = tmp
          tmp = shuffledDirections[2]; shuffledDirections[2] = shuffledDirections[3]; shuffledDirections[3] = tmp

        sixProbs = shuffledProbs
        sixDirections = shuffledDirections

        for i in [0...6]
          if sixProbs[i] == 0 then break
          if Math.random() < sixProbs[i]
            switch sixDirections[i]
              when 0
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x - 1][y][z]]
              when 1
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x][y - 1][z]]
              when 2
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x][y][z - 1]]
              when 3
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x + 1][y][z]]
              when 4
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x][y + 1][z]]
              when 5
                particleNextTickAt[x][y][z] = reactionOptions[currentParticle][particleAt[x][y][z + 1]]
            break

  return

numberOfParticles = 0
instrumentation_countParticles = ->
  numberOfParticles = 0
  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...gridSizeZ]
        # TODO count below should be put behind a flag
        if particleAt[x][y][z] != 0 then numberOfParticles++
  return
