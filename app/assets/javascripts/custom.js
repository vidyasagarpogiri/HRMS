$(function(){

  $("#employee_date_of_birth").datepicker();


   $("#new_country").hide();
   $("#country_list").append("<option value='0'>Select Country</option>");     
  $.getJSON("/addresses/countries.json", function( data ) {
      parseData("country",data);
   } ) ;
   
   add_new_field("country");     
   function states(){
    $("#new_state").hide();
    $("#state_list").append("<option value='0'>Select State</option>");
    $.getJSON("/addresses/states.json?country_id="+$("#country_list").val(), function( data ) {
        parseData("state",data);
     } ) ;
     
     add_new_field("state");
   }
   
   function cities(){
    $("#new_city").hide();
    $("#city_list").append("<option value='0'>Select City</option>");
    $.getJSON("/addresses/cities.json?state_id="+$("#state_list").val(), function( data ) {
        parseData("city",data);
     } ) ;
     
     add_new_field("city");
   }
   
  function parseData(field_type, data){
    $.each( data, function( key, val ) {
        value = val['id'];
        name = val[""+field_type+"_name"]
        $("#"+field_type+"_list").append("<option value='"+value+"'>"+name+"</option>");
      });
        $("#"+field_type+"_list").append("<option value='other' id='other_"+field_type+"'>Other</option>");
    }
  
  function add_new_field(field_type){
     $("#"+field_type+"_list").change(function(){ 
       if($("#"+field_type+"_list").val()=="other"){
        $("#new_"+field_type+"").show();
        if(field_type=="country"){
        $("#new_"+field_type+"").attr('placeholder','Country');
        $("#state_dpdwn").prepend("<input type='text' id='new_state' name='new_state' placeholder='State'><input type='text' id='new_city' name='new_city' placeholder='City'>");
        }
       } else {
         $("#new_"+field_type+"").hide();
           if(field_type=="country"){
               $("#state_dpdwn").html("<select id='state_list' name='ed_state'></select><input type='text' id='new_state' name='new_state'>");
               states();             
           }
           if(field_type=="state"){
               $("#city_dpdwn").html("<select id='city_list' name='ed_city'></select><input type='text' id='new_city' name='new_city'>");
               cities();             
           }
         }
       });
     }     
});
