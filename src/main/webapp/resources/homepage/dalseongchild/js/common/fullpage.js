$(document).ready(function () {
    let fpInstance = null; // fpInstance를 전역으로 선언

    // FullPage.js 초기화 함수
    function initializeFullpage() {
        fpInstance = new fullpage('#fullpage', {
            autoScrolling: true,
            sectionSelector: ".section-wrapper",
            navigation: false, // 기본 내비게이션을 비활성화
            anchors: ['section1', 'section2', 'section3', 'section4'],
            afterLoad: function(origin, destination, direction){
                updateIndicator(destination.index);

                var cur_page = destination.index+1;
                if (destination.index == 0 ) {
                    $('#header').addClass("background-white");
                    $('.Gnb').css('border-bottom','0');
                    $('.Gnb').css('background','none');
                    $('.tnb').css('background','none');
                }  else if( destination.index == 1 ) {
                    $('#header').removeClass("background-white");
                    $('.Gnb').css('border-bottom','1px solid #e6e6e6');
                    $('.Gnb').css('background','#fff');
                    $('.tnb').css('background','#fff');
                }	else if( destination.index == 2 ) {
                    $('#header').removeClass("background-white");
                    $('.Gnb').css('border-bottom','1px solid #e6e6e6');
                    $('.Gnb').css('background','#fff');
                    $('.tnb').css('background','#fff');
                }  else if( destination.index == 3 ) {
                    $('#header').removeClass("background-white");
                    $('.Gnb').css('border-bottom','1px solid #e6e6e6');
                    $('.Gnb').css('background','#fff');
                    $('.tnb').css('background','#fff');
                } else {
                    $('#header').removeClass("background-white");
                    $('.Gnb').css('border-bottom','1px solid #e6e6e6');
                    $('.Gnb').css('background','#fff');
                    $('.tnb').css('background','#fff');
                }
            },
        });
    }

    // FullPage.js 활성화 / 비활성화 체크 함수
    function checkFullpageStatus() {
        const mediaQuery = window.matchMedia('(max-width: 1600px)');

        if (mediaQuery.matches) {
            // 1600px 이하일 때 FullPage.js 비활성화
            if (fpInstance) {
                fullpage_api.destroy('all');
                fpInstance = null;
                document.querySelector('#fullpage').style.height = 'auto';
            }
        } else {
            // 1600px 초과일 때 FullPage.js 활성화
            if (!fpInstance) {
                initializeFullpage();
            }
        }
    }

    // 커스텀 네비게이션 클릭 처리
    document.querySelectorAll('#fullpage-indicator div').forEach((navItem) => {
        navItem.addEventListener('click', function (e) {
            e.preventDefault();
            const sectionAnchor = this.getAttribute('data-menuanchor');

            if (fpInstance) {
                // FullPage.js가 활성화된 경우
                fullpage_api.moveTo(sectionAnchor);
            } else {
                // 일반 스크롤인 경우
                const targetSection = document.querySelector(`.section-wrapper[data-anchor="${sectionAnchor}"]`);
                if (targetSection) {
                    targetSection.scrollIntoView({ behavior: 'smooth' });
                }
            }
        });
    });

    // 섹션이 이동할 때마다 커스텀 네비게이션에 active 클래스를 업데이트
    function updateIndicator(index) {
        // 모든 인디케이터 div에서 active 클래스 제거
        const navItems = document.querySelectorAll('#fullpage-indicator div');
        navItems.forEach((navItem) => {
            navItem.classList.remove('active');
        });

        // 해당 index의 div에 active 클래스 추가
        const activeNavItem = navItems[index];
        if (activeNavItem) {
            activeNavItem.classList.add('active');
        }
    }

    // 페이지 로드 후 초기화
    window.addEventListener('load', function () {
        checkFullpageStatus();

        let customNav = document.querySelector('#fullpage-indicator');
        if (document.querySelector('.section-wrapper[data-anchor="section1"]')) {
            customNav.classList.add('section1');
        }
    });

    // 화면 크기 변경 시 FullPage.js 체크
    window.addEventListener('resize', checkFullpageStatus);

    // 커스텀 네비게이션 클릭 처리 (중복 제거)
    document.querySelectorAll('#fullpage-indicator div').forEach((navItem) => {
        navItem.addEventListener('click', function () {
            const sectionAnchor = this.getAttribute('data-menuanchor');
            fullpage_api.moveTo(sectionAnchor);
        });
    });
});
