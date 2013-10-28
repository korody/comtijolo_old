jQuery.fn.bindFileUploader = ->
  $(@).fileupload
    dataType: 'script'
    add: (e, data) ->
      data.context = $(tmpl("template-upload", data.files[0]))
      $('.upload-gallery').append data.context
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      data.context.remove()
    start: ->
      $('.btn-upload').hide()
      $('.upload-loader').show()
    stop: ->
      $('.upload-loader').hide()
      $('.btn-upload').show()

$ ->
  $('#new_attachment').bindFileUploader() if $('#new_attachment')

$(document).on 'page:load', ->
  $('#new_attachment').bindFileUploader() if $('#new_attachment')