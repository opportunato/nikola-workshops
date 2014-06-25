$(function() {
  var vph, vpw;
  vpw = $(window).width();
  vph = $(window).height();

  // $(".intro").height(vph);
  $(".kazarma").height(vph);

  $(window).resize(function() {
    vph = $(window).height();
    // $(".intro").height(vph);
    $(".kazarma").height(vph);
  });

  $('.menuButton').on('click', function(e) {
    $('header').toggleClass('opened');
  });
  
  $('.workshopWrapper').on('click', function(e) {
    $('.morph-content').toggleClass('opened');
  });

  $('.trigger').on('click', function(e) {
    return $('html, body').animate({
      scrollTop: $(".fullPage").offset().top
    }, 400);
  });
});