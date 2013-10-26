jQuery ->
  $('.best_in_place').best_in_place()

$('#video-collapse').click ->
  button = $(this);
  collapsible = button.next('.button-collapse');
  collapsible.toggle(800).addClass('colapsed')
  button.button('reset')

$('#create-video').click ->
  $this = $(this);
  $this.button('loading')