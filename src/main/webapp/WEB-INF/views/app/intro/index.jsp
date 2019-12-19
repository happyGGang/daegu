<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {

	$('img#symbol').error(function() {
		$(this).remove();
	});

});
</script>

<c:choose>
<c:when test="${homepage.context_path eq 'daegu'}">
<div id="wrap" class="k-index">
	<div class="web_section">
		<div id="header">
			<div class="title">
				대구 통합 도서관<br/>통합회원 인증센터
			</div>
		</div>

		<div id="container">
			<div class="txt">
				대구 통합 도서관을 이용하시기 위해서는 반드시 통합회원으로 가입하여야 하므로 통합회원가입 신청하시길 바랍니다.
			</div>
			<div class="button">
				<a href="/intro/${homepage.context_path}/join/integration.do" class="goBtn"><img src="/resources/common/img/joinBtn.png" alt="login"/></a>
			</div>
		</div>
	</div>
</div>
</c:when>
<c:otherwise>
<div id="wrap" class="k-index">
	<div id="lnb_hm" style="right: 0px;">
		<div class="layout">
			<ul class="m-siteLink">
				<li class="card" style="${isMobile ? '':'display:none'}"><a href="/intro/${homepage.context_path}/login/mobileCard.do">모바일회원증</a></li>
				<c:choose>
				<c:when test="${sessionScope.member.login}">
				<li class="login"><a href="/intro/${homepage.context_path}/login/logout.do">로그아웃</a></li>
				<li class="join"><a href="/intro/${homepage.context_path}/join/passCheck.do">정보수정</a></li>
				</c:when>
				<c:otherwise>
				<li class="login"><a href="/intro/${homepage.context_path}/login/index.do">로그인</a></li>
				<li class="join"><a href="/intro/${homepage.context_path}/join/index.do">신규회원가입</a></li>
				<!-- <li class="integration"><a href="/intro/${homepage.context_path}/join/integration.do">통합인증센터</a></li> -->
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
				<c:choose>
				<c:when test="${homepage.context_path ne 'bukbu'}">
			<li class="bg bg02"><a href="/intro/${homepage.context_path}/search/hope/req.do"><img src="/resources/common/img/bt004.png" alt="희망도서신청" class="wbt"/><img src="/resources/common/img/mbt004.png" alt="희망도서신청" class="mbt"/></a></li>
				</c:when>
				<c:otherwise>
			<li class="bg bg02"><a href="#" class="not-hope"><img src="/resources/common/img/bt004.png" alt="희망도서신청" class="wbt"/><img src="/resources/common/img/mbt004.png" alt="희망도서신청" class="mbt"/></a></li>
				</c:otherwise>
				</c:choose>
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
			Copyright &copy; by Daegu Library, All rights reserved.
		</address>
	</div>
	</div>
</div>
</c:otherwise>
</c:choose>



