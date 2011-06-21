$(document).ready(function() {
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
})