$(document).ready(function () {
  // 슬라이더 초기화
  $('.section4-slide').slick({
    slidesToShow: 1,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 5000,
    dots: false,
    swipe: true,
    infinite: true,
    speed: 300,
    initialSlide: 0,
    fade: true,
    cssEase: 'linear',
    pauseOnHover: false,
    pauseOnFocus: false
  });

  // 슬라이드 변경 시 active 클래스 처리
  $('.section4-slide').on('afterChange', function (event, slick, currentSlide) {
    $('.section4-pagination-item').removeClass('active');
    $('.section4-pagination-item').eq(currentSlide).addClass('active');
  });

  // 페이지네이션 클릭 시 해당 슬라이드로 이동
  $('.section4-pagination-item').on('click', function () {
    const index = $(this).index();
    $('.section4-slide').slick('slickGoTo', index);
  });

  // 초기 상태 active 클래스 적용
  $('.section4-pagination-item').eq(0).addClass('active');

  // 이전/다음 버튼
  $('.section4-slide-prev').click(function () {
    $('.section4-slide').slick('slickPrev');
  });

  $('.section4-slide-next').click(function () {
    $('.section4-slide').slick('slickNext');
  });
});
