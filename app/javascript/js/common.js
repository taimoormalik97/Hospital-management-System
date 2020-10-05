function collapseSidebar() {

  /*-----------------------------------/
  /*  TOP NAVIGATION AND LAYOUT
  /*----------------------------------*/
  $('.btn-toggle-fullwidth').on('click', function() {
    if(!$('body').hasClass('layout-fullwidth')) {
      $('body').addClass('layout-fullwidth');
      $('.sidebar-row').addClass('vertical-block');
      $('.sidebar-nav-item').removeClass('row');

    } else {
      $('body').removeClass('layout-fullwidth');
      $('.sidebar-row').removeClass('vertical-block');
      $('.sidebar-nav-item').addClass('row');

    }

    var padding = $('.content-with-sidebar').css('padding-left');
    var newPadding = (padding=='260px')?'60px':'260px';
    $('.content-with-sidebar').css('padding-left',newPadding);

    $('.arrow').toggleClass('fa-arrow-circle-left fa-arrow-circle-right');
    $('.sidebar-icon').toggleClass('vertical-icon col-1');
    $('.sidebar-text').toggleClass('vertical-span col-8');

    $('.navbar-btn').toggleClass('justify-content-center justify-content-end');

    if($(window).innerWidth() < 1025) {
      if(!$('body').hasClass('offcanvas-active')) {
        $('body').addClass('offcanvas-active');
      } else {
        $('body').removeClass('offcanvas-active');
      }
    }
  });

  $(window).on('load', function() {
    if($(window).innerWidth() < 1025) {
      $('.btn-toggle-fullwidth').find('.icon-arrows')
      .removeClass('icon-arrows-move-left')
      .addClass('icon-arrows-move-right');
    }

    // adjust right sidebar top position
    $('.right-sidebar').css('top', $('.navbar').innerHeight());

    // if page has content-menu, set top padding of main-content
    if($('.has-content-menu').length > 0) {
      $('.navbar + .main-content').css('padding-top', $('.navbar').innerHeight());
    }

    // for shorter main content
    if($('.main').height() < $('#sidebar-nav').height()) {
      $('.main').css('min-height', $('#sidebar-nav').height());
    }
  });


  /*-----------------------------------/
  /*  SIDEBAR NAVIGATION
  /*----------------------------------*/

  $('.sidebar a[data-toggle="collapse"]').on('click', function() {
    if($(this).hasClass('collapsed')) {
      $(this).addClass('active');
    } else {
      $(this).removeClass('active');
    }
  });
}

function showAvailabilitiesForAppointment() {
  $('body').on('click', '.next', function(){
    var data = { doctor_id: $('#doctor').val(), date: $('#date').val() };
    $.ajax({ type: "GET", url: '/appointments/show_availabilities', data: data });
  });
}


$(document).ready(function(){
  $('body').on('change', '#speciality_filter', function(){
    $.ajax({ type: "GET", url: '/doctors/speciality_filter', data: { filter: $(this).val() } });
  });
});

$(document).ready(collapseSidebar)
$(document).ready(showAvailabilitiesForAppointment)