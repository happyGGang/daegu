$(document).ready(function () {
    // 메인 배경
    $('.main-bg-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: true,
        infinite: true,
        fade: true,
        cssEase: 'linear',
    });

    // Slick Slider 초기화
    $('.notice-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: true,
        infinite: true,
        vertical: true,
        verticalSwiping: false
    });

    // 재생/일시정지 버튼
    const $playPauseBtn = $('.notice-slide-wrapper img');
    let isPlaying = true;

    $playPauseBtn.on('click', function () {
        if (isPlaying) {
            $('.notice-slide').slick('slickPause');
            $(this).attr('src', '/resources/homepage/dalseong/img/main/notice-slide-play.svg');
            $(this).attr('alt', 'Play');
        } else {
            $('.notice-slide').slick('slickPlay');
            $(this).attr('src', '/resources/homepage/dalseong/img/main/notice-slide-pause.svg');
            $(this).attr('alt', 'Pause');
        }
        isPlaying = !isPlaying;
    });
});
