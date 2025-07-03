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
        speed: 300,
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
        $('.main-popup-pagination-item').removeClass('active').show();

        if ($(window).width() <= 768) {
            // 768px 이하일 때
            if (currentSlide === 0 || currentSlide === 1) {
                // 슬라이드 1, 2일 때 페이지네이션 3, 4번 숨기기
                $('.main-popup-pagination-item').eq(2).hide();
                $('.main-popup-pagination-item').eq(3).hide();
                $('.main-popup-pagination-item').eq(currentSlide).addClass('active');
            } else if (currentSlide === 2 || currentSlide === 3) {
                // 슬라이드 3, 4일 때 페이지네이션 1, 2번 숨기기
                $('.main-popup-pagination-item').eq(0).hide();
                $('.main-popup-pagination-item').eq(1).hide();
                $('.main-popup-pagination-item').eq(currentSlide).addClass('active');
            }
        } else {
            // 768px 초과일 때: 현재 슬라이드에 해당하는 페이지네이션만 활성화
            $('.main-popup-pagination-item').eq(currentSlide).addClass('active');
        }
    }

    // 슬라이더 변경 시 페이지네이션 UI 업데이트
    $('.main-popup').on('afterChange', function (event, slick, currentSlide) {
        updatePagination(currentSlide);
    });

    // 페이지네이션 클릭 이벤트 처리
    $('.main-popup-pagination-item').click(function () {
        var index = $(this).index();

        // 슬라이더 이동
        $('.main-popup').slick('slickGoTo', index);

        // 페이지네이션 업데이트
        updatePagination(index);
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

    // 창 크기 변경 시 페이지네이션 업데이트!
    $(window).resize(function () {
        updatePagination($('.main-popup').slick('slickCurrentSlide'));
    });
});