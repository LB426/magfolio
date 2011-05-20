$(document).ready(function() {
  $("a#buket_add").fancybox({
  		'hideOnContentClick': false
  });
  $("a#buket_edit").fancybox({
  		'hideOnContentClick': false
  });
  $("a#buket_delete").fancybox({
  		'hideOnContentClick': false
  });
  $('a[id^="delete_buket"]').click(function(){
    var href = $(this).attr("href");
    var product_id = href.replace('product_id_','');
    $('#product_'+product_id+'_delete_form').submit();
    return false;
	});
})