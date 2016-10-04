# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@app ?= {}

(($) ->

  $(document).on 'turbolinks:load', ->
    app.events.init()

  app.events =
    init: ->
      $('.js-player-participation button').click ->
        $(this).siblings('input[type=checkbox]').each ->
          $(this).prop('checked', !$(this).prop('checked'))

) jQuery

