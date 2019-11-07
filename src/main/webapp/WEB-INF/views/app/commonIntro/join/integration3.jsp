<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
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

	alert('회원정보 수정 후 저장 하여야만 통합회원 동의/미동의 여부가 저장됩니다.');

	if (location.href.indexOf('https') == -1) {
//   		location.href = 'https://www.gbelib.kr' + location.pathname + location.search;
	}

	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		<c:if test="${empty member.web_id}">
		if ($('input#web_id').val().trim() == '') {
			alert('아이디를 입력해주세요.');
			$('input#web_id').focus();
			return false;
		}
		if (!idCheck) {
			alert('아이디 중복확인 후 가능합니다.');
			return false;
		}
		</c:if>
		
		if (!pwCheck2) {
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			$('input#member_pw').focus();
			return false;
		}
		if (!pwCheck) {
			alert('비밀번호 확인 후 가능 합니다.');
			$('input#member_pw_confirm').focus();
			return false;
		}
		<c:if test="${!fn:contains(member.user_id, '*')}">
		if ($('input#card_password').val().length != 4) {
			alert('대출증 비밀번호 설정은 숫자 4자리로 입력해주세요.');
			$('input#card_password').focus();
			return false;
		}
		</c:if>
		$('#email').val($('#email1').val() + '@' + $('#email2').val());
		$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
		try {
			if(doAjaxPost($('#memberInfoForm'))) {
				location.href="/${homepage.context_path}/index.do";
			}
		} catch (e) {
			alert('통합회원 전환 과정 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요. 오류 코드: 016');
		}
// 		alert('준비중입니다');
	});
	
	$('input#web_id').on('keyup', function(e) {
		e.preventDefault();
		idCheck = false;
	});
	$('input#web_id').on('change', function(e) {
		e.preventDefault();
		idCheck = false;
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
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
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
			$('#pw_confirm_message').text('* 비밀번호를 한번 더 입력해주세요.');
		}
	});

	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('form#memberInfoForm input#web_id').val().trim();
		$('form#memberInfoForm input#web_id').val(id);
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
			$('#memberInfoForm #web_id').focus();
			return false;
		}
		if (id.length < 6) {
			alert('아이디는 6자리 이상 20자 이내만 가능합니다.');
			$('#memberInfoForm #web_id').focus();
			return false;
		}

		$('#checkForm #newMemberId').val($('#memberInfoForm #web_id').val().trim());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
			alert('사용 가능한 ID 입니다.');
		} else {
			alert('사용 불가능한 ID 입니다.');
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

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
	});

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs02.png">
				</td>
				<td class="joinText">
					이용약관동의
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
					<img src="/resources/common/img/mem_prcs04_on.png">
				</td>
				<td class="active joinText">
					본인확인 및 정보입력
				</td>
			</tr>
		</tbody>
	</table>

<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
	<form:hidden path="member_id" id="newMemberId"/>
	<form:hidden path="ageType"/>
</form:form>

<div class="join-wrap" style="padding: 0;">

	<div class="info">
		- 회원정보 수정 후 저장 하여야만 통합회원 동의/미동의 여부가 저장됩니다.
	</div>

	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="https://www.gbelib.kr/${homepage.context_path}/intro/join/save.do" onsubmit="return false;">
		<form:hidden path="editMode" value="INTEGRATION"/>
		<form:hidden path="member_id"/>
		<form:hidden path="user_id"/>
		<form:hidden path="unAgreeFlag"/>
		<form:hidden path="integrationId"/>
		<form:hidden path="integrationIdList"/>
		<form:hidden path="integrationSeqNo"/>
		<form:hidden path="integrationSeqNoList"/>
		<div style="text-align: right; margin-top: 25px;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm"">
			<tbody>
				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<c:choose>
							<c:when test="${empty member.web_id or member.web_id eq null or member.web_id eq '' or fn:length(member.web_id) < 6 or member.web_id eq 'whale8'}">
						<form:input path="web_id" cssClass="text" maxlength="20"/>
						<a href="#" id="check-btn" class="btn">중복확인</a>
							</c:when>
							<c:otherwise>
						${member.web_id}
						<form:hidden path="web_id" cssClass="text" maxlength="20"/>
							</c:otherwise>
						</c:choose>
						<div class="ui-state-highlight">
							<span id="pwdcheck">* 아이디는 영문 또는 숫자만 가능하며 6자 이상 20자 이내만 가능합니다.</span>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<div class="ui-state-highlight">
							<span id="pwdcheck">* 비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text">
						<div class="ui-state-highlight">
							<span id="pw_confirm_message">* 비밀번호를 한번 더 입력해주세요.</span>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						성명(<span style="color: red;">*</span>)
					</th>
					<td>
						${memberInfo.member_name}
					</td>
				</tr>
				<tr>
					<th>
						성별(<span style="color: red;">*</span>)
					</th>
					<td>
						${memberInfo.sex eq '0001' ? '남' : '여' }
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
						${memberInfo.birth_day}
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
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
						<form:checkbox path="sms_service_yn" value="Y" label="SMS 수신 여부" cssStyle="vertical-align: middle;"/>
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
								<form:input path="address1" class="text" style="width:90%;" /> <br/>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						소속도서관(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:select path="loca" cssClass="selectmenu-search" style="width:250px" disabled="${elibLendCnt > 0}">
							<form:option value="00347034" label="경상북도교육청연수원" />
							<form:option value="00147046" label="경상북도교육청정보센터" />
							<form:option value="00147003" label="경상북도교육청 구미도서관" />
							<form:option value="00147010" label="경상북도교육청 안동도서관" />
							<form:option value="00147011" label="경상북도교육청 안동도서관용상분관" />
							<form:option value="00147039" label="경상북도교육청 안동도서관풍산분관" />
							<form:option value="00147008" label="경상북도교육청 상주도서관" />
							<form:option value="00147040" label="경상북도교육청 상주도서관화령분관" />
							<form:option value="00147032" label="경상북도교육청 영주선비도서관" />
							<form:option value="00147024" label="경상북도교육청 영주선비도서관풍기분관" />
							<form:option value="00147105" label="경상북도교육청문화원" />
							<form:option value="00147013" label="경상북도교육청 영일도서관" />
							<form:option value="00147016" label="경상북도교육청 외동도서관" />
							<form:option value="00147014" label="경상북도교육청 금호도서관" />
							<form:option value="00147020" label="경상북도교육청 점촌도서관" />
							<form:option value="00147006" label="경상북도교육청 점촌도서관가은분관" />
							<form:option value="00147004" label="경상북도교육청 삼국유사군위도서관" />
							<form:option value="00147019" label="경상북도교육청 의성도서관" />
							<form:option value="00147022" label="경상북도교육청 청송도서관" />
							<form:option value="00147012" label="경상북도교육청 영양도서관" />
							<form:option value="00147031" label="경상북도교육청 영덕도서관" />
							<form:option value="00147021" label="경상북도교육청 청도도서관" />
							<form:option value="00147002" label="경상북도교육청 고령도서관" />
							<form:option value="00147009" label="경상북도교육청 성주도서관" />
							<form:option value="00147023" label="경상북도교육청 칠곡도서관" />
							<form:option value="00147015" label="경상북도교육청 예천도서관" />
							<form:option value="00147007" label="경상북도교육청 봉화도서관" />
							<form:option value="00147018" label="경상북도교육청 울진도서관" />
							<form:option value="00147017" label="경상북도교육청 울릉도서관" />
						</form:select>
						<c:if test="${elibLendCnt > 0}">
						<div class="ui-state-highlight">
							* 대출, 예약중인 전자 콘텐츠가 있는 경우 소속도서관을 변경할 수 없습니다.
						</div>
						</c:if>
					</td>
				</tr>
				<c:if test="${!fn:contains(member.user_id, '*')}">
				<tr>
					<th>
						대출증 비밀번호 설정(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="card_password" maxlength="4" class="text" /> *대출증 비밀번호 4자리를 입력하세요.
					</td>
				</tr>
				</c:if>
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
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;" >
							<option value="" >--직접입력--</option>
							<c:forEach items="${email}" var="i" varStatus="status">
							<option value="${i.code_name}" <c:if test="${i.code_name eq member.email2 }">selected="selected"</c:if> >${i.code_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">저장</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
		<%-- <a href="/${homepage.context_path}/intro/join/secessionForm.do?menu_idx=${param.menu_idx}" id="cancel-btn" class="btn btn1">회원탈퇴</a> --%>
	</div>
	<br/>
</div>
