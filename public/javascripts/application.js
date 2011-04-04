// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

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
    var userFile = $(this).val();
    //alert(userFile);
    var max = 5000000 ;
    var iframe = $( '<iframe name="iframe" id="iframe" class="hidden" src="about:none" />' );
    $("#logo_upload").append( iframe );
    $('#business_img_upload_form').attr( "action", "/signup/logoupload" );
    $('#business_img_upload_form').attr( "method", "post" );
    $('#business_img_upload_form').attr( "userfile", userFile );
    $('#business_img_upload_form').attr( "MAX_FILE_SIZE", max );
    $('#business_img_upload_form').attr( "enctype", "multipart/form-data" );
    $('#business_img_upload_form').attr( "encoding", "multipart/form-data" );
    $('#business_img_upload_form').attr( "target", "iframe" );
    $('#business_img_upload_form').submit();
    $("#iframe").load(
      function(){
        //iframeContents = $("iframe#logo_upload_iframe").contentDocument.body.innerHTML;
        //$("div#logo_upload").html(iframeContents);
      }
    );
    return false;
  });
	$('input[type=file]#signup_logotype').change(function(event){
		var userFile = $(this).val();
		$("#upload_progress_bar").show();
		$('#new_signup').attr( "target", "upload_iframe" );
		$('#new_signup').submit();
		$("#upload_iframe").load(function(){
			$("#upload_progress_bar").hide();	
		});
		return false;
	});
})
