<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="" >
			<h1 class='web-logo'><a href="/${homepage.context_path}/index.do">대구광역시통합도서관</a></h1>

			<div class="util">
				<ul>
					<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<li>
							<b style="font-weight:200;font-size:15px;color:#facb00;vertical-align:middle;">${sessionScope.member.member_name}님</b>
						</li>
						<li>
							<a href="/${homepage.context_path}/intro/login/logout.do"><img src="/resources/homepage/${homepage.context_path}/img/logout_icon.png" alt="로그아웃" /></a>
						</li>
						<!--li>
							<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=73">MY Library</a>
						</li-->
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<li>
							<b style="font-weight:200;font-size:15px;color:#facb00;vertical-align:middle;">${sessionScope.member.member_name}님</b>
						</li>
						<li>
							<a href="/${homepage.context_path}/intro/login/logout.do"><img src="/resources/homepage/${homepage.context_path}/img/logout_icon.png" alt="로그아웃" /></a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=43" title="로그인"><img src="/resources/homepage/${homepage.context_path}/img/login_icon.png" alt="로그인" /></a>
						</li>
						<li>
							<a href="http://library.daegu.go.kr/dgportal/intro/join/index.do?menu_idx=42" title="대구통합도서관 회원가입 바로가기(새창열림)" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/join_icon.png" alt="회원가입"></a>
						</li>
					</c:otherwise>
					</c:choose>
						<li>
							<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=47"><img src="/resources/homepage/${homepage.context_path}/img/sitemap_icon.png" alt="사이트맵"></a>
						</li>
				</ul>
			</div>
		</div>
	</div>

