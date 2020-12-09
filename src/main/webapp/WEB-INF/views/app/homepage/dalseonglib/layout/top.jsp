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
				<a href="https://www.facebook.com/dalseonglib" class="sns_icon" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/facebook_icon.png" title="페이스북 아이콘" alt="페이스북 아이콘"></a>
				<a href="http://pf.kakao.com/_YxnJxjj" class="sns_icon" target="_blank" style="margin-right:5px;"><img src="/resources/homepage/${homepage.context_path}/img/kakao_ch_icon.png" title="카카오톡 채널 아이콘" alt="카카오톡 채널 아이콘"></a>
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
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=70">회원가입</a>
						<!-- <span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findIdForm.do?menu_idx=6">아이디찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/findPwForm.do?menu_idx=7">비밀번호찾기</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>
						<a href="https://twitter.com/tglnetlib" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/twitter.png" alt="트위터"></a>
						<span></span>
						<a href="https://www.facebook.com/tglnet/?ref=aymt_homepage_panel&eid=ARBF0x7CH2csV2V7L0aXEdhh4dIYs4K1IKdQSBAXVHW3pZ0IPcMg2ZCwYG5kNNr48Acmj11-YLdHKykL" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/facebook.png" alt="페이스북"></a>
						<span></span>
						<a href="https://www.instagram.com/tglnetlib/" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/instagram.png" alt="인스타그램"></a> -->
					</c:otherwise>
				</c:choose>
			</div>
			<div>

			</div>
		</div>
	</div>

