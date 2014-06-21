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
  $('.header').toggleClass('opened');
});

// $(".intro").height(vph);
// if ($(window).width() > 1024) {
//   $(".fullPage").css({
//     marginTop: vph
//   });
// }
// $(window).resize(function() {
//   vph = $(window).height();
//   $(".intro").height(vph);
//   if ($(window).width() > 1024) {
//     return $(".fullPage").css({
//       marginTop: vph
//     });
//   } else {
//     return $(".fullPage").css({
//       marginTop: 0
//     });
//   }
// });