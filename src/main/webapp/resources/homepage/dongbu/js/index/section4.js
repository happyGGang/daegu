$(document).ready(function () {
    const links = {
        tab1: 'https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=138&manage_idx=290',
        tab2: 'https://library.daegu.go.kr/dongbu/intro/search/bestBook/index.do?menu_idx=15',
        tab3: 'https://library.daegu.go.kr/dongbu/intro/search/newBook/index.do?menu_idx=14'
    };

    const linkTexts = {
        tab1: '신착도서 더보기',
        tab2: '대출베스트 더보기',
        tab3: '사서&북큐레이션 더보기'
    };

    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');

        $('.tab-button').removeClass('active-tab').filter($this).addClass('active-tab');
        $('.tab-content').hide().filter('.' + target).show();

        const link = links[target];
        const linkText = linkTexts[target];

        if (link) {
            $('#tab-link').attr('href', link);
            $('#tab-link div').text(linkText);
        } else {
            console.error('Link or linkText not found for target:', target);
        }

        // 탭 컨텐츠가 Ajax로 로드되었다면, 새로 슬라이더 초기화 필요
        // 예: loadTabContent('.' + target, link); // 만약 Ajax를 통해 컨텐츠 로드한다면 이렇게 호출!
        initBookSlider($('.' + target)); // 선택한 탭 슬라이더 초기화
    }).filter('.active-tab').trigger('click');
});

function initBookSlider($tab) {
    const $bookSlide = $tab.find('.book-slide');
    const $mainBookSlide = $tab.find('.main-book-slide');

    // book-slide와 main-book-slide가 둘 다 있어야 asNavFor 연결 가능
    if (
            $bookSlide.length &&
            !$bookSlide.hasClass('slick-initialized') &&
            $mainBookSlide.length &&
            !$mainBookSlide.hasClass('slick-initialized')
    ) {
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

function loadTabContent(selector, url) {
    const $tab = $(selector);
    $tab.html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    $tab.load(url, function () {
        initBookSlider($tab);
    });
}
