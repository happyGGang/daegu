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
});





