$(document).ready(function () {
    // 메인 배경
    $('.book-slide').slick({
        slidesToShow: 6,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 5000,
        dots: false,
        swipe: true,
        infinite: true,
        variableWidth: true,
    });

    $('.book-content-tab[data-target="recommended"]').addClass('active');
    $('.recommended').show();
    $('.new').hide();

    // 탭 클릭 이벤트
    $('.book-content-tab').on('click', function() {
        // 모든 탭에서 active 클래스 제거
        $('.book-content-tab').removeClass('active');
        // 클릭한 탭에 active 클래스 추가
        $(this).addClass('active');

        // 모든 콘텐츠 숨기기
        $('.recommended, .new').hide();
        // 클릭한 탭의 타겟 콘텐츠 표시
        var target = $(this).data('target');
        $('.' + target).show();
    });
});
