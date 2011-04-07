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
  $('input[type=file]#signup_bestpicture').change(function(event){
		$('#best_picrute_upload_progress_bar').show();
		$('#new_bestpicture_signup_form').attr( "target", "best_picrute_upload_iframe" );
		$('#new_bestpicture_signup_form').submit();
		$('#best_picrute_upload_iframe').load(function(){
			signup_id = $('#best_picrute_upload_iframe').contents().find('#signup_id').html();
			$("#live_preview_best_business_image").load('/signup/' + signup_id + '/bestpictureurl');
			$('#best_picrute_upload_progress_bar').hide();
		});
    return false;
  });
	$('#signup_logo').change(function(event){
	  if(signup_id != 0){
  		$("#logo_upload_progress_bar").show();
  		$('#new_logo_signup_form').attr( "action", "/signup/"+ signup_id +"/logoupload" );
  		$('#new_logo_signup_form').attr( "target", "logo_upload_iframe" );
  		$('#new_logo_signup_form').submit();
  		//$("#upload_iframe").empty();
  		//$("#upload_iframe").contents().find("body").html("");
  		//alert($('#upload_iframe').contents().find('html').html());
  		$("#logo_upload_iframe").load(function(){
  			$("#logo_upload_progress_bar").hide();
  		});
	  }else{
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	  }
		return false;
	});
	$('#best_picrute_description').keyup(function(){
    best_picrute_desc = $(this).val();
    $('#live_image_description').text(best_picrute_desc);
	});
	$('#company_name').keyup(function(){
    company_name = $(this).val();
    $('#live_company_name').text(company_name);
	});
	$('#business_type_id').change(function(){
	  business_type_id = $(this).val();
	  if(business_type_id == 0){
      $("a#inline").click();
    }else{
      if(business_type_id != -1){
        var text = $('#business_type_id option:selected').html();
	      $('#live_business_type').text(text);
      }
    }
	});
	$('#location_id').change(function(){
	  location_id = $(this).val();
	  var text = $('#location_id option:selected').html();
	  $('#live_company_location').text(text);
	});
	$('#contact_phone').keyup(function(){
	  phone = $(this).val();
	});
	$('#contact_email').keyup(function(){
	  email = $(this).val();
	});
	$('#website_url').keyup(function(){
	  url = $(this).val();
	});
	$('#save_and_contunue_btn').click(function(){
	  if(signup_id == 0){ 
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	    return false;
	  }	  
	  $('#save_and_continue_form').attr( "action", "/signup/" + signup_id + "/cost" );
	  $('#signup_company_name').val(company_name);
	  $('#signup_business_type').val(business_type_id);
	  $('#signup_location').val(location_id);
	  $('#signup_phone').val(phone);
	  $('#signup_email').val(email);
	  $('#signup_company_url').val(url);
	});
	$('#save_and_contunue_btn2').click(function(){
	  alert(signup_id + ' ' + best_picrute_desc + ' ' + company_name + ' ' + business_type_id + ' ' + location_id + ' ' + phone + ' ' + email + ' ' + url);
	});
	$("a#inline").fancybox({
  		'hideOnContentClick': false ,
			'onClosed': function(){
				$.getJSON('/businesstype/ajaxgetbusinesstype', function(data){
					$.each(data, function(i,item){
						alert(item);
						//$j("#business_type_id").append(
					});
				});
			}
  });
	$("#business_type_add_iframe").load(function(){
		$.fancybox.close();
	});
})
