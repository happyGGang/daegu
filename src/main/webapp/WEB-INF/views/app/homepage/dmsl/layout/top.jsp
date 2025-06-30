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
				<div class="left">
					<a href="https://library.daegu.go.kr/dalseonglib/index.do"><b style="color: #ffdb00">달성군립</b></a>
					<a href="https://library.daegu.go.kr/dalseongchild/index.do">달성어린이숲</a>
					<a href="https://library.daegu.go.kr/dalseonglib/html.do?menu_idx=93">작은</a>
					<a href="https://library.daegu.go.kr/elib/index.do">전자도서관</a>
					<a href="https://dsef.or.kr/index.do">달성교육재단</a>
					<a href="https://www.instagram.com/dalseonglib/" target="_blank"><img src="/resources/homepage/bukbu/img/common/instagram-color.svg" title="" alt=""></a>
					<a href="https://www.youtube.com/channel/UCEjC8gsgHQj4c5pt4XARYlA" target="_blank"><img src="/resources/homepage/bukbu/img/common/youtube-color.svg" title="" alt=""></a>
					<a href="https://www.facebook.com/dalseonglib" target="_blank"><img src="/resources/homepage/bukbu/img/common/facebook-color.svg" title="" alt=""></a>
					<a href="https://pf.kakao.com/_YxnJxjj"  target="_blank"><img src="/resources/homepage/bukbu/img/common/kakaotalk-color.svg" title="" alt=""></a>
				</div>

				<div class="right">
					<c:choose>
						<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<b style="font-weight:200;font-size:15px;color:#fff;">${sessionScope.member.member_name}님</b>
							<span class="txt-bar"></span>
							<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
							<span class="txt-bar"></span>
							<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=66">정보수정</a>
						</c:when>
						<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
							<b style="font-weight:200;font-size:15px;color:#fff;">관리자 로그인 중</b>
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
			<div>

			</div>
		</div>
	</div>

