// 슬릭 오류 방지
jQuery.event.special.touchstart = {
    setup: function (_, ns, handle) {
        this.addEventListener('touchstart', handle, { passive: false });
    },
};
jQuery.event.special.touchmove = {
    setup: function (_, ns, handle) {
        this.addEventListener('touchmove', handle, { passive: false });
    },
};

$(document).ready(function () {
    // 팝업 슬라이더
    $('.banner-slide').slick({
        slidesToShow: 6,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        arrows: false,
        dots: false,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.banner-prev, .banner-next').click(function () {
        if ($('.banner-slide').hasClass('slick-initialized')) {
            $('.banner-slide').slick($(this).hasClass('banner-prev-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});





