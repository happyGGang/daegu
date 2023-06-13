<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(function() {

	$('input#member_pw_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#member_id_tmp').val() == '') {
			$('input#member_id_tmp').focus();
			alert('아이디를 입력해주세요.');
			return false;
		}

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#supportMember').attr('onsubmit', '');
// 		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
// 		$('input#member_password').val(encrypt($('input#member_pw_tmp').val()));
		$('input#member_id').val($('input#member_id_tmp').val().trim());
		$('input#member_password').val($('input#member_pw_tmp').val());
 		$('form#supportMember').submit();
	});

});
</script>

<div class="login-box">
	<div class="login-head">
		<p><b>학교도서관 회원인증</b></p>
	</div>
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">학교도서관 회원인증</dt>
				<div class="loginBox1">
				<dd class="login">
					<div class="loginImgBox">
						<img src="/resources/common/img/mem_loginimg.png" alt="" class="loginImg">
					</div>
					<fieldset>
						<legend class="blind">로그인</legend>
						<form:form modelAttribute="supportMember" action="loginProc.do" onsubmit="return false;">
							<form:hidden path="member_password" cssStyle="display:none;" />
							<form:hidden path="member_id"/>
							<form:hidden path="before_url"/>
							<div class="form-box">
								<label class="blind" for="member_id_tmp">아이디</label>
								<input id="member_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="20" /></p>
								<label for="member_pw_tmp" class="blind" >비밀번호</label>
								<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20"/></p>
							</div>
							<button id="save-btn">
								<i class="fa fa-unlock-alt"></i>
								<span>로그인</span>
							</button>
						</form:form>
					</fieldset>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>

