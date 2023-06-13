<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(function() {

	$('input#member_pw_tmp').val('');
	$('button#modify-btn').on('click', function(e) {
		e.preventDefault();
		
		if(!confirm('비밀번호를 변경하시겠습니까?')) {
			return false;
		}
		
		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}
		
		if($('input#member_pw_check').val() == '') {
			$('input#member_pw_check').focus();
			alert('비밀번호 확인을 입력해주세요.');
			return false;
		}

		$('form#supportMember').attr('onsubmit', '');
		$('input#member_id').val($('input#member_id_tmp').val().trim());
		$('input#member_password').val($('input#member_pw_tmp').val());
		$('input#password_check').val($('input#member_pw_check').val());
		doAjaxPost($('form#supportMember'));
	});

});
</script>

<div class="login-box">
	<div class="login-head">
		<p><b>학교도서관 회원 비밀번호 변경</b></p>
	</div>
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">학교도서관 회원 비밀번호 변경</dt>
				<div class="loginBox1">
				<dd class="login">
					<div class="loginImgBox">
						<img src="/resources/common/img/mem_loginimg.png" alt="" class="loginImg">
					</div>
					<fieldset>
						<legend class="blind">비밀변호변경</legend>
						<form:form modelAttribute="supportMember" action="passwordChange.do" onsubmit="return false;">
							<form:hidden path="member_id"/>
							<form:hidden path="member_password"/>
							<form:hidden path="password_check"/>
							<form:hidden path="before_url"/>
							<div class="form-box">
								<label for="member_id_tmp" class="blind">아이디</label>
								<input id="member_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="20" value="${loginSupport.member_id}" readonly="readonly"/></p>
								<label for="member_pw_tmp" class="blind" >비밀번호</label>
								<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20"/></p>
								<label for="member_pw_check" class="blind" >비밀번호 확인</label>
								<input type="password" id="member_pw_check" class="txt" placeholder="비밀번호 확인" title="비밀번호 확인" maxlength="">
							</div>
							<button id="modify-btn">
								<i class="fa fa-unlock-alt"></i>
								<span>수정</span>
							</button>
						</form:form>
					</fieldset>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>

