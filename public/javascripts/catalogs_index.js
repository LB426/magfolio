
var catalogs = new Array();
var catalog_ids = new Array();
var show_on_map = -1 ;
var cookie_izbrannoe = null ;
var location_id = null ;
var product_kind = null ;
var service_kind = null ;
var locations = null ;
var deal_ids = null ;

function imgchg_link(a,b) {
  var catalog_id = a;
  var pic_id = b;
  for (var i = 0; i < catalogs.length; i++){
    if(catalogs[i].id == catalog_id){
      for (var j = 0; j < catalogs[i].imgs.length; j++) {
        var img_id = catalogs[i].imgs[ j ] ;
        var link_img = "#link_img_"+catalogs[i].id+'_'+img_id ;
        var class_attr = $(link_img).attr('class');
        $(link_img).attr('class', 'inactive');
        if(img_id == pic_id){
          $(link_img).attr('class', 'active');  
          $("div.activeimg[id^=image_catalog_"+catalog_id+"]").hide();
          $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('class','inactiveimg');
          $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).show();
          $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).attr('class','activeimg');
        }
      }
    }
  }
  return false;
}

function img_next(a) {
  var catalog_id = a;
  var id = $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('id');
  var activeimg_id = parseInt(id.replace("image_catalog_"+catalog_id+"_",""));
  for (var i = 0; i < catalogs.length; i++) {
    if(catalogs[i].id == catalog_id){
      for (var j = 0; j < catalogs[i].imgs.length; j++) {
        if(catalogs[i].imgs[j] == activeimg_id){
          if(j < catalogs[i].imgs.length - 1){
            var img_id = catalogs[i].imgs[ j+1 ] ;
            $("#image_catalog_"+catalog_id+"_"+activeimg_id).hide();
            $("#image_catalog_"+catalog_id+"_"+activeimg_id).attr('class','inactiveimg');
            $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).show();
            $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).attr('class','activeimg');
            $('#link_img_'+catalog_id+'_'+activeimg_id).attr('class','inactive');
            $('#link_img_'+catalog_id+'_'+img_id).attr('class','active');
            break;
          }
        }
      }
    }
  }
  return false;
}

function img_prev(a) {
  var catalog_id = a;
  var id = $("div.activeimg[id^=image_catalog_"+catalog_id+"]").attr('id');
  var activeimg_id = parseInt(id.replace("image_catalog_"+catalog_id+"_",""));
  for (var i = 0; i < catalogs.length; i++) {
    if(catalogs[i].id == catalog_id){
      for (var j = 0; j < catalogs[i].imgs.length; j++) {
        if(catalogs[i].imgs[j] == activeimg_id){
          if(j > 0){
            var img_id = catalogs[i].imgs[ j-1 ] ;
            $("#image_catalog_"+catalog_id+"_"+activeimg_id).hide();
            $("#image_catalog_"+catalog_id+"_"+activeimg_id).attr('class','inactiveimg');
            $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).show();
            $("div.inactiveimg#image_catalog_"+catalog_id+"_"+img_id).attr('class','activeimg');
            $('#link_img_'+catalog_id+'_'+activeimg_id).attr('class','inactive');
            $('#link_img_'+catalog_id+'_'+img_id).attr('class','active');
            break;
          }
        }
      }
    }
  }
  return false;
}

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

$(document).ready(function() {  
  
  $('.footer').waypoint(function(event, direction) {
    var flag = false ;
    $('.footer').waypoint('remove');
    if(direction === 'down'){
      //$('#catalogs_upload_progress_bar').show();
      if((catalog_ids.lenght != 0)&&(flag == false)){
        $.get('/catalogs/indexload', 
              { catalog_ids: catalog_ids, location_id: location_id, product_kind: product_kind, service_kind: service_kind, deal_ids: deal_ids, locations: locations },
              function(data, textStatus, jqXHR) {
                $('div.content').append(data);
                if(data.length != 1){
                  $('.footer').waypoint({ offset: '100%' });
                }else{
                  flag = true;
                }
        });
      }
      //$('#catalogs_upload_progress_bar').hide();
    }else{
      //alert('You have scrolled to an content.');
    }
  },{ offset: '100%' });
  
})