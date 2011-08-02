function showcomment(data) {
  alert(data);
}

function get_order_state() {
  if(typeof(order_id) != "undefined"){
    //$('#last_state').hide();
    $.ajax({
      type: "GET",
      url: '/order/'+ order_id +'/getstate',
      //data: { authenticity_token: form_authenticity_token },
      success: function(data){
        var obj = jQuery.parseJSON(data);
        var state = '0';
        $('#order_state').html('');
        $.each(obj, function(i,item){
          if(item.comment != undefined){
            $('#order_state').append('<a href="#" onclick="showcomment(\''+item.comment+'\');" id="show_state_comment_' + i + '" style="text-decoration:none;" title="'+ item.comment +'">' + item.state + '</a>&nbsp;' + item.date + '<br>');
          }else{
            $('#order_state').append(item.state + '&nbsp;' + item.date + '<br>'); 
          }
          state = item.state;
          $('#order_statuses_all').attr('style','background-color:'+item.bgcolor+';color:'+item.color+';');
  		  });
  		  if(state == "передан в архив"){
  		    $('#order_state').hide();
  		    var str = $('#order_state').html();
          var arr = str.split('<br>');
          var last = arr.length - 2 ;
  		    $('#last_state').html(arr[last]);
  		    $('#last_state').show();
  		    $('#change_state').hide();
  		    $('#add_comment_to_last_state_link').hide();
  		  }else{
          $('#order_state').show();
        }
      }
    });
  }
}

$(document).ready(function() {
  get_order_state();
  
  $('#last_state').hide();
  $('#delivery_services').hide();
  $('#delivery').click(function(){
    $('.column').hide();
    $('#delivery_services').show();
  });
  $('#order_confirm').click(function(){
    if($('#agreement').is(':checked')){
      return true;
    }else{
      alert('Вы не подтвердили своё согласие с предоставляемыми услугами');
      return false;
    }
    return false;
  });
  $('#state_show_hide').click(function(){
    $('#order_state').toggle();
    if($('#order_state').is(':hidden')){
      var str = $('#order_state').html();
      var arr = str.split('<br>');
      var last = arr.length - 2 ;
      $('#last_state').show();
      $('#last_state').html(arr[last]);
    }else{
      $('#last_state').hide();
    }
    return false;
  });
  $('#change_state').change(function(){
    var state = $(this).val();
    //var state = $(this).find("option:selected").text();
    $('#last_state').hide();
    $.ajax({
      type: "POST",
      url: '/order/'+ order_id +'/editstate',
      data: { future_state: state, authenticity_token: form_authenticity_token },
      success: function(data){
        get_order_state();
      }
    });
  });
  $("a#add_comment_to_last_state_link").fancybox({
  		'hideOnContentClick': false,
  		'onClosed': function(){
  		  get_order_state();
		  }
  });
  $('#add_comment_to_last_state_dialog_submit_button').click(function(){
    $.fancybox.close();
  });
  $("a#terms_of_confirm_link").fancybox({
  		'hideOnContentClick': false,
  		'onClosed': function(){
  		  var phone = $('#customer_phone').val();
    	  var email = $('#customer_email').val();
    	  var reEmail = new RegExp(/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/);
    	  var rePhoneNumber1 = new RegExp(/^\([1-9]\d{4}\)\d{5}$/);
    	  var rePhoneNumber2 = new RegExp(/^\+7\([1-9]\d{2}\)\d{3}\-\d{2}\-\d{2}$/);
    	  if(email == '' && phone == ''){
    	    alert('Вы ничего не ввели');
    	    $("input#agreement").attr('checked', false);
        }else{
          if(phone != ''){
    	      if(!rePhoneNumber1.test(phone)){
        	    if(!rePhoneNumber2.test(phone)){
        	      alert('Номер должен соответствовать формату - (86196)41199\nили +7(918)123-44-56');
        	      $("input#agreement").attr('checked', false);
        	    }
            }
          }
          if(email != ''){
    		    if(!reEmail.test(email)){
        	    alert("Неправильно указан e-mail!");
        	    $("input#agreement").attr('checked', false);
        	  }
    	    }
        }
		  }
  });
  $('#agreement').click(function(){
    $("a#terms_of_confirm_link").click();
  });
  $('#use_terms_of_confirm').click(function(){
    var phone = $('#customer_phone').val();
	  var email = $('#customer_email').val();
	  var reEmail = new RegExp(/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/);
	  var rePhoneNumber1 = new RegExp(/^\([1-9]\d{4}\)\d{5}$/);
	  var rePhoneNumber2 = new RegExp(/^\+7\([1-9]\d{2}\)\d{3}\-\d{2}\-\d{2}$/);
	  $("input#agreement").attr('checked', false);
	  if(email == '' && phone == ''){
	    alert('Вы ничего не ввели');
	    return false;
    }else{
      if(phone != ''){
	      if(!rePhoneNumber1.test(phone)){
    	    if(!rePhoneNumber2.test(phone)){
    	      alert('Номер должен соответствовать формату - (86196)41199\nили +7(918)123-44-56');
    	      return false;
    	    }
        }
      }
      if(email != ''){
		    if(!reEmail.test(email)){
    	    alert("Неправильно указан e-mail!");
    	    return false;
    	  }
	    }
    }
    $("input#agreement").attr('checked', true);
    $.fancybox.close();
  });
  $('#state_filter').fancybox({
    'hideOnContentClick': false,
		'onClosed': function(){
		  //set_filter_params_for_catalog();
	  }
  });
  
})