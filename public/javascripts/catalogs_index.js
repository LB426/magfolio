
var catalogs = new Array();
var catalog_ids = new Array();
var show_on_map = -1 ;

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

$(document).ready(function() {
  $('.footer').waypoint(function(event, direction) {
    $('.footer').waypoint('remove');
    if(direction === 'down'){
      //$('#catalogs_upload_progress_bar').show();
      if(catalog_ids.lenght >= 1){
        $.get('/catalogs/indexload', 
              { catalog_ids: catalog_ids },
              function(data, textStatus, jqXHR) {
                $('div.content').append(data);
                if(data.length != 0){
                  $('.footer').waypoint({ offset: '100%' });
                }
        });
      }
      //$('#catalogs_upload_progress_bar').hide();
    }else{
      //alert('You have scrolled to an content.');
    }
  },{ offset: '100%' });
  
  /* вызов карты
  $("a[id^=map_pic_]").fancybox({
  		'hideOnContentClick': false
  }); */
  
})