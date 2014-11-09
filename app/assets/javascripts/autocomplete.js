$(function() {

  $("#post_category_tokens").tokenInput("/categories/autocomplete", {
    crossDomain: false,
    prePopulate: $("#post_category_tokens").data("load"),
    preventDuplicates: true
  });

  $("#post_collection_tokens").tokenInput("/collections/autocomplete", {
    crossDomain: false,
    prePopulate: $("#post_collection_tokens").data("load"),
    preventDuplicates: true
  });

  $("#post_tag_tokens").tokenInput("/tags/autocomplete", {
    crossDomain: false,
    prePopulate: $("#post_tag_tokens").data("load"),
    preventDuplicates: true
  });

  $("#post_complements_tokens").tokenInput("/posts/autocomplete", {
    crossDomain: false,
    prePopulate: $("#post_complements_tokens").data("load"),
    preventDuplicates: true
  });

});