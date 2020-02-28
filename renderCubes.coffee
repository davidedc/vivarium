renderCubes = ->
  # takes care of both backface culling and
  # eliminating adjacent faces

  # I did try a further optimisation i.e. to consolidate
  # contiguous faces of the same color into a single stripe.
  # However that didn't pay much dividents and made the code
  # much more complex, because stripes tend to occur along the
  # x and y axes rather than along the z axis (because elements
  # tend to "deposit" according to gravity),
  # which means that the loops needed to be rethough to
  # make "natural grain" of the arrays to run through either x or y
  # rather than z as it is now, in order to make the consolidation
  # practical. Also, this doesn't save any
  # "fill" time, but rather just "geometry sending" time.
  # All in all, I didn't find it worth it.

  for x in [0...gridSizeX]
    for y in [0...gridSizeY]
      for z in [0...gridSizeZ]
        
        currentParticle = particleAt[x][y][z]

        if currentParticle

          if (x==gridSizeX-1 or !particleAt[x+1][y][z]) and x < cameraX
            face currentParticle, FACE_RIGHT, x+1, y, z+1

          if (x==0 or !particleAt[x-1][y][z]) and x > cameraX
            face currentParticle, FACE_LEFT, x, y, z+1

          if (y==gridSizeY-1 or !particleAt[x][y+1][z]) and y < cameraY
            face currentParticle, FACE_BOTTOM, x, y+1, z

          if (y==0 or !particleAt[x][y-1][z]) and y > cameraY 
            face currentParticle, FACE_TOP, x, y, z

          if (z==gridSizeZ-1 or !particleAt[x][y][z+1]) and z < cameraZ
            face currentParticle, FACE_FRONT, x, y, z+1

          if (z==0 or !particleAt[x][y][z-1]) and z > cameraZ
            face currentParticle, FACE_BACK, x, y, z

  flushFaces();
