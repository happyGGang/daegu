<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if (!pwCheck) {
			alert('비밀번호를 입력해주세요.');
			$('input#member_pw').focus();
			return false;
		}
		if ($('input#card_password').val() != '') {
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
				$('#pw_confirm_message').text('');
			}
		} else {
			pwCheck = false;
			$('#pw_confirm_message').text('');
		}
	});
	$('a#createWebId').on('click', function(e) {
		e.preventDefault();
// 		$(this).hide();
// 		$('div#newIdDiv').show();
// 		$('input#web_id').focus();
		location.href = 'createIdForm.do';
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

});
</script>
<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="certType">
</form>
<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
	<form:hidden path="member_id" id="newMemberId"/>
</form:form>
<div class="join-wrap" style="padding: 0;">
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="https://www.gbelib.kr/${homepage.context_path}/intro/join/save.do" onsubmit="return false;">
		<form:hidden path="editMode" value="MODIFY"/>
		<form:hidden path="member_id"/>
		<form:hidden path="user_id"/>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						<c:choose>
							<c:when test="${member.web_id eq ''}">아이디 생성</c:when>
							<c:otherwise>아이디</c:otherwise>
						</c:choose>
					</th>
					<td>
						<c:choose>
							<c:when test="${member.web_id eq ''}">
						<a href="#" id="createWebId" class="btn">아이디생성</a>
							</c:when>
							<c:otherwise>
						${member.web_id}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<span id="pwdcheck"> *기존 비밀번호를 입력해주세요. 정보수정을 위한 확인용입니다.</span>
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
						성명
					</th>
					<td>
						${memberInfo.member_name}
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
					 	<form:select path="cell_phone1" items="${phoneCode}" itemLabel="code_name" itemValue="code_id" cssClass="selectmenu" cssStyle="width: 65px;"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4"/>
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
						소속도서관
					</th>
					<td>
						<form:select path="loca" cssClass="selectmenu" >
							<c:forEach items="${libList.data}" var="i">
								<c:choose>
									<c:when test="${member.loca eq i.lib_manage_code}">
										<form:option label="${i.lib_name}" value="${i.lib_manage_code}" selected="selected"/>
									</c:when>
									<c:otherwise>
										<form:option label="${i.lib_name}" value="${i.lib_manage_code}" />
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<th>
						대출증 비밀번호 설정
					</th>
					<td>
						<form:password path="card_password" maxlength="4" class="text" /> *숫자 4자리만 가능하며 입력된 경우에만 변경됩니다.
					</td>
				</tr>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
						<form:hidden path="phone"/>
						<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4"/>
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
							<c:forEach items="${email}" var="i" varStatus="status">
							<option value="${i.code_name}" >${i.code_name}</option>
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
	</div>
	<br/>
</div>
