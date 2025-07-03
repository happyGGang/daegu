$(document).ready(function () {
    // 슬릭 초기화 함수
    function initSlick() {
        $('.section3-slide').not('.slick-initialized').slick({
            slidesToShow: 1,
            arrows: false,
            autoplay: false,
            dots: false,
            swipe: true,
            infinite: true,
            variableWidth: true,
        });
    }

    // 초기 링크 설정: 기본 탭 활성화된 div에서 링크 추출
    const $defaultTab = $('.section3-tab > div.section3-tab-active');
    const defaultLink = $defaultTab.data('link');
    $('.tab-link2').attr('href', defaultLink); // 기본 링크 설정

    // 탭 클릭 이벤트
    $('.section3-tab > div').on('click', function () {
        const $this = $(this);
        const target = $this.data('target');

        // 탭 스타일
        $('.section3-tab > div').removeClass('section3-tab-active');
        $this.addClass('section3-tab-active');

        // 콘텐츠 전환
        $('.section3-content4, .section3-content5, .section3-content6, .section3-content7').hide();
        const $targetContent = $('.section3-content' + target).show();

        // 슬릭 초기화
        const $slide = $targetContent.find('.section3-slide');
        if ($slide.hasClass('slick-initialized')) {
            $slide.slick('unslick');
        }
        initSlick();

        // 링크 변경
        const newLink = $this.data('link');
        $('.tab-link2').attr('href', newLink);
    });

    // 슬릭 초기 실행
    initSlick();

    // 이전/다음 버튼
    $('.section3-slide-prev').click(function () {
        $('.section3-slide.slick-initialized').slick('slickPrev');
    });

    $('.section3-slide-next').click(function () {
        $('.section3-slide.slick-initialized').slick('slickNext');
    });
});
