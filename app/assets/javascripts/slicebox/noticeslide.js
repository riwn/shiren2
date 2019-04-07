function Slide_Notice() {
    $(function () {
        var Page = (function () {
            var $navArrows = $('#nav-arrows').hide(),
                slicebox = $('#sb-slider').slicebox({
                    onReady: function () {
                        $navArrows.show();
                    },
                    orientation: 'r',
                    cuboidsRandom: true,
                    disperseFactor: 30,
                    autoplay: true
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