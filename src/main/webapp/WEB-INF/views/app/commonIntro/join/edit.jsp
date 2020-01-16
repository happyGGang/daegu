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
	$('input#member_id').on('change', function(e) {
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

	$('th.th1').css('width', '20%');
	$('th.th1').css('text-align', 'right');

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
	<p class="blind">
		회원가입 단계
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1">
					<img src="/resources/common/img/mem_prcs01.png" alt="" >
				</td>
				<td class="joinText">
					회원유형확인
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png" alt="">
				</td>
				<td class="joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03.png" alt="" >
				</td>
				<td class="joinText">
					본인확인
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04_on.png" alt="" >
				</td>
				<td class="active joinText">
					정보입력
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
<!-- 	* 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/> -->
<!--    	 &nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b> -->
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
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>

		<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>

		<div style="border-top:2px solid #ccc">
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<caption>회원가입 정보입력. 아이디,비밀번호,성명,성별,생년월일,휴대폰 번호,주소,소속도서관,집전화번호,이메일 등을 입력</caption>
			<tbody>
				<tr>
					<th>
						<span style="color: red;">*</span> 아이디
					</th>
					<td>
						<form:input path="member_id" class="text" title="아이디 입력" maxlength="20"/> <a href="#" id="check-btn" class="btn" title="중복확인">중복확인</a>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span>* 아이디는 영문 또는 숫자만 가능하며 6자 이상 20자 이내만 가능합니다.</span>
						</div>
					</td>
				</tr>
 				<tr>
					<th>
						<span style="color: red;">*</span> 비밀번호
					</th>
					<td>
						<form:password path="member_pw" class="text" title="신규 비밀번호 입력" maxlength="20"/>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 비밀번호 확인
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text" title="신규 비밀번호 확인을 위한 입력" > <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 성명
					</th>
					<td>
						${newMember.member_name}
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 성별
					</th>
					<td>
						${newMember.sex eq '0' ? '남' : '여' }
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 생년월일
					</th>
					<td >
						${newMember.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 휴대폰 번호
					</th>
					<td>
						<div id="cell_phone_div">
						<c:if test="${not empty newMember.cell_phone}">
						${newMember.cell_phone}&nbsp;
					 	<form:hidden path="cell_phone1" class="text" cssStyle="width:60px;" title="휴대폰 번호  첫번째 자리 입력" maxlength="3" numberOnly="true"/>
					 	<form:hidden path="cell_phone2" class="text" cssStyle="width:60px;" title="휴대폰 번호  중간 자리 입력" maxlength="4" numberOnly="true"/>
					 	<form:hidden path="cell_phone3" class="text" cssStyle="width:60px;" title="휴대폰 번호  끝 자리 입력"  maxlength="4" numberOnly="true"/>
						</c:if>
						<c:if test="${empty newMember.cell_phone}">
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;"   title="휴대폰 번호 첫번째 자리 입력" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" title="휴대폰 번호  중간 자리 입력" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" title="휴대폰 번호  끝 자리 입력"  maxlength="4" numberOnly="true"/>
						</c:if>
					 	<form:hidden path="cell_phone"/>
					 	<form:checkbox path="sms_service_yn" value="Y" label=" SMS 수신 여부" cssStyle="vertical-align: middle;"/>
						</div>
						<div class="ui-state-highlight" style="margin-top:7px">
							* 도서관련 알림 및 행사 안내를 받으실 수 있습니다
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 주소
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="zipcode" class="text" title="우편번호" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn" title="새창열림">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:80%;" title="상세 주소 입력" />
								<form:input path="address2" class="text" style="width:80%;" title="동이하 주소 입력"/>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 소속도서관
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
						<form:input path="phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true" title="전화번호 지역번호 입력"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true" title="전화번호 중간번호 입력"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true" title="전화번호 끝 번호 입력"/>
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text" title="이메일 아이디 입력" /> @
						<form:input path="email2" class="text" title="이메일주소 입력" />
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;border:1px solid #d0d1d6;border-radius:3px" title="이메일 주소 선택">
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
		</div>

		<div class="btn-wrap">
			<c:if test="${newMember.editMode eq 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1" title="회원가입">회원가입</a>
			</c:if>
			<c:if test="${newMember.editMode ne 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1"title="수정완료">수정완료</a>
			</c:if>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소">취소</a>
		</div>

	</form:form>
	<br/>
</div>
