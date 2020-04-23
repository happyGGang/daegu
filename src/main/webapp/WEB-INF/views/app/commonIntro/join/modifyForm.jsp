<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/member.css"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {

	<%--회원정보 수정--%>
	$('a#save-btn').on('click', function(e) {
		e.preventDefault();

		if ($("#new_password_area1").is(':visible')) {
			if (!pwCheck2) {
				alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
				$('#memberNewPw').focus();
				return false;
			}
			if (!pwCheck) {
				alert('비밀번호 확인 후 가능 합니다.');
				$('input#member_pw_confirm').focus();
				return false;
			}
		}

		if ($("#new_card_password_area1").is(':visible')) {
			if (!cardCheck) {
				alert('카드 비밀번호는 숫자 4자리만 가능합니다.');
				$('input#card_password').focus();
				return false;
			}
		}

		doAjaxPost($('#memberInfoForm'));
	});

	$('a#findPostCode').on('click', function(e){
		e.preventDefault();
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

	<%--이메일선택--%>
	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
	});

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#memberNewPw').val() == $('#member_pw_confirm').val() ) {
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
	$('input#memberNewPw').on('keyup', function(e) {
		e.preventDefault();
		var pwdcheck = false;
		var pw = $(this).val();
		var rule = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d$!@#$%^&*]{9,20}$/;
		if(!rule.test(pw)){
			$('span#pwdcheck').css('color', 'red');
			pwCheck = false;
			return false;
		}
		$('#member_pw_confirm').val('');
		$('#pw_confirm_message').text('');
		$('span#pwdcheck').css('color', 'black');
		pwCheck = false;
		pwCheck2 = true;
		return true;
	});

	$('input#change_password_flag').on('click', function(e) {
		var newPasswordObj1 = $("#new_password_area1");
		var newPasswordObj2 = $("#new_password_area2");

		if($("input#change_password_flag").is(":checked")){
			if(newPasswordObj1.css("display") == "none") {
				newPasswordObj1.css("display", "table-row");
				$("#memberNewPw").focus();
			}
			if(newPasswordObj2.css("display") == "none") {
				newPasswordObj2.css("display", "table-row");
			}
		}else{
			if(newPasswordObj1.css("display") == "table-row") {
				$("#memberNewPw").val("");
				newPasswordObj1.css("display", "none");
				$('span#pwdcheck').css('color', 'black');
			}
			if(newPasswordObj2.css("display") == "table-row") {
				$("#member_pw_confirm").val("");
				newPasswordObj2.css("display", "none");
				$('#pw_confirm_message').text('');
			}
		}
	});
	$('input#change_card_password_flag').on('click', function(e) {
		var newPasswordObj1 = $("#new_card_password_area1");

		if($("input#change_card_password_flag").is(":checked")){
			if(newPasswordObj1.css("display") == "none") {
				newPasswordObj1.css("display", "table-row");
				$("#card_password").focus();
			}
		}else{
			if(newPasswordObj1.css("display") == "table-row") {
				$("#card_password").val("");
				newPasswordObj1.css("display", "none");
				$('span#cardcheck').css('color', 'black');
			}
		}
	});
	$('input#card_password').on('keyup', function() {
		var val = $(this).val();
		if (val && val.length == 4 && parseInt(val) ) {
			$('span#cardcheck').css('color', 'black');
			cardCheck = true;
		} else {
			$('span#cardcheck').css('color', 'red');
			cardCheck = false;
		}
	});
	
	$('a.certtype').on('click', function(e) {
		e.preventDefault();
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
$(document).on("keyup change", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
	<input type="hidden" name="certType">
	<input type="hidden" name="mode" value="changeTel">
	<input type="hidden" name="menu_idx" value="${param.menu_idx}">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<div class="join-wrap" style="padding: 0;">
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode" value="MODIFY"/>
		<form:hidden path="menu_idx" value="${param.menu_idx}"/>
		<table id="memberForm">
			<tbody>
				<tr>
					<th>
						성명
					</th>
					<td>
						${memberInfo.member_name}
					</td>
				</tr>
				<c:if test="${memberInfo.user_no ne 'null'}">
				<tr>
					<th>
						대출번호
					</th>
					<td>
						${memberInfo.user_no}
					</td>
				</tr>
				</c:if>
				<tr>
					<th>
						아이디
					</th>
					<td>
						${memberInfo.member_id}
					</td>
				</tr>
				<tr>
					<th>
						비밀번호 변경여부
					</th>
					<td>
						<input type="checkbox" id="change_password_flag" /> 비밀번호 변경
					</td>
				</tr>
				<tr id="new_password_area1" style="display:none;width:100%;">
					<th>
						변경할 비밀번호
					</th>
					<td>
						<form:password path="memberNewPw" class="text" maxlength="20"/>
						<div class="ui-state-highlight">
							<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>
					</td>
				</tr>
				<tr id="new_password_area2" style="display:none;width:100%;">
					<th>
						변경할 비밀번호 확인
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text" maxlength="20"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<c:if test="${memberInfo.user_no ne 'null'}">
				<tr>
					<th>
						카드 비밀번호 변경여부
					</th>
					<td>
						<input type="checkbox" id="change_card_password_flag" /> 카드 비밀번호 변경
					</td>
				</tr>
				<tr id="new_card_password_area1" style="display:none;width:100%;">
					<th>
						카드 비밀번호
					</th>
					<td>
						<form:password path="card_password" class="text" maxlength="4"/>
						<div class="ui-state-highlight">
							<span id="cardcheck">카드비밀번호는 숫자 4자리만 가능</span>
						</div>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>
						휴대폰 번호
					</th>
					<td>
						<div id="cell_phone_div">
							<form:input path="cell_phone1" class="text" cssStyle="width:60px;" title="휴대폰 번호 첫번째 자리 입력" maxlength="3" numberOnly="true" readonly="true"/>
							- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" title="휴대폰 번호  중간 자리 입력" maxlength="4" numberOnly="true" readonly="true"/>
							- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" title="휴대폰 번호  끝 자리 입력"  maxlength="4" numberOnly="true" readonly="true"/>
							<form:checkbox path="sms_service_yn" value="Y" label=" SMS 수신 여부" cssStyle="vertical-align: middle;"/>
							<a href="#" id="sms" class="btn certtype" title="새창열림">인증확인</a>
							<div class="highlight">
								<label for="sms_service_yn1"> * 입력한 휴대폰 번호로 반납 및 연체문자가 수신됩니다.</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						성별
					</th>
					<td>
						${memberInfo.sex eq '0' ? '남자' : '여자'}
					</td>
				</tr>
				<tr>
					<th>
						생년월일
					</th>
					<td >
						${memberInfo.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						주소
					</th>
					<td>
						<div class="line2">
							<p>
								${memberInfo.zipcode}
							</p>
							<p>
								${memberInfo.address1}
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
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
						<select id="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--직접입력--</option>
							<c:forEach items="${email}" var="i" varStatus="status">
	<%-- 						<option value="${i.code_name}" >${i.code_name}</option> --%>
							</c:forEach>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gmail.com" >gmail.com</option>
							<option value="nate.com" >nate.com</option>
							<option value="korea.com" >korea.com</option>
							<option value="hotmail.com" >hotmail.com</option>
							<option value="yahoo.com" >yahoo.com</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
						<br/>
						<form:checkbox path="email_service_yn" value="Y" label="EMAIL 수신여부"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1" title="저장">저장</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소" >취소</a>
	</div>
	<br/>
</div>