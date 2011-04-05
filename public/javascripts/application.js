// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
  }
});

/*
jQuery.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  }
});
*/

$(document).ready(function() {
  $('body').click(function() {
    $("#search_location_menu").hide();
    $("#search_budget_menu").hide();
    $("#search_service_menu").hide();
  });
  $("#slide_listed").hide();
  $('#signup').mouseenter(function() {
    $("#slide_listed").show("slide", { direction: "up" }, 700);
  });
  $('#signup').mouseleave(function() {
    $("#slide_listed").hide("slide", { direction: "up" }, 700);
  });
  $('#search_location_name').click(function(event) {
    $("#search_location_menu").show();
    event.stopPropagation();
  });
  $('#search_budget_name').click(function(event) {
    $("#search_budget_menu").show();
    event.stopPropagation();
  });
  $('#search_service_name').click(function(event) {
    $("#search_service_menu").show();
    event.stopPropagation();
  });
  $('input[type=file]#best_business_image').change(function(event){
		
    return false;
  });
	$('input[type=file]#signup_logo').change(function(event){
		var userFile = $(this).val();
		//alert(document.cookie);
		//alert($.cookie("_session_id"));
		$("#logo_upload_progress_bar").show();
		$('#new_signup').attr( "target", "upload_iframe" );
		$('#new_signup').submit();
		$("#upload_iframe").load(function(){
			//signup_id = $('#upload_iframe').contents().find('#signup_id').html();
			//alert(signup_id);
			$("#logo_upload_progress_bar").hide();
		});
		return false;
	});
})
