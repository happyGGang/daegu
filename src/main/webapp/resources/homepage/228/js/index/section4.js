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
    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');
        const link = $this.data('link');


        $('.tab-button').removeClass('active-tab');
        $this.addClass('active-tab');

        $('.tab-content').hide().filter('.' + target).show();

        $('#tab-link').attr('href', link);

        if (target === 'tab2') {
            const $tab2 = $('.tab2');
            if (!$tab2.find('.tab-list').hasClass('slick-initialized')) {
                initBookSlider($tab2);
            }
        }
    });

    $('.tab-button.active-tab').trigger('click');
});
