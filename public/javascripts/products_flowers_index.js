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
})