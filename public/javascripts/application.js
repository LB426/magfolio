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
  if ($.browser.msie){
    if($.browser.version == '6.0') {alert('У Вас старый Internet Explorer 6-й версии.\nБезопасность под угрозой!\n срочно обновите браузер!');}
    if($.browser.version == '7.0') {alert('У Вас старый Internet Explorer 7-й версии.\nБезопасность под угрозой!\n срочно обновите браузер!');}
    //if($.browser.version == '8.0') {alert('У Вас старый Internet Explorer 8-й версии.\nБезопасность под угрозой!\n срочно обновите браузер!');}
  }
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
			$('#best_picrute_upload_iframe').contentWindow.document.body.innerHTML = '';
		});
		$('#upload_best_picrute').attr('class','');
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
	  var c_name = $(this).val();
    $('#live_company_name').text(c_name);    
    var ch_cut_url = c_name.replace(/\s+/gi, "-");
    ch_cut_url = ch_cut_url.toLowerCase();
    $('#shortcut_url').val(ch_cut_url);
	});
	$('#business_type_id').change(function(){
	  if(signup_id == 0){ 
	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
	    $('#upload_best_picrute').attr('class','thiserror');
	    return false;
	  }else{
	    var business_type_id = $(this).val();
  	  if(business_type_id == 0){
        $("a#inline_business_type").click();
      }else{
        if(business_type_id != -1){
          var text = $('#business_type_id option:selected').html();
  	      $('#live_business_type').text(text);
        }
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
	  var shcturl = $('#shortcut_url').val();
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
	  if(shcturl == ''){
	    alert("Вы не указали Короткое название каталога");
	    return false;
	  }
	  $('#signup_bestpic_comment').val(bpc);
	  $('#signup_company_name').val(cn);
	  $('#signup_businesstype_id').val(btid);
	  $('#signup_location_id').val(lid);
	  $('#signup_phone').val(cphn);
	  $('#signup_email').val(ceml);
	  $('#signup_shortcut_url').val(shcturl);
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
	$("a#inline_business_type").fancybox({
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
				  var btn = $('#business_type_name').val();
				  $("#business_type_id :contains(" + btn + ")").attr("selected", "selected");
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
  $('#catalog_delete_form_send').click(function(){
	  if (confirm('Удалить каталог?')){
	    $('#catalog_delete_form').submit();
    }else{
      return false;
    }
	});	
	$("a#catalog_tariff_change").fancybox({
  		'hideOnContentClick': false
  });
	
	/* заполняем виды товаров и услуг */

	$("#business_deals_iframe").load(function(){
		$.fancybox.close();
	});
	$("a#inline_add_business_deal").fancybox({
  		'hideOnContentClick': false,
  		'onStart': function(){
  		  if(signup_id == 0){ 
    	    alert("Вы не загрузили лучшую фотографию Вашего бизнеса!");
    	    $('#upload_best_picrute').attr('class','thiserror');
    	    return false;
    	  }else{
  		    $('#business_deal_id option').each(function(){
  		      var signup_business_deal_id = $(this).val()
  		      $("form#signup_add_business_deal input[type='checkbox']").each(function() {
  		        var business_deal_id = $(this).val();
  		        if(signup_business_deal_id === business_deal_id){
  		          $(this).attr('checked','checked');
  		        }
  		      });
  		    });
		    }
  		},
  		'onClosed': function(){
  		  $('#business_deal_id').empty();
  		  $.getJSON('/signup/getbusinessdeals', function(data){
  		    $.each(data, function(i,item){
  		      $('#business_deal_id').append('<option selected value="'+ item.id + '">' + item.name + '</option>');
		      });
		    });
		  }
  });
  
  /* вызывает окно ввода координат, для отображения на карте */
  $("a#add_to_map").fancybox({
  		'hideOnContentClick': false
  });
  
  /* вызывает окно выбора товаров и услуг */
  $("a#edit_business_deals").fancybox({
  		'hideOnContentClick': false
  });
  
  $("a#add_coord_to_catalog").fancybox({
  		'hideOnContentClick': false
  });
  
  $('a[id="product_id"]').click(function(){
    var href = $(this).attr("href");
    $("#non_checked_product_"+href).toggle();
    $("#checked_product_"+href).toggle();
	});
	
	$('a[id="location_id"]').click(function(){
    var href = $(this).attr("href");
    $("#non_checked_location_"+href).toggle();
    $("#checked_location_"+href).toggle();
	});
	
	$('#search_btn').click(function(){
	  var products = new Array();
	  var locations = new Array();
	  $('.content').find('a[href]').each(function(i, item){
	    var href = $(item).attr('href');
	    var link_id = $(item).attr('id');
	    if(link_id === 'product_id'){
	      var img = $('#checked_product_'+href);
	      if(img.is(":visible")){
	        //alert(i + ' ' + $(item).attr('id'));
	        products.push(href);
	      } 
	    }
	    if(link_id === 'location_id'){
	      var img = $('#checked_location_'+href);
	      if(img.is(":visible")){
	        locations.push(href);
	      } 
	    }
	  });
	  //alert(products + ' ' + locations);
	  $('#business_deals').val(products);
	  $('#locations_for_search').val(locations);
	  $('#search_form').submit();
	});
  
})
