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
  $('input[type=file]#listing_logo').change(function(event){
    var userFile = $(this).val();
    alert(userFile);
    var max = 5000000 ;
    var iframe = $( '
    <iframe name="logo_upload_iframe" id="logo_upload_iframe" class="hidden" src="about:none" /> 
    <form id="logo_upload_form">
    <input type="hidden" id="max" name="MAX_FILE_SIZE" value="5000000" >
    <input id="userfile" name="userfile" size="50" type="file" value="asdfg">
    <input id="formsubmit" type="submit" value="Send File" >
    </form>
    </iframe>' );
    $("#logo_upload").append( iframe );
    $('#logo_upload_form').attr( "action", "/signup/logoupload" );
    $('#logo_upload_form').attr( "method", "post" );
    //$('#logo_upload_form').attr( "userfile", userFile );
    //$('#userfile').val(userFile);
    $('#logo_upload_form').attr( "MAX_FILE_SIZE", max );
    $('#logo_upload_form').attr( "enctype", "multipart/form-data" );
    $('#logo_upload_form').attr( "encoding", "multipart/form-data" );
    $('#logo_upload_form').attr( "target", "logo_upload_iframe" );
    $('#logo_upload_form').submit();
    $("#logo_upload_iframe").load(
      function(){
        //iframeContents = $("iframe#logo_upload_iframe").contentDocument.body.innerHTML;
        //$("div#logo_upload").html(iframeContents);
      }
    );
    return false;
  });
})
