$(document).ready(function () {
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

    $('.quick-menu').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: false,
        dots: false,
        swipe: false,
        infinite: true,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 1440,
                settings: {
                    swipe: true,
                },
            },
        ],
    });

    // Previous/Next buttons
    $('.quick-prev, .quick-next').click(function () {
        if ($('.quick-menu').hasClass('slick-initialized')) {
            $('.quick-menu').slick($(this).hasClass('quick-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});