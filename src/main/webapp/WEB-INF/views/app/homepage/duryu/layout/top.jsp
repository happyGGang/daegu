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
						<a href="/${homepage.context_path}/index.do">홈으로</a>
						<span class="txt-bar"></span>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="#" id="memberInfoBtn">${sessionScope.member.member_name}님</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16">나의도서관</a>
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
					</c:otherwise>
				</c:choose>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92">사이트맵</a>

						<a href="https://twitter.com/duryulibrary" target="_blank" class="sitemap-img2" style="padding-left:18px;">
						<img src="/resources/homepage/${homepage.context_path}/img/twitter-btn.png" alt="트위터" /></a>

						<a href="https://www.facebook.com/duryulib" target="_blank" class="sitemap-img2">
						<img src="/resources/homepage/${homepage.context_path}/img/facebook-btn.png" alt="페이스북" /></a>
			</div>
		</div>
	</div>

