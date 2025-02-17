<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/common/js/didLogin.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {

	$('th.th1').css('width', '30%');
	$('th.th1').css('text-align', 'right');

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

$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});

function daeguIdLogin(){
	var menu_idx = ${member.menu_idx};
	var data = {
		siteId : "HB1d1Mhaof7fEN8rGmc61Gg",
		requiredVC : "DaeguMasterVC",
		subVC : "",
		returnUrl : "edit.do?menu_idx="+menu_idx
	}
	didLogin.loginPopup(data);
}
</script>

	<p class="blind">
		회원가입 단계
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1">
					<img alt="" src="/resources/common/img/mem_prcs01.png">
				</td>
				<td class="joinText">
					회원유형확인
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img alt="" src="/resources/common/img/mem_prcs02.png">
				</td>
				<td class="joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img alt="" src="/resources/common/img/mem_prcs03_on.png">
				</td>
				<td class="active joinText">
					본인확인
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img alt="" src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					정보입력
				</td>
			</tr>
		</tbody>
	</table>


<div class="join-wrap" style="padding: 0">
<c:if test="${param.ageType eq 'under'}">
<c:set var="parentNameTag" value="보호자 "></c:set>
<c:set var="childNameTag" value="14세미만 "></c:set>
</c:if>
	<div class="info">
   	 &nbsp; <b>I-PIN 신규발급 [<a href="http://www.vno.co.kr/ipin3/personal/personal01.asp" target="_blank">신규발급바로가기</a>]</b>
	</div>
	<form id="loginForm" action="/${homepage.context_path}/intro/login/index.do" method="post">
		<input type="hidden" name="menu_idx" value="${loginMenuIdx}" >
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
		<input type="hidden" name="auth_homepage_type" value="1">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="edit.do">
		<form:hidden path="member_id" id="newMemberId"/>
		<form:hidden path="editMode"/>
		<form:hidden path="user_position"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>
		<div style="${param.ageType ne 'under' ? 'display:none;':''}">
		* 보호자(법정대리인) 본인인증 버튼입니다. 보호자 인증 후 만 14세 미만 본인인증 선택화면이 나타납니다.
		</div>
		<div class="identi_select" style="${param.ageType ne 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" title="새창열림" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt=""/>
					<span>${parentNameTag}휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" title="새창열림" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt=""/>
					<span>${parentNameTag}I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>
		<table style="margin-bottom:50px; ${param.ageType ne 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<td style="font-weight: bold; background: #f8f8f8">
						보호자(법정대리인) 본인인증
					</td>
					<td id="parentCert">
						* 본인인증방법을 선택해 주세요.
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; background: #f8f8f8">
						보호자(법정대리인) 확인
					</td>
					<td id="parentName">
						<label for="parentNameInput" class="blind">보호자(법정대리인) 확인</label>
						<input id="parentNameInput" type="text" class="text" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; background: #f8f8f8">
						보호자(법정대리인) 동의
					</td>
					<td>
						<input type="checkbox" id="parentagree" style="vertical-align: middle; cursor: pointer;"/>
						<label for="parentagree" style="cursor: pointer;"><strong>14세미만 어린이/아동회원의 보호자(법정대리인)임을 확인합니다.</strong></label>
					</td>
				</tr>
			</tbody>
		</table>


		<div id="memberCert" class="identi_select" style="${param.ageType eq 'under' ? 'display:none;':''}">
		<div style="color:red; font-weight: bold; ${param.ageType ne 'under' ? ' display:none;':''}">
		* 실제 가입하려는 만 14세 미만 아동의 명의로 된 휴대폰 또는 아이핀으로 인증하시기 바랍니다.
		</div>
			<p class="identy_a">
				<a href="#" title="새창열림" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt=""/>
					<span>${childNameTag}휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" title="새창열림" class="certtype" id="certGpin">
					<img src="/resources/common/img/identy2.png" alt=""/>
					<span>${childNameTag} I-PIN(아이핀)인증</span>
				</a>
			</p>
			<p class="identy_c" style="display:none;">
				<a href="#" title="새창열림" class="daDaegu" id="daDaegu" onclick="daeguIdLogin()">
					<img src="/resources/common/img/identy2.png" alt=""/>
					<span>${childNameTag}다대구앱 인증</span>
				</a>
			</p>
		</div>

	</form:form>
	<br/>
</div>
