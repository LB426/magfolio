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
  		$("#logo_upload_iframe").load(function(){
  			$("#logo_upload_progress_bar").hide();
  		});
	  }else{
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	  }
		return false;
	});
	$('#bestpic_comment').keyup(function(){
    $('#live_image_description').text($(this).val());
	});
	$('#company_name').keyup(function(){
    $('#live_company_name').text($(this).val());
	});
	$('#business_type_id').change(function(){
	  var business_type_id = $(this).val();
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
	  var location_id = $(this).val();
	  if(location_id == 0){
      $("a#inline_add_location").click();
    }else{
      if(location_id != -1){
        var text = $('#location_id option:selected').html();
	      $('#live_company_location').text(text);
      }
    }
	});
	$('#save_and_contunue_btn').click(function(){
	  if(signup_id == 0){ 
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	    return false;
	  }	  
	  //$('#save_and_continue_form').attr( "action", "/signup/" + signup_id + "/stage2" );
	  $('#signup_bestpic_comment').val($('#bestpic_comment').val());
	  $('#signup_company_name').val($('#company_name').val());
	  $('#signup_businesstype_id').val($('#business_type_id').val());
	  $('#signup_location_id').val($('#location_id').val());
	  $('#signup_phone').val($('#contact_phone').val());
	  $('#signup_email').val($('#contact_email').val());
	  $('#signup_company_url').val($('#website_url').val());
	});
	$('#save_and_contunue_btn2').click(function(){
	  alert(signup_id + ' ' + best_picrute_desc + ' ' + company_name + ' ' + business_type_id + ' ' + location_id + ' ' + phone + ' ' + email + ' ' + url);
	});
	$("a#inline").fancybox({
  		'hideOnContentClick': false ,
  		'onComplete': function(){ $("#business_type_name").focus(); },
			'onClosed': function(){
			  $('#business_type_id').empty();
			  $('#business_type_id').prepend('<option value="-1">Выберите вид деятельности...</option>');
				$.getJSON('/businesstype/getbusinesstypes', function(data){
					$.each(data, function(i,item){
					  $('#business_type_id').append('<option value="'+ item.business_type.id + '">' + item.business_type.name + '</option>');
				  });
				  $('#business_type_id').append('<option value="0">Моего бизнеса нет в списке</option>');
				});
			}
  });
	$("#business_type_add_iframe").load(function(){
		$.fancybox.close();
	});
	$("a#inline_add_location").fancybox({
  		'hideOnContentClick': false
  });
	$("#location_add_iframe").load(function(){
		$.fancybox.close();
	});
})
