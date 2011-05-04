var cookie_izbrannoe = null ;

function to_izbrannoe(catalog_id) {
  cookie_izbrannoe = $.cookie("izbrannoe") ;
  var atext = $('a[id="izbrannoe_'+ catalog_id +'"]').text() ;
  var izbrannoe_count = 0 ;
  if(atext === 'Добавить в избранное'){
    
  }else{
    $.ajax({
       type: "DELETE",
       url: "/izbrannoes/0",
       data: { catalog_id: catalog_id, identificator: cookie_izbrannoe },
       success: function(msg){
         if(msg === '0'){ $.cookie("izbrannoe", null); }
         location.reload();    
       }
     });
  }
  return false;
}

$(document).ready(function() {

})