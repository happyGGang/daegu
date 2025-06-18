$(document).ready(function () {
    // 메인 팝업 슬라이더 초기화
    $('.main-popup').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: true,
        infinite: true,
        asNavFor: '.main-bg-slide',
        speed: 300, // 전환 속도 추가
        initialSlide: 0
    });

    // 메인 배경 슬라이더 초기화
    $('.main-bg-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: false,
        infinite: true,
        fade: true,
        cssEase: 'linear',
        asNavFor: '.main-popup',
        speed: 300
    });

    // 페이지네이션 UI 업데이트 함수
    function updatePagination(currentSlide) {
        $('.main-popup-pagination-item').removeClass('active').eq(currentSlide).addClass('active');
    }

    // 슬라이더 변경 시 페이지네이션 UI 업데이트
    $('.main-popup').on('afterChange', function (event, slick, currentSlide) {
        updatePagination(currentSlide);
    });

    // 페이지네이션 클릭 이벤트 처리 (반응 빠르게 개선)
    $('.main-popup-pagination-item').click(function () {
        var index = $(this).index();

        // 먼저 active 클래스 반영
        $('.main-popup-pagination-item').removeClass('active');
        $(this).addClass('active');

        // 슬라이더 이동
        $('.main-popup').slick('slickGoTo', index);
    });

    // 이전 버튼
    $('.main-popup-prev').click(function () {
        $('.main-popup').slick('slickPrev');
    });

    // 다음 버튼
    $('.main-popup-next').click(function () {
        $('.main-popup').slick('slickNext');
    });

    // 페이지 진입 시 초기 페이지네이션 활성화
    updatePagination(0);
});
