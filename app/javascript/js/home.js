$(document).scroll(function () {
  var $nav = $(".nav-transparent");
  $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
  $(".main-sign-up-btn").toggleClass('scrolled-sign-up-btn-color', $(this).scrollTop() > $nav.height());
});