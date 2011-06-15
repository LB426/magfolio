$(document).ready(function() {
  $("a#buket_add").fancybox({
  		'hideOnContentClick': false
  });
  $("a#buket_edit").fancybox({
  		'hideOnContentClick': false
  });
  $('a[id^="delete_buket"]').click(function(){
    var href = $(this).attr("href");
    var product_id = href.replace('product_id_','');
    $('#product_'+product_id+'_delete_form').submit();
    return false;
	});
	$('a[rel^="product_"]').fancybox({
    'transitionIn'          : 'none',
    'transitionOut'         : 'none',
    'titlePosition'         : 'over',
    'titleFormat'           : function(title, currentArray, currentIndex, currentOpts){ 
      return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>'; 
    }
  });
  $('a[id^="add_to_cart_"]').click(function(){
    var thislink = $(this);
    var cart_count = parseInt($("#cart_count").text());
    var link = $(this).attr('href')
    var id = $(this).attr('id');
    var product_id = id.replace('add_to_cart_', '');
    $.getJSON(link, function(data){
			$.each(data, function(i,item){
			  if(item.result == true){
			    $('#mycart').show();
			    $.cookie( "cart", item.cart_unique_id,{expires: 2000, path: "/"});
			    cart_count = cart_count + 1 ;
			    $("#cart_count").text(item.products_count);
			    thislink.text('В корзине (' + item.product_count + ')');
			  }else{
			    alert('Не удалось добавить в корзину этот товар!'); 
			  }
		  });
		});
    return false;
	});
})