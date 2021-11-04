<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	$('#main-search-btn').on('click', function(e) {
		e.preventDefault();
		if( $('input#search_text').val() == '' ) {
			alert('검색어를 입력하세요.');
			$('input#search_text').focus();
			return false;
		} else {
			$('#mainSearchForm').submit();
		}
	});

});

$(document).ready(function() {
});
</script>
<div id="header">
	<nav id="menu"></nav>
	<div class="tnb">
		<div class="section">
			<h1><a href="http://www.gbelib.kr/${homepage.context_path}/index.do"><img src="/resources/homepage/elib/img/logo.png" alt="${homepage.homepage_name}"/></a></h1>
			<div class="mmode m-menu">
				<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
			</div>
			<!-- top menu S -->
			<div class="util">
				<div class="section">
					<ul>
						<li>
							<a href="http://www.gbelib.kr/${homepage.context_path}/index.do">처음으로</a>
							<c:choose>
							<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="#" id="memberInfoBtn">${sessionScope.member.member_name}님</a>
							<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
							<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=48">MY Library</a>
							</c:when>
							<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
							</c:when>
							<c:otherwise>
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=43">로그인</a>
							<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=42">회원가입</a>
							<a href="/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=48">MY Library</a>
							</c:otherwise>
							</c:choose>
							<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=47">사이트맵</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- top menu E -->
		</div>
	</div>

	<div class="mmenu">
		<!--
		<h2 class="blind">주메뉴</h2>
		<ul class="menu">
			<li><a href="/${homepage.context_path}/html.do?menu_idx=53"><span>이용안내</span></a></li>
			<li class="m3"><a href="/${homepage.context_path}/module/elib/lending/index.do?menu_idx=4&menu=LENDING"><span>내 서재</span></a></li>
		</ul>
		-->

		<tiles:insertAttribute name="topMenu" />

		<div class="search-box">
			<form id="mainSearchForm" method="POST" action="/newelib/module/newelib/search/index.do">
				<input type="hidden" name="menu_idx" value="2">
				<fieldset>
					<legend class="blind">통합검색</legend>
					<div class="box">
						<div class="b1">
							<input type="text" class="text" name="search_text" id="search_text" placeholder="전자도서관 자료를 검색하세요"/>
						</div>
						<div class="b2">
							<button id="main-search-btn"><i class="fa fa-search"></i><span class="blind">검색</span></button>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

	<!--
	<div class="search-box">
		<form id="mainSearchForm" method="POST" action="/elib/module/elib/search/index.do">
			<input type="hidden" name="menu_idx" value="2">
			<fieldset>
				<legend class="blind">통합검색</legend>
				<div class="box1">
					<div class="box2">
						<input type="text" class="text" name="search_text" id="search_text" placeholder="전자도서관 자료를 검색하세요"/>
					</div>
				</div>
				<button id="main-search-btn">SEARCH</button>
			</fieldset>
		</form>
	</div>
	-->
