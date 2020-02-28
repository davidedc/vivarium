# from: https://gist.github.com/Hacker-YHJ/744d81becac5315352c3
newArray = (size, other..., v) ->
  # if last value is not a function, wrap it up
  _func = if typeof v isnt 'function' then () -> v else v

  array = (size, other..., v) ->
    return size() if arguments.length is 1
    return Array.apply(null, Array(size)).map (e, i) ->
      array.apply @, other.concat(v.bind(@, i))

  other.unshift size
  other.push _func
  array.apply @, other
