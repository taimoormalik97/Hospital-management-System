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

  /*-----------------------------------/
  /*  TODO LIST
  /*----------------------------------*/

  $('.todo-list input').change( function() {
    if( $(this).prop('checked') ) {
      $(this).parents('li').addClass('completed');
    }else {
      $(this).parents('li').removeClass('completed');
    }
  });


  /*-----------------------------------/
  /* TOASTR NOTIFICATION
  /*----------------------------------*/

  if($('#toastr-demo').length > 0) {
    toastr.options.timeOut = "false";
    toastr.options.closeButton = true;
    toastr['info']('Hi there, this is notification demo with HTML support. So, you can add HTML elements like <a href="#">this link</a>');

    $('.btn-toastr').on('click', function() {
      $context = $(this).data('context');
      $message = $(this).data('message');
      $position = $(this).data('position');

      if($context == '') {
        $context = 'info';
      }

      if($position == '') {
        $positionClass = 'toast-left-top';
      } else {
        $positionClass = 'toast-' + $position;
      }

      toastr.remove();
      toastr[$context]($message, '' , { positionClass: $positionClass });
    });

    $('#toastr-callback1').on('click', function() {
      $message = $(this).data('message');

      toastr.options = {
        "timeOut": "300",
        "onShown": function() { alert('onShown callback'); },
        "onHidden": function() { alert('onHidden callback'); }
      }

      toastr['info']($message);
    });

    $('#toastr-callback2').on('click', function() {
      $message = $(this).data('message');

      toastr.options = {
        "timeOut": "10000",
        "onclick": function() { alert('onclick callback'); },
      }

      toastr['info']($message);

    });

    $('#toastr-callback3').on('click', function() {
      $message = $(this).data('message');

      toastr.options = {
        "timeOut": "10000",
        "closeButton": true,
        "onCloseClick": function() { alert('onCloseClick callback'); }
      }

      toastr['info']($message);
    });
  }
}
$(document).on('turbolinks:load', arrow)
$(document).ready(arrow)

function showAvailabilitiesForAppointment() {
  $('body').on('click', '.next', function(){
    var data = { doctor_id: $('#doctor').val(), date: $('#date').val() };
    $.ajax({ type: "GET", url: '/appointments/show_availabilities', data: data });
  });
}

$(document).on('turbolinks:load', collapseSidebar)
$(document).ready(collapseSidebar)
$(document).on('turbolinks:load', showAvailabilitiesForAppointment)
$(document).ready(showAvailabilitiesForAppointment)

// toggle function
$.fn.clickToggle = function( f1, f2 ) {
  return this.each( function() {
    var clicked = false;
    $(this).bind('click', function() {
      if(clicked) {
        clicked = false;
        return f2.apply(this, arguments);
      }

      clicked = true;
      return f1.apply(this, arguments);
    });
  });

}
