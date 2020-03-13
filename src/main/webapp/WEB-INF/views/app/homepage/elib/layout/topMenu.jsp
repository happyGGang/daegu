<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="Gnb">
	<h2 class="blind">주메뉴</h2>
	<div class="section">
		<h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/${homepage.context_path}_logo.png" alt="대구광역시 전자도서관"/></a></h1>

		<div class="mmode m-menu">
			<a href="#menu"><img src="/resources/homepage/${homepage.context_path}/img/mmenu-icon1.gif"></a>
		</div>

		<div class="g-menu">
			<!-- menu S -->
			<homepageTag:topMenu menuList="${menuTreeList}" />

			<!-- menu E -->
			<div class="mmode">
						<a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=81" class="btn4">
							<i class="fa fa-bookmark"></i>
							<span>모바일회원증</span>
						</a>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=83" class="mobilemeberinfo">
								<i class="fa fa-user"></i>
									<span>${sessionScope.member.member_name}님</span>
							</a>
							<!-- <a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16" class="btn4">
								<i class="fa fa-bookmark"></i>
								<span>나의도서관</span>
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
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=43" class="btn1">
							<i class="fa fa-lock"></i>
							<span>LOGIN</span>
						</a>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=42" class="btn2">
							<i class="fa fa-user-plus"></i>
							<span>JOIN</span>
						</a>
							<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=82" class="btn2">
								<i class="fa fa-user-plus"></i>
								<span>통합인증</span>
							</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</div>

<script>
$(document).ready(function() {
	$('ul.gnb-menu li.menu_3').hide();
})
</script>
