<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();

		<c:if test="${param.ageType eq 'under'}">
		if ($('div.identi_select:eq(0)').find('p.success').length < 1) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('You can sign up after you sign up for a guardian (legal representative).');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('보호자(법정대리인) 인증 후 가입가능합니다.');
			</c:if>
			$('input#parentagree').focus();
			return false;
		}
		if (!$('input#parentagree').is(':checked')) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('You can join after your guardian (legal representative) has agreed.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('보호자(법정대리인) 동의 후 가입가능합니다.');
			</c:if>
			$('input#parentagree').focus();
			return false;
		}
		</c:if>

		var certCheck = true;

		if ($('input#certType').val() == '' ) {
			var certCheck = false;
		}

		if (!certCheck) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('You can sign up after you authenticate yourself.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('본인 인증 후 가입 가능합니다.');
			</c:if>
			return false;
		}


		if (!idCheck) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('Possible after confirmation of ID duplication.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('아이디 중복확인 후 가능합니다.');
			</c:if>
			return false;
		}

		if (!pwCheck2) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('Password must be between 9 and 20 characters in English, numeric, and special characters.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			</c:if>
			return false;
		}
		if (!pwCheck) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('It is possible after confirming the password.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('비밀번호 확인 후 가능 합니다.');
			</c:if>
			return false;
		}

		$('#email').val($('#email1').val() + '@' + $('#email2').val());
		if ($('#email').val() == '@') {
			$('#email').val('');
		}
		$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
		doAjaxPost($('#memberJoinForm'));
	});

	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('#memberJoinForm #member_id').val();
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('ID can only be entered in English or numbers.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
			</c:if>
			$('#memberJoinForm #member_id').focus();
			return false;
		}
		$('#checkForm #member_id').val($('#memberJoinForm #member_id').val());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
		}
	});

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
	});

	$('input#member_id').on('keyup', function(e) {
		e.preventDefault();
		idCheck = false;
	});

	$('input#zipcode').on('click', function(e) {
		e.preventDefault();
		$('a#findPostCode').click();
	});

	$('a#findPostCode').on('click', function(e){
		e.preventDefault();
		daum.postcode.load(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
					fullAddr = data.roadAddress;
					if(data.bname !== ''){
					    extraAddr += data.bname;
					}
					if(data.buildingName !== ''){
					    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                $('#zipcode').val(data.zonecode);//5자리 새우편번호 사용
	                $('#address1').val(fullAddr);
	                $('#address1').focus();
	            }
	        }).open();
		});
	});
	$('a#findPostCode2').on('click', function(e){
		e.preventDefault();
		daum.postcode.load(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
					fullAddr = data.roadAddress;
					if(data.bname !== ''){
					    extraAddr += data.bname;
					}
					if(data.buildingName !== ''){
					    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                $('#company_zipcode').val(data.zonecode);//5자리 새우편번호 사용
	                $('#company_addr').val(fullAddr);
	                $('#company_addr').focus();
	            }
	        }).open();
		});
	});


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

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;
					<c:if test="${member.langMode eq 'eng'}">
					$('#pw_confirm_message').text('Match.');
					</c:if>
					<c:if test="${member.langMode ne 'eng'}">
					$('#pw_confirm_message').text('일치합니다.');
					</c:if>
				}
				else {
					pwCheck = false;
					<c:if test="${member.langMode eq 'eng'}">
					$('#pw_confirm_message').text('Not Match.');
					</c:if>
					<c:if test="${member.langMode ne 'eng'}">
					$('#pw_confirm_message').text('일치하지 않습니다.');
					</c:if>
				}
			}
			else {
				pwCheck = false;
				$('#pw_confirm_message').text('');
			}
		}
	});
	$('input#member_pw').blur(function(e) {
		e.preventDefault();
		var pwdcheck = false;
		var pw = $(this).val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[^\da-zA-Z]/gi);
		if(pw.length < 9 || pw.length > 20){
// 			alert('4자리 ~ 20자리 이내로 입력해주세요.');
			$('span#pwdcheck').css('color', 'red');
			return false;
		}
		if(pw.search(/\s/) != -1){
// 			alert("비밀번호는 공백없이 입력해주세요.");
			$('span#pwdcheck').css('color', 'red');
			return false;
		}
		if(num < 0 || eng < 0 || spe < 0 ){
			$('span#pwdcheck').css('color', 'red');
// 			alert("비밀번호는 공백없이 입력해주세요.");
			return false;
		}
		$('span#pwdcheck').css('color', 'black');
		pwCheck2 = true;
		return true;
	});

	<c:if test="${param.ageType ne 'under' and param.ageType ne 'more'}">
	alert('잘못된 경로로 접근하였습니다.');
	location.href = 'index.do';
	</c:if>
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<c:if test="${member.langMode eq 'eng'}">
<style>
.join-step li { margin: 0% 2%;}
.join-wrap .identi_select a {
    font-size: 113%;
}
</style>
</c:if>
<c:choose>
	<c:when test="${member.langMode eq 'eng'}">
	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>
		<c:if test="${!engMode}">회원가입 단계</c:if>
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1">
					<img src="/resources/common/img/mem_prcs01.png">
				</td>
				<td class="joinText">
					Check<br/> member<br/> type
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png">
				</td>
				<td class="joinText">
					Consent to<br/> users<br/> agreement
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03_on.png">
				</td>
				<td class="active joinText">
					Identification
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					Information<br/> input
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap">

	<div class="info">
	* This is the service substituting resident registration number for self authentication  by using ID and password issued at Public I-Personal InformationN Center of the Ministry of Government Administration and Home Affairs<br/>
   	 &nbsp; <b>Issuance of new Public I-Personal InformationN [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b>
	</div>

	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="edit.do">
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>
		<div style="${param.ageType ne 'under' ? 'display:none;':''}">
		* This is the button for self authentication of guardian (legal representative). After authentication of guardian, the screen for self authentication selection for children aged 14 and under will appear.
		</div>
		<div class="identi_select" style="${param.ageType ne 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt="Self authentication with mobile phone."/>
					<span>Self authentication with mobile phone.</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt="Public I-Personal InformationN authentication"/>
					<span>Public I-Personal InformationN authentication</span>
				</a>
			</p>
		</div>

		<table style="margin-bottom:50px; ${param.ageType ne 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						Self authentication of guardian<br/>(legal representative)
					</th>
					<td id="parentCert">
						* Please select the method of self authentication.
					</td>
				</tr>
				<tr>
					<th>
						Check guardian<br/> (legal representative)
					</th>
					<td id="parentName">
						<input type="text" class="text" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<th>
						Consent of guardian<br/>(legal representative)
					</th>
					<td>
						<input type="checkbox" id="parentagree" style="vertical-align: middle; cursor: pointer;"/>
						<label for="parentagree" style="cursor: pointer;"><strong>I confirm that I am the guardian (legal representative) of a child /child member aged 14 and under.</strong></label>
					</td>
				</tr>
			</tbody>
		</table>

		<div id="memberCert" class="identi_select" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt="Self authentication with mobile phone."/>
					<span>Self authentication with mobile phone.</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="certGpin">
					<img src="/resources/common/img/identy2.png" alt="Public I-Personal InformationN authentication"/>
					<span>Public I-Personal InformationN authentication</span>
				</a>
			</p>
		</div>

	</form:form>
	<br/>
</div>
	</c:when>














	<c:otherwise>

			<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
			
			<p class="blind">회원가입 단계</p>
			<table class="joinNoline">
				<tbody>
					<tr>
						<td class="joinImg1 center">
							<div class="en">STEP 01</div>
							<div class="ko">회원유형</div>
						</td>
		
						<td class="joinImg2 center">
							<div class="en">STEP 02</div>
							<div class="ko">이용약관동의</div>
						</td>
		
						<td class="joinImg3 center active">
							<div class="en">STEP 03</div>
							<div class="ko">본인확인</div>
						</td>
		
						<td class="joinImg4 center">
							<div class="en">STEP 04</div>
							<div class="ko">정보입력</div>
						</td>
					</tr>
					<tr>
						<td class="joinLine center active">
							<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
						</td>
		
						<td class="joinLine center">
							<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
						</td>
		
						<td class="joinLine center">
							<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
						</td>
		
						<td class="joinLine center">
							<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
						</td>
					</tr>
				</tbody>
			</table>

<div class="join-wrap">
<c:if test="${param.ageType eq 'under'}">
<c:set var="parentNameTag" value="보호자 "></c:set>
<c:set var="childNameTag" value="14세미만 "></c:set>
</c:if>
	<div class="info">
   	 &nbsp; <b>I-PIN 신규발급 [<a href="http://www.vno.co.kr/ipin3/personal/personal01_01.asp" target="_blank">신규발급바로가기</a>]</b>
	</div>
	<form id="loginForm" action="/intro/${homepage.context_path}/login/index.do">
	</form>
	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="edit.do">
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>
		<div style="${param.ageType ne 'under' ? 'display:none;':''}">
		* 보호자(법정대리인) 본인인증 버튼입니다. 보호자 인증 후 만 14세 미만 본인인증 선택화면이 나타납니다.
		</div>
		<!--
		<div class="identi_select" style="${param.ageType ne 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>${parentNameTag}휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt="I-PIN(아이핀)인증"/>
					<span>${parentNameTag}I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>
		-->

		<div class="identi_select" style="${param.ageType ne 'under' ? 'display:none;':''}">
			<table class="center joinSelect">
				<colgroup>
					<col width="50%"/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy1.jpg" alt="휴대폰 본인인증"  class="joinAdult"/>
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">${parentNameTag}<br/>휴대폰 본인인증</div>
								<div class="joinText2">본인 명의의 휴대폰으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="parentSms">인증하기</a></div>
							</div>
						</div>
					</td>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy2.jpg" alt="아이핀 본인인증" class="joinChild">
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">${parentNameTag}<br/>I-PIN(아이핀)인증</div>
								<div class="joinText2">발급받은 아이핀(I-PIN)으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="parentGpin">인증하기</a></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<table class="editTbl" style="margin-bottom:50px; ${param.ageType ne 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						보호자(법정대리인) 본인인증
					</th>
					<td id="parentCert">
						* 본인인증방법을 선택해 주세요.
					</td>
				</tr>
				<tr>
					<th>
						보호자(법정대리인) 확인
					</th>
					<td id="parentName">
						<input type="text" class="text" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<th>
						보호자(법정대리인) 동의
					</th>
					<td>
						<input type="checkbox" id="parentagree" style="vertical-align: middle; cursor: pointer;"/>
						<label for="parentagree" style="cursor: pointer;"><strong>14세미만 어린이/아동회원의 보호자(법정대리인)임을 확인합니다.</strong></label>
					</td>
				</tr>
			</tbody>
		</table>

		<div id="memberCert" class="identi_select" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<!--
			<p class="identy_a">
				<a href="#" class="certtype" id="certSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>${childNameTag}<br/>휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="certGpin">
					<img src="/resources/common/img/identy2.png" alt="I-PIN(아이핀)인증"/>
					<span>${childNameTag}<br/>I-PIN(아이핀)인증</span>
				</a>
			</p>
			-->
			<table class="center joinSelect">
				<colgroup>
					<col width="50%"/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy1.jpg" alt="휴대폰 본인인증"  class="joinAdult"/>
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">${childNameTag}<br/>휴대폰 본인인증</div>
								<div class="joinText2">본인 명의의 휴대폰으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="certSms">인증하기</a></div>
							</div>
						</div>
					</td>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy2.jpg" alt="아이핀 본인인증" class="joinChild">
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">${childNameTag}<br/>I-PIN(아이핀)인증</div>
								<div class="joinText2">발급받은 아이핀(I-PIN)으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="certGpin">인증하기</a></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

	</form:form>
	<br/>
</div>
	</c:otherwise>
</c:choose>