<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="g-menu">
    <homepageTag:newTopMenu menuList="${menuTreeList}"/>

    <a href="https://library.daegu.go.kr/duryu/sitemap/index.do?menu_idx=92" class="site-map">
        <img src="/resources/homepage/${homepage.context_path}/img/common/site-map.svg" alt=""/>
    </a>

    <div class="mobile-menu-trigger">
        <img src="/resources/homepage/${homepage.context_path}/img/common/site-map.svg" alt="my-menu"/>
    </div>

    <div class="mobile-menu" id="mobile-menu">
        <homepageTag:topMenu menuList="${menuTreeList}"/>
    </div>
</div>

<div id="mobile-menu-header" style="display:none;">
    <div class="mobile-menu-header">
        <a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=125" class="btn4">
            <i class="fa fa-bookmark"></i><span>모바일회원증</span>
        </a>
        <c:choose>
            <c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
                <a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95" class="mobilemeberinfo">
                    <i class="fa fa-user"></i><span>${sessionScope.member.member_name}님</span>
                </a>
                <a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
                    <i class="fa fa-sign-out"></i><span>로그아웃</span>
                </a>
            </c:when>
            <c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
                <a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
                    <i class="fa fa-sign-out"></i><span>관리자 로그아웃</span>
                </a>
            </c:when>
            <c:otherwise>
                <a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4" class="btn1">
                    <i class="fa fa-lock"></i><span>로그인</span>
                </a>
                <a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5" class="btn2">
                    <i class="fa fa-user-plus"></i><span>회원가입</span>
                </a>
                <a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8" class="btn2">
                    <i class="fa fa-user-plus"></i><span>통합인증</span>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
