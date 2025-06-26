$(document).ready(function () {
    $('.menu-slide').slick({
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false,
        arrows: false,
        dots: false,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.menu-slide-prev, .menu-slide-next').click(function () {
        if ($('.menu-slide').hasClass('slick-initialized')) {
            $('.menu-slide').slick($(this).hasClass('menu-slide-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});