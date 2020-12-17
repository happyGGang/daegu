<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="main-section">
			<div class="libSite">
				<ul>
					<li><a href="/bukgs/index.do">구수산</a></li>
					<li><a href="/bukdh/index.do">대현</a></li>
					<li class="on"><a href="/buktj/index.do">태전</a></li>
					<li><a href="html.do?menu_idx=89">작은</a></li>
					<li><a href="/buktj/html.do?menu_idx=25">전자도서관</a></li>
					<li><a href="https://www.hbcf.or.kr:8443/front/" target="_blank">행복북구문화재단</a></li>
				</ul>
			</div>

			<h1 class="mobile-logo"><a href="/${homepage.context_path}/index.do">태전 도서관</a></h1>

			<div class="mmode m-menu">
				<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
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
						<b>관리자 로그인 중</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=70">회원가입</a>
						<!-- <span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findIdForm.do?menu_idx=6">아이디찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findPwForm.do?menu_idx=7">비밀번호찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a> -->
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</div>

