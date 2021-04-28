<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="head">
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="main-section">
				<h1 class="web-logo"><a href="/${homepage.context_path}/index.do">동구통합도서관</a></h1>

				<!-- menu S -->
				<div class="g-menu">
					<homepageTag:topMenu menuList="${menuTreeList}" />
					
					<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=141" class="last-box_w"><img src="/resources/common/img/sitemap_icon_white.png" alt="사이트맵" /></a>
					<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=141" class="last-box_b"><img src="/resources/common/img/sitemap_icon_black.png" alt="사이트맵" /></a>
					<div class="mmode">
							<a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=68" class="btn4">
								<i class="fa fa-bookmark"></i>
								<span>모바일회원증</span>
							</a>
					<c:choose>
						<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=53" class="mobilemeberinfo">
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
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=69" class="btn1">
								<i class="fa fa-lock"></i>
								<span style='letter-spacing:-1.5px;'>로그인</span>
							</a>
							<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=70" class="btn2">
								<i class="fa fa-user-plus"></i>
								<span style='letter-spacing:-1.5px;'>회원가입</span>
							</a>
							<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=73" class="btn2">
								<i class="fa fa-user-plus"></i>
								<span style='letter-spacing:-1.5px;'>통합인증</span>
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