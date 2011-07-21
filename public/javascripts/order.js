$(document).ready(function() {
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
        var obj = jQuery.parseJSON(data);
        $('#order_state').html('');
        $.each(obj, function(i,item){
				  $('#order_state').append(item.state_name + ' ' + item.date + '&nbsp;<a href="#" style="text-decoration:none;">+</a>' + '<br>');
			  });
        $('#order_state').show();
      }
    });
  });
})