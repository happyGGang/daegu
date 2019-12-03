<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
var pwCheck = false;
var pwCheck2 = false;
$(function() {

	<%--회원정보 수정--%>
	$('button#pw-change-btn').on('click', function(e) {
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

		doAjaxPost($('#memberInfo'));
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

<!-- 비밀번호 찾기 전용 [START] -->
<div id="contents-title">
	<h2>
		본인 확인이 완료되었습니다.
		</br>
		<span style="font-weight:300; color:#fab000">비밀번호를 변경해 주십시요.</span>
	</h2>
</div>

<div class="login-box">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">회원 비밀번호 변경</dt>
				<div class="loginBox1">
					<dd class="login">
						<fieldset>
							<legend class="blind">비밀번호 변경</legend>

							<form:form modelAttribute="memberInfo" action="changeMemberPw.do" method="post" onsubmit="return false;">
							<form:password path="memberNewPw" cssStyle="display:none;"/>

							<div class="form-box">
								<p id="pwp" class="idtype" >
								<label for="member_pw_tmp">비밀번호</label>
								<input type="password" id="member_pw_tmp" maxlength="20" class="txt" value="" placeholder="비밀번호를 입력해주세요" />
								<div class="ui-state-highlight">
									<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
								</div>

								</p>
								<p id="pwp" class="idtype" >
								<label for="member_pw_confirm">비밀번호확인</label>
								<input type="password"  id="member_pw_confirm" class="txt" maxlength="20" value="" placeholder="새비밀번호 확인을 입력해 주십시요." >
								<b id="pw_confirm_message"></b>
								</p>
							</div>

							<button id="pw-change-btn">
								<span>변경</span>
							</button>

							</form:form>

						</fieldset>

						<div class="highlight">
						<span id="">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>
					</dd>
				</div>
			</dl>
		</div>
	</div>
</div>
<!-- 비밀번호 찾기 전용 [ END ] -->