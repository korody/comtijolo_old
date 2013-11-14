ready = ->
  $(".carousel").carousel pause: "hover"

$(document).ready ready
$(document).on 'page:load', ready