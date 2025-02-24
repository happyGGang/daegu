<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	$('a.certtype').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parent('div').find('p.success').length;
		if (parent > 0) { return false; }
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val($(this).attr('id'));
		$('form#certForm')[0].submit();
		certWindow.focus();
	});


});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="join-wrap" style="padding: 0">
	<div style="width:100%;text-align:right;margin-bottom:10px;">
		<a href="http://www.vno.co.kr/ipin3/personal/personal01.asp" title="I-PIN 신규발급 바로가기">* I-PIN 신규발급 바로가기 <img src="/resources/common/img/link_icon.png"></a>
	</div>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
		<input type="hidden" name="mode" value="findId">
		<input type="hidden" name="auth_homepage_type" value="1">
	</form>
	<form:form id="memberInfo" modelAttribute="memberInfo" action="findId.do">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>
		<form:hidden path="menu_idx"/>

		<div id="memberCert" class="identi_select">
			<p class="identy_a">
				<a href="#" title="휴대폰 본인인증 새창열림" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰이미지"/>
					<span>휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" title="아이핀 인증 새창열림" class="certtype" id="certGpin">
					<img src="/resources/common/img/identy2.png" alt="아이핀이미지"/>
					<span>I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>

	</form:form>
	<br/>
</div>

