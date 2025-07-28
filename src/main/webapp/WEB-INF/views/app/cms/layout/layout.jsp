<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>도서관통합관리프로그램</title>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/aside.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/cms/js/design.js"></script>
</head>
    <style>
#menuSearchResults {
    position: absolute;
    background: white;
    border: 1px solid #ccc;
    max-height: 200px;
    overflow-y: auto;
    z-index: 9999;
    display: none;
    width: 200px;
}

#menuSearchResults li {
    padding: 5px 10px;
    cursor: pointer;
}

#menuSearchResults li:hover {
    background-color: #eee;
}
</style>
<body>
    <script type="text/javascript">
        let idleTimeout, logoutTimeout, countdownInterval;
        const warningTime = 60 * 60 * 1000;
        const logoutTime = 61 * 60 * 1000;

        function resetSessionTimers() {
            clearTimeout(idleTimeout);
            clearTimeout(logoutTimeout);
            clearInterval(countdownInterval); // 기존 카운트다운 제거
            idleTimeout = setTimeout(showTimeoutWarning, warningTime);
            logoutTimeout = setTimeout(logout, logoutTime);
        }

        function showTimeoutWarning() {
            document.getElementById("sessionTimeoutModal").style.display = "block";
            startCountdown((logoutTime - warningTime) / 1000);
        }

        function startCountdown(seconds) {
            let remaining = seconds;
            document.getElementById("countdown").innerText = remaining;
            countdownInterval = setInterval(() => {
                remaining--;
                document.getElementById("countdown").innerText = remaining;
                if (remaining <= 0) {
                    clearInterval(countdownInterval);
                    logout();
                }
            }, 1000);
        }

        function extendSession() {
            $.post("/cms/session/extend.do", function() {
                document.getElementById("sessionTimeoutModal").style.display = "none";
                clearInterval(countdownInterval);
                resetSessionTimers();
            });
        }

        function logout() {
            location.href = "/cms/login/logout.do";
        }

        $(document).ready(function () {
            resetSessionTimers();

            $(document).on("mousemove keydown click", function () {
                resetSessionTimers();
            });
        });

        $(document).ready(function () {
            const $input = $('#menuSearchInput');
            const $results = $('#menuSearchResults');

            // 모든 메뉴 수집
            const menuList = [];
            $('.aside a').each(function () {
                const $a = $(this);
                const name = $a.text().trim();
                const href = $a.attr('href');
                if (href && name) {
                    menuList.push({ name, href });
                }
            });

            $input.on('input', function () {
                const keyword = $(this).val().toLowerCase();
                $results.empty().hide();

                if (keyword.length < 1) return;

                const filtered = menuList.filter(m => m.name.toLowerCase().includes(keyword));

                filtered.forEach(m => {
                    const $li = $('<li>').text(m.name).data('href', m.href);
                    $results.append($li);
                });

                if (filtered.length > 0) $results.show();
            });

            // 결과 클릭 시 메뉴로 이동 및 포커스
            $results.on('click', 'li', function () {
                const href = $(this).data('href');

                location.href=href;
            });

            // 바깥 클릭 시 자동완성 닫기
            $(document).on('click', function (e) {
                if (!$(e.target).closest('#menuSearchInput, #menuSearchResults').length) {
                    $results.hide();
                }
            });
        });
    </script>

    <div>
        <div id="wrap" class="left-sidebar">
            <div class="aside">
                <div id="header">
                    <h1><a href="/cms/index.do">SJS</a></h1>
                    <div>
                        <p><b>(${sessionScope.member.member_name})</b>님 로그인 중입니다.</p>
                        <p>
                            <a href="/cms/login/logout.do" target="_parent">
                                <i class="fa fa-sign-out"></i>
                                <em>로그아웃</em>
                            </a>
                            <span>|</span>
                            <a class="pass-change-btn" href="">
                                <i class="fa fa-gear"></i>
                                <em>비밀번호 변경</em>
                            </a>
                        </p>
                        <p>
                            <tiles:insertAttribute name="asideHomepage" />
                        </p>
                        <c:if test="${member.admin}">
                            <p>
                                <a href="" onclick="javascript:parent.location.href='/wbuilder/adminMenu/index.do'; return false;">[WBuilder관리 이동]</a>
                            </p>
                        </c:if>
                        <p>
                            <input type="text" id="menuSearchInput" placeholder="메뉴명 검색" autocomplete="off"/>
                            <ul id="menuSearchResults" class="search-autocomplete"></ul>
                        </p>
                    </div>
                </div>
                <cmsTag:asideMenu adminMenuList="${adminMenuList}"/>
            </div>
        </div>

        <div id="container"style="float: left; clear: none; width: 80%;">
            <div class="wrapper wrapper-white" >
                <tiles:insertAttribute name="body" />
            </div>
        </div>

        <div id="sessionTimeoutModal" class="session-timeout-modal">
            <h3 class="session-timeout-title">자동로그아웃안내</h3>
            <p class="session-timeout-timer">남은시간 <span id="countdown" class="countdown-number">360</span>초</p>
            <p class="session-timeout-message">
                고객님의 안전한 개인정보 보호를 위해 자동로그아웃을 합니다.<br>
                로그인 시간을 연장하시겠습니까?
            </p>
            <button onclick="extendSession();" class="btn btn-extend">연장하기</button>
            <button onclick="logout();" class="btn btn-logout">로그아웃</button>
        </div>
    </div>
