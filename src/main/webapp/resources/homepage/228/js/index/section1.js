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

    // 공지사항 슬라이더 초기화
    $('.notice-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 8000,
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
            $(this).attr('src', '/resources/homepage/bukbu/img/main/notice-slide-play.svg');
            $(this).attr('alt', 'Play');
        } else {
            $('.notice-slide').slick('slickPlay');
            $(this).attr('src', '/resources/homepage/bukbu/img/main/notice-slide-pause.svg');
            $(this).attr('alt', 'Pause');
        }
        isPlaying = !isPlaying;
    });
});