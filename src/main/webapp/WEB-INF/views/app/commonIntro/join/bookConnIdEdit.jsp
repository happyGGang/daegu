<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<div class="join-wrap" style="padding: 0">

	<form:form id="checkForm" modelAttribute="member" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
	</form:form>

	<form:form id="memberJoinForm" modelAttribute="member" action="webIdSave.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="user_id"/>

		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>

		<div style="border-top:2px solid #ccc">
		<table id="memberForm">
			<caption>회원가입 정보입력. 아이디,비밀번호를 입력</caption>
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
			</tbody>
		</table>
		</div>

		<div class="btn-wrap">
			<c:if test="${member.editMode eq 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1" title="계정등록">계정등록</a>
			</c:if>
<%-- 			<c:if test="${member.editMode ne 'ADD' }"> --%>
<!-- 			<a href="#" id="save-btn" class="btn btn1"title="수정완료">수정완료</a> -->
<%-- 			</c:if> --%>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소">취소</a>
		</div>
	</form:form>
	<br/>
</div>