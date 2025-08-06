<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta content="${_csrf.token}" id="_csrf" name="_csrf"/>
    <meta content="${_csrf.headerName}" id="_csrf_header" name="_csrf_header"/>
    <title>SJS - 도서관통합관리프로그램</title>
    <link href="/resources/cms/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/cms/css/font.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/cms/css/side.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/cms/css/common.css" rel="stylesheet" type="text/css"/>

    <script src="/resources/common/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/resources/cms/js/sjs/side.js" type="text/javascript"></script>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body>

<script type="text/javascript">
    let idleTimeout, logoutTimeout, countdownInterval;
    let isWarningActive = false;

    const warningTime = 10 * 60 * 1000;
    const logoutTime = 11 * 60 * 1000;

    function resetSessionTimers() {
        clearTimeout(idleTimeout);
        clearTimeout(logoutTimeout);
        clearInterval(countdownInterval);

        idleTimeout = setTimeout(showTimeoutWarning, warningTime);
        logoutTimeout = setTimeout(logout, logoutTime);

        isWarningActive = false;
    }

    function showTimeoutWarning() {
        document.getElementById("sessionTimeoutModal").style.display = "block";
        startCountdown((logoutTime - warningTime) / 1000);
        isWarningActive = true;
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
        $.post("/cms/session/extend.do", function () {
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
            if (isWarningActive) return;
            resetSessionTimers();
        });
    });
</script>

<div class="cms-container">
    <div class="side-menu">
        <div class="side-menu-toggle-btn">
            <img alt="" src="/resources/cms/img/sideMenu/toggle.svg">
        </div>
        <img alt="" class="logo" src="/resources/cms/img/sideMenu/logo.png">
        <div class="user-name"><span>${sessionScope.member.member_name}</span>님 반갑습니다.</div>
        <div class="action-wrapper">
            <a href="/cms/login/logout.do" target="_parent">
                <img alt="" src="/resources/cms/img/sideMenu/logout.svg">
                <div>로그아웃</div>
            </a>
            <a href="/cms/index.do">
                <img alt="" src="/resources/cms/img/sideMenu/setting.svg">
                <div>사이트관리 이동</div>
            </a>
        </div>
        <div class="menu-list">
            <div class="one-depth" id="memberGroup">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/user.svg">
                        <div>사용자 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/sjs/memberGroup/index.do">· 그룹관리</a></li>
                    <li><a href="/sjs/member/index.do">· 사용자 관리</a></li>
                    <li><a href="/sjs/accountLock/index.do">· 계정 잠금 관리</a></li>
                    <li><a href="/sjs/loginLog/index.do">· 로그인 기록 관리</a></li>
                </ul>
            </div>
            <div class="one-depth" id="memberGroupAuth">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/right.svg">
                        <div>권한 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/sjs/memberGroupAuth/index.do">· 그룹권한 관리</a></li>
                </ul>
            </div>
            <div class="one-depth" id="cmsManage">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/cms-manage.svg">
                        <div>CMS 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/sjs/accessIp/index.do">· 접근가능 IP</a></li>
                    <li><a href="/sjs/limitedIp/index.do">· 홈페이지 접근불가능 IP</a></li>
                    <li><a href="/sjs/code/cms/index.do">· 공통코드 관리</a></li>
                    <li><a href="/sjs/moduleMngt/index.do">· 모듈관리</a></li>
                </ul>
            </div>
            <div class="one-depth" onclick="location.href='/sjs/adminMenu/index.do'" id="cmsAdminManage">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/cms-admin.svg">
                        <div>CMS 관리자 메뉴</div>
                    </div>
                    <img alt="" src="" style="display: none">
                </div>
            </div>
        </div>
    </div>
    <tiles:insertAttribute name="body"/>

    <div id="sessionTimeoutModal" class="session-timeout-modal ui-dialog ui-corner-all" style="display: none; height: 300px; position: fixed; left: 50%; transform: translate(-50%, -50%); top: 50%" >
        <h3 class="session-timeout-title ui-widget-header">자동로그아웃안내</h3>
        <div class="ui-dialog-content" style="text-align: center">
            <p class="session-timeout-timer session-message-title" >남은시간 <span id="countdown" class="countdown-number">360</span>초</p>
            <p class="session-timeout-message session-message-desc">
                고객님의 안전한 개인정보 보호를 위해 자동로그아웃을 합니다.<br>
                로그인 시간을 연장하시겠습니까?
            </p>
        </div>
        <div class="ui-dialog-buttonpane">
            <button onclick="extendSession();" class="icon-btn navy btn-extend" style="margin:.5em .4em">연장하기</button>
            <button onclick="logout();" class="icon-btn gray btn-logout">로그아웃</button>
        </div>
    </div>
</div>

</body>
</html>

