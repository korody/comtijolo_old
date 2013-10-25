$(function() {

  $("#post_category_tokens").tokenInput("/categories.json", {
    crossDomain: false,
    prePopulate: $("#post_category_tokens").data("load"),
    preventDuplicates: true
  });

  $("#post_tag_tokens").tokenInput("/tags.json", {
    crossDomain: false,
    prePopulate: $("#post_tag_tokens").data("load"),
    preventDuplicates: true
  });

});