function loadTabContent(selector, url) {
    const $tab = $(selector);

    $tab.html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    $tab.load(url, function () {
        initBookSlider($tab);
    });
}

function initBookSlider($tab) {
    const $bookSlide = $tab.find('.tab-list');
    if ($bookSlide.length && !$bookSlide.hasClass('slick-initialized')) {
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
    const links = {
        tab1: '/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14',
        tab2: '/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=75',
        tab3: '/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15'
    };

    $('.tab-button').click(function () {
        const $this = $(this);
        const target = $this.data('target');

        $('.tab-button').removeClass('active-tab').filter($this).addClass('active-tab');
        $('.tab-content').hide().filter('.' + target).show();

        const link = links[target];
        if (link) $('#tab-link').attr('href', link);
        else console.error('Link not found for target:', target);
    }).filter('.active-tab').trigger('click');

    $('.tab-list').slick({
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

    // 이전/다음 버튼
    $('.book-slide-prev, .book-slide-next').click(function () {
        if ($('.tab-list').hasClass('slick-initialized')) {
            $('.tab-list').slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
        }
    });
});