
function search(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true, theme: 'facebook', tokenLimit: 1, hintText: 'search medicines'});
}

function search_doctor(){
	$('#search_doctors').tokenInput("/doctors/search_pred", {preventDuplicates: true, theme: 'facebook', tokenLimit: 1, hintText: 'search doctor'});
}
$(document).ready(search)
$(document).ready(search_doctor)
