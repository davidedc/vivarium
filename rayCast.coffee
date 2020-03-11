rayCast = ->
  for i in [0...200]
    rayMarching = i * 0.1

    [marchingPointX, marchingPointY, marchingPointZ] = fromCameraCalculateMoveOf rayMarching, 0, 0
    marchingPointX = Math.round marchingPointX
    marchingPointY = Math.round marchingPointY
    marchingPointZ = Math.round marchingPointZ

    if marchingPointX >= 0 and marchingPointX < gridSizeX and marchingPointY >= 0 and marchingPointY < gridSizeY and marchingPointZ >= 0 and marchingPointZ < gridSizeZ
      if particleAt[marchingPointX][marchingPointY][marchingPointZ] != 0
        rayCastSlot = [marchingPointX, marchingPointY, marchingPointZ]
        break
      else
        justInFrontOfRayCastSlot = [marchingPointX, marchingPointY, marchingPointZ]
  return
