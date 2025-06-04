$(document).ready(function () {
    // Set default state to show notices
    $('.notice-list').show();
    $('.event-list').hide();
    $('.notice-board-title:contains("공지사항")').addClass('active');
    $('.notice-board-header a').attr('href', 'https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=36&manage_idx=123');

    // Click handler for notice title
    $('.notice-board-title:contains("공지사항")').click(function() {
        $('.notice-list').show();
        $('.event-list').hide();
        $('.notice-board-title').removeClass('active');
        $(this).addClass('active');
        $('.notice-board-header a').attr('href', 'https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=170&manage_idx=474');
    });

    // Click handler for event title
    $('.notice-board-title:contains("강좌·행사안내")').click(function() {
        $('.notice-list').hide();
        $('.event-list').show();
        $('.notice-board-title').removeClass('active');
        $(this).addClass('active');
        $('.notice-board-header a').attr('href', 'https://library.daegu.go.kr/dongbu/module/teach/index.do?menu_idx=30');
    });


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
        $('.popup-pagination').text(`1 / ${slick.slideCount}`);
    });

    // 슬라이드 변경 시 페이징 업데이트
    $popupSlide.on('afterChange', function (event, slick, currentSlide) {
        $('.popup-pagination').text(`${currentSlide + 1} / ${slick.slideCount}`);
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
            $(this).attr('src', '/resources/homepage/dongbu/img/notice/play.svg');
        } else {
            $popupSlide.slick('slickPlay');
            $(this).attr('src', '/resources/homepage/dongbu/img/notice/pause.svg');
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
