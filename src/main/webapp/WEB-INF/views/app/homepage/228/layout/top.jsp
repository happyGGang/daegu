<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div>
			<a href="/${homepage.context_path}/school/index.do">학교도서관집중지원센터</a>
			<a href="/${homepage.context_path}/html.do?menu_idx=121">불로작은도서관</a>
			<a href="/${homepage.context_path}/html.do?menu_idx=129">2·28청소년존</a>
			<a href="/${homepage.context_path}/html.do?menu_idx=253">그린대로</a>
		</div>
		<div class="util-wrapper">
			<div class="util">
				<div class="sns-box">
					<a href="https://www.facebook.com/228lib?ref=bookmarks"><img src="/resources/homepage/${homepage.context_path}/img/common/facebook-color.svg" alt=""></a>
					<a href="https://www.instagram.com/grindaero_/"><img src="/resources/homepage/${homepage.context_path}/img/common/instagram-color.svg" alt=""></a>
					<a href="https://x.com/daebonglib"><img src="/resources/homepage/${homepage.context_path}/img/common/x-color.svg" alt=""></a>
					<a href="https://www.youtube.com/channel/UCHJiipMqeDWHgehZTp6En3Q"><img src="/resources/homepage/${homepage.context_path}/img/common/youtube-color.svg" alt=""></a>
				</div>
				<c:if test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<a><b>${sessionScope.member.member_name}님</b></a>
				</c:if>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
						<a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95">정보수정</a>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
						<a>관리자 로그인 중</a>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a>
						<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a>
						<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8">통합회원인증</a>
					</c:otherwise>
				</c:choose>
			</div>
			<c:set var="url" value="${pageContext.request.requestURL}" />
			<c:set var="pageUrl" value="${homepage.context_path}/index" />
			<c:if test="${fn:contains(url,pageUrl) }">
				<div class="total-popup-trigger">
					<div>팝업 다시보기</div>
					<div>${fn:length(popupFullList)}</div>
				</div>
			</c:if>
		</div>
	</div>
</div>
