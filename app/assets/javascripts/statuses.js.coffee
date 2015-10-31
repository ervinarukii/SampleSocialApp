# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $('.reply-comment-form').hide()

  $('.reply-comment').click ->
    $(this).parent().parent().find('.reply-comment-form').toggle()
    return

$(document).ready(ready)
$(document).on('page:load', ready)
