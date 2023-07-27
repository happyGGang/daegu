<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">

$(function() {

	$('input#member_id_tmp').val('');
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

		$('form#member').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
 		$('form#member').submit();
	});

	$('input#member_id_tmp, input#member_pw_tmp').on('keyup', function(e) {
		if (e.keyCode == 13) {
			$('button#save-btn').click();
		}
	});
});
</script>


<!-- contents-title-->
<div id="contents-title">
	<h2>로그인 후 서비스를 이용해주세요</h2>
</div>
<!-- /contents-title-->

<div class="login-box">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">통합도서관 로그인</dt>
				<div class="loginBox1">
					<dd class="login">
						<fieldset>
							<legend class="blind">로그인</legend>

							<form:form modelAttribute="member" action="/intro/${context_path}/login/loginProc.do" onsubmit="return false;">
							<form:hidden path="before_url" htmlEscape="true"/>
							<form:hidden path="member_id"/>
							<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
							<form:password path="member_pw" cssStyle="display:none;"/>

							<div class="form-box">
								<p class="idtype" >
								<label for="member_id_tmp">아이디</label>
								<input type="text" id="member_id_tmp" class="txt" placeholder="아이디" maxlength="20" />
								</p>

								<p id="pwp" class="idtype" >
								<label for="member_pw_tmp">비밀번호</label>
								<input type="password" id="member_pw_tmp" maxlength="20" class="txt" value="" placeholder="비밀번호를 입력해주세요" />
								</p>
							</div>
							<button id="save-btn">
								<span>로그인</span>
							</button>

							</form:form>

						</fieldset>
					</dd>

					<!-- 아이디/비밀번호찾기 [START] -->
					<div class="idpwSection" style="text-align:center;">
						<a href="/intro/${context_path}/join/findIdForm.do" class="btn btn01">아이디찾기</a>
						<a href="/intro/${context_path}/join/findPwForm.do" class="btn btn02">비밀번호찾기</a>
					</div>
					<!-- 아이디/비밀번호찾기 [ END ] -->

				</div>
			</dl>
		</div>
	</div>
	<div class="login-body2">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">통합도서관 로그인</dt>
				<div class="loginBox1" style="border-left: 1px solid #eeee;">
				<div class="tit"><i class="fa fa-chevron-circle-right"></i> RFID회원증 로그인</div>
					<a href="/intro/${homepage.context_path}/rfLogin/index.do">
						<img style="margin:15px 0 0 0; width: 130px;" src="/resources/common/img/kiosk/bc_sample.png" alt="카드 리더기">
					</a>
				</div>
			</dl>
		</div>
	</div>
</div>

