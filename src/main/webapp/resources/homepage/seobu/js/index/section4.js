$(document).ready(function () {
    const links = {
        tab1: 'https://library.daegu.go.kr/seobu/board/index.do?menu_idx=138&manage_idx=290',
        tab2: 'https://library.daegu.go.kr/seobu/intro/search/bestBook/index.do?menu_idx=15',
        tab3: 'https://library.daegu.go.kr/seobu/intro/search/newBook/index.do?menu_idx=14'
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
});