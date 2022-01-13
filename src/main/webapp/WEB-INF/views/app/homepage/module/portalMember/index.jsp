<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(function() {

	$('input#agency_pw_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#agency_id_tmp').val() == '') {
			$('input#agency_id_tmp').focus();
			alert('아이디를 입력해주세요.');
			return false;
		}

		if($('input#agency_pw_tmp').val() == '') {
			$('input#agency_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#portalMember').attr('onsubmit', '');
		$('input#agency_id').val($('input#agency_id_tmp').val().trim());
		$('input#agency_password').val($('input#agency_pw_tmp').val());
 		$('form#portalMember').submit();
	});

});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="login-box">
	<div class="login-head">
		<p><b>대표도서관 회원인증</b></p>
	</div>
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">대표도서관 회원인증</dt>
				<div class="loginBox1">
				<dd class="login">
					<div class="loginImgBox">
						<img src="/resources/common/img/mem_loginimg.png" alt="" class="loginImg">
					</div>
					<fieldset>
						<legend class="blind">로그인</legend>
						<form:form modelAttribute="portalMember" action="loginProc.do" onsubmit="return false;">
							<form:hidden path="agency_password" cssStyle="display:none;" />
							<form:hidden path="agency_id"/>
							<form:hidden path="before_url"/>
							<div class="form-box">
								<label class="blind" for="agency_id_tmp">아이디</label>
								<input id="agency_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="20" /></p>
								<label for="agency_pw_tmp" class="blind" >비밀번호</label>
								<input type="password" id="agency_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20"/></p>
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

