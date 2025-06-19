$(document).ready(function () {
    // slick 초기화
    $('.course-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: false,
        dots: false,
        swipe: true,
        infinite: true,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.course-slide-prev, .course-slide-next').click(function () {
        if ($('.course-slide').hasClass('slick-initialized')) {
            $('.course-slide').slick($(this).hasClass('course-slide-prev') ? 'slickPrev' : 'slickNext');
        }
    });

    $('.movie-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: false,
        dots: false,
        swipe: true,
        infinite: true,
        variableWidth: true,
    });

    // 이전/다음 버튼
    $('.movie-slide-prev, .movie-slide-next').click(function () {
        if ($('.movie-slide').hasClass('slick-initialized')) {
            $('.movie-slide').slick($(this).hasClass('movie-slide-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});
