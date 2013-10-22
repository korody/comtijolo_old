$(function() {

  $("#post_category_tokens").tokenInput("/categories.json", {
    crossDomain: false,
    prePopulate: $("#post_category_tokens").data("load"),
    preventDuplicates: true
  });

});