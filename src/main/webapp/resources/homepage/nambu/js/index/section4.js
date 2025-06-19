$(document).ready(function () {
  // 팝업 슬라이더
  const $bookSlide = $('.recommended-book-slide');
  $bookSlide.slick({
    slidesToShow: 5,
    slidesToScroll: 1,
    autoplay: false,
    arrows: false,
    dots: false,
    variableWidth: true,
    responsive: [
      {
        breakpoint: 1260,
        settings: {
          slidesToShow: 4,
          variableWidth: true,
        },
      },
      {
        breakpoint: 865,
        settings: {
          slidesToShow: 2,
          variableWidth: true,
        },
      },
      {
        breakpoint: 490,
        settings: {
          slidesToShow: 1,
          variableWidth: true,
        },
      },
    ],
  });

  // 이전/다음 버튼
  $('.recommended-book-slide-prev, .recommended-book-slide-next').off(
      'click').on('click', function () {
    if ($bookSlide.hasClass('slick-initialized')) {
      $bookSlide.slick(
          $(this).hasClass('recommended-book-slide-prev') ? 'slickPrev'
              : 'slickNext'
      );
    }
  });

  $('.book-slide').slick({
    slidesToShow: 5,
    slidesToScroll: 1,
    autoplay: false,
    arrows: false,
    dots: false,
    variableWidth: true,
    responsive: [
      {
        breakpoint: 1260,
        settings: {
          slidesToShow: 4,
          variableWidth: true,
        },
      },
      {
        breakpoint: 865,
        settings: {
          slidesToShow: 3,
          variableWidth: true,
        },
      },
    ],
  });

  $('.book-slide-prev, .book-slide-next').off('click').on('click', function () {
    if ($('.book-slide').hasClass('slick-initialized')) {
      $('.book-slide').slick(
          $(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
    }
  });
});
