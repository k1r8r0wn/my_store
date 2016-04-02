# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.delete_action').click ->
    current_item_tr = $(this).parents('tr')[0]
    if confirm('Are you sure?')
      $.ajax
        url: 'items/' + $(current_item_tr).attr('data-item_id')
        type: 'POST'
        data:
          _method: 'DELETE'
          admin: 1
        success: () ->
          $(current_item_tr).fadeOut 200
          return
    return
  return
