$(document).ready(function() {
    const tabSettings = {
        culture: {
            content1: 'block',
            content2: 'none',
            bg: 'url("/resources/homepage/dalseongchild/img/culture/cultrue-bg.svg") no-repeat center center'
        },
        program: {
            content1: 'none',
            content2: 'block',
            bg: 'url("/resources/homepage/dalseongchild/img/culture/program-bg.svg") no-repeat center center'
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
    $('.tab').click(function() {
        setTabState($(this));
    });
});