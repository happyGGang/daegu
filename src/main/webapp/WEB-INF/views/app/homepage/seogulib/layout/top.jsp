<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="section">
			<h1>
				<a href="/${homepage.context_path}/index.do" style="padding:0;">
					<img src="/resources/homepage/${homepage.context_path}/img/logo.png" alt="${homepage.homepage_name}"/>
				</a>
			</h1>

			<div class="mmode m-menu">
				<a href="#menu"><img src="/resources/homepage/${homepage.context_path}/img/menu.png" alt="사이트맵" /><span class="blind">메뉴</span></a>
			</div>

			<div class="util">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<b>${sessionScope.member.member_name}님</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=66">정보수정</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<b><span>관리자 로그인 중</span></b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=69">통합허브시스템 로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=70">회원가입</a>
						<!--<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findIdForm.do?menu_idx=6">아이디찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findPwForm.do?menu_idx=7">비밀번호찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>-->
					</c:otherwise>
				</c:choose>
			</div>
			<div>

			</div>
		</div>
	</div>

