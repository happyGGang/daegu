<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	<%--회원정보 수정--%>
	$('a#save-btn').on('click', function(e) {
		e.preventDefault();

		if (!pwCheck2) {
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			$('#member_pw_tmp').focus();
			return false;
		}
		if (!pwCheck) {
			alert('비밀번호 확인 후 가능 합니다.');
			$('input#member_pw_confirm').focus();
			return false;
		}

		$('input#memberNewPw').val(encrypt($('input#member_pw_tmp').val()));

		doAjaxPost($('#memberInfoForm'));
	});

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw_tmp').val() == $('#member_pw_confirm').val() ) {
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
	$('input#member_pw_tmp').on('keyup', function(e) {
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


});
</script>

<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 신규 비밀번호를 입력해주세요.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="seccession">
	</div>
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="changeMemberPw.do">
		<form:password path="memberNewPw" cssStyle="display:none;"/>
		<table id="memberForm">
			<colgroup>
				<col width="20%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>
						신규 비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<input type="password" id="member_pw_tmp" maxlength="20" class="text" value="" placeholder="비밀번호를 입력해주세요" />
						<span id="pwdcheck">영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
					</td>
				</tr>
				<tr>
					<th>
						신규 비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">비밀번호 변경</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
