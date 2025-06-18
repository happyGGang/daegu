$(document).ready(function () {
    // Function to wrap quick-menu-items into quick-grid divs
    function wrapQuickMenuItems() {
        const $quickMenuSlide = $('.quick-menu-slide');
        const $items = $quickMenuSlide.find('.quick-menu-item');
        const isMobile = $(window).width() <= 865;

        // Destroy existing Slick to avoid conflicts
        if ($quickMenuSlide.hasClass('slick-initialized')) {
            $quickMenuSlide.slick('unslick');
        }

        // Remove existing quick-grid wrappers to reset structure
        $items.unwrap('.quick-grid');

        if (isMobile) {
            // Wrap items in groups of 6
            for (let i = 0; i < $items.length; i += 6) {
                $items.slice(i, i + 6).wrapAll('<div class="quick-grid"></div>');
            }

            // Initialize Slick with settings for grouped items
            $quickMenuSlide.slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                arrows: false,
                dots: false,
                variableWidth: false,
                infinite: true,
                swipe: true
            });
        } else {
            // Initialize Slick with original settings for desktop
            $quickMenuSlide.slick({
                slidesToShow: 6,
                slidesToScroll: 1,
                rows: 1,
                autoplay: false,
                arrows: false,
                dots: false,
                variableWidth: true,
                infinite: true,
                swipe: true
            });
        }
    }

    // Main background slider
    $('.main-bg-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: true,
        infinite: true,
        fade: true,
        cssEase: 'linear'
    });

    // Run wrapping function on load
    wrapQuickMenuItems();

    // Re-run on window resize
    $(window).resize(function () {
        wrapQuickMenuItems();
    });

    // Previous/Next buttons
    $('.quick-prev, .quick-next').click(function () {
        if ($('.quick-menu-slide').hasClass('slick-initialized')) {
            $('.quick-menu-slide').slick($(this).hasClass('quick-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});