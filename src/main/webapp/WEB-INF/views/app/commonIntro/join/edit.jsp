<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
if (!String.prototype.trim) {
	String.prototype.trim = function () {
		return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
	};
}

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
			alert('Password must consist of letters (A-Z), numbers and special characters(!@$^*?_~) (at least 9 characters or more and 20 characters or less)');
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
		if ($('input#cell_phone1').length > 0) {
			$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
		}
		$('input#newMemberId').val($('input#web_id').val().trim());
		doAjaxPost($('#memberJoinForm'));
	});

	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('#memberJoinForm #web_id').val().trim();
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
		if (id.length < 6 || id.length > 20) {
			<c:if test="${member.langMode eq 'eng'}">
			alert('The ID must be between 6 and 20 characters.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('아이디는 6자 이상 20자 이내만 가능합니다.');
			</c:if>
			$('#memberJoinForm #web_id').focus();
			return false;
		}

		$('#checkForm #member_id').val($('#memberJoinForm #web_id').val().trim());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
			<c:if test="${member.langMode eq 'eng'}">
			alert('ID available');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('사용 가능한 ID 입니다.');
			</c:if>
		} else {
			<c:if test="${member.langMode eq 'eng'}">
			alert('Unavailable ID.');
			</c:if>
			<c:if test="${member.langMode ne 'eng'}">
			alert('사용 불가능한 ID 입니다.');
			</c:if>
		}
	});

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
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

	$('th.th1').css('width', '20%');
	$('th.th1').css('text-align', 'right');

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;
					<c:if test="${member.langMode eq 'eng'}">
					$('#pw_confirm_message').text('Match');
					</c:if>
					<c:if test="${member.langMode ne 'eng'}">
					$('#pw_confirm_message').text('일치합니다.');
					</c:if>
				}
				else {
					pwCheck = false;
					<c:if test="${member.langMode eq 'eng'}">
					$('#pw_confirm_message').text('Not Match');
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

	$('a#dls').on('click', function(e) {
		e.preventDefault();
		$('div#dlsForm').toggle();
		$('input#dlsId').focus();
	});

	$('a#dlsCheck').on('click', function(e) {
		e.preventDefault();
		$('input#dlsId').val($('input#dlsId').val());

		if ($('input#dlsId').val() == '') {
			alert('DLS 아이디를 입력해주세요.');
			$('input#dlsId').focus();
			return false;
		}

		if ($('input#dlsPw').val() == '') {
			alert('DLS 비밀번호를 입력해주세요.');
			$('input#dlsPw').focus();
			return false;
		}
		$.get('dlsIdCheck.do?dls_id='+$('input#dlsId').val(), function(response) {
			if (response.valid) {
				alert('이미 인증 받은 아이디입니다.\nDLS 아이디를 확인 하시기 바랍니다.');
			} else {
				$('input#reading_id').val($('input#dlsId').val());
				$('input#reading_pw').val($('input#dlsPw').val());

				var wWidth = 360;
		 		var wHight = 360;
		 		var wX = (window.screen.width - wWidth) / 2;
		 		var wY = (window.screen.height - wHight) / 2;

				var dlsWindow = window.open('', "dlsWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
				$('form#dlsCheckForm').submit();
				dlsWindow.focus();
			}
		});

	});

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
<c:set var="engMode" value="${member.langMode eq 'eng'}"></c:set>
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
					<img src="/resources/common/img/mem_prcs01.png" alt="">
				</td>
				<td class="joinText">
					Check<br/> member<br/> type
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png" alt="">
				</td>
				<td class="joinText">
					Consent to<br/> users<br/> agreement
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03.png" alt="">
				</td>
				<td class="joinText">
					Identification
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04_on.png" alt="">
				</td>
				<td class="active joinText">
					Information<br/> input
				</td>
			</tr>
		</tbody>
	</table>
<div class="join-wrap" style="padding: 0">

	<div class="info">
<!-- 	* 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/> -->
<!--    	 &nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b> -->
	</div>
	<form id="dlsCheckForm" method="post" target="dlsWindow" action="https://reading.gyo6.net/r/reading/search/ebookView_kb_ck.jsp">
	<input type="hidden" name="reading_pw" id="reading_pw" >
	<input type="hidden" name="reading_id" id="reading_id" >
	<input type="hidden" name="return_url" value="http://www.gbelib.kr/geic/intro/join/checkDlsA.do">
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
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="member_id" id="newMemberId"/>
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>

		<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
			(<span style="color: red; font-weight: bold;">*</span>) This is a required input value.
		</div>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						ID(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="web_id" class="text"/> <a href="#" id="check-btn" class="btn">Double check</a>
					</td>
				</tr>
 				<tr>
					<th>
						New password(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<div class="ui-state-highlight">
							<span id="pwdcheck">Password must consist of letters (A-Z), numbers and special characters(!@$^*?_~) (at least 9 characters or more and 20 characters or less)</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						Check new password(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						Name(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.member_name}
						<form:hidden path="member_name" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						Sex(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.sex eq '0001' ? 'Man' : 'Woman' }
						<div id="sex_div" style="display: none;">
						<div class="radio inline">
							<form:radiobutton path="sex" value="0002" label="Man"/>
						</div>
						<div class="radio inline">
							<form:radiobutton path="sex" value="0001" label="Women"/>
						</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						Birthdate(<span style="color: red;">*</span>)
					</th>
					<td >
						${newMember.birth_day}
						<form:hidden path="birth_day"/>
					</td>
				</tr>
				<tr>
					<th>
						Mobile phone number(<span style="color: red;">*</span>)
					</th>
					<td>
						<div id="cell_phone_div">
						<c:if test="${not empty newMember.cell_phone}">
						${newMember.cell_phone}
						</c:if>
						<c:if test="${empty newMember.cell_phone}">
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
						</c:if>
					 	<form:hidden path="cell_phone"/>
					 	<form:checkbox path="sms_service_yn" value="Y" label="Whether you receive SMS or not" cssStyle="vertical-align: middle;"/>
						</div>
						<div class="ui-state-highlight">
							* You may receive the notices related to the books or guide of events
						</div>
					</td>
				</tr>
				<tr>
					<th>
						Address(<span style="color: red;">*</span>)
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn">search postal code</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:80%;" />
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						Affiliated library(<span style="color: red;">*</span>)
					</th>
					<td>
						<c:set value="${fn:split(homepage.homepage_code, ',')}" var="homepage_code"></c:set>
						<form:select path="loca" cssClass="selectmenu-search" style="width:400px">
							<c:if test="${homepage.homepage_id eq 'h1'}">
							<form:option label="== select an option ==" value=""/>
							</c:if>
							<c:forEach items="${homepageList}" var="i">
								<c:if test="${i.homepage_id ne 'c0' and i.homepage_id ne 'c1' and i.homepage_id ne 'h27' and i.homepage_id ne 'h1' and i.homepage_id ne 'h30' and i.homepage_id ne 'h32' and i.homepage_id ne 'h29'}">
								<c:choose>
									<c:when test="${homepage_code[0] eq fn:split(i.homepage_code, ',')[0]}">
										<c:if test="${!engMode}">
										<form:option label="${i.homepage_name}" value="${fn:split(i.homepage_code, ',')[0]}" selected="selected"/>
										</c:if>
										<c:if test="${engMode}">
										<c:set var="homepage_enm" value="${fn:replace(i.homepage_eng_name, 'BY ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2010 ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2013 ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, 'by ', '')}"></c:set>
										<form:option label="${homepage_enm}" value="${fn:split(i.homepage_code, ',')[0]}" selected="selected"/>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${!engMode}">
										<form:option label="${i.homepage_name}" value="${fn:split(i.homepage_code, ',')[0]}"/>
										</c:if>
										<c:if test="${engMode}">
										<c:set var="homepage_enm" value="${fn:replace(i.homepage_eng_name, 'BY ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2010 ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2013 ', '')}"></c:set>
										<c:set var="homepage_enm" value="${fn:replace(homepage_enm, 'by ', '')}"></c:set>
										<form:option label="${homepage_enm}" value="${fn:split(i.homepage_code, ',')[0]}"/>
										</c:if>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
						</form:select>
						<c:if test="${member.editMode eq 'ADD'}">
							<div class="ui-state-highlight">
								* Please select your desired library for membership
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>
						Home phone number
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
						E-mail
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text"/> @
						<form:input path="email2" class="text"/>
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--Please enter in person--</option>
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
			<a href="#" id="save-btn" class="btn btn1">Join</a>
			</c:if>
			<c:if test="${newMember.editMode ne 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1">수정완료</a>
			</c:if>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">Cancel</a>
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
	<form id="dlsCheckForm" method="post" target="dlsWindow" action="https://reading.gyo6.net/r/reading/search/ebookView_kb_ck.jsp">
		<input type="hidden" name="reading_pw" id="reading_pw" >
		<input type="hidden" name="reading_id" id="reading_id" >
		<input type="hidden" name="return_url" value="https://www.gbelib.kr/geic/intro/join/checkDlsA.do">
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
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="member_id" id="newMemberId"/>
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
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
						<form:input path="web_id" class="text" title="아이디 입력" /> <a href="#" id="check-btn" class="btn" title="중복확인">중복확인</a>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span id="pwdcheck">* 아이디는 영문 또는 숫자만 가능하며 6자 이상 20자 이내만 가능합니다.</span>
						</div>
					</td>
				</tr>
 				<tr>
					<th>
						<span style="color: red;">*</span> 비밀번호
					</th>
					<td>
						<form:password path="member_pw" class="text" title="신규 비밀번호 입력" />
						<div class="ui-state-highlight" style="margin-top:7px">
							<span id="pwdcheck">비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
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
						<form:hidden path="member_name" class="text" title="성명 입력" />
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 성별
					</th>
					<td>
						${newMember.sex eq '0001' ? '남' : '여' }
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
						<span style="color: red;">*</span> 생년월일
					</th>
					<td >
						${newMember.birth_day}
						<form:hidden path="birth_day" title="생년월일"/>
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
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 소속도서관
					</th>
					<td>
						<c:set value="${fn:split(homepage.homepage_code, ',')}" var="homepage_code"></c:set>
						<form:select path="loca" cssClass="selectmenu-search" style="width:200px;height:28px;border:1px solid #d0d1d6;border-radius:3px" title="소속도서관 선택">
							<c:if test="${homepage.homepage_id eq 'h1'}">
							<form:option label="== 선택하세요 ==" value=""/>
							</c:if>
							<c:forEach items="${libList}" var="i">
								<c:if test="${i.LOCATION_CODE ne '00000001' and i.LOCATION_CODE ne '00123456'}">
								<c:choose>
									<c:when test="${homepage_code[0] eq i.LOCATION_CODE}">
										<form:option label="${i.LOCATION_NAME}" value="${i.LOCATION_CODE}" selected="selected" />
									</c:when>
									<c:otherwise>
										<form:option label="${i.LOCATION_NAME}" value="${i.LOCATION_CODE}" />
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
						</form:select>
						<c:if test="${member.editMode eq 'ADD'}">
							<div class="ui-state-highlight" style="margin-top:7px">
								* 회원증 발급 및 주로 이용하는 도서관을 선택하세요.
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
						<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true" title="전화번호 지역번호 입력"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="전화번호 중간번호 입력"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="전화번호 끝 번호 입력"/>
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
		</div>

		<div style="text-align:left;padding:49px 0 7px 0">
			선택 입력 사항
		</div>
		<div style="border-top:2px solid #ccc">
		<table id="memberForm">
			<caption>DLS 연계 등을 입력</caption>
			<tbody>
				<tr>
					<th>
						DLS회원인증
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							DLS 아이디 : <input type="text" id="dlsId" class="text" style="width: 100px;" title="DLS아이디 입력">
							DLS 패스워드 : <input type="password" id="dlsPw" class="text" title="DLS 패스워드 입력 ">
							<a href="#" id="dlsCheck" class="btn">확인</a>
						</div>
						<div id="dlsCmt" class="ui-state-highlight">
							* 회원가입일 기준, 학교도서관지원시스템(DLS) 회원일 경우에만 인증을 통해 정회원으로 등록하시기 바랍니다.
						</div>
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
</c:otherwise>
</c:choose>