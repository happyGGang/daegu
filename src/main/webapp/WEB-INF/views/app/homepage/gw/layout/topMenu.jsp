<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div id="m-util" class="no3">
		<ul>
			<li><a href="https://library.daegu.go.kr/dgportal/index.do" target="_blank">대구통합도서관</a></li>
			<li><a href="https://library.daegu.go.kr/elib/index.do" target="_blank">대구전자도서관</a></li>
		</ul>
	</div>


	<div class="head">
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="wide-sections">
				<h1><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/${homepage.context_path}/img/logo.png" alt="${homepage.homepage_name}"/></a></h1>
				<div class="mmode m-menu">
					<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
				</div>
				<!-- menu S -->
				<div class="g-menu">
					<homepageTag:topMenu menuList="${menuTreeList}"/>
					<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92" class="last-box-a"><img src="/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png" alt="사이트맵" class="last-box"></a>

					<div class="mmode">
						<c:choose>
							<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=113" class="mobilemeberinfo">
								<i class="fa fa-user"></i>
									<span>${sessionScope.member.member_name}님</span>
							</a>
							<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=179" class="btn4">
								<i class="fa fa-bookmark"></i>
									 <span>나의도서관</span>
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
								<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4" class="btn1">
									<i class="fa fa-lock"></i>
									<span>로그인</span>
								</a>
								<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5" class="btn2">
									<i class="fa fa-user-plus"></i>
									<span>회원가입</span>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- menu E -->
			</div>
			<div class="mask">&nbsp;</div>
		</div>
	</div>
</div>