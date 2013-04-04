$ ->
  window.addEventListener "load", ->
    setTimeout (->
      window.scrollTo 0, 1
    ), 0
  $('.video-overlay').click ->
    player_height = $(@).height()
    player_width = $(@).width()
    $(@).hide()
    id = $(@).data('vid-id')
    player_id = $(@).data 'player'
    createPlayer(id, player_id, player_height, player_width)

  browserUA = navigator.userAgent.toLowerCase()
  if browserUA.search('windows phone os 7') > -1
    $('#featured p.second').css 'padding': '0 10px 10px'
    $('#sponsors p').css 'padding': '10px'
    $('footer a').css 'margin': '0px 3px 20px'

  $('.overlay-link').click ->
    data = $(@).data 'link'
    $('#main').fadeOut(500)
    show_overlay(data)
    return false

  $('.back').click ->
    hide_overlay()
    return false

show_overlay = (data) ->
  $(data).fadeIn(500)

hide_overlay = ->
  $('.overlay').fadeOut(500)
  $('#main').fadeIn(1000)

createPlayer = (id, player_id, player_height, player_width) ->
  player = new YT.Player(player_id,
    width: player_width
    height: player_height
    videoId: id
    playerVars:
      'autoplay': 1
  )