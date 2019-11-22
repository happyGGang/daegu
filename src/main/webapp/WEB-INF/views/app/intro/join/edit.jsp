<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();

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
			$('#memberJoinForm #member_id').focus();
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

		doAjaxPost($('#memberJoinForm'));
	});

	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('#memberJoinForm #member_id').val();
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
			return false;
		}
		$('#checkForm #member_id').val($('#memberJoinForm #member_id').val());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
		}
	});

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
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
	                $('#address2').focus();
	            }
	        }).open();
		});
	});


	$('th.th1').css('width', '20%');
	$('th.th1').css('text-align', 'right');

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;
					$('#pw_confirm_message').text('일치합니다.');
				} else {
					pwCheck = false;
					$('#pw_confirm_message').text('일치하지 않습니다.');
				}
			} else {
				pwCheck = false;
				$('#pw_confirm_message').text('');
			}
		}
	});
	$('input#member_pw').blur(function(e) {
		e.preventDefault();
		var pwdcheck = false;
		var pw = $(this).val();
		var passwordRules = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d$!@#$%^&*]{9,20}$/;
		if(!passwordRules.test(pw)){
			$('span#pwdcheck').css('color', 'red');
			return false;
		}
		$('#member_pw_confirm').val('');
		$('#pw_confirm_message').text('');
		$('span#pwdcheck').css('color', 'black');
		pwCheck = false;
		pwCheck2 = true;
		return true;

	});


});
</script>

<p class="blind">
	회원가입 단계
</p>
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

			<td class="joinImg3 center">
				<div class="en">STEP 03</div>
				<div class="ko">본인확인</div>
			</td>

			<td class="joinImg4 center active">
				<div class="en">STEP 04</div>
				<div class="ko">정보입력</div>
			</td>
		</tr>
		<tr>
			<td class="joinLine center ">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="join-wrap">

	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form:form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>

		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm" class="editTbl">
			<colgroup>
				<col width="10%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="member_id" class="text" maxlength="20"/> <a href="#" id="check-btn" class="btn">중복확인</a>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<div class="ui-state-highlight">
							<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						비밀번호 확인(<span style="color: red;">*</span>)
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
						${newMember.member_name}
					</td>
				</tr>
				<tr>
					<th>
						성별(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.sex eq '0' ? '남' : '여' }
					</td>
				</tr>
				<tr>
					<th>
						생년월일(<span style="color: red;">*</span>)
					</th>
					<td >
						${newMember.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						휴대폰 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<div id="cell_phone_div">
						<c:if test="${not empty newMember.cell_phone}">
						${newMember.cell_phone}
						<form:input path="cell_phone1" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 0, 3)}"/>
						<form:input path="cell_phone2" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 3, 7)}" />
					 	<form:input path="cell_phone3" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 7, 20)}" />
						</c:if>
						<c:if test="${empty newMember.cell_phone}">
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
						</c:if>
					 	<form:checkbox path="sms_service_yn" value="Y" label="SMS 수신여부"/>
						</div>
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
								<form:input path="address2" class="text" style="width:80%;" />
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						소속도서관(<span style="color: red;">*</span>)
					</th>
					<td>
					 	${homepage.homepage_name}
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
						<form:input path="email1" class="text"/> @
						<form:input path="email2" class="text"/>
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--직접입력--</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gmail.com" >gmail.com</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
						<br/>
						<form:checkbox path="email_service_yn" value="Y" label="EMAIL 수신여부"/>
					</td>
				</tr>

			</tbody>
		</table>

		<div class="btn-wrap">
			<a href="#" id="save-btn" class="btn btn2">회원가입</a>
			<a href="/intro/${homepage.context_path}/index.do" id="cancel-btn" class="btn btn03">취소</a>
		</div>

	</form:form>
	<br/>
</div>
