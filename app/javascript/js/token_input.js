
function search(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true});
}
function search_doctor(){
	$('#search_doctors').tokenInput("/doctors/search_pred", {preventDuplicates: true});
}
$(document).ready(search)
$(document).ready(search_doctor)
