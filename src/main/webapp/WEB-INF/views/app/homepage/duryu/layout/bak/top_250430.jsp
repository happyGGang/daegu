<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
    <nav id="menu"></nav>

    <div class="tnb">
        <div class="section">
            <h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/logo.png" alt="${homepage.homepage_name}"/></a></h1>

            <div class="mmode m-menu">
                <a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
            </div>

            <div class="util">
                <c:if test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
                    <b style="color:#fff;font-weight:200;font-size:14px;">${sessionScope.member.member_name}님</b>
                </c:if>
                <a href="/${homepage.context_path}/index.do">홈으로</a>
                <span class="txt-bar"></span>
                <c:choose>
                    <c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
                        <a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
                        <span class="txt-bar"></span>
                        <a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95">정보수정</a>
                    </c:when>
                    <c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
                        <font color="red">관리자 로그인 중</font>
                        <span class="txt-bar"></span>
                        <a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
                        <span class="txt-bar"></span>
                        <a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a>
                        <span class="txt-bar"></span>
                        <a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8" style="color:#ff0000;">통합회원인증</a>
                    </c:otherwise>
                </c:choose>
                <span class="txt-bar"></span>
                <a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92">사이트맵</a>

                <a href="https://pf.kakao.com/_xbIxlJb" target="_blank" class="sitemap-img2" style="padding-left:18px;" title="카카오톡채널 바로가기(새창열림)">
                    <img src="/resources/homepage/${homepage.context_path}/img/kakaoch-btn.jpg" alt="카카오톡채널" /></a>

                <a href="https://www.instagram.com/duryulib/" target="_blank" class="sitemap-img2" title="인스타그램 바로가기(새창열림)">
                    <img src="/resources/homepage/${homepage.context_path}/img/instagram-btn.png" alt="인스타그램" /></a>

                <a href="https://www.youtube.com/channel/UCLIjzSfEz4vRczvr02hMy2w/featured" target="_blank" class="sitemap-img2" title="유튜브 바로가기(새창열림)">
                    <img src="/resources/homepage/${homepage.context_path}/img/youtube-btn.png" alt="유튜브" /></a>

                <!-- <a href="https://twitter.com/duryulibrary" target="_blank" class="sitemap-img2" title="트위터 바로가기(새창열림)">
                <img src="/resources/homepage/${homepage.context_path}/img/twitter-btn.png" alt="트위터" /></a>

                <a href="https://www.facebook.com/duryulib" target="_blank" class="sitemap-img2" title="페이스북 바로가기(새창열림)">
                <img src="/resources/homepage/${homepage.context_path}/img/facebook-btn.png" alt="페이스북" /></a> -->
            </div>
        </div>
    </div>

