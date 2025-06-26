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

    // 탭 클릭 이벤트
    $('.section3-tab > div').on('click', function () {
        // 탭 활성화 스타일
        $('.section3-tab > div').removeClass('section3-tab-active');
        $(this).addClass('section3-tab-active');

        // 모든 콘텐츠 숨김
        $('.section3-content4, .section3-content5, .section3-content6, .section3-content7').hide();

        // 클릭된 탭의 data-target에 맞는 콘텐츠 표시
        const target = $(this).data('target');
        const $targetContent = $('.section3-content' + target);
        $targetContent.show();

        // 슬릭 재초기화
        const $slide = $targetContent.find('.section3-slide');
        if ($slide.hasClass('slick-initialized')) {
            $slide.slick('unslick');
        }
        initSlick();

        // 링크 변경
        const newLink = $(this).data('link');
        $('.tab-link2').attr('href', newLink);
    });

    // 초기 슬릭 실행
    initSlick();

    // 이전 버튼
    $('.section3-slide-prev').click(function () {
        $('.section3-slide.slick-initialized').slick('slickPrev');
    });

    // 다음 버튼
    $('.section3-slide-next').click(function () {
        $('.section3-slide.slick-initialized').slick('slickNext');
    });
});
