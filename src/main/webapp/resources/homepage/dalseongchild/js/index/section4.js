$(document).ready(function () {
    function initSlick(selector) {
        const $slider = $(selector);
        if (!$slider.hasClass('slick-initialized')) {
            $slider.slick({
                slidesToShow: 6,
                arrows: false,
                autoplay: true,
                autoplaySpeed: 5000,
                dots: false,
                swipe: true,
                infinite: true,
                variableWidth: true,
            });
        }
    }

    initSlick('.recommended .book-slide');

    $('.book-content-tab[data-target="recommended"]').addClass('active');
    $('.recommended').show();
    $('.new').hide();

    $('.book-content-tab').on('click', function () {
        const $this = $(this);
        const target = $this.data('target');

        $('.book-content-tab').removeClass('active');
        $this.addClass('active');

        $('.recommended, .new').hide();
        $('.' + target).show();

        initSlick('.' + target + ' .book-slide');
    });
});
