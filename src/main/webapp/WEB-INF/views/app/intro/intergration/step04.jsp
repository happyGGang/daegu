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
		<c:if test="${empty newMember.cell_phone}">
		$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
		</c:if>
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
	
	
	$('th.th1').css('width', '20%');
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
					$('#pw_confirm_message').text('Match');
					</c:if>
					<c:if test="${member.langMode ne 'eng'}">
					$('#pw_confirm_message').text('일치합니다.');
					</c:if>
				}
				else {
					pwCheck = false;
					<c:if test="${member.langMode eq 'eng'}">
					$('#pw_confirm_message').text('일치하지 않습니다.');
					</c:if>
					<c:if test="${member.langMode ne 'eng'}">
					$('#pw_confirm_message').text('Not Match');
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
	
	$('a#dls').on('click', function(e) {
		e.preventDefault();
		$('div#dlsForm').toggle();
		$('input#dlsId').focus();
	});
	
	$('a#dlsCheck').on('click', function(e) {
		e.preventDefault();
		$('input#dlsId').val($('input#dlsId').val());
		
		if ($('input#dlsId').val() == '') {
			alert('DLSC 아이디를 입력해주세요.');
			$('input#dlsId').focus();
			return false;
		}
		
		if ($('input#dlsPw').val() == '') {
			alert('DLSC 비밀번호를 입력해주세요.');
			$('input#dlsPw').focus();
			return false;
		}
		
		$.get('dlsIdCheck.do?dls_id='+$('input#dlsId').val(), function(response) {
			if (response.valid) {
				alert('이미 인증 받은 아이디입니다.\nDLSC 아이디를 확인 하시기 바랍니다.');
				return false;
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
.join-step li { margin: 0% 2%;}
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
					<img src="/resources/common/img/mem_prcs03.png">
				</td>
				<td class="joinText">
					Identification
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04_on.png">
				</td>
				<td class="active joinText">
					Information<br/> input
				</td>
			</tr>
		</tbody>
	</table>
<div class="join-wrap">

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
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>
		
		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) This is a required input value.
		</div>
		<table id="memberForm" >
			<colgroup>
				<col width="10%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th>
						ID(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="member_id" class="text" maxlength="20"/> <a href="#" id="check-btn" class="btn">Double check</a>
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
						<form:input path="cell_phone1" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 0, 3)}"/>
						<form:input path="cell_phone2" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 3, 7)}" />
					 	<form:input path="cell_phone3" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 7, 20)}" />
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
						<c:choose>
						<c:when test="${homepage.homepage_code eq '00147046'}">
						Gyeongsangbuk-do Information Center of Education
						</c:when>
						<c:otherwise>
						<c:set var="homepage_enm" value="${fn:replace(i.homepage_eng_name, 'BY ', '')}"></c:set>
						<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2010 ', '')}"></c:set>
						<c:set var="homepage_enm" value="${fn:replace(homepage_enm, '2013 ', '')}"></c:set>
						<c:set var="homepage_enm" value="${fn:replace(homepage_enm, 'by ', '')}"></c:set>
					 	${homepage_enm}
						</c:otherwise>
						</c:choose>
						<c:set value="${fn:split(homepage.homepage_code, ',')}" var="homepage_code"></c:set>
						<form:hidden path="loca" value="${homepage_code[0]}"/>
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
							<option value="" >--Enter--</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gyo6.net" >gyo6.net</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
<%-- 						<form:checkbox path="email_service_yn" label="이메일 수신 여부" value="Y"/> --%>
					</td>
				</tr>
				<%--<tr>
					<th>
						DLSC 연계
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							DLSC 아이디 : <input type="text" id="dlsId" class="text" style="width: 100px;"> 
							DLSC 패스워드 : <input type="password" id="dlsPw" class="text">
							<a href="#" id="dlsCheck" class="btn">확인</a>
						</div>
						<div id="dlsCmt" class="ui-state-highlight">
							* 학교도서관 디지털자료실지원센터와 연계하여 정회원으로 가입이 가능합니다.
						</div>
					</td>
				</tr> --%>
			</tbody>
		</table>
		
		<div class="btn-wrap">
			<a href="#" id="save-btn" class="btn btn1">Join</a>
			<a href="/intro/${homepage.context_path}/index.do" id="cancel-btn" class="btn">Cancel</a>
		</div>
	
	</form:form>
	<br/>
</div>	
	</c:when>
	
	
	
	
	
	
	
	
	<c:otherwise>
	
			<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
			<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>	
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

	<form id="dlsCheckForm" method="post" target="dlsWindow" action="https://reading.gyo6.net/r/reading/search/ebookView_kb_ck.jsp">
		<input type="hidden" name="reading_pw" id="reading_pw" >
		<input type="hidden" name="reading_id" id="reading_id" >
		<input type="hidden" name="return_url" value="https://www.gbelib.kr/geic/intro/join/checkDlsA.do">
	</form>
	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="user_position" value="WEB"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="langMode"/>
		
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
							<span id="pwdcheck">비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
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
						대출카드 비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="card_pw_confirm" type="password" class="text"> 
					</td>
				</tr>
				<tr>
					<th>
						성명(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.member_name}
						<form:hidden path="member_name" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						성별(<span style="color: red;">*</span>)
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
						생년월일(<span style="color: red;">*</span>)
					</th>
					<td >
						${newMember.birth_day}
						<form:hidden path="birth_day"/>
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
					 	<form:hidden path="cell_phone"/>
					 	<form:hidden path="sms_service_yn" value="Y"/>
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
							</p>
						</div>
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
						<form:hidden path="email_service_yn" value="Y"/>
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
</c:otherwise>
</c:choose>