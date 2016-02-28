initializeFacebookSDK = ->
  FB.init
    appId: '1117317048288129'
    cookie: true
    xfmbl: true
    version: 'v2.1'


jQuery ->
  delete FB
  $.getScript "//connect.facebook.net/en_US/all.js#xfbml=1", ->
    initializeFacebookSDK()