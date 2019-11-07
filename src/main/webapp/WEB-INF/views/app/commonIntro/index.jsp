<%@ page language="java" pageEncoding="utf-8" %>
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
});
</script>

<form id="goSearchForm" method="post" action="search/index.do">
<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>

<div id="wrap" class="k-index">
	<div id="header">
		<h1><img src="/resources/book/intro/img/logo.png" alt="경상북도공공도서관"/></h1>
	</div>
	<div id="container">
		<div class="txt">
			<b>교육정보센터 방문을 환영합니다.</b>
			<p>아래 이용하시고자 하는 메뉴를 선택해주세요.</p>
		</div>
		<ul class="qlink">
			<li><a id="search-btn"><img src="/resources/book/intro/img/bt1.png" alt="bt1"/></a></li>
			<li><a id="login-btn"><img src="/resources/book/intro/img/bt2.png" alt="bt2"/></a></li>
			<li><a id="join-btn"><img src="/resources/book/intro/img/bt3.png" alt="bt3"/></a></li>
		</ul>
	</div>
	<div id="footer">
		<address>Copyright &copy; by Gyeongsangbukdo Information Center of Education, All rights reserved.</address>
	</div>
</div>

<%@ include file="layout/footer.jsp"%>