<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
});
</script>
<div id="header">
<nav id="menu"></nav>
<div class="tnb">
	<div class="section">
		<h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/logo.png" alt="${homepage.homepage_name}"/></a></h1>
		<div class="mmode m-menu">
			<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
		</div>
		<div class="util">
			<a href="/${homepage.context_path}/index.do">처음으로</a>
			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<span class="txt-bar"></span>
					<a href="#" id="memberInfoBtn">${sessionScope.member.member_name}님</a>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=179">MY Library</a>
					<span class="txt-bar"></span>
				</c:when>
				<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
					<span class="txt-bar"></span>
					<font color="gray">관리자 로그인 중</font>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					<span class="txt-bar"></span>
				</c:when>
				<c:otherwise>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=121">로그인</a>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=120">회원가입</a>
					<span class="txt-bar"></span>
					<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=179">MY Library</a>
					<span class="txt-bar"></span>
				</c:otherwise>
			</c:choose>
			<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=148">사이트맵</a>
		</div>
	</div>
</div>


<%-- <jsp:include page="/WEB-INF/views/app/homepage/common/mainName.jsp" flush="false" /> --%>