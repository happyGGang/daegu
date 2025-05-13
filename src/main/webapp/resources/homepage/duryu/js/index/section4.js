$(document).ready(function () {
    $('.tab-button').click(function () {
        // 탭 active 클래스 이동
        $('.tab-button').removeClass('active-tab');
        $(this).addClass('active-tab');

        // 모든 콘텐츠 숨기고 해당 콘텐츠만 표시
        $('.tab-content').hide();
        const target = $(this).data('target');
        $('.' + target).show();

        // 링크 변경
        const link = (target === 'tab-content1')
                ? 'https://library.daegu.go.kr/duryu/intro/search/newBook/index.do?menu_idx=14'
                : 'https://library.daegu.go.kr/duryu/board/index.do?menu_idx=41&manage_idx=233';

        $('#tab-link').attr('href', link);
    });
});