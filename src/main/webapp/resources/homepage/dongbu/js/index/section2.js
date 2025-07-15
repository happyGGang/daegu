$(document).ready(function () {
    // Set default state to show notices
    $('.notice-list').hide();
    $('.event-list').show();
    $('.notice-board-title:contains("강좌·행사안내")').addClass('active');
    $('.notice-board-header a').attr('href', 'https://library.daegu.go.kr/dongbu/module/teach/index.do?menu_idx=30');

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
            $(this).attr('src', '/resources/homepage/dongbu/img/notice/play.svg');
        } else {
            $popupSlide.slick('slickPlay');
            $(this).attr('src', '/resources/homepage/dongbu/img/notice/pause.svg');
        }
        isPlaying = !isPlaying;
    });
});
