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
            $('#order_state').append('<a href="#" onclick="showcomment(\''+item.comment+'\');" id="show_state_comment_' + i + '" style="text-decoration:none;" title="'+ item.comment +'">' + item.state_name + '</a>&nbsp;' + item.date + '<br>');
          }else{
            $('#order_state').append(item.state_name + '&nbsp;' + item.date + '<br>'); 
          }
          state = item.state_val;
  		  });
  		  if(state == '13'){
  		    $('#order_state').hide();
  		    var str = $('#order_state').html();
          var arr = str.split('<br>');
          var last = arr.length - 2 ;
  		    $('#last_state').html(arr[last]);
  		    $('#last_state').show();
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
    if($('#terms_of_confirm').is(':checked')){
      //alert('1');
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
})