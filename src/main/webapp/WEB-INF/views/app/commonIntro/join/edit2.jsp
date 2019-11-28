<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();

		<c:if test="${param.ageType eq 'under'}">
		if ($('div.identi_select:eq(0)').find('p.success').length < 1) {
			alert('보호자(법정대리인) 인증 후 가입가능합니다.');
			$('input#parentagree').focus();
			return false;
		}
		if (!$('input#parentagree').is(':checked')) {
			alert('보호자(법정대리인) 동의 후 가입가능합니다.');
			$('input#parentagree').focus();
			return false;
		}
		</c:if>

		var certCheck = true;

		if ($('input#certType').val() == '' ) {
			var certCheck = false;
		}

		if (!certCheck) {
			alert('본인 인증 후 가입 가능합니다.');
			return false;
		}


		if (!idCheck) {
			alert('아이디 중복확인 후 가능합니다.');
			return false;
		}

		if (!pwCheck2) {
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			return false;
		}
		if (!pwCheck) {
			alert('비밀번호 확인 후 가능 합니다.');
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
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
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
	$('a#findPostCode2').on('click', function(e){
		e.preventDefault();
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
					$('#pw_confirm_message').text('일치합니다.');
				}
				else {
					pwCheck = false;
					$('#pw_confirm_message').text('일치하지 않습니다.');
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
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<div class="join-step" style="position: inherit;">
	<p class="blind">회원가입 단계</p>
	<ul>
<!-- 		<li class="step1"><span>1</span> <em>회원유형확인</em></li> -->
		<li class="step2"><span>2</span> <em>이용약관동의</em></li>
		<li class="step3 active"><span>3</span> <em>본인확인 및 정보입력</em></li>
	</ul>
</div>

<div class="join-wrap" style="padding: 0">

	<div class="info">
	* 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/>
   	 &nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b>
	</div>

	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="testMode" value="T">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="member_id" id="newMemberId"/>
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<div class="identi_select" style="${param.ageType ne 'under' ? 'display:none;':''}">
			<p class="identy_a">
				<a href="#" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt="공공 I-PIN인증"/>
					<span>공공 I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>

		<table style="margin-bottom:50px; ${param.ageType ne 'under' ? 'display:none;':''}">
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
<!-- 		<button id="testMode">테스트인증</button> -->
		<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="web_id" class="text"/> <a href="#" id="check-btn" class="btn">중복확인</a>
					</td>
				</tr>
 				<tr>
					<th>
						신규 비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<span id="pwdcheck">비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
					</td>
				</tr>
				<tr>
					<th>
						신규 비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						성명(<span style="color: red;">*</span>)
					</th>
					<td>
						<span id="member_name">*인증 후 자동 입력됩니다.</span>
						<form:hidden path="member_name" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						성별(<span style="color: red;">*</span>)
					</th>
					<td>
						<span id="sex_span">*인증 후 자동 입력됩니다.</span>
						<div id="sex_div" style="display: none;">
						<div class="radio inline">
							<form:radiobutton path="sex" value="0002" label="여자"/>
						</div>
						<div class="radio inline">
							<form:radiobutton path="sex" value="0001" label="남자"/>
						</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						생년월일(<span style="color: red;">*</span>)
					</th>
					<td >
						<span id="birth_day_span">*인증 후 자동 입력됩니다.</span>
						<form:hidden path="birth_day"/>
					</td>
				</tr>
				<tr>
					<th>
						휴대폰 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<span id="cell_phone_span"></span>
						<div id="cell_phone_div">
					 	<form:hidden path="cell_phone"/>
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
						</div>
						<form:checkbox path="sms_service_yn" value="Y" label="SMS 수신 여부" cssStyle="vertical-align: middle;"/>
						<div class="ui-state-highlight">
							* 도서관련 알림 및 행사 안내를 받으실 수 있습니다
						</div>

					</td>
				</tr>
				<tr>
					<th>
						주소(<span style="color: red;">*</span>)
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:80%;" />
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						소속도서관(<span style="color: red;">*</span>)
					</th>
					<td>
						<c:set value="${fn:split(homepage.homepage_code, ',')}" var="homepage_code"></c:set>
						<form:select path="loca" cssClass="selectmenu" style="width:200px">
							<c:forEach items="${libList}" var="i">
								<c:choose>
									<c:when test="${homepage_code[0] eq i.LOCATION_CODE}">
										<form:option label="${i.LOCATION_NAME}" value="${i.LOCATION_CODE}" selected="selected"/>
									</c:when>
									<c:otherwise>
										<form:option label="${i.LOCATION_NAME}" value="${i.LOCATION_CODE}" />
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</form:select>
						<c:if test="${member.editMode eq 'ADD'}">
							<div class="ui-state-highlight">
								* 회원가입을 희망하는 도서관을 선택하시기 바랍니다
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
						<form:hidden path="phone"/>
						<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text"/> @
						<form:input path="email2" class="text"/>
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--직접입력--</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gyo6.net" >gyo6.net</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
					</td>
				</tr>
				<!--
				<tr>
					<th>
						직장명
					</th>
					<td>
						<form:input path="company_name" cssClass="text" cssStyle="width: 200px;"/>
					</td>
				</tr>
				<tr>
					<th>
						직장주소
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="company_zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode2" class="btn">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="company_addr" class="text" style="width:80%;" />
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						직장연락처
					</th>
					<td>
						<form:hidden path="company_phone"/>
						<form:input path="company_phone1" class="text" cssStyle="width:60px;;" maxlength="3"/>
					 	- <form:input path="company_phone2" class="text" cssStyle="width:60px;;" maxlength="4"/>
					 	- <form:input path="company_phone3" class="text" cssStyle="width:60px;;" maxlength="4"/>
					</td>
				</tr>
				<tr id="parentNameTr" style="display: none;">
					<th>
						법정대리인 성명
					</th>
					<td id="parentNameTd">
						<form:hidden path="parent_name"/>
					</td>
				</tr>
				<tr id="parentPhoneTr" style="display: none;">
					<th>
						법정대리인 연락처
					</th>
					<td>
						<form:hidden path="parent_phone"/>
						<form:input path="parent_phone1" class="text" cssStyle="width:60px;;" maxlength="3"/>
					 	- <form:input path="parent_phone2" class="text" cssStyle="width:60px;;" maxlength="4"/>
					 	- <form:input path="parent_phone3" class="text" cssStyle="width:60px;;" maxlength="4"/>
					</td>
				</tr> -->
			</tbody>
		</table>

		<div class="btn-wrap">
			<c:if test="${newMember.editMode eq 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1">회원가입</a>
			</c:if>
			<c:if test="${newMember.editMode ne 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1">수정완료</a>
			</c:if>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
		</div>

	</form:form>
	<br/>
</div>
