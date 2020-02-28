# from Processing

class Matrix4x4

  constructor: ->
    # When a matrix is created, it is set to an identity matrix
    @reset()
    return

  set: ->
    if arguments.length == 16
      @elements = Array::slice.call(arguments)
    else if arguments.length == 1 and arguments[0] instanceof Matrix4x4
      @elements = arguments[0].array()
    else if arguments.length == 1 and arguments[0] instanceof Array
      @elements = arguments[0].slice()
    return

  get: ->
    outgoing = new Matrix4x4
    outgoing.set @elements
    outgoing

  reset: ->
    @elements = [
      1, 0, 0, 0
      0, 1, 0, 0
      0, 0, 1, 0
      0, 0, 0, 1
    ]
    return

  array: ->
    @elements.slice()

  translate: (tx, ty, tz) ->
    if tx instanceof Array
      ty = tx[1]
      tz = tx[2]
      tx = tx[0]
    @elements[3] += tx * @elements[0] + ty * @elements[1] + tz * @elements[2]
    @elements[7] += tx * @elements[4] + ty * @elements[5] + tz * @elements[6]
    @elements[11] += tx * @elements[8] + ty * @elements[9] + tz * @elements[10]
    @elements[15] += tx * @elements[12] + ty * @elements[13] + tz * @elements[14]
    #console.log(this.elements);
    return

  transpose: ->
    temp = @elements[4]
    @elements[4] = @elements[1]
    @elements[1] = temp
    temp = @elements[8]
    @elements[8] = @elements[2]
    @elements[2] = temp
    temp = @elements[6]
    @elements[6] = @elements[9]
    @elements[9] = temp
    temp = @elements[3]
    @elements[3] = @elements[12]
    @elements[12] = temp
    temp = @elements[7]
    @elements[7] = @elements[13]
    @elements[13] = temp
    temp = @elements[11]
    @elements[11] = @elements[14]
    @elements[14] = temp
    return

  apply: ->
    source = undefined
    if arguments.length == 1 and arguments[0] instanceof Matrix4x4
      source = arguments[0].array()
    else if arguments.length == 16
      source = Array::slice.call(arguments)
    else if arguments.length == 1 and arguments[0] instanceof Array
      source = arguments[0]
    result = [
      0, 0, 0, 0
      0, 0, 0, 0
      0, 0, 0, 0
      0, 0, 0, 0
    ]
    e = 0
    row = 0
    while row < 4
      col = 0
      while col < 4
        result[e] += @elements[row * 4 + 0] * source[col + 0] + @elements[row * 4 + 1] * source[col + 4] + @elements[row * 4 + 2] * source[col + 8] + @elements[row * 4 + 3] * source[col + 12]
        col++
        e++
      row++
    @elements = result.slice()
    return

  scale: (sx, sy, sz) ->
    if sx and !sy and !sz
      sy = sz = sx
    else if sx and sy and !sz
      sz = 1
    if sx and sy and sz
      @elements[0] *= sx
      @elements[1] *= sy
      @elements[2] *= sz
      @elements[4] *= sx
      @elements[5] *= sy
      @elements[6] *= sz
      @elements[8] *= sx
      @elements[9] *= sy
      @elements[10] *= sz
      @elements[12] *= sx
      @elements[13] *= sy
      @elements[14] *= sz
    return
