<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">

<!-- 		<div class="l-util"> -->
<!-- 			<ul> -->
<!-- 				<li><a href="/busanlibrary/index.do" target="_blank">부산도서관</a></li> -->
<!-- 				<li><a href="/portal/index.do" target="_blank">부산도서관포털</a></li> -->
<!-- 				<li><a href="/elib/index.do" target="_blank">전자도서관</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
		<!-- <div class="util">
			<div>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=74" id="memberInfoBtn">${sessionScope.member.member_name}님</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=76">내서재</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<font color="red">관리자 로그인 중</font>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=59">로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=60">회원가입</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=76">내서재</a>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=60">통합회원인증</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div> -->

		<h1 class="mobile-logo"><a href="/${homepage.context_path}/index.do">부산학 디지털 아카이브</a></h1>

		<div class="mmode m-menu">
			<a href="#menu"><img src="/resources/homepage/${homepage.context_path}/img/sitemap_icon.png" alt="사이트맵" /></a>
		</div>
		<div class="end"></div>
	</div>

