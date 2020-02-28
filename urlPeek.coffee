# from https://html-online.com/articles/get-url-parameters-javascript/
getUrlVars = ->
  vars = {}
  window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, (m, key, value) ->
    vars[key] = value
    return
  )
  vars

physicsMode = parseInt getUrlVars()["physicsMode"]
slowDown = parseInt getUrlVars()["slowDown"]
