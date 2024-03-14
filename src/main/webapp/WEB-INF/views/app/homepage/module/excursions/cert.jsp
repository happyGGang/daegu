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
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {

			var parent = $(this).parent('div').find('p.success').length;
			if (parent > 0) { return false; }
			var wWidth = 360;
	 		var wHight = 120;
	 		var wX = (window.screen.width - wWidth) / 2;
	 		var wY = (window.screen.height - wHight) / 2;
			var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
			$('form#certForm input[name=certType]').val($(this).attr('id'));
			$('form#certForm')[0].submit();
		}
		else {
			alert('약관에 동의해 주시기 바랍니다.');
			false;
		}

	});

});
</script>

<div class="join-wrap" style="padding: 0">
<!--
	<div class="info">
	* 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/>
	&nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b>
	</div>
-->
	<form:form id="board" modelAttribute="excursions" action="edit.do" method="get" onsubmit="return false;">
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="excursions_idx"/>
	<form:hidden path="homepage_id"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="mode" value="board">
		<input type="hidden" name="certType">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
		<div class="identi_select" >
			<p class="identy_a">
				<a href="#" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>${parentNameTag}휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt="공공 I-PIN인증"/>
					<span>${parentNameTag}공공 I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>
	<br/>
</div>
