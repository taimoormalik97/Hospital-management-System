function search(){
  $('#search_medicines').tokenInput("/medicines/search_medicines", { preventDuplicates: true, theme: 'facebook', tokenLimit: 1, hintText: 'search medicines' });
}

function search_doctor(){
  $('#search_doctors').tokenInput("/doctors/search_doctors", { preventDuplicates: true, theme: 'facebook', tokenLimit: 1, hintText: 'search doctor' });
}
$(document).ready(search)
$(document).ready(search_doctor)