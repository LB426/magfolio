var cookie_izbrannoe = null ;

function to_izbrannoe(catalog_id) {
  cookie_izbrannoe = $.cookie("izbrannoe") ;
  var atext = $('a[href="/izbrannoe/'+ catalog_id +'"]').text() ;
  var izbrannoe_count = 0 ;
  if(atext === 'Добавить в избранное'){
    $('a[href="/izbrannoe/'+ catalog_id +'"]').text('Удалить из избранного');
    if(cookie_izbrannoe == null){
      $.post('/izbrannoes', 
            { catalog_id: catalog_id },
            function(data, textStatus, jqXHR) {
              if(data.length != 0){
                var obj = jQuery.parseJSON(data);
                $.cookie( "izbrannoe", obj.izbrannoe.identificator, 
                          {expires: 2000, path: "/"});
                izbrannoe_count = izbrannoe_count + 1 ;
                $('#izbrannoe_count').text('(' + izbrannoe_count + ')');
              }
      });
    }else{
      $.ajax({
         type: "PUT",
         url: "/izbrannoes/0",
         data: { catalog_id: catalog_id, identificator: cookie_izbrannoe },
         success: function(msg){
           $('#izbrannoe_count').text('(' + msg + ')');
         }
       });
    }
  }else{
    $.ajax({
       type: "DELETE",
       url: "/izbrannoes/0",
       data: { catalog_id: catalog_id, identificator: cookie_izbrannoe },
       success: function(msg){
         $('#izbrannoe_count').text('(' + msg + ')');
         if(msg === '0'){ $.cookie("izbrannoe", null); }
       }
     });
    $('a[href="/izbrannoe/'+ catalog_id +'"]').text('Добавить в избранное');
  }
  return false;
}
