//= require jquery
//= require jquery_ujs
$(document).ready(function(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true})
});