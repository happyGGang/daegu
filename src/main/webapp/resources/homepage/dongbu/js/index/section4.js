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
    const $bookSlide = $tab.find('.book-slide');
    const $mainBookSlide = $tab.find('.main-book-slide');

    // 이미 slick 초기화된 경우 제거 후 다시 적용
    if ($bookSlide.hasClass('slick-initialized')) {
        $bookSlide.slick('unslick');
    }

    if ($mainBookSlide.hasClass('slick-initialized')) {
        $mainBookSlide.slick('unslick');
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
            asNavFor: $mainBookSlide,
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
    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');
        const link = $this.data('link');
        const text = $this.data('text');

        $('.tab-button').removeClass('active-tab');
        $this.addClass('active-tab');

        $('.tab-content').hide().filter('.' + target).show();

        $('#tab-link').attr('href', link);
        $('#tab-link > div').text(text);

        if (target === 'tab3') {
            const $tab2 = $('.tab3');
            if (!$tab2.find('.tab-list').hasClass('slick-initialized')) {
                initBookSlider($tab2);
            }
        }
    });

    $('.tab-button.active-tab').trigger('click');
});
