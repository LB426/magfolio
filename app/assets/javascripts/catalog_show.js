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

function deleterow(row){
  ps.splice(row, 1);
  refreshtable();
}

function pickup(row){
  if(row > 0){
    var pre = ps[row - 1];
    var cur = ps[row];
    ps.splice(row-1, 2, cur, pre);
    refreshtable();
  }
}

function putdown(row){
  var last = ps.length - 1 ;
  if(row < last){
    var cur = ps[row];
    var next = ps[row + 1];
    ps.splice(row, 2, next, cur);
    refreshtable();
  }
}

function filldefault(){
  ps = new Array() ;
  ps = ps.concat(ps_default);
  refreshtable();
}

function refreshtable(){
  if(typeof(ps) != "undefined"){
    $('#possible_statuses').empty();
    for(var i=0; i<ps.length; i++){
      $('#possible_statuses').append('<tr><td style="background-color:'+ps[i].bgcolor+';color:'+ps[i].color+'">'+ps[i].text+'</td><td><a href="" onclick="deleterow('+ i +'); return false;">удалить</a></td><td><a href="" onclick="pickup('+i+'); return false;">поднять</a></td><td><a href="" onclick="putdown('+i+');return false;">опустить</a></td><td>'+ps[i].color+'</td><td>'+ps[i].bgcolor+'</td></tr>');
    }
    $('#all_statuses').val($.toJSON(ps));
  }
}

$(document).ready(function() {
  $("a#possible_order_status_link").fancybox({
  		'hideOnContentClick': false,
  		'onStart': refreshtable()
  });
  $('#status_add').click(function(){
    var hash = new Object();
    hash.text = $.trim($('#possible_status_text').val());
    hash.color = $.trim($('#possible_status_color').val());
    hash.bgcolor = $.trim($('#possible_status_bg_color').val());
    ps.push(hash);
    refreshtable();
    return false;
  });
})