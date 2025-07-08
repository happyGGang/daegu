$(document).ready(function () {
    // 초기 페이징 설정 이벤트 바인딩
    $('.main-popup')
            .on('init', function (event, slick) {
                $('.popup-pagination').text(`1 / ${slick.slideCount}`);
            })
            .on('afterChange', function (event, slick, currentSlide) {
                $('.popup-pagination').text(`${currentSlide + 1} / ${slick.slideCount}`);
            })
            .on('reInit', function (event, slick) {
                $('.popup-pagination').text(`1 / ${slick.slideCount}`);
            });

    // 메인 팝업 슬라이더 초기화
    $('.main-popup').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 8000,
        dots: false,
        swipe: true,
        infinite: true,
        asNavFor: '.main-bg-slide',
        speed: 300,
        initialSlide: 0
    });

    // 메인 배경 슬라이더 초기화
    $('.main-bg-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 8000,
        dots: false,
        swipe: false,
        infinite: true,
        fade: true,
        cssEase: 'linear',
        asNavFor: '.main-popup',
        speed: 300
    });

    // 이전/다음 버튼
    $('.main-popup-prev').click(function () {
        $('.main-popup').slick('slickPrev');
    });
    $('.main-popup-next').click(function () {
        $('.main-popup').slick('slickNext');
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
