// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require jquery.remotipart
//= require twitter/bootstrap
//= require jquery.timepicker.js
//= require jquery.colorbox
//= require slick
//= require moment
//= require fullcalendar
//= require_tree .




$(function() {
    $( ".date-picker" ).datepicker({ dateFormat: 'dd/mm/yy' });
  });
  
$(function() {
    //$(".alert.alert-danger.alert-dismissable").delay(6000).hide(500);
});



  $(function() {
    $( ".datepicker_with_year" ).datepicker({
      changeMonth: true,
      changeYear: true,
      yearRange: "-100:+0",
      dateFormat: 'dd/mm/yy',
       maxDate: -0
    });
    

    
  });



