
function search(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true});
}
function search_patient(){
	$('#patient_search').tokenInput("/patients/search_pred", {preventDuplicates: true});
}
function search_doctor(){
	$('#search_doctors').tokenInput("/doctors/search_pred", {preventDuplicates: true});
}
$(document).on('turbolinks:load',search)
$(document).ready(search)
$(document).on('turbolinks:load',search_patient)
$(document).ready(search_patient)
$(document).on('turbolinks:load',search_doctor)
$(document).ready(search_doctor)


