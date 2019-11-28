<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
// 		doAjaxPost($('#member'));
	});

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').blur(function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;
					$('#pw_confirm_message').text('일치합니다.');
				}
				else {
					pwCheck = false;
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
		pwdcheck = false;
		var pw = $(this).val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[^\da-zA-Z]/gi);
		if(pw.length < 6 || pw.length > 20){
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
			return false;
		}
		$('span#pwdcheck').css('color', 'black');
		pwCheck2 = true;
		return true;
	});
});
</script>

<div class="join-wrap">


	<form:form id="memberJoinForm" modelAttribute="member" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode" value="pwChange"/>

		<table>
			<tbody>
				<tr>
					<th>
						아이디
					</th>
					<td>
						${sessionScope.member.member_id}
					</td>
				</tr>
				<tr>
					<th>
						비밀번호
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<span id="pwdcheck">비밀번호는 영문, 숫자, 특수문자 조합으로 6자이상 20자이내로 입력하셔야 합니다.</span>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호 확인
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="btn-wrap">
			<a href="#" id="save-btn" class="btn btn1">비밀번호 변경</a>
			<a href="/intro/index.do" id="cancel-btn" class="btn">취소</a>
		</div>

	</form:form>
	<br/>
</div>
