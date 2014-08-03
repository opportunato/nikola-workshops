/*jshint browser:true, strict: false*/
/*global $*/

$(function() {
  // detect if IE : from http://stackoverflow.com/a/16657946
  var ie = (function() {
    var rv = -1; // Return value assumes failure.
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf('MSIE ');
    var trident = ua.indexOf('Trident/');

    if (msie > 0) {
    // IE 10 or older => return version number
    rv = parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    } else if (trident > 0) {
    // IE 11 (or newer) => return version number
    var rvNum = ua.indexOf('rv:');
    rv = parseInt(ua.substring(rvNum + 3, ua.indexOf('.', rvNum)), 10);
    }

    return ((rv > -1) ? rv : undefined);
  }());

  var keys = [32, 37, 38, 39, 40],
    wheelIter = 0,
    oriental,
    $w = $(window);

  function keydown(e) {
    for (var i = keys.length; i--;) {
      if (e.keyCode === keys[i]) {
        e.preventDefault();
        return;
      }
    }
  }

  function touchmove(e) {
    e.preventDefault();
  }

  function orientationPervert () {
    clearTimeout(oriental);
    oriental = setTimeout(function() {
      clearTimeout(oriental);
      oriental = undefined;
    }, 100);
  }

  function disable_scroll() {
    window.onmousewheel = document.onmousewheel;
    document.onkeydown = keydown;
    document.body.ontouchmove = touchmove;
  }

  function enable_scroll() {
    window.onmousewheel = document.onmousewheel = document.onkeydown = document.body.ontouchmove = null;
    orientationPervert();
  }

  var docElem = window.document.documentElement,
    scrollVal,
    isRevealed = false,
    noscroll,
    isAnimating,
    touchDevices = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent),
    $container = $( '#container' ),
    $trigger = $container.find( '.trigger' );

  function scrollPage(e) {
    scrollVal = $w.scrollTop();

    if( noscroll && !ie ) {
      if( scrollVal >= 0 ) {
        window.scrollTo( 0, 0 );
      }
    }

    if( $container.hasClass('notrans' ) ) {
      $container.removeClass('notrans');
      e.preventDefault();
    } else if( isAnimating || oriental) {
      e.preventDefault();
    } else if( scrollVal <= 0 && isRevealed) {
      toggle(0);
    } else if( scrollVal > 0 && !isRevealed){
      toggle(1);
    }

  }

  function toggle( reveal ) {
    isAnimating = true;

    if( reveal ) {
      $container.addClass('modify');
    } else {
      noscroll = true;
      disable_scroll();
      $container.removeClass('modify');
    }
    // simulating the end of the transition:
    setTimeout( function() {
      isAnimating = false;
      if( reveal ) {
        isRevealed = true;
        noscroll = false;
        enable_scroll();
      } else {
        isRevealed = false;
      }
    }, 1800 );
  }

  if ($(".intro-effect-push").length > 0) {
    // refreshing the page...
    var pageScroll = $w.scrollTop();
    noscroll = pageScroll === 0;

    disable_scroll();

    if( pageScroll ) {
      isRevealed = true;
      $container.addClass('modify notrans');
    }
    $w
      .on("scroll", scrollPage )
      .on("orientationchange", orientationPervert);

    $trigger.on( 'click', function() {
      toggle( 'reveal' );
    });
  }
});
