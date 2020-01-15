<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="head">
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="section">
				<!-- menu S -->
				<div class="g-menu">
					<homepageTag:topMenu menuList="${menuTreeList}" />

					<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92" class="last-box"><img src="/resources/homepage/${homepage.context_path}/img/sitemap-btn.png" alt="사이트맵" /></a>

					<div class="mmode">
					<c:choose>
						<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
							<a href="/${homepage.context_path}/intro/join/accessInfo.do?menu_idx=115" class="mobilemeberinfo">
								<i class="fa fa-user"></i>
									<span>${sessionScope.member.member_name}님</span>
							</a>
							<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=115" class="btn4">
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
							<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=121" class="btn1">
								<i class="fa fa-lock"></i>
								<span>로그인</span>
							</a>
							<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=120" class="btn2">
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

	<div class="section">
		<div class="txt">
			<span class="">꿈을 향한 힘찬 도전<Br/> <b>대구광역시립<em>수성도서관</em></b></span>
		</div>

		<div id="holiday-box">
		</div>
	</div>
</div>