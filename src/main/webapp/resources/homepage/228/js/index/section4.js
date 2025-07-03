function loadTabContent(selector, url) {
    const $tab = $(selector);

    // 로딩 애니메이션 표시
    $tab.html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    // ajax로 콘텐츠 불러온 뒤 슬라이드 초기화
    $tab.load(url, function () {
        initBookSlider($tab);
    });
}

function initBookSlider($tab) {
    const $bookSlide = $tab.find('.tab-list');

    // 이미 slick 초기화된 경우 제거 후 다시 적용
    if ($bookSlide.hasClass('slick-initialized')) {
        $bookSlide.slick('unslick');
    }

    // 슬릭 슬라이더 재초기화
    if ($bookSlide.length) {
        $bookSlide.slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: false,
            arrows: false,
            dots: false,
            variableWidth: true,
            responsive: [
                { breakpoint: 1260, settings: { slidesToShow: 4, variableWidth: true } },
                { breakpoint: 865,  settings: { slidesToShow: 3, variableWidth: true } },
            ],
        });
    }

    // 이전/다음 버튼 이벤트 재연결
    $tab.find('.book-slide-prev, .book-slide-next')
      .off('click')
      .on('click', function () {
          if ($bookSlide.hasClass('slick-initialized')) {
              $bookSlide.slick(
                $(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext'
              );
          }
      });
}

$(document).ready(function () {
    const links = {
        tab1: 'https://library.daegu.go.kr/228/intro/search/newBook/index.do?menu_idx=14',
        tab2: 'https://library.daegu.go.kr/228/board/index.do?menu_idx=41&manage_idx=75',
        tab3: 'https://library.daegu.go.kr/228/intro/search/bestBook/index.do?menu_idx=15'
    };

    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');

        // 탭 버튼 스타일 처리
        $('.tab-button').removeClass('active-tab');
        $this.addClass('active-tab');

        // 탭 콘텐츠 show/hide
        $('.tab-content').hide().filter('.' + target).show();

        // 해당 탭 콘텐츠 불러오기 및 슬라이드 초기화
        const link = links[target];
        if (link) {
            $('#tab-link').attr('href', link);
            loadTabContent('.' + target, link);
        } else {
            console.error('Link not found for target:', target);
        }
    });

    // 첫 번째 탭 강제 클릭
    $('.tab-button.active-tab').trigger('click');
});
