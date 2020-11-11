<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="section">
			<h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/${homepage.context_path}_logo.png" alt="${homepage.homepage_name}"/></a></h1>

			<div class="m-menu2">
				<a href="#search" id="onLoadSearch"><img src="/resources/homepage/${homepage.context_path}/img/search-btn.png" alt="검색"></a>
			</div>

			<div class="mmode m-menu">
				<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
			</div>

			<div class="search-box">
				<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
					<input type="hidden" name="menu_idx" value="13">
					<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
					<fieldset>

						<div class="main-box">
							<div class="title-box">자료검색</div>
							<div class="box1">
								<div class="box2">
									<label for="search_text_1" class="blind">자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
							</div>
							<button id="main-search-btn">검색</button>
						</div>
					</fieldset>
				</form>
			</div>


			<div class="util">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<b style="font-weight:200;font-size:15px;">${sessionScope.member.member_name}님</b>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95">정보수정</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<font color="gray">관리자 로그인 중</font>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
						<span class="txt-bar"></span>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</div>

