$(document).scroll(function () {
  var $nav = $(".nav-transparent");
  $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
  $(".main-sign-up-btn").toggleClass('scrolled-sign-up-btn-color', $(this).scrollTop() > $nav.height());
  $(".main-sign-in-btn").toggleClass('scrolled-sign-in-btn-color', $(this).scrollTop() > $nav.height());
  $(".hms-nav-item").toggleClass('scrolled-hms-nav-item', $(this).scrollTop() > $nav.height());
  $(".hms-title").toggleClass('scrolled-hms-title', $(this).scrollTop() > $nav.height());
});
