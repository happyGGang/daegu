<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="header">
    <nav id="menu"></nav>

    <div class="tnb">
        <div>
            <a href="https://cn.nld.go.kr/index.do">책나래</a>
            <a href="https://books.nl.go.kr/">책바다</a>
            <a href="https://www.nl.go.kr/NL/contents/N30502000000.do">사서에게물어보세요</a>
        </div>
        <div class="util-wrapper">
            <div class="util">
                <c:if test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
                    <div>${sessionScope.member.member_name}님</div>
                </c:if>
                <c:choose>
                    <c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
                        <a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
                        <a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95">정보수정</a>
                    </c:when>
                    <c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
                        <div>관리자 로그인 중</div>
                        <a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
                        <a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a>
                        <a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="total-popup-trigger">
                <div>통합팝업열기</div>
                <div>${fn:length(popupList)}</div>
            </div>
        </div>
    </div>
</div>
