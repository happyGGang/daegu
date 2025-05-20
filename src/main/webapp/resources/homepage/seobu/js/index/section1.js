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

    // 퀵메뉴 6개씩 그룹으로 묶기
    const $items = $('.quick-menu-item');
    const $container = $('.quick-menu-slide');
    $container.empty(); // 기존 아이템 제거

    for (let i = 0; i < $items.length; i += 6) {
        const $group = $('<div class="quick-menu-grid"></div>');
        $items.slice(i, i + 6).appendTo($group);
        $container.append($group);
    }

    // slick 초기화
    $container.slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: false,
        dots: false,
        swipe: true,
        infinite: true,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.quick-menu-slide-prev, .quick-menu-slide-next').click(function () {
        if ($container.hasClass('slick-initialized')) {
            $container.slick($(this).hasClass('quick-menu-slide-prev') ? 'slickPrev' : 'slickNext');
        }
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
            $(this).attr('src', '/resources/homepage/seobu/img/main/notice-slide-play.svg');
            $(this).attr('alt', 'Play');
        } else {
            $('.notice-slide').slick('slickPlay');
            $(this).attr('src', '/resources/homepage/seobu/img/main/notice-slide-pause.svg');
            $(this).attr('alt', 'Pause');
        }
        isPlaying = !isPlaying;
    });
});
