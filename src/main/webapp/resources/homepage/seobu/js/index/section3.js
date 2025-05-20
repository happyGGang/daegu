$(document).ready(function () {
    // 행사일 슬라이더
    $('.event-slide').slick({
        slidesToShow: 12,
        slidesToScroll: 1,
        autoplay: false,
        arrows: false,
        dots: false,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.event-slide-prev, .event-slide-next').click(function () {
        if ($('.event-slide').hasClass('slick-initialized')) {
            $('.event-slide').slick($(this).hasClass('event-slide-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});
