$(document).ready(function () {
    // 기본 링크 설정 (초기 상태는 신착도서)
    $('#tab-link').attr('href', `https://library.daegu.go.kr/duryu/intro/search/newBook/index.do?menu_idx=14`);

    // 탭 버튼 클릭 시
    $('.tab-button').on('click', function () {
        const target = $(this).data('target');

        // 탭 버튼 스타일 변경
        $('.tab-button').removeClass('active-tab');
        $(this).addClass('active-tab');

        // 탭 콘텐츠 전환
        $('.tab-content').hide();
        $('.' + target).show();

        // 슬라이드 제거 후 재초기화
        const $tabList = $('.' + target).find('.tab-list');

        if ($tabList.hasClass('slick-initialized')) {
            $tabList.slick('unslick');
        }

        if ($tabList.length) {
            $tabList.slick({
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
        }

        // 좌우 컨트롤 다시 연결
        $('.book-slide-prev, .book-slide-next').off('click').on('click', function () {
            if ($tabList.hasClass('slick-initialized')) {
                $tabList.slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
            }
        });

        // 링크 변경 처리
        if (target === 'tab1') {
            $('#tab-link').attr('href', `https://library.daegu.go.kr/duryu/intro/search/newBook/index.do?menu_idx=14`);
        } else if (target === 'tab2') {
            $('#tab-link').attr('href', `https://library.daegu.go.kr/duryu/board/index.do?menu_idx=41&manage_idx=233`);
        }
    });
});