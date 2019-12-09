<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header.jsp"%>
<script type="text/javascript">
$(function() {

	$('img#symbol').error(function() {
		$(this).remove();
	});

});
</script>


<div id="wrap" class="k-index">
	<div id="lnb_hm" style="right: 0px;">
		<div class="layout">
			<ul class="siteLink">
				<li class="card" style="${isMobile ? '':'display:none'}"><a href="/intro/${homepage.context_path}/login/mobileCard.do">모바일회원증</a></li>
				<c:choose>
				<c:when test="${sessionScope.member.login}">
				<li class="login"><a href="/intro/${homepage.context_path}/login/logout.do">로그아웃</a></li>
				<li class="join"><a href="/intro/${homepage.context_path}/join/passCheck.do">정보수정</a></li>
				</c:when>
				<c:otherwise>
				<li class="login"><a href="/intro/${homepage.context_path}/login/index.do">로그인</a></li>
				<li class="join"><a href="/intro/${homepage.context_path}/join/index.do">신규회원가입</a></li>
				<li class="integration"><a href="/intro/${homepage.context_path}/join/integration.do">통합인증센터</a></li>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>

	<div class="web_section">

	<div id="header">
		<div>
			<span class="symbol01"><img src="/resources/common/img/symbol01.png" onerror="" alt="대구광역시"/></span>
			<span class="main_logo"><img id="symbol" src="/resources/book/intro/img/logo/${homepage.context_path}_logo.png" onerror="" alt="심볼 마크"/></span>
			<span class="symbol02"><img src="/resources/common/img/symbol02.png" onerror="" alt="행복한 시민 자랑스러운 대구"/></span>
		</div>
	</div>

	<div id="container">
		<ul>
			<li class="bg bg01"><a href="/intro/${homepage.context_path}/search/index.do" id="search-btn"><img src="/resources/common/img/bt001.png" alt="통합검색센터"  class="wbt"/><img src="/resources/common/img/mbt001.png" alt="통합검색센터" class="mbt"/></a></li>
			<c:choose>
			<c:when test="${sessionScope.member.login}">
			<li class="bg bg02"><a href="/intro/${homepage.context_path}/search/hope/req.do"><img src="/resources/common/img/bt004.png" alt="희망도서신청" class="wbt"/><img src="/resources/common/img/mbt004.png" alt="희망도서신청" class="mbt"/></a></li>
			<li class="bg bg03"><a href="/intro/${homepage.context_path}/search/loan/index.do" class="join-btn"><img src="/resources/common/img/bt005.png" alt="마이페이지" class="wbt"/><img src="/resources/common/img/mbt005.png" alt="마이페이지" class="mbt"/></a></li>
			</c:when>
			<c:otherwise>
			<li class="bg bg02"><a href="/intro/${homepage.context_path}/join/integration.do"><img src="/resources/common/img/bt002.png" alt="통합인증센터" class="wbt"/><img src="/resources/common/img/mbt002.png" alt="통합인증센터" class="mbt"/></a></li>
			<li class="bg bg03"><a href="/intro/${homepage.context_path}/join/index.do" class="join-btn"><img src="/resources/common/img/bt003.png" alt="신규회원가입" class="wbt"/><img src="/resources/common/img/mbt003.png" alt="신규회원가입" class="mbt"/></a></li>
			</c:otherwise>
			</c:choose>
		</ul>
	</div>

	<div id="footer">
		<address>
			<c:choose>
				<c:when test="${homepage.lib_code eq '00147032'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147024'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147014'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147020'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147004'}">Copyright &copy; by Gyeongsangbuk-do Samgukyusa Gunwi Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147019'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147022'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147012'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147031'}">Copyright &copy; 2013 Gyeongsangbuk-do Yeongdeok Public Library. All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147021'}">Copyright &copy; by Gyeongsangbuk-do Cheongdo Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147003'}">Copyright &copy; by Gyeongsangbuk-do GuMi Library. All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147002'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147009'}">Copyright &copy; by Seongju Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147023'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147015'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147015'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147015'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147015'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147046'}">Copyright &copy; by Gyeongsangbuk-do office of Education Information Center, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147010'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147011'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147039'}"></c:when>
				<c:when test="${homepage.lib_code eq '00147008'}">Copyright &copy; by 2010 Gyeongbuk Provincial Sang-ju Library, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147040'}">Copyright &copy; by Gyeongsangbuk-do Sangju Library Hwaryeong Branch, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147013'}">Copyright &copy; by Gyeongsangbuk-do Youngil Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.lib_code eq '00147016'}">Copyright &copy; by Gyeongsangbuk-do Oedong Public Library, All rights reserved.</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</address>
	</div>
	</div>
</div>

<%@ include file="layout/footer.jsp"%>