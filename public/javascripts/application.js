// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
  $("#slide_listed").hide();
  $('#signup').mouseenter(function() {
    $("#slide_listed").show("slide", { direction: "up" }, 700);
  });
  $('#signup').mouseleave(function() {
    $("#slide_listed").hide("slide", { direction: "up" }, 700);
  });
})