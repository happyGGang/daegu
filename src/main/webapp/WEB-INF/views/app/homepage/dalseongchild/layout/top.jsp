<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="main-section">
			<div class="libSite">
				<ul>
					<li class="on"><a href="#this">달성어린이숲</a></li>
					<li><a href="#this">달성군립</a></li>
					<li><a href="#this">작은</a></li>
					<li><a href="#this">전자도서관</a></li>
					<li class="br"><a href="#this" target="_blank">달성교육재단</a></li>
				</ul>
			</div>

			<h1 class="mobile-logo"><a href="/${homepage.context_path}/index.do" style="background:none;">달성어린이숲도서관</a></h1>

			<!--<div class="sns-box">
				<ul class="sns-link">
					<li><a href="https://www.youtube.com/channel/UCrU93GSooFE7YPnoXu4NPTA" target="_blank" title="유튜브 바로가기" alt="유튜브 바로가기" class="newWin"><img src="/resources/homepage/bukgs/img/sns_icon_youtube.png"><i class="fa fa-external-link"></i></a></li>
					<li><a href="https://www.instagram.com/gususan.library" target="_blank" title="인스타그램 바로가기" alt="인스타그램 바로가기" class="newWin"><img src="/resources/homepage/bukgs/img/sns_icon_instagram.png"><i class="fa fa-external-link"></i></a></li>
					<li><a href="https://pf.kakao.com/_xiRxeIxb" target="_blank" title="카카오톡 바로가기" alt="카카오톡 바로가기" class="newWin"><img src="/resources/homepage/bukgs/img/sns_icon_kakaotalk.png"><i class="fa fa-external-link"></i></a></li>
				</ul>
			</div>-->

			<div class="mmode m-menu">
				<a href="#menu"><img src="/resources/homepage/dalseongchild/img/common/hamberger.svg" alt="사이트맵"/><span class="blind">메뉴</span></a>
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
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=69">통합허브시스템 로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=73">통합회원인증</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=70">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</div>

