$(function() {
  var vph, vpw;
  vpw = $(window).width();
  vph = $(window).height();

  $(".kazarma").height(vph);

  if ($(window).width() > 1024) {
    $("#carousel").height(vph);
  } else {
    $("#carousel").height(400);
  }

  $(window).resize(function() {
    vph = $(window).height();
    $(".kazarma").height(vph);
    if ($(window).width() > 1024) {
      $("#carousel").height(vph);
    } else {
      $("#carousel").height(400);
    }
  });

  $('.menuButton').on({
    click: function() {
      $('body').toggleClass('noscroll');
      setTimeout(function() {
        $('header').toggleClass('opened');
      }, 50);
    }
  });

  $('.menuButtonPopup').on({
    click: function() {
      $('.overlay').toggleClass('opened');
      setTimeout(function() {
        $('body').toggleClass('noscroll');
      }, 50);
    }
  });
  
  $('.workshopWrapper').on({
    click: function() {
      $('body').toggleClass('noscroll');
      setTimeout(function() {
        $('.overlay').toggleClass('opened');
      }, 50);
    }
  });
});