$(document).ready(function () {
    const links = {
        tab1: 'https://library.daegu.go.kr/seobu/board/index.do?menu_idx=138&manage_idx=290',
        tab2: 'https://library.daegu.go.kr/seobu/intro/search/bestBook/index.do?menu_idx=15',
        tab3: 'https://library.daegu.go.kr/seobu/intro/search/newBook/index.do?menu_idx=14'
    };

    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');

        // 탭 스타일 처리
        $('.tab-button').removeClass('active-tab').filter($this).addClass('active-tab');
        $('.tab-content').hide().filter('.' + target).show();

        // 링크 변경
        const link = links[target];
        if (link) $('#tab-link').attr('href', link);
        else console.error('Link not found for target:', target);

        // 🔄 슬라이더 재초기화
        const $tab = $('.' + target);
        const $bookSlide = $tab.find('.tab-list');

        if ($bookSlide.length) {
            if ($bookSlide.hasClass('slick-initialized')) {
                $bookSlide.slick('unslick'); // destroy
            }

            // init
            $bookSlide.slick({
                slidesToShow: 5,
                slidesToScroll: 1,
                autoplay: false,
                arrows: false,
                dots: false,
                variableWidth: true,
                responsive: [
                    { breakpoint: 1260, settings: { slidesToShow: 4, variableWidth: true } },
                    { breakpoint: 865, settings: { slidesToShow: 3, variableWidth: true } },
                ],
            });

            // prev/next 버튼 이벤트 다시 연결
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
    });

    // 첫 탭 자동 트리거
    $('.tab-button.active-tab').trigger('click');
});
