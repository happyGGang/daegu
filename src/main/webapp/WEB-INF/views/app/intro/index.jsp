<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	response.setHeader("X-Frame-Options", "DENY");
	response.setHeader("X-Content-Type-Options", "nosniff");
	response.setHeader("X-XSS-Protection", "1");
%>
<script type="text/javascript">
$(function() {

	$('img#symbol').error(function() {
		$(this).remove();
	});

});
</script>

<c:choose>
<c:when test="${context_path eq 'daegu'}">
<div id="wrap" class="k-index">
	<div class="web_section">
		<div id="header">
		<div>
			<span class="symbol01"><img src="/resources/common/img/symbol01.png" onerror="" alt="대구광역시"></span>
			<span class="symbol02"><img src="/resources/common/img/symbol02.png" onerror="" alt="행복한 시민 자랑스러운 대구"></span>
		</div>
		<div class="tit_box">
		<img src="/resources/common/img/dg_tit.png" alt="대구 도서관 통합허브시스템 ID 지금부터 만들 수 있어요 ">  
		</div>
			<div class="tit_box2">
				<img src="/resources/common/img/main_text.png" alt="알기 쉽고, 기억하기 쉬운 나만의 아이디 대구통합도서관 회원가입으로 미리 만드세요">  
			</div>
		</div>
		<div id="container">
			<div class="txt">
				대구지역 96개 공립 도서관의 회원정보를 단계적으로 통합하여<br/>
                <strong>2020년 말까지 하나의 도서관처럼 이용할 수 있는 서비스</strong>로 확대됩니다.<br/>
                이제 <font color="#ffd300"><strong>하나의 ID</strong></font>로 모든 서비스를 이용 할 수 있습니다. 
			</div>
			<div class="button">
				<a href="/intro/${context_path}/join/index.do?" class="goBtn"><img src="/resources/common/img/joinBtn2.png" alt="login"/></a>
			</div>
						<div class="cons">
				대구광역시립도서관 회원이시면 통합인증을 하여주시기 바랍니다. <a href="/intro/${context_path}/join/integration.do" class="goBtn">[인증하러가기]</a><br/>
                현재 만든 ID는 소속도서관이 통합되어야 사용 할 수 있습니다.
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
				<li class="card" style="${isMobile ? '':'display:none'}"><a href="/intro/${context_path}/login/mobileCard.do">모바일회원증</a></li>
				<c:choose>
				<c:when test="${sessionScope.member.login}">
				<li class="login"><a href="/intro/${context_path}/login/logout.do">로그아웃</a></li>
				<li class="join"><a href="/intro/${context_path}/join/passCheck.do">정보수정</a></li>
				</c:when>
				<c:otherwise>
				<li class="login"><a href="/intro/${context_path}/login/index.do">로그인</a></li>
				<li class="join"><a href="/intro/${context_path}/join/index.do">신규회원가입</a></li>
				<!-- <li class="integration"><a href="/intro/${context_path}/join/integration.do">통합인증센터</a></li> -->
				</c:otherwise>
				</c:choose>
				<!-- 
				<c:choose>
				<c:when test="${context_path eq 'beomeo'}">
				<li class="gohomepage"><a href="http://library.suseong.kr/beomeo/" target="_blank">홈페이지로이동</a></li>
				</c:when>
				<c:when test="${context_path eq 'yonghak'}">
				<li class="gohomepage"><a href="http://library.suseong.kr/yonghak/" target="_blank">홈페이지로이동</a></li>
				</c:when>
				<c:when test="${context_path eq 'gosan'}">
				<li class="gohomepage"><a href="http://library.suseong.kr/gosan/main/index.htm" target="_blank">홈페이지로이동</a></li>
				</c:when>
				<c:otherwise>
				</c:otherwise>
				</c:choose> 
				-->
			</ul>
		</div>
	</div>

	<div class="web_section">

	<div id="header">
		<div>
			<span class="symbol01"><img src="/resources/common/img/symbol01.png" onerror="" alt="대구광역시"/></span>
			<span class="main_logo"><img id="symbol" src="/resources/book/intro/img/logo/${context_path}_logo.png" onerror="" alt="심볼 마크"/></span>
			<span class="symbol02"><img src="/resources/common/img/symbol02.png" onerror="" alt="행복한 시민 자랑스러운 대구"/></span>
		</div>
	</div>

	<div id="container">
		<ul>
			<li class="bg bg01"><a href="/intro/${context_path}/search/index.do" id="search-btn"><img src="/resources/common/img/bt001.png" alt="통합검색센터"  class="wbt"/><img src="/resources/common/img/mbt001.png" alt="통합검색센터" class="mbt"/></a></li>
			<c:choose>
			<c:when test="${sessionScope.member.login}">

			<c:choose>
				<c:when test="${context_path eq 'bolli'||context_path eq 'kids'}">
			<li class="bg bg02"><a href="#" onclick="alert('2021년 도서구입 예산소진으로 희망도서신청을 중단합니다. \n\r그 동안 이용해 주셔서 감사합니다.')"><img src="/resources/common/img/bt004.png" alt="희망도서신청" class="wbt"/><img src="/resources/common/img/mbt004.png" alt="희망도서신청" class="mbt"/></a></li>
				</c:when>
				<c:when test="${context_path eq 'dssmalllib'}">
			<li class="bg bg02"><a href="/intro/${context_path}/search/newBook/index.do"><img src="/resources/common/img/bt006.png" alt="신착자료" class="wbt"/><img src="/resources/common/img/mbt006.png" alt="신착자료" class="mbt"/></a></li>
				</c:when>
				<c:otherwise>
			<li class="bg bg02"><a href="/intro/${context_path}/search/hope/req.do"><img src="/resources/common/img/bt004.png" alt="희망도서신청" class="wbt"/><img src="/resources/common/img/mbt004.png" alt="희망도서신청" class="mbt"/></a></li>
				</c:otherwise>
			</c:choose>
			<li class="bg bg03"><a href="/intro/${context_path}/search/loan/index.do" class="join-btn"><img src="/resources/common/img/bt005.png" alt="마이페이지" class="wbt"/><img src="/resources/common/img/mbt005.png" alt="마이페이지" class="mbt"/></a></li>
			</c:when>
			<c:otherwise>
			<li class="bg bg02"><a href="/intro/${context_path}/join/integration.do"><img src="/resources/common/img/bt002.png" alt="통합인증센터" class="wbt"/><img src="/resources/common/img/mbt002.png" alt="통합인증센터" class="mbt"/></a></li>
			<li class="bg bg03"><a href="/intro/${context_path}/join/index.do" class="join-btn"><img src="/resources/common/img/bt003.png" alt="신규회원가입" class="wbt"/><img src="/resources/common/img/mbt003.png" alt="신규회원가입" class="mbt"/></a></li>
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



