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

$ ->
  writeCoordinates = (c) ->
    $('#item_image_crop_data_x').val c.x
    $('#item_image_crop_data_y').val c.y
    $('#item_image_crop_data_width').val c.w
    $('#item_image_crop_data_height').val c.h
    return

  $('#crop_image').Jcrop
    onSelect: writeCoordinates
    boxWidth: 400
    aspectRatio: 1
    minSize: [400, 400]
    setSelect: [0, 0, 400 ,400]
  return

