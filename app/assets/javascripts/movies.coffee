$(document).on "turbolinks:load", ->
  $('#recommended').click ->
    $('#rec').empty()
    $('#rec').append("Your recommendation: recommended")

  $('#not-recommended').click ->
    $('#rec').empty()    
    $('#rec').append("Your recommendation: not recommended")

  $('#neutral').click ->
    $('#rec').empty()
    $('#rec').append("Your recommendation: neutral")