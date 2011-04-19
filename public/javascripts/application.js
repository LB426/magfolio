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

var catalog_images = new Array();

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
	  var bpc = $('#bestpic_comment').val();
	  var cn = $('#company_name').val();
	  var btid = $('#business_type_id').val();
	  var lid = $('#location_id').val();
	  var cphn = $('#contact_phone').val();
	  var ceml = $('#contact_email').val();
	  var url = $('#website_url').val();
	  var reEmail = new RegExp(/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/);
	  if(signup_id == 0){ 
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	    $('#upload_best_picrute').attr('class','thiserror');
	    return false;
	  }
	  if(bpc == ''){
	    alert("Вы не дали описание или комментарий к фотографии!");
	    $('#bestpic_comment_err').attr('class','thiserror');
	    return false;
	  }
	  if(cn == ''){
	    alert("Вы не указали название своей компании");
	    $('#company_name_err').attr('class','thiserror');
	    return false;
	  }
	  if((btid == '-1')||(btid == '0')){
	    alert("Вы не указали тип бизнеса");
	    $('#business_type_err').attr('class','thiserror');
	    return false;
	  }
	  if((lid == '-1')||(lid == '0')){
	    alert("Вы не указали местонахождение компании!");
	    $('#location_err').attr('class','thiserror');
	    return false;
	  }
	  if(cphn != ''){
  	  var rePhoneNumber1 = new RegExp(/^\([1-9]\d{4}\)\d{5}$/);
  	  var rePhoneNumber2 = new RegExp(/^\+7\([1-9]\d{2}\)\d{3}\-\d{2}\-\d{2}$/);
  	  if(!rePhoneNumber1.test(cphn)){
  	    if(!rePhoneNumber2.test(cphn)){
  	      alert('Номер должен соответствовать формату - (86196)41199\nили +7(918)123-44-56');
  	      $('#contact_phone_err').attr('class','thiserror');
  	      return false;
  	    }
      }
	  }else{
	    $('#contact_phone_err').attr('class','thiserror');
	    alert('Обязательно укажите номер телефона!')
	    return false;
	  }
	  if(!reEmail.test(ceml)){
	    alert("Неправильно указан e-mail!");
	    $('#contact_email_err').attr('class','thiserror');
	    return false;
	  }
	  $('#signup_bestpic_comment').val(bpc);
	  $('#signup_company_name').val(cn);
	  $('#signup_businesstype_id').val(btid);
	  $('#signup_location_id').val(lid);
	  $('#signup_phone').val(cphn);
	  $('#signup_email').val(ceml);
	  $('#signup_company_url').val(url);
	});
	$('#business_type_submit').click(function(){
	  var btn = $('#business_type_name').val();
	  if(btn.length < 3){
	    alert("Вы не указали тип бизнеса или длина слов менее 3-х символов!");
	    return false;
	  }
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
	$("a#catalog_base_data_edit").fancybox({
  		'hideOnContentClick': false
  });
  $("a#catalog_description_edit").fancybox({
  		'hideOnContentClick': false
  });
  $("a#catalog_galery_img_add").fancybox({
  		'hideOnContentClick': false
  });
  $('a[id^="control_id"]').click(function(event) {
    var catalog_id = parseInt(this.id.replace("control_id_", ""));
    var catalog_ctrl_links = $("a[href^='#catalog_"+catalog_id+"_link_image']");
    var img_id = parseInt($(this).attr('href').replace("#catalog_"+catalog_id+"_link_image_",""));
    $.each(catalog_ctrl_links,function(i,item){
      var class_attr = $(item).attr('class');
      if(class_attr == 'active'){ $(item).attr('class', ''); };
    });
    $(this).attr('class','active');
    $("div.activeimg[id^=image_catalog_"+catalog_id+"]").hide();
    $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('class','inactiveimg');
    $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).show();
    $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).attr('class','activeimg');
  });
  $('a.next').click(function(event) {
    var catalog_id = parseInt(this.id.replace("catalog_", ""));
    var id = $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('id');
    var activeimg_id = parseInt(id.replace("image_catalog_"+catalog_id+"_image_",""));

    //alert(catalog_id + ' ' + activeimg_id);
    //1) сформировать массив с ID картинок
    //2) отсортировать его по возрастанию
    //3) найти позицию activeimg_id
    //4) взять следующий ID
    //5) отобразить его
    for (var i = 0; i < catalog_images.length; i++) {
      if(catalog_images[i].id == catalog_id){
        for (var j = 0; j < catalog_images[i].imgs.length; j++) {
          if(catalog_images[i].imgs[j] == activeimg_id){
            if(j < catalog_images[i].imgs.length - 1){
              var img_id = catalog_images[i].imgs[ j+1 ] ;
              $("#image_catalog_"+catalog_id+"_image_"+activeimg_id).hide();
              $("#image_catalog_"+catalog_id+"_image_"+activeimg_id).attr('class','inactiveimg');
              $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).show();
              $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).attr('class','activeimg');
              $('a[href^="#catalog_'+catalog_id+'_link_image_'+activeimg_id+'"]').attr('class','');
              $('a[href^="#catalog_'+catalog_id+'_link_image_'+img_id+'"]').attr('class','active');
              break;
            }
          }
        }
      }
    }
  });
  $('a.previous').click(function(event) {
    var catalog_id = parseInt(this.id.replace("catalog_", ""));
    var id = $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('id');
    var activeimg_id = parseInt(id.replace("image_catalog_"+catalog_id+"_image_",""));
    for (var i = 0; i < catalog_images.length; i++) {
      if(catalog_images[i].id == catalog_id){
        for (var j = 0; j < catalog_images[i].imgs.length; j++) {
          if(catalog_images[i].imgs[j] == activeimg_id){
            if(j > 0){
              var img_id = catalog_images[i].imgs[ j-1 ] ;
              $("#image_catalog_"+catalog_id+"_image_"+activeimg_id).hide();
              $("#image_catalog_"+catalog_id+"_image_"+activeimg_id).attr('class','inactiveimg');
              $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).show();
              $("div.inactiveimg#image_catalog_"+catalog_id+"_image_"+img_id).attr('class','activeimg');
              $('a[href^="#catalog_'+catalog_id+'_link_image_'+activeimg_id+'"]').attr('class','');
              $('a[href^="#catalog_'+catalog_id+'_link_image_'+img_id+'"]').attr('class','active');
              break;
            }
          }
        }
      }
    }
  });  
})
