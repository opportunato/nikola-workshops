/**
* super simple carousel
* animation between panes happens with css transitions
*/
function Carousel(element)
{
    var self = this;
    element = $(element);

    var container = $(">ul", element);
    var panes = $(">ul>li", element);

    var pane_width = 0;
    var pane_count = panes.length;

    var current_pane = 0;

    var arrowLeft = $(".arrowLeft")
    var arrowRight = $(".arrowRight")

    /**
     * initial
     */
    this.init = function() {
        setPaneDimensions();
        checkArrows();

        $(window).on("load resize orientationchange", function() {
            setPaneDimensions();
        })
    };


    /**
     * set the pane dimensions and scale the container
     */
    function setPaneDimensions() {
        pane_width = element.width();
        panes.each(function() {
            $(this).width(pane_width);
        });
        container.width(pane_width*pane_count);
    };


    /**
     * show pane by index
     */
    this.showPane = function(index, animate) {
        // between the bounds
        index = Math.max(0, Math.min(index, pane_count-1));
        current_pane = index;

        var offset = -((100/pane_count)*current_pane);
        setContainerOffset(offset, animate);

        checkArrows();
    };

    function checkArrows() {
        if (current_pane === 0) {
            arrowLeft.hide();
        } else if (current_pane === pane_count-1) {
            arrowRight.hide();
        } else {
            arrowLeft.show();
            arrowRight.show();
        }
    }

    function setContainerOffset(percent, animate) {
        container.removeClass("animate");

        if(animate) {
            container.addClass("animate");
        }

        if(Modernizr.csstransforms3d) {
            container.css("transform", "translate3d("+ percent +"%,0,0) scale3d(1,1,1)");
        }
        else if(Modernizr.csstransforms) {
            container.css("transform", "translate("+ percent +"%,0)");
        }
        else {
            var px = ((pane_width*pane_count) / 100) * percent;
            container.css("left", px+"px");
        }
    }

    this.next = function() { return this.showPane(current_pane+1, true); };
    this.prev = function() { return this.showPane(current_pane-1, true); };

    function handleHammer(ev) {
        // disable browser scrolling
        ev.gesture.preventDefault();



        switch(ev.type) {
            case 'dragright':
            case 'dragleft':
                // stick to the finger
                var pane_offset = -(100/pane_count)*current_pane;
                var drag_offset = ((100/pane_width)*ev.gesture.deltaX) / pane_count;

                // slow down at the first and last pane
                if((current_pane == 0 && ev.gesture.direction == "right") ||
                    (current_pane == pane_count-1 && ev.gesture.direction == "left")) {
                    drag_offset *= .4;
                }

                setContainerOffset(drag_offset + pane_offset);
                break;

            case 'swipeleft':
                self.next();
                ev.gesture.stopDetect();
                break;

            case 'swiperight':
                self.prev();
                ev.gesture.stopDetect();
                break;

            case 'release':
                // more then 50% moved, navigate
                if(Math.abs(ev.gesture.deltaX) > pane_width/2) {
                    if(ev.gesture.direction == 'right') {
                        self.prev();
                    } else {
                        self.next();
                    }
                }
                else {
                    self.showPane(current_pane, true);
                }
                break;
        }
    }

    new Hammer(element[0], { dragLockToAxis: true }).on("tap release dragleft dragright swipeleft swiperight", handleHammer);
}