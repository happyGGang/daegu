<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<style>
		.new_logo {
		   width:166px; position: absolute; top: 18px; left: 209px
		}
	</style>

	<div class="head">
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="main-section">
				<h1 class="web-logo"><a href="/${homepage.context_path}/index.do">대구혁신도시복합혁신센터도서관</a></h1>
				<img class="new_logo" src="/resources/homepage/${homepage.context_path}/img/new_logo.svg" alt="대구혁신도시복합혁신센터도서관"/>


				<!-- menu S -->
				<div class="g-menu">
					<homepageTag:topMenu menuList="${menuTreeList}" />
					<div class="mmode">
						<a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=170" class="btn4">
							<i class="fa fa-bookmark"></i>
							<span>모바일회원증</span>
						</a>
						<c:choose>
							<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
								<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95" class="mobilemeberinfo">
									<i class="fa fa-user"></i>
									<span>${sessionScope.member.member_name}님</span>
								</a>
								<a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
									<i class="fa fa-sign-out"></i>
									<span>로그아웃</span>
								</a>
								<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
							</c:when>
							<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
								<a href="/${homepage.context_path}/intro/login/logout.do" class="btn3">
									<i class="fa fa-sign-out"></i>
									<span>관리자 로그아웃</span>
								</a>
								<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
							</c:when>
							<c:otherwise>
								<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=85" class="btn1">
									<i class="fa fa-lock"></i>
									<span style='letter-spacing:-1.5px;'>로그인</span>
								</a>
								<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5" class="btn2">
									<i class="fa fa-user-plus"></i>
									<span style='letter-spacing:-1.5px;'>회원가입</span>
								</a>
								<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8" class="btn2">
									<i class="fa fa-user-plus"></i>
									<span style='letter-spacing:-1.5px;'>통합인증</span>
								</a>
								<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- menu E -->
				<div class='authentication'>
					<c:choose>
						<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<b>${sessionScope.member.member_name}님</b>
							<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
							
							<div onclick="location.href='/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=81'" style='cursor:pointer'>
								정보수정
							</div>
							<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
						</c:when>
						<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
							<div>관리자 로그인 중</div>
							<div onclick="location.href='/${homepage.context_path}/intro/login/logout.do'" style='cursor:pointer'>
								로그아웃
							</div>
							<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
						</c:when>
						<c:otherwise>
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=85">로그인</a>
							<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=89">통합회원인증</a>
							<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=86">회원가입</a>
							<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=93"></a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>


</div>