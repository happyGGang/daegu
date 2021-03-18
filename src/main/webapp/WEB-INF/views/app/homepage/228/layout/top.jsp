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
			 <a href="https://www.facebook.com/dblib01/" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/facebook-icon-btn.png" alt="페이스북" class="sitemap-img2"></a>
			 <a href="https://www.instagram.com/228studentlibrary/" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/insta-icon-btn.png" alt="인스타그램" class="sitemap-img2"></a>
			 <a href="https://twitter.com/daebonglib" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/twitter-icon-btn.png" alt="트위터" class="sitemap-img2"></a>
			 <a href="https://www.youtube.com/channel/UCHJiipMqeDWHgehZTp6En3Q" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/youtube-icon-btn.png" alt="트위터" class="sitemap-img2"></a>
					<c:if test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<b style="font-weight:200;font-size:14px;">${sessionScope.member.member_name}님</b>
						<span class="txt-bar"></span>
					</c:if>
						<a href="/${homepage.context_path}/index.do">홈으로</a>
						<span class="txt-bar"></span>
				<c:choose>
					<c:when test="${not empty sessionScope.loginSupport and sessionScope.loginSupport.login}">
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/module/supportMember/logout.do">학교도서관 로그아웃</a>
					</c:when>
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
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>
					</c:otherwise>
				</c:choose>
				<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92" class="more-btbtbt"><img src="/resources/homepage/${homepage.context_path}/img/more_btbtbt.png" alt="사이트맵"/></a>
			</div>
		</div>
	</div>

