<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb mobile_tnb">
		<div class="main-section">
			<h1 class="mobile-logo"><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/logo-w.svg" alt="대구혁신도시복합혁신센터도서관"/></a></h1>

			<div class="mmode m-menu">
				<a href="#menu"><img src="/resources/homepage/center/img/hamburger.svg" alt="메뉴"><span class="blind">메뉴</span></a>
			</div>

			<div class="util">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<b>${sessionScope.member.member_name}님</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=81">정보수정</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<b>관리자 로그인 중</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</div>

