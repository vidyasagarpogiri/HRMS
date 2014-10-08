$('document').ready(function(){

try {
  //To display the icons in wysiwyg editor
  $.each($('i'), function(data){ $(this).attr('class' , $(this).attr('class').replace('glyphicon glyphicon', 'icon'));})
  // to display imagae-upload-icon in wysiwyg editor
  $.each($('span'), function(data){ $(this).attr('class' , $(this).attr('class').replace('glyphicon glyphicon', 'icon'));})
}
catch(err) {

}

  
});
