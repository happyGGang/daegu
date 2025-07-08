$(document).ready(function () {
    const $popupSlide = $('.popup-slide');
    const $popupPagination = $('.popup-pagination');

    // 슬라이더 초기화 전 이벤트 바인딩
    $popupSlide.on('init', function (event, slick) {
        const slideCount = slick.slideCount || 1;
        $popupPagination.text(`1 / ${slideCount}`);
    });

    $popupSlide.on('afterChange', function (event, slick, currentSlide) {
        const slideCount = slick.slideCount || 1;
        $popupPagination.text(`${currentSlide + 1} / ${slideCount}`);
    });

    $popupSlide.on('reInit', function (event, slick) {
        const slideCount = slick.slideCount || 1;
        $popupPagination.text(`1 / ${slideCount}`);
    });

    // 슬라이더 초기화
    $popupSlide.slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        arrows: false,
        dots: false,
        speed: 300,
    });

    // 이전/다음 버튼
    $('.popup-prev, .popup-next').on('click', function () {
        if ($popupSlide.hasClass('slick-initialized')) {
            $popupSlide.slick($(this).hasClass('popup-prev') ? 'slickPrev' : 'slickNext');
        }
    });

    // 재생/일시정지 버튼
    const $playPauseBtn = $('.popup-play-and-pause img');
    let isPlaying = true;

    $playPauseBtn.on('click', function () {
        if (isPlaying) {
            $popupSlide.slick('slickPause');
            $(this).attr('src', '/resources/homepage/duryu/img/notice/play.svg');
        } else {
            $popupSlide.slick('slickPlay');
            $(this).attr('src', '/resources/homepage/duryu/img/notice/pause.svg');
        }
        isPlaying = !isPlaying;
    });
});
