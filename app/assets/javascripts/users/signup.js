$(document).ready(function(){
	 $("#hospital_name").keyup(function(){
    var myStr = $("#hospital_name").val();
        myStr = myStr.toLowerCase().replace(/\s/g, "");
        $("#sub_domain").val(myStr);
  });
});