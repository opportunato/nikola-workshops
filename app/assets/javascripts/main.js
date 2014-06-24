$(function() {
  var vph, vpw;
  vpw = $(window).width();
  vph = $(window).height();

  $(".intro").height(vph);
  $(".kazarma").height(vph);
  // $(".columns").height(vph);
  $(".fullPage").css({
    marginTop: vph
  });

  $(window).resize(function() {
    vph = $(window).height();
    $(".intro").height(vph);
    $(".kazarma").height(vph);
    // $(".columns").height(vph);
    if ($(window).width() > 1) {
      return $(".fullPage").css({
        marginTop: vph
      });
    } else {
      return $(".fullPage").css({
        marginTop: 0
      });
    }
  });

  $('.menuButton').on('click', function(e) {
    $('header').toggleClass('opened');
  });

  $('.menu').on('click', function(e) {
    $('header').toggleClass('opened');
  });

  $('.arrowDown').on('click', function(e) {
    return $('html, body').animate({
      scrollTop: $(".fullPage").offset().top
    }, 400);
  });
});