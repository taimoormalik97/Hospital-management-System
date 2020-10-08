function set_domain(){
  $("#hospital_name").keyup(function(){
    var SubDomain = $("#hospital_name").val();
    SubDomain = SubDomain.toLowerCase().split(' ').join("").split('.').join("");
    $("#sub_domain").val(SubDomain);
  });
}

$(document).ready(set_domain)