</body>

<script>
$(document).ready(function () {
    const currentPath = window.location.pathname;

    // 현재 경로에 해당하는 메뉴 활성화
    $('.aside a').each(function () {
        const linkPath = $(this).attr('href');
        if (linkPath && currentPath === linkPath) {
            const $li = $(this).closest('li');
            $li.addClass('active');
            $li.parents('ul').show();
            $li.parents('li').addClass('active');
        }
    });

    // 재귀적 메뉴 토글 처리 함수
    function setupMenuToggle($rootSelector) {
        $rootSelector.children('li').each(function () {
            const $li = $(this);
            const $a = $li.children('a');
            const $submenu = $li.children('ul');

            if ($submenu.length > 0) {
                // 하위 메뉴가 있을 경우, 클릭 이벤트 설정
                $a.on('click', function (e) {
                    e.preventDefault();
                    const isActive = $li.hasClass('active');

                    // 동일 뎁스 내 다른 메뉴 닫기
                    $li.siblings('li').removeClass('active').children('ul').slideUp(80);

                    // 현재 메뉴 toggle
                    if (!isActive) {
                        $submenu.slideDown(80);
                        $li.addClass('active');
                    } else {
                        $submenu.slideUp(80);
                        $li.removeClass('active');
                    }
                });

                // 초기 로딩 시 하위 active 처리
                if ($submenu.find('li.active').length > 0) {
                    $li.addClass('active');
                    $submenu.show();
                }

                // 재귀 호출로 하위 뎁스 처리
                setupMenuToggle($submenu);
            } else {
                $li.addClass('s'); // 서브 없음 표시
            }
        });
    }

    // 최상위 aside > ul 에서부터 시작
    setupMenuToggle($('.aside > ul'));

    // 비밀번호 변경
    $('a.pass-change-btn').on('click', function (e) {
        e.preventDefault();
        $('input#passChangeEvent').val(true);
        location.href = "/cms/member/index.do";
    });

    // 홈페이지 선택 변경
    $('#siteList').on('change', function () {
        const selectedHomepageId = $(this).val();

        $.ajax({
            type: 'POST',
            url: '/cms/asideHomepage.do',
            data: { homepage_id: selectedHomepageId },
            success: function () {
                location.reload();
            },
            error: function () {
                alert('사이트 변경 중 오류 발생');
            }
        });
    });
});
</script>