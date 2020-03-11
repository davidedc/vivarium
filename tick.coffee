ticks = 0
fps_frameCount = 0

tick = ->
  ticks++
  fps_frameCount++
  # even if the color buffer isn't cleared with background(),
  # the depth buffer needs to be cleared regardless.
  curContext.clear curContext.DEPTH_BUFFER_BIT

  curContextCache = { attributes: {}, locations: {} }

  camera()

  # we could put this inside the keyPressed
  # handler. However, by doing so we'd be at the mercy of
  # key repeat frequency, so the camera updates as soon
  # as the key is pressed, and then it waits a bit and then
  # the key repeats kick in. That's a little jarring.
  # Doing the check here means that we update
  # as soon as the key is down and then we keep updating
  # smoothly as long as the key is down according to
  # tick fequency rather than to key repeat frequency.
  
  # wasd, shift and space navigate similar to minecraft
  cameraMoveForward = 0.0
  cameraMoveSide = 0.0
  cameraMoveUp = 0.0
  cameraMoveAmount = 0.5
  cameraYawDelta = 0.0
  cameraPitchDelta = 0.0

  if isKeyPressed["w"]
    cameraMoveForward += cameraMoveAmount
  if isKeyPressed["a"]
    cameraMoveSide += cameraMoveAmount
  if isKeyPressed["s"]
    cameraMoveForward -= cameraMoveAmount
  if isKeyPressed["d"]
    cameraMoveSide -= cameraMoveAmount
  if isKeyPressed["Shift"]
    cameraMoveUp -= cameraMoveAmount
    pitch += cameraMoveAmount/50
  if isKeyPressed[" "]
    cameraMoveUp += cameraMoveAmount
    pitch -= cameraMoveAmount/50
  
  if currentlyOpenModal != examplesModal
    if isKeyPressed["ArrowLeft"]
      cameraYawDelta -= 0.05
    if isKeyPressed["ArrowRight"]
      cameraYawDelta += 0.05
    if isKeyPressed["ArrowUp"]
      cameraPitchDelta -= 0.05
    if isKeyPressed["ArrowDown"]
      cameraPitchDelta += 0.05



  yaw += smoothed_YAW cameraYawDelta
  pitch += smoothed_PITCH cameraPitchDelta


  updateCamera (smoothed_FWD cameraMoveForward), (smoothed_SIDE cameraMoveSide), (smoothed_UP cameraMoveUp)

  rayCastSlot[0] = -1
  justInFrontOfRayCastSlot[0] = -1

  rayCast()

  if (slowDown==1) and ticks % 20 != 0
    skipBecauseSlowDown = true
  else
    skipBecauseSlowDown = false

  if !pauseReactionsAndMotion and !skipBecauseSlowDown
    particlesReactions_t0 = performance.now()
    particlesReactions()
    particlesReactions_tf = performance.now()
    particlesMotion_t0 = performance.now()
    particlesMotion()
    particlesMotion_tf = performance.now()
    instrumentation_countParticles_t0 = performance.now()
    instrumentation_countParticles()
    instrumentation_countParticles_tf = performance.now()
    [particleAt, particleNextTickAt] = [particleNextTickAt, particleAt]

  #console.log cameraX + " " + cameraY + " " + cameraZ + " " + cameraDirectionX + " " + cameraDirectionY + " " + cameraDirectionZ
  if !pauseRendering
    camera cameraX, cameraY, cameraZ, cameraDirectionX, cameraDirectionY, cameraDirectionZ, 0, 0, 1
    background backgroundColor
    render_t0 = performance.now()
    renderCubes()
    render_tf = performance.now()

    if rayCastSlot[0] != -1
      stroke 0, 255, 255
      modelViewOrig = modelView.get()
      newScale = 1 + 0.1
      modelView.translate rayCastSlot
      modelView.translate 0.5, 0.5, 0.5
      modelView.scale newScale
      modelView.translate -rayCastSlot[0] - 0.5 , -rayCastSlot[1] - 0.5 , -rayCastSlot[2] - 0.5
      boxStroke rayCastSlot[0], rayCastSlot[1], rayCastSlot[2], 1, 1, 1
      modelView.set modelViewOrig

    if justInFrontOfRayCastSlot[0] != -1
      stroke 0, 255, 255
      modelViewOrig = modelView.get()
      newScale = 0.9
      modelView.translate justInFrontOfRayCastSlot
      modelView.translate 0.5, 0.5, 0.5
      modelView.scale newScale
      modelView.translate -justInFrontOfRayCastSlot[0] - 0.5 , -justInFrontOfRayCastSlot[1] - 0.5 , -justInFrontOfRayCastSlot[2] - 0.5
      boxDottedStroke 5, justInFrontOfRayCastSlot[0], justInFrontOfRayCastSlot[1], justInFrontOfRayCastSlot[2], 1, 1, 1
      modelView.set modelViewOrig
  
    # draw the container box
    stroke 0, 255, 255
    
    # make the container box slightly bigger to avoid conflict
    # with content and also to make it look slightly a little more polished
    percentageBigger = 5/100
    modelView.translate -gridSizeX*percentageBigger/2 , -gridSizeY*percentageBigger/2 , -gridSizeZ*percentageBigger/2
    modelView.scale 1 + percentageBigger
    containerBox 0, 0, 0, gridSizeX, gridSizeY, gridSizeZ


  if ticks % 30 == 0
    debugText = 'FPS: ' + Math.round(fps_frameCount/((performance.now() - last_fps_count_time)/1000))  + '\nPlace: ' + elementName[elementChosenByUserToBeAddedToWorld]
    last_fps_count_time = performance.now()
    fps_frameCount = 0

    if DEBUG_UI
      debugText += ' rendering ms: ' + (render_tf - render_t0).toFixed(2)
      debugText += ' reactions ms: ' + (particlesReactions_tf - particlesReactions_t0 + particlesMotion_tf - particlesMotion_t0 + instrumentation_countParticles_tf - instrumentation_countParticles_t0).toFixed(2)
      debugText += ' particlesReactions ms: ' + (particlesReactions_tf - particlesReactions_t0).toFixed(2)
      debugText += ' particlesMotion ms: ' + (particlesMotion_tf - particlesMotion_t0).toFixed(2)
      debugText += ' instrumentation_countParticles ms: ' + (instrumentation_countParticles_tf - instrumentation_countParticles_t0).toFixed(2)
      if pauseReactionsAndMotion
        debugText = debugText + ' REACTIONS AND MOTION PAUSED'
      if pauseRendering
        debugText = debugText + ' RENDERING PAUSED'
      debugText += ' camera x: ' + cameraX.toFixed(2)
      debugText += ' camera y: ' + cameraY.toFixed(2)
      debugText += ' camera z: ' + cameraZ.toFixed(2)
      debugText += ' pitch: ' + pitch.toFixed(2)
      debugText += ' yaw: ' + yaw.toFixed(2)
      debugText += ' numberOfParticles: ' + numberOfParticles
      document.getElementById('status-info').innerHTML = debugText

  requestAnimationFrame tick

requestAnimationFrame tick
