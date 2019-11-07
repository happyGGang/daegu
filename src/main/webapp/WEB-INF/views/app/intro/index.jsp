<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header.jsp"%>
<script type="text/javascript">
$(function() {
	$('#search-btn').on('click', function(e) {
		$('#goSearchForm').submit();
	});

	$('#login-btn').on('click', function(e) {
		doGetLoad("login/index.do", "");
	});

	$('#join-btn').on('click', function(e) {
		doGetLoad("join/index.do", "");
	});

	$('img#symbol').error(function() {
		$(this).remove();
	});

	<c:if test="${homepage.context_path eq 'geiclib'}">
	location.href = '/intro/geic/index.do';
	</c:if>

});
</script>

<form id="goSearchForm" method="post" action="search/index.do">
<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>

<div id="wrap" class="k-index">
	<div id="header">
		<h1>
			<img id="symbol" src="/resources/book/intro/img/logo/${homepage.context_path}.png" onerror="" alt="심볼 마크"/>
			<c:set var="homepage_name" value="${homepage.homepage_name}"></c:set>
			<strong>
			 	${homepage.homepage_name}
			</strong>
		</h1>
	</div>
	<div id="container" style="padding-top: 140px;">
		<div class="txt">
			<b> </b>
			<p> </p>
<%-- 			<b>${homepage.homepage_name} 방문을 환영합니다.</b> --%>
<!-- 			<p>아래 이용하시고자 하는 메뉴를 선택해주세요.</p> -->
		</div>
		<ul class="qlink">
			<li><a id="search-btn"><img src="/resources/book/intro/img/bt1.png" alt="noImage"/></a></li>
			<li><a id="login-btn"><img src="/resources/book/intro/img/bt2.png" alt="noImage"/></a></li>
			<li><a id="join-btn"><img src="/resources/book/intro/img/bt3.png" alt="noImage"/></a></li>
		</ul>
	</div>
	<div id="footer">
		<address>
			<c:choose>
				<c:when test="${homepage.homepage_code eq '00147032'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147024'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147014'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147020'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147004'}">Copyright &copy; by Gyeongsangbuk-do Samgukyusa Gunwi Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147019'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147022'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147012'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147031'}">Copyright &copy; 2013 Gyeongsangbuk-do Yeongdeok Public Library. All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147021'}">Copyright &copy; by Gyeongsangbuk-do Cheongdo Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147003'}">Copyright &copy; by Gyeongsangbuk-do GuMi Library. All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147002'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147009'}">Copyright &copy; by Seongju Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147023'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147015'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147015'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147015'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147015'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147046'}">Copyright &copy; by Gyeongsangbuk-do office of Education Information Center, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147010'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147011'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147039'}"></c:when>
				<c:when test="${homepage.homepage_code eq '00147008'}">Copyright &copy; by 2010 Gyeongbuk Provincial Sang-ju Library, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147040'}">Copyright &copy; by Gyeongsangbuk-do Sangju Library Hwaryeong Branch, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147013'}">Copyright &copy; by Gyeongsangbuk-do Youngil Public Library, All rights reserved.</c:when>
				<c:when test="${homepage.homepage_code eq '00147016'}">Copyright &copy; by Gyeongsangbuk-do Oedong Public Library, All rights reserved.</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</address>
	</div>
</div>

<%@ include file="layout/footer.jsp"%>