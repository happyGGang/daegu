<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#main-search-btn').on('click', function() {
		if( $('input#search_text_1').val() == '' ) {
			alert('검색어를 입력하세요.');
			$('input#search_text_1').focus();
			return false;
		}
			$('#mainSearchForm').submit();
	});

});
</script>
	<div class="head">
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="section">
				<!-- menu S -->
				<div class="g-menu">
					<homepageTag:topMenu menuList="${menuTreeList}" />
					<div class="mmode">
							<a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=66" class="btn4">
								<i class="fa fa-bookmark"></i>
								<span>모바일회원증</span>
       						</a>
					<c:choose>
						<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=62" class="mobilemeberinfo">
								<i class="fa fa-user"></i>
									<span>${sessionScope.member.member_name}님</span>
							</a>
							<!-- <a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=33" class="btn4">
								<i class="fa fa-bookmark"></i>
									 <span>나의 도서관</span>
							  </a> -->
							<a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
								<i class="fa fa-sign-out"></i>
								<span>로그아웃</span>
							</a>
						</c:when>
						<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
								<i class="fa fa-sign-out"></i>
								<span>관리자 로그아웃</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=41" class="btn1">
								<i class="fa fa-lock"></i>
								<span>로그인</span>
							</a>
							<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=42" class="btn2">
								<i class="fa fa-user-plus"></i>
								<span>회원가입</span>
							</a>
							<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=45" class="btn2">
								<i class="fa fa-user-plus"></i>
								<span>통합인증</span>
							</a>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
				<!-- menu E -->
			</div>
			<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=53" class="site-map"><img src="/resources/homepage/${homepage.context_path}/img/site-map-icon.png" alt="사이트맵"></a>
			<div class="mask">&nbsp;</div>
		</div>
	</div>
	<div class="sub-menu">
		<div class="section">
			<ul>
				<li><a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=7" class="quick-btn01">통합자료검색</a></li>
				<li></li>
				<li><a href="/${homepage.context_path}/board/index.do?menu_idx=18&manage_idx=287" class="quick-btn02">도서관찾기</a></li>
				<li></li>
				<li>
				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/indexAll.do">
						<input type="hidden" name="menu_idx" value="7">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box0">
									<img src="/resources/homepage/${homepage.context_path}/img/search-dotbogi.png" alt="검색">
								</div>
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text searchText" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색</button>
							</div>
						</fieldset>
					</form>
				</div>
				</li>
			</ul>
		</div>
	</div>

</div>