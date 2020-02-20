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
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="/${homepage.context_path}/intro/join/accessInfo.do?menu_idx=115" class="mobilemeberinfo">
							<i class="fa fa-user"></i>
								<span>${sessionScope.member.member_name}님</span>
						</a>
						<a href="https://www.gbelib.kr/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=73" class="btn4">
							<i class="fa fa-bookmark"></i>
								 <span>MY Library</span>
						  </a>
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
						<a href="https://www.gbelib.kr/${homepage.context_path}/intro/login/index.do?menu_idx=121" class="btn1">
							<i class="fa fa-lock"></i>
							<span>LOGIN</span>
						</a>
						<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/index.do?menu_idx=42" class="btn2">
							<i class="fa fa-user-plus"></i>
							<span>JOIN</span>
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
