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
		$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
// 		$('input#editMode').val('MODIFY2');
		$('input#newMemberId').val($('input#web_id').val());
		doAjaxPost($('#memberJoinForm'));
	});
	
	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('#memberJoinForm #web_id').val();
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('ID can only be entered in English or numbers.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
			</c:if>
			$('#memberJoinForm #web_id').focus();
			return false;
		}
		$('#checkForm #member_id').val($('#memberJoinForm #web_id').val());		
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
		}
	});
	
	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
	});
	
	$('input#web_id').on('keyup', function(e) {
		e.preventDefault();
		idCheck = false;
	});
	$('input#web_id').on('change', function(e) {
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
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	//                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	//                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
	//                     fullAddr = data.jibunAddress;
	//                 }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	//                 if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	//                 }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#zipcode').val(data.zonecode);//5자리 새우편번호 사용
	                $('#address1').val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
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
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	//                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	//                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
	//                     fullAddr = data.jibunAddress;
	//                 }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	//                 if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	//                 }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#company_zipcode').val(data.zonecode);//5자리 새우편번호 사용
	                $('#company_addr').val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
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
// 		alert('인증이 완료되었습니다.');
		
// 		var certtype = $(this).attr('certtype');
// 		if (certtype == '') {
			
// 		}
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
	
	<c:if test="${member.langMode eq 'eng'}">
	$('div.doc-title > h3').text('Membership');
	</c:if>
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<c:if test="${member.langMode eq 'eng'}">
<style>
.join-step li { margin: 0% 3%;}
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
					<img alt="" src="/resources/common/img/mem_prcs01.png">
				</td>
				<td class="joinText">
					Check<br/> member<br/> type	
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img alt="" src="/resources/common/img/mem_prcs02.png">
				</td>
				<td class="joinText">
					Consent to<br/> users<br/> agreement
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img alt="" src="/resources/common/img/mem_prcs03_on.png">
				</td>
				<td class="active joinText">
					Identification
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img alt="" src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					Information<br/> input
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
	* This is the service substituting resident registration number for self authentication  by using ID and password issued at Public I-Personal InformationN Center of the Ministry of Government Administration and Home Affairs<br/>
   	 &nbsp; <b>Issuance of new Public I-Personal InformationN [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b>
	</div>

	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
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
						Check guardian (legal representative)
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

	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>	
		<c:if test="${!engMode}">회원가입 단계</c:if>	
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
		</div>
	
	</form:form>
	<br/>
</div>
	</c:otherwise>
</c:choose>