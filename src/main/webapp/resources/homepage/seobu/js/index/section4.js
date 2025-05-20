$(document).ready(function () {
    const links = {
        'tab-content1': 'https://library.daegu.go.kr/seobu/board/index.do?menu_idx=138&manage_idx=290',
        'tab-content2': 'https://library.daegu.go.kr/seobu/intro/search/bestBook/index.do?menu_idx=15',
        'tab-content3': 'https://library.daegu.go.kr/seobu/intro/search/newBook/index.do?menu_idx=14'
    };

    $('.tab-button').click(function () {
        // 탭 active 클래스 이동
        $('.tab-button').removeClass('active-tab');
        $(this).addClass('active-tab');

        // 모든 콘텐츠 숨기고 해당 콘텐츠만 표시
        $('.tab-content').hide();
        const target = $(this).data('target');
        $('.' + target).show();

        // 링크 변경
        const link = links[target];
        $('#tab-link').attr('href', link);
    });
});
