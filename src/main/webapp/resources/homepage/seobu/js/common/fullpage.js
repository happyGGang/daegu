$(document).ready(function () {
    let fpInstance = null;

    // FullPage.js 초기화
    function initializeFullpage() {
        if (!document.querySelector('#fullpage')) return;

        fpInstance = new fullpage('#fullpage', {
            autoScrolling: true,
            sectionSelector: ".section-wrapper",
            navigation: false,
            anchors: ['section1', 'section2', 'section3', 'section4', 'section5'],
            afterLoad: function (origin, destination, direction) {
                updateIndicator(destination.index);
            },
        });
    }

    // FullPage.js 활성화 / 비활성화
    function checkFullpageStatus() {
        const isMobile = window.matchMedia('(max-width: 1600px)').matches;

        if (isMobile && fpInstance) {
            fullpage_api.destroy('all');
            fpInstance = null;
            document.querySelector('#fullpage').style.height = 'auto';
        } else if (!isMobile && !fpInstance) {
            initializeFullpage();
        }
    }

    // 인디케이터 활성화 표시
    function updateIndicator(index) {
        const navItems = document.querySelectorAll('#fullpage-indicator div');
        navItems.forEach((item, i) => {
            item.classList.toggle('active', i === index);
        });
    }

    // 커스텀 내비게이션 클릭 이벤트 설정
    function setupCustomNav() {
        document.querySelectorAll('#fullpage-indicator div').forEach((navItem) => {
            navItem.addEventListener('click', function (e) {
                e.preventDefault();
                const sectionAnchor = this.getAttribute('data-menuanchor');

                if (fpInstance) {
                    fullpage_api.moveTo(sectionAnchor);
                } else {
                    const targetSection = document.querySelector(`.section-wrapper[data-anchor="${sectionAnchor}"]`);
                    if (targetSection) {
                        targetSection.scrollIntoView({ behavior: 'smooth' });
                    }
                }
            });
        });
    }

    // 초기 실행
    checkFullpageStatus(); // ✅ DOM ready 되자마자 실행
    setupCustomNav();      // ✅ 클릭 이벤트도 즉시 바인딩

    // section1 클래스 붙이기
    const customNav = document.querySelector('#fullpage-indicator');
    if (document.querySelector('.section-wrapper[data-anchor="section1"]')) {
        customNav.classList.add('section1');
    }

    // 리사이즈 대응
    window.addEventListener('resize', checkFullpageStatus);
});
