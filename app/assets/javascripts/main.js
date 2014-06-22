var vph, vpw;
vpw = $(window).width();
vph = $(window).height();

$(".intro").height(vph);
$(".fullPage").css({
  marginTop: vph
});

$(window).resize(function() {
  vph = $(window).height();
  $(".intro").height(vph);
  $(".kazarma").height(vph);
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
  $('.headroom').toggleClass('opened');
});

$('.menu').on('click', function(e) {
  $('.headroom').toggleClass('opened');
});

$(".kazarma").height(vph);


$('.arrowDown').on('click', function(e) {
  return $('html, body').animate({
    scrollTop: $(".fullPage").offset().top
  }, 400);
});

// grab an element
var myElement = document.querySelector("header");
// construct an instance of Headroom, passing the element
var headroom  = new Headroom(myElement);
// initialise
headroom.init(); 