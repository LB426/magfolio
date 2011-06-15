$(document).ready(function() {
  /* $('input[id^="catalog_"]').keyup(function(){
    var reProductCount = new RegExp(/^\d*$/);
    var value = $(this).val();
    if(reProductCount.test(value)){
      // alert(value); 
    }else{
      alert('Допустимы только цифры!!!'); 
    }
	}); */
	$('a[rel^="product_"]').fancybox({
    'transitionIn'          : 'none',
    'transitionOut'         : 'none',
    'titlePosition'         : 'over',
    'titleFormat'           : function(title, currentArray, currentIndex, currentOpts){ 
      return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>'; 
    }
  });
  $('#calculate').click(function(){
    var reProductCount = new RegExp(/^\d*$/);
    $('input[id^="catalog_"]').each(function(){
      var name = $(this).attr('name');
      var old_amount = parseInt(name.replace('productcount_',''));
      var new_amount = 0;
      var value = $(this).val();
      if(reProductCount.test(value)){
        new_amount = parseInt(value);
      }else{
        alert('Допустимы только цифры!!!');
        return false; 
      }
      var input_id = $(this).attr('id');
      var x = input_id.replace('catalog_','');
      var ids = x.split('_product_');
      var catalog_id = ids[0];
      var product_id = ids[1];
      if(new_amount != old_amount){
        $.ajax({
          type: "POST",
          url: '/mycart/edit',
          data: { catalog_id: catalog_id, product_id: product_id, new_amount: new_amount },
          success: function(msg){
            if(msg === 'true'){
              window.location = '/mycart' ;
            }else{
              alert('Не удалось изменить количество!');
            }
          }
        });
      }else{
        //alert(catalog_id + ' ' + product_id + ' old ' + old_amount + ' new ' + new_amount); 
      }
    });
  });
  $('#mycart_destroy').click(function(){
    window.location = '/mycart/destroy' ;
  });
})