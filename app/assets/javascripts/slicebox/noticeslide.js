function Slide_Notice() {
    $(function () {
        var Page = (function () {
            var $navArrows = $('#nav-arrows').hide(),
                slicebox = $('#sb-slider').slicebox({
                    onReady: function () {
                        $navArrows.show();
                    },
                    orientation: 'r',
                    perspective : 1500,
                    cuboidsRandom: true,
                    disperseFactor: 20,
                    easing : 'ease',
                    speed : 1000,
                    interval: 5000,
                    autoplay: true,
                    fallbackFadeSpeed : 300,
                }),
                init = function () {
                    initEvents();
                },
                initEvents = function () {
                    // add navigation events
                    $navArrows.children(':first').on('click', function () {
                        slicebox.next();
                        return false;
                    });
                    $navArrows.children(':last').on('click', function () {
                        slicebox.previous();
                        return false;
                    });
                };
            return {
                init: init
            };
        })();
        Page.init();
    });
}