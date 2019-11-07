<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
// 		alert('인증이 완료되었습니다.');
		
// 		var certtype = $(this).attr('certtype');
// 		if (certtype == '') {
			
// 		}
	});
	
	$('button#testMode').on('click', function(e) {
		e.preventDefault();
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val($(this).attr('id'));
		$('form#certForm')[0].submit();
	});
	
});
</script>
<!-- <button id="testMode">테스트인증</button> -->
<%-- <form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow"> --%>
<!-- 	<input type="hidden" name="certType"> -->
<%-- </form> --%>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="testMode" value="T">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>



	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs02_on.png">
				</td>
				<td class="active joinText">
					본인인증
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs03.png">
				</td>
				<td class="joinText">
					아이디 선택
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					정보수정
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
	- * 본인인증이 되지 않은 아이디는 본인인증 후 통합회원으로 전환이 가능합니다. <br/>
	- * 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/>
   	 &nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b>
	</div>
	
	<div id="memberCert" class="identi_select" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="certGpin">
					<img src="/resources/common/img/identy2.png" alt="공공 I-PIN(아이핀)인증"/>
					<span>공공 I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>
	
	<form:form id="memberAgreeForm" modelAttribute="newMember" action="integration2.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="before_url"/>
	<form:hidden path="ageType"/>
	<form:hidden path="menu_idx"/>
	
	
	</form:form>
	
</div>