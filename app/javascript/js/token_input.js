
function search(){
	$('#search_medicines').tokenInput("/medicines/search_pred", {preventDuplicates: true});
}
$(document).ready(search)
