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

function loadTabContent(selector, url) {
    const $tab = $(selector);

    $tab.html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    $tab.load(url, function () {
        initBookSlider($tab);
    });
}
