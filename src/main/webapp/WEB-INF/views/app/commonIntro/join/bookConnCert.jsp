<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('a.certtype').on('click', function(e) {
		e.preventDefault();
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val("certSms");
		$('form#certForm').submit();
		certWindow.focus();

	});
});
</script>

<div class="join-wrap" style="padding: 0">

	<div class="info">
		<ul class="con2">
			<li>휴대폰 본인인증 후 웹아이디를 생성할 수 있습니다.</li>
			<li>본인명의의 휴대폰으로만 인증 가능합니다.</li>
			<li>등록된 휴대폰 번호와 비교를 위해 IPIN인증은 지원하지 않습니다.</li>
		</ul>
	</div>

	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="mode" value="createWebId">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>

	<form:form id="memberJoinForm" modelAttribute="memberInfo" action="bookConnIdEdit.do">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>
		<form:hidden path="menu_idx"/>

		<div id="memberCert" class="identi_select">
			<p class="identy_a">
				<a href="#" title="새창열림" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt=""/>
					<span>휴대폰 본인인증</span>
				</a>
			</p>
		</div>
	</form:form>

</div>