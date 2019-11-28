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

	$('#save-btn').on('click', function(e) {
		e.preventDefault();
// 		if (!pwCheck) {
// 			alert('비밀번호를 입력해주세요.');
// 			$('input#member_pw').focus();
// 			return false;
// 		}
		if ($('input#card_password').val() && $('input#card_password').val() != '') {
			if ($('input#card_password').val().length != 4) {
				alert('대출증 비밀번호 설정은 숫자 4자리로 입력해주세요.');
				return false;
			}
		}
		$('#email').val($('#email1').val() + '@' + $('#email2').val());
		$('#cell_phone').val($('#cell_phone1').val() + $('#cell_phone2').val() + $('#cell_phone3').val());
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
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if ( $('#member_pw_confirm').val().length > 0 ) {
			if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
				pwCheck = true;
				$('#pw_confirm_message').text('일치합니다.');
			} else {
				pwCheck = false;
				$('#pw_confirm_message').text('');
			}
		} else {
			pwCheck = false;
			$('#pw_confirm_message').text('');
		}
	});
	$('a#createWebId').on('click', function(e) {
		e.preventDefault();
		$(this).hide();
		$('div#newIdDiv').show();
		$('input#web_id').focus();
	});
	$('a#createWebId2').on('click', function(e) {
		e.preventDefault();
		location.href = 'step2.do?menu_idx=${param.menu_idx}&editMode=MODIFY2';
	});
	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('form#memberInfoForm input#web_id').val();
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			alert('아이디는 영문, 숫자조합만 입력가능합니다.');
			$('#memberInfoForm #web_id').focus();
			return false;
		}
		$('#checkForm #newMemberId').val($('#memberInfoForm #web_id').val());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
		}
	});

	$('a#integration').on('click', function(e) {
		e.preventDefault();
		location.href = 'https://www.gbelib.kr/${homepage.context_path}/intro/join/integration.do?menu_idx=${param.menu_idx}';
	});

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
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

	$('a#changeNamePopup').on('click', function(e) {
		$('div#cert_layer').hide();
		$('div#popup_layer').show();
		e.preventDefault();
	});

	$('a#closePopup').on('click', function(e) {
		$('div#popup_layer').hide();
		e.preventDefault();
	});

	$('a#closePopup2').on('click', function(e) {
		$('div#cert_layer').hide();
		e.preventDefault();
	});

	$('a#changeName').on('click', function(e) {
		e.preventDefault();
		$('div#popup_layer').hide();
		$('div#cert_layer').show();
	});

	$('a.changeNameCert').on('click', function(e) {
		e.preventDefault();
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val($(this).attr('certType'));
		$('form#certForm')[0].submit();
		certWindow.focus();
	});

});
$(document).on("keydown", "input:text[numberOnly]", function(e) {
	var keyCode = e.keyCode;
// 	console.log(keyCode);
// 	console.log($(this).val().length);
});
$(document).on("keyup change", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
function dlsSuccess() {
	alert('DLS 인증이 완료되었습니다. 재 로그인하여 정회원으로 이용가능합니다.');
	location.href = '/${homepage.context_path}/intro/login/logout.do?relogin=true';
}
function dlsFail() {
	alert('DLS 인증에 실패하였습니다. 다시 시도하시기 바랍니다.');
}
</script>


<form id="dlsCheckForm" method="post" target="dlsWindow" action="https://reading.gyo6.net/r/reading/search/ebookView_kb_ck.jsp">
<input type="hidden" name="reading_pw" id="reading_pw" >
<input type="hidden" name="reading_id" id="reading_id" >
<input type="hidden" name="return_url" value="https://www.gbelib.kr/geic/intro/join/checkDls.do">
</form>
<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
	<input type="hidden" name="certType">
	<input type="hidden" name="mode" value="changeName">
	<input type="hidden" name="menu_idx" value="${param.menu_idx}">
	<input type="hidden" name="contextPath" value="${homepage.context_path}">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
	<form:hidden path="member_id" id="newMemberId"/>
</form:form>


<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<div style="padding:10px;box-sizing:border-box">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>


<div class="join-wrap" style="padding: 0;">
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="https://www.gbelib.kr/${homepage.context_path}/intro/join/save.do" onsubmit="return false;">
		<form:hidden path="editMode" value="MODIFY"/>
		<form:hidden path="member_id"/>
		<form:hidden path="user_id"/>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						아이디
					</th>
					<td>
						${member.web_id}
					</td>
				</tr>
				<tr style="display: none;">
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text" title="비밀번호 입력" />
						<span id="pwdcheck"> *기존 비밀번호를 입력해주세요. 정보수정을 위한 확인용입니다.</span>
					</td>
				</tr>
				<tr style="display: none;">
					<th>
						비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text" title="비밀번호 입력 확인"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						성명
					</th>
					<td>
						${memberInfo.member_name}
						<a href="#" id="changeName" class="btn" title="성명 변경">성명변경</a>
						<a href="#" id="changeNamePopup" class="help" title="성명변경 도움말"><i class="fa fa-question-circle"></i></a>
					</td>
				</tr>
				<tr>
					<th>
						성별
					</th>
					<td>
						<c:choose>
							<c:when test="${memberInfo.sex eq '0001'}">남자</c:when>
							<c:otherwise>여자</c:otherwise>
						</c:choose>
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
						휴대폰 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<span id="cell_phone_span"></span>
						<div id="cell_phone_div">
					 	<form:hidden path="cell_phone"/>
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true" title="휴대전화 번호 앞 자리 입력 " />
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="휴대전화 번호 중간 자리 입력 " />
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="휴대전화 번호 마지막 자리 입력 " />
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
								<form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;" title="우편번호" /> <a href="#" id="findPostCode" class="btn" title="새창열림">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:90%;" title="주소 입력" /> <br/>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						소속도서관
					</th>
					<td>
						<form:select path="loca" cssClass="selectmenu-search" style="width:250px" disabled="${elibLendCnt > 0}" title="소속도서관 선택">
						<%-- <form:select path="loca" cssClass="selectmenu-search" style="width:250px" disabled="${elibLendCnt > 0}" title="소속도서관 선택"> --%>
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
						<form:hidden path="loca"/>
						<div class="ui-state-highlight">
							* 대출, 예약중인 전자 콘텐츠가 있는 경우 소속도서관을 변경할 수 없습니다.
						</div>
						</c:if>
					</td>
				</tr>
				<c:if test="${member.auth_id eq '20000'}">
				<tr>
					<th>
						대출증 비밀번호 설정
					</th>
					<td>
						<form:password path="card_password" maxlength="4" class="text" title="카드비밀번호 입력" /> *숫자 4자리만 가능하며 입력된 경우에만 변경됩니다.
					</td>
				</tr>
				</c:if>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
						<form:hidden path="phone"/>
						<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true" title="전화번호 지역번호 입력" />
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="전화번호 중간지라 입력" />
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true" title="전화번호 마지막 자리 입력" />
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text" title="이메일 아이디 입력" /> @
						<form:input path="email2" class="text" title="이메일 주소 입력" />
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;" title="이메일 주소 @이하 입력">
							<option value="" title="직접입력">--직접입력--</option>
							<c:forEach items="${email}" var="i" varStatus="status">
							<option value="${i.code_name}" title="${i.code_name}">${i.code_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<c:if test="${member.unAgreeFlag ne '0001'}">
				<tr>
					<th>
						통합회원전환
					</th>
					<td>
						<a href="#" id="integration" class="btn" title="통합회원 전환">통합회원 전환</a>
					</td>
				</tr>
				</c:if>
				<c:if test="${member.auth_id eq '30000'}">
				<tr>
					<th>
						※선택사항: DLS회원인증
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							DLS 아이디 : <input type="text" id="dlsId" class="text" title="DLS 아이디 입력" >
							DLS 패스워드 : <input type="password" id="dlsPw" class="text" title="DLS 패스워드 입력" >
							<a href="#" id="dlsCheck" class="btn" title="확인" >확인</a>
						</div>
						<div class="ui-state-highlight">
							* 수정일 기준, 학교도서관지원시스템(DLS) 회원일 경우에만 인증을 통해 정회원으로 등록하시기 바랍니다.
						</div>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1" title="저장">저장</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소" >취소</a>
		<%-- <a href="/${homepage.context_path}/intro/join/secessionForm.do?menu_idx=${param.menu_idx}" id="cancel-btn" class="btn btn1">회원탈퇴</a> --%>
	</div>
	<br/>
</div>

<div class="planView">
	<div class="inbox" id="popup_layer" style="display: none;">
		<div class="calAll" >
			<dl style="text-align: center;">
				<dt>이름변경 방법 안내</dt>
			</dl>
			<ol>
				<li>개명한 경우 본인인증을 통하여 이름 변경이 가능합니다.</li>
				<li>이 경우 실명확인 등록기관에 개명한 이름으로 등록되어 있어야 합니다.</li>
				<li>본인인증 완료 후에는 개명한 이름으로 회원정보가 자동으로 수정됩니다.</li>
			</ol>
			<br/>
			<div style="text-align: center;">
				<ul>
					<li><a href="https://www.namecheck.co.kr/front/personal/register_howtoonline.jsp?menu_num=1&page_num=0&page_num_1=1" target="_blank" title="새창열림" >[실명확인 등록기관 바로가기]</a></li>
					<li><a href="https://www.namecheck.co.kr/front/board/faqRead.nc?seq=40&type=P" target="_blank" title="새창열림">[실명확인 등록기관 QNA 바로가기]</a></li>
				</ul>
			</div>
		</div>
		<a href="#" id="closePopup" class="close" title="닫기"><i class="fa fa-close"></i></a>
	</div>
</div>

<div id="certTypeDiv">
	<div class="inbox" id="cert_layer" style="display: none;">
		<div class="calAll" >
			<dl style="text-align: center;">
				<dt>본인인증방법 선택</dt>
			</dl>
			<a href="#" id="phonebtn" class="btn changeNameCert" certType="sms" title="휴대폰인증">휴대폰인증</a>
			<a href="#" id="ipinbtn" class="btn changeNameCert" certType="gpin" title="공공I-PIN인증">공공I-PIN인증</a>
		</div>
		<a href="#" id="closePopup2" class="close" title="닫기"><i class="fa fa-close"></i></a>
	</div>
</div>


<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
