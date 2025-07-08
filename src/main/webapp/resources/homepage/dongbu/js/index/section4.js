$(document).ready(function () {
    const links = {
        tab1: 'https://library.daegu.go.kr/dongbu/intro/search/newBook/index.do?menu_idx=14',
        tab2: 'https://library.daegu.go.kr/dongbu/intro/search/bestBook/index.do?menu_idx=15',
        tab3: 'https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=41&manage_idx=254'
    };

    const linkTexts = {
        tab1: '신착도서 더보기',
        tab2: '대출베스트 더보기',
        tab3: '사서&북큐레이션 더보기'
    };

    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');

        // 탭 버튼 스타일 업데이트
        $('.tab-button').removeClass('active-tab');
        $this.addClass('active-tab');

        // 탭 콘텐츠 show/hide
        $('.tab-content').hide();
        $('.' + target).show();

        const link = links[target];
        const linkText = linkTexts[target];

        if (link) {
            $('#tab-link').attr('href', link);
            $('#tab-link div').text(linkText);
            // Ajax로 콘텐츠 로드 및 슬라이더 초기화
            loadTabContent('.' + target, link);
        } else {
            console.error('Link or linkText not found for target:', target);
        }
    });

    // 첫 번째 탭 자동 클릭
    $('.tab-button.active-tab').trigger('click');
});

function loadTabContent(selector, url) {
    const $tab = $(selector);
    $tab.html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    $tab.load(url, function () {
        initBookSlider($tab);
    });
}

function initBookSlider($tab) {
    const $bookSlide = $tab.find('.book-slide');
    const $mainBookSlide = $tab.find('.main-book-slide');

    // 기존 슬릭 제거 후 재초기화 (있다면)
    if ($bookSlide.hasClass('slick-initialized')) {
        $bookSlide.slick('unslick');
    }
    if ($mainBookSlide.hasClass('slick-initialized')) {
        $mainBookSlide.slick('unslick');
    }

    // 슬릭 슬라이더 재초기화
    if ($bookSlide.length && $mainBookSlide.length) {
        $bookSlide.slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            arrows: false,
            dots: false,
            variableWidth: true,
            asNavFor: $mainBookSlide
        });

        $mainBookSlide.slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            arrows: false,
            dots: false,
            variableWidth: true,
            asNavFor: $bookSlide
        });
    }

    // 이전/다음 버튼 이벤트 연결
    $tab.find('.book-slide-prev, .book-slide-next')
      .off('click')
      .on('click', function () {
          if ($bookSlide.hasClass('slick-initialized')) {
              $bookSlide.slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
          }
      });
}
