$(document).ready(function () {
    const screenWidth = window.innerWidth;

    let bgCulture, bgProgram;

    if (screenWidth <= 440) {
        bgCulture = 'url("/resources/homepage/dalseongchild/img/culture/360_1.png") no-repeat center center';
        bgProgram = 'url("/resources/homepage/dalseongchild/img/culture/360_2.png") no-repeat center center';
    } else if (screenWidth <= 840) {
        bgCulture = 'url("/resources/homepage/dalseongchild/img/culture/768_1.png") no-repeat center center';
        bgProgram = 'url("/resources/homepage/dalseongchild/img/culture/768_2.png") no-repeat center center';
    } else if (screenWidth <= 1260) {
        bgCulture = 'url("/resources/homepage/dalseongchild/img/culture/1024_1.png") no-repeat center center';
        bgProgram = 'url("/resources/homepage/dalseongchild/img/culture/1024_2.png") no-repeat center center';
    } else {
        bgCulture = 'url("/resources/homepage/dalseongchild/img/culture/cultrue-bg.svg") no-repeat center center';
        bgProgram = 'url("/resources/homepage/dalseongchild/img/culture/program-bg.svg") no-repeat center center';
    }

    const tabSettings = {
        culture: {
            content1: 'block',
            content2: 'none',
            bg: bgCulture
        },
        program: {
            content1: 'none',
            content2: 'block',
            bg: bgProgram
        }
    };

    function setTabState($tab) {
        $('.tab').removeClass('active').find('img').attr('src', '/resources/homepage/dalseongchild/img/culture/more.svg');
        $tab.addClass('active').find('img').attr('src', '/resources/homepage/dalseongchild/img/culture/active-more.svg');

        const content = $tab.data('content');
        $('.tab-content1').css('display', tabSettings[content].content1);
        $('.tab-content2').css('display', tabSettings[content].content2);
        $('.board-wrapper').css('background', tabSettings[content].bg);
    }

    // Set initial state
    setTabState($('.tab.active'));

    // Handle tab click
    $('.tab').click(function () {
        setTabState($(this));
    });
});
