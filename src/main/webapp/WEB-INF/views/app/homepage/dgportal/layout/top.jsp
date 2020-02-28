<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="section">
			<h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/${homepage.context_path}_logo.png" alt="${homepage.homepage_name}"/></a></h1>

			<div class="mmode m-menu">
				<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
			</div>

			<div class="util">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<b style="font-weight:200;font-size:15px;">${sessionScope.member.member_name}님</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=62">정보수정</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<font color="gray">관리자 로그인 중</font>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:when test="${not empty sessionScope.loginPortal and sessionScope.loginPortal.login}">
						${sessionScope.loginPortal.agency_name}님
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/module/portalMember/logout.do">학교도서관 로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=41">로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=42">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

