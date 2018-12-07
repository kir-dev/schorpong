# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $('.showed-up').change ->
    card = $(this).closest('.card')
    card.removeClass('orange green red')
    $.ajax '/events/' + this.getAttribute('event') + '/entries/' + this.getAttribute('entry'),
      type: 'PUT',
      beforeSend: ->
        card.addClass('orange')
      success: ->
        card.addClass('green')
      error: ->
        card.addClass('red')
