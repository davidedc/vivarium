class Vec3
  x: 0
  y: 0
  z: 0

  constructor: (@x = 0,@y = 0,@z = 0) ->

  mag: ->
    x = @x
    y = @y
    z = @z
    Math.sqrt x * x + y * y + z * z

  div: (v) ->
    if typeof v == 'number'
      @x /= v
      @y /= v
      @z /= v
    else
      @x /= v.x
      @y /= v.y
      @z /= v.z
    return

  cross: (v) ->
    x = @x
    y = @y
    z = @z
    new Vec3(y * v.z - (v.y * z), z * v.x - (v.z * x), x * v.y - (v.x * y))

  normalize: ->
    m = @mag()
    if m > 0
      @div m
    return
