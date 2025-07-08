$(document).ready(function () {
    const $paginationWrapper = $('.main-popup-pagination');
    let $paginationItems = $('.main-popup-pagination-item');
    const totalSlides = $('.main-popup .main-popup-item').length;

    let groupSize = getGroupSize();

    function getGroupSize() {
        return window.innerWidth <= 865 ? 2 : 4;
    }

    // ✅ 그룹핑 처리 함수 (처음 + 리사이즈 때도 실행됨)
    function groupPaginationItems() {
        // 기존 그룹 래퍼 제거
        $('.pagination-border-wrapper').children().unwrap();

        groupSize = getGroupSize(); // 최신 groupSize 다시 계산

        // 새롭게 $paginationItems 갱신
        $paginationItems = $('.main-popup-pagination-item');

        // 인덱스 재설정
        $paginationItems.each(function (idx) {
            $(this).attr('data-index', idx);
        });

        for (let i = 0; i < $paginationItems.length; i += groupSize) {
            const $group = $paginationItems.slice(i, i + groupSize);
            $group.wrapAll('<div class="pagination-border-wrapper"></div>');
        }
    }

    // ✅ 페이지네이션 그룹 계산
    function getPaginationGroup(currentIndex) {
        if (totalSlides <= groupSize) {
            return Array.from({ length: totalSlides }, (_, i) => i);
        }

        const groupIndex = Math.floor(currentIndex / groupSize);
        const startIndex = groupIndex * groupSize;
        const endIndex = Math.min(startIndex + groupSize, totalSlides);

        return Array.from({ length: endIndex - startIndex }, (_, i) => startIndex + i);
    }

    // ✅ 페이지네이션 표시 처리
    function updatePagination(currentIndex) {
        const indicesToShow = getPaginationGroup(currentIndex);
        $paginationItems.hide();
        indicesToShow.forEach(index => {
            $paginationItems.eq(index).css('display', 'inline-flex');
        });

        $paginationItems.removeClass('active');
        $paginationItems.eq(currentIndex).addClass('active');
    }

    // ✅ 초기 그룹핑 실행
    groupPaginationItems();

    // ✅ 메인 슬라이더 초기화
    $('.main-popup').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 8000,
        dots: false,
        swipe: true,
        infinite: true,
        asNavFor: '.main-bg-slide',
        speed: 300,
        initialSlide: 0
    });

    $('.main-bg-slide').slick({
        slidesToShow: 1,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 8000,
        dots: false,
        swipe: false,
        infinite: true,
        fade: true,
        cssEase: 'linear',
        asNavFor: '.main-popup',
        speed: 300
    });

    // ✅ 초기 렌더
    updatePagination(0);

    // ✅ 슬라이드 변경 시
    $('.main-popup').on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        updatePagination(nextSlide);
    });

    // ✅ 페이지네이션 클릭 (이벤트 위임 방식)
    $paginationWrapper.on('click', '.main-popup-pagination-item', function () {
        const index = $(this).data('index');
        $('.main-popup').slick('slickGoTo', index);
    });

    // ✅ 이전/다음 버튼
    $('.main-popup-prev').click(function () {
        $('.main-popup').slick('slickPrev');
    });

    $('.main-popup-next').click(function () {
        $('.main-popup').slick('slickNext');
    });

    // ✅ 해상도 변경 시 그룹 다시 적용
    let resizeTimer;
    $(window).on('resize', function () {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function () {
            groupPaginationItems();
            updatePagination($('.main-popup').slick('slickCurrentSlide'));
        }, 200);
    });
});
