
function search(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true});
}
$(document).on('turbolinks:load',search)
$(document).ready(search)


