$(document).ready(function(){
  $("#hospital_name").keyup(function(){
    var sub_domain = $("#hospital_name").val();
    sub_domain = sub_domain.toLowerCase().replace(/\s/g, "");
    $("#sub_domain").val(sub_domain);
  });
});