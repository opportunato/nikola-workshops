$(function makeImagesResponsive() {
  width = $(window).width();

  var tablet = width < 1025 && width > 641;
  var mobile = width < 641;
  if(tablet) {
    $('img').each(function(i, el) {
      $(el).attr("src", el.src.replace(".jpg", "@tablet.jpg"));
    });
    $('.bg').each(function() {
      var style = $(this).attr('style');
      $(this).attr("style", style.replace(".jpg", "@tablet.jpg"));
    });
  } else if (mobile) {
    $('img').each(function(i, el) {
      $(el).attr("src", el.src.replace(".jpg", "@mobile.jpg"));
    });
    $('.bg').each(function() {
      var style = $(this).attr('style');
      $(this).attr("style", style.replace(".jpg", "@mobile.jpg"));
    });
  }
});