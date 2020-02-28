cameraFOV = 60 * (Math.PI / 180)

cameraX = 0.0
cameraY = 0.0
cameraZ = 0.0

cameraDirectionX = 0.0
cameraDirectionY = 0.0
cameraDirectionZ = 0.0

cameraMoveForward = 0.0
cameraMoveSide = 0.0
cameraMoveUp = 0.0

pitch = 0
yaw = 0

cameraX = canvasWidth / 2
cameraY = canvasHeight / 2
cameraZ = cameraY / Math.tan(cameraFOV / 2)


#//////////////////////////////////////////////////////////////////////////
# Camera functions from Processing
#//////////////////////////////////////////////////////////////////////////

###*
# Sets the position of the camera through setting the eye position, the center of the scene, and which axis is facing
# upward. Moving the eye position and the direction it is pointing (the center of the scene) allows the images to be
# seen from different angles. The version without any parameters sets the camera to the default position, pointing to
# the center of the display window with the Y axis as up. The default values are camera(width/2.0, height/2.0,
# (height/2.0) / tan(PI*60.0 / 360.0), width/2.0, height/2.0, 0, 0, 1, 0). This function is similar to gluLookAt()
# in OpenGL, but it first clears the current camera settings.
#
# @param {float} eyeX    x-coordinate for the eye
# @param {float} eyeY    y-coordinate for the eye
# @param {float} eyeZ    z-coordinate for the eye
# @param {float} centerX x-coordinate for the center of the scene
# @param {float} centerY y-coordinate for the center of the scene
# @param {float} centerZ z-coordinate for the center of the scene
# @param {float} upX     usually 0.0, 1.0, -1.0
# @param {float} upY     usually 0.0, 1.0, -1.0
# @param {float} upZ     usually 0.0, 1.0, -1.0
#
# @see beginCamera
# @see endCamera
# @see frustum
###

camera = (eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ) ->
  if !eyeX?
    eyeX = cameraX
    eyeY = cameraY
    eyeZ = cameraZ
    centerX = cameraX
    centerY = cameraY
    centerZ = 0
    upX = 0
    upY = 1
    upZ = 0
  z = new Vec3(eyeX - centerX, eyeY - centerY, eyeZ - centerZ)
  y = new Vec3(upX, upY, upZ)
  z.normalize()
  x = y.cross(z)
  y = z.cross(x)
  x.normalize()
  y.normalize()
  xX = x.x
  xY = x.y
  xZ = x.z
  yX = y.x
  yY = y.y
  yZ = y.z
  zX = z.x
  zY = z.y
  zZ = z.z
  cam.set xX, xY, xZ, 0, yX, yY, yZ, 0, zX, zY, zZ, 0, 0, 0, 0, 1
  cam.translate -eyeX, -eyeY, -eyeZ
  modelView.set cam


cameraVectorAhead = (forwardHowMuch, leftHowMuch, upHowMuch) ->
  tmpX = Math.cos(yaw) * forwardHowMuch + Math.sin(yaw) * leftHowMuch
  tmpY = Math.cos(yaw) * leftHowMuch - Math.sin(yaw) * forwardHowMuch
  tmpZ = Math.sin(pitch) * forwardHowMuch + Math.cos(pitch) * upHowMuch
  return [tmpX, tmpY, tmpZ]

updateCamera = ->
  # past these angles some really
  # strange stuff starts to happen
  tiltLimit = 0
  if pitch > Math.PI / 2 - tiltLimit
    pitch = Math.PI / 2 - tiltLimit
  if pitch < -Math.PI / 2 + tiltLimit
    pitch = -Math.PI / 2 + tiltLimit

  while yaw > Math.PI * 2
    yaw = yaw - Math.PI * 2
  while yaw < -Math.PI * 2
    yaw = yaw + Math.PI * 2


  [cameraToAddPosX, cameraToAddPosY, cameraToAddPosZ] = cameraVectorAhead cameraMoveForward, cameraMoveSide, cameraMoveUp
  cameraX += cameraToAddPosX
  cameraY += cameraToAddPosY
  cameraZ += cameraToAddPosZ + cameraMoveUp/2

  [cameraToAddLookX, cameraToAddLookY, cameraToAddLookZ] = cameraVectorAhead 1,0,0
  cameraDirectionX = cameraX + cameraToAddLookX
  cameraDirectionY = cameraY + cameraToAddLookY
  cameraDirectionZ = cameraZ + cameraToAddLookZ

  cameraMoveForward = 0
  cameraMoveSide = 0
  cameraMoveUp = 0
