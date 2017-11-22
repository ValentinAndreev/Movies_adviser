$(document).on "turbolinks:load", ->
  $('#recommended').click ->
    $('#rec').empty()
    $('#rec').append("Your recommendation: recommended")
    $('#recommended').hide()
    $('#not-recommended').show()
    $('#neutral').show()

  $('#not-recommended').click ->
    $('#rec').empty()
    $('#rec').append("Your recommendation: not recommended")
    $('#not-recommended').hide()
    $('#neutral').show()
    $('#recommended').show()

  $('#neutral').click ->
    $('#rec').empty()
    $('#rec').append("Your recommendation: neutral")
    $('#neutral').hide()
    $('#recommended').show()
    $('#not-recommended').show()