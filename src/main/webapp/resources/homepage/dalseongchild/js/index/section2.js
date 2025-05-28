$(document).ready(function () {
    // 팝업 슬라이더
    const $popupSlide = $('.popup-slide');
    $popupSlide.slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        arrows: false,
        dots: false,
    });

    // 초기 페이징 설정
    $popupSlide.on('init', function (event, slick) {
        $('.popup-pagination').html(`<span>1</span> / ${slick.slideCount}`);
    });

    // 슬라이드 변경 시 페이징 업데이트
    $popupSlide.on('afterChange', function (event, slick, currentSlide) {
        $('.popup-pagination').html(`<span>${currentSlide + 1}</span> / ${slick.slideCount}`);
    });

    // 이전/다음 버튼
    $('.popup-prev, .popup-next').click(function () {
        if ($popupSlide.hasClass('slick-initialized')) {
            $popupSlide.slick($(this).hasClass('popup-prev') ? 'slickPrev' : 'slickNext');
        }
    });

    // 재생/일시정지 버튼
    const $playPauseBtn = $('.popup-play-and-pause img');
    let isPlaying = true;

    $playPauseBtn.click(function () {
        if (isPlaying) {
            $popupSlide.slick('slickPause');
            $(this).attr('src', '/resources/homepage/dalseongchild/img/notice/play.svg');
        } else {
            $popupSlide.slick('slickPlay');
            $(this).attr('src', '/resources/homepage/dalseongchild/img/notice/pause.svg');
        }
        isPlaying = !isPlaying;
    });

    // 슬라이더 위치 재설정
    $popupSlide.slick('setPosition');

    // 슬라이더 재초기화 시 페이징 업데이트
    $popupSlide.on('reInit', function (event, slick) {
        $('.popup-pagination').text(`1 / ${slick.slideCount}`);
    });
});
