// 슬릭 오류 방지
jQuery.event.special.touchstart = {
    setup: function (_, ns, handle) {
        this.addEventListener('touchstart', handle, { passive: false });
    },
};
jQuery.event.special.touchmove = {
    setup: function (_, ns, handle) {
        this.addEventListener('touchmove', handle, { passive: false });
    },
};


// 쿠키
function setCookie(name, value) {
    const now = new Date();
    const midnight = new Date();
    midnight.setHours(24, 0, 0, 0);
    document.cookie = name + "=" + value + ";expires=" + midnight.toUTCString() + ";path=/";
}

function getCookie(name) {
    const value = document.cookie.match('(^|;)\\s*' + name + '\\s*=\\s*([^;]+)');
    return value ? value.pop() : '';
}

$(document).ready(function () {
    // 우클릭 방지
    $(document).on('contextmenu', function(e) {
        return false;
    });


    let zoomLevel = 1; // 초기 줌 레벨

    $('#plus').on('click', function() {
        zoomLevel += 0.1; // 10% 증가
        applyZoom();
    });

    $('#minus').on('click', function() {
        zoomLevel = Math.max(0.1, zoomLevel - 0.1); // 10% 감소, 최소 10% 유지
        applyZoom();
    });

    function applyZoom() {
        // CSS zoom 속성 적용
        $('body').css('zoom', zoomLevel);

        // 브라우저 호환성을 위해 transform 사용 (Safari 등에서 더 나은 결과)
        $('body').css({
            'transform': `scale(${zoomLevel})`,
            'transform-origin': '0 0' // 왼쪽 상단 기준으로 확대/축소
        });
    }

    // 페이지 진입 시 쿠키 확인
    if (getCookie('hideTodayPopup') !== 'Y') {
        $('.total-popup-overlay, .total_popup_area').css('display', 'flex');
    }

    // 팝업 트리거 클릭 시
    $('.total-popup-trigger').on('click', function () {
        $('.total-popup-overlay, .total_popup_area').css('display', 'flex');
    });

    // 닫기 버튼
    $('.popup-close').on('click', function () {
        $('.total-popup-overlay, .total_popup_area').css('display', 'none')
    });

    // 오늘 하루 보지 않기
    $('.popup-today-close').on('click', function () {
        setCookie('hideTodayPopup', 'Y');
        $('.total-popup-overlay, .total_popup_area').css('display', 'none');
    });

    // 통합 팝업 슬라이드
    $('.total-popup-slide').slick({
        slidesToShow: 3,
        slidesToScroll: 1,
        infinite: true,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 3000,
        speed: 300,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 1385,
                settings: {
                    slidesToShow: 2,
                    variableWidth: true,
                },
            },
            {
                breakpoint: 980,
                settings: {
                    slidesToShow: 1,
                    variableWidth: true,
                },
            },
        ],
    });

    $('.total-popup-slide-prev').click(function () {
        $('.total-popup-slide').slick('slickPrev');
    });

    $('.total-popup-slide-next').click(function () {
        $('.total-popup-slide').slick('slickNext');
    });





    // 메인 메뉴
    // 1. data-menu 속성 동적으로 부여
    $('.one-depth-menu a').each(function (index) {
        $(this).attr('data-menu', 'menu' + index);
    });

    $('.two-depth-menu').each(function (index) {
        $(this).attr('data-menu', 'menu' + index);
    });

    // 전역 변수로 현재 활성화된 menuKey 기억
    let currentMenuKey = null;

    // 2. 원뎁스 메뉴 호버 시
    $('.one-depth-menu a').on('mouseenter', function () {
        currentMenuKey = $(this).data('menu');

        $('.two-depth-menu-wrapper').css('display', 'flex');

        $('.two-depth-menu').removeClass('active');
        $('.two-depth-menu[data-menu="' + currentMenuKey + '"]').addClass('active');
    });

    // ✅ 3. 투뎁스 메뉴 영역에서도 a 태그 hover 시 active 전환
    $('.two-depth-menu-wrapper .two-depth-menu').on('mouseenter', function () {
        const thisKey = $(this).data('menu');

        if (thisKey !== currentMenuKey) {
            currentMenuKey = thisKey;
            $('.two-depth-menu').removeClass('active');
            $('.two-depth-menu[data-menu="' + currentMenuKey + '"]').addClass('active');
        }
    });

    // 4. 투뎁스 메뉴 위에 마우스가 있을 때 유지
    $('.two-depth-menu-wrapper').on('mouseenter', function () {
        $(this).css('display', 'flex');
    });

    // 5. 영역 밖으로 벗어나면 숨기기
    $(document).on('mousemove', function (e) {
        const $target = $(e.target);
        const isOutside = !$target.closest('.one-depth-menu').length && !$target.closest('.two-depth-menu-wrapper').length;

        if (isOutside) {
            $('.two-depth-menu-wrapper').css('display', 'none');
            $('.two-depth-menu').removeClass('active');
            currentMenuKey = null;
        }
    });




    // 모바일 메인 메뉴
    var $menu = $('#mobile-menu');

    $menu.mmenu({
        "offCanvas": {
            "position": "right"
        },
        "slidingSubmenus": false,
        "extensions": ["shadow-page", "pagedim-black", "border-full"],
        "navbars": [{
            position: "top",
            content: [
                $('#mobile-menu-header').html()
            ]
        }]
    });

    var API = $menu.data('mmenu');

    $('.mobile-menu-trigger').on('click', function (e) {
        e.preventDefault();
        API.open();
    });



    
    // 배너 슬라이드
    $('.banner-slide').slick({
        slidesToShow: 7,
        slidesToScroll: 1,
        infinite: true,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 3000,
        speed: 300,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 1600,
                settings: {
                    slidesToShow: 7,
                    variableWidth: true,
                },
            },
            {
                breakpoint: 1440,
                settings: {
                    slidesToShow: 6,
                    variableWidth: true,
                },
            },
            {
                breakpoint: 1260,
                settings: {
                    slidesToShow: 5,
                    variableWidth: true,
                },
            },
            {
                breakpoint: 1170,
                settings: {
                    slidesToShow: 4,
                    variableWidth: true,
                },
            },
            {
                breakpoint: 865,
                settings: {
                    slidesToShow: 2,
                    variableWidth: true,
                },
            },
        ],
    });

    $('.banner-prev, .banner-next').click(function () {
        if ($('.banner-slide').hasClass('slick-initialized')) {
            $('.banner-slide').slick($(this).hasClass('main-popup-prev') ? 'slickPrev' : 'slickNext');
        }
    });

    // 재생/일시정지 버튼
    const $playPauseBtn = $('.banner-play-and-pause');
    let isPlaying = true;

    $playPauseBtn.click(function () {
        if (isPlaying) {
            $('.banner-slide').slick('slickPause');
            $(this).attr('src', '/resources/homepage/duryu/img/common/banner-play.svg');
        } else {
            $('.banner-slide').slick('slickPlay');
            $(this).attr('src', '/resources/homepage/duryu/img/common/banner-pause.svg');
        }
        isPlaying = !isPlaying;
    });
});





