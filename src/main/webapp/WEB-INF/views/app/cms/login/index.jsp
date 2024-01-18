<%@ page language="java" pageEncoding="utf-8" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>에스제이씨 로그인</title>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/fontawesome.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/brands.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/solid.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/all.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/login_new.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/font-style.css"/>
</head>
<script type="text/javascript" src="/resources/cms/js/all.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<body>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('input#member_id').focus();
	
	$('input#member_pw_tmp').val('');
});

$(function() {
	$('#save-btn').on('click', function(e) {
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

		$('form#login').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
 		$('form#login').submit();
	});
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

<h1 class="logo_wh" id="logo_wh"><img src="/resources/cms/img/logo_wh.png" alt="logo"></h1>
<div class="wrap">
	<div class="login-box">
		<div class="info">
			<div class="container">
				<h1 class="logo_wh"><img src="/resources/cms/img/logo_wh.png" alt="logo"></h1>
				<p>Smart Service ICT<br>
                Integrated Management System</p>
			</div>
		</div>
		<div class="form">
			<div class="container">
				<div class="title">
					<h1 class="user_txt">
						<b>사용자 로그인</b>
					</h1>
				</div>
				<fieldset>
					<form:form modelAttribute="login" action="login.do" method="post" onsubmit="return false;">
						<form:hidden path="member_pw" cssStyle="display:none;" />
						<form:hidden path="member_id"/>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa-solid fa-user"></i></span>
<%-- 								<form:input path="member_id_tmp"  maxlength="25" cssClass="form-control" placeholder="ID" value=""/> --%>
								<input type="text" id="member_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="25" placeholder="ID"/>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa-solid fa-lock"></i></span>
<%-- 								<form:password path="member_pw_tmp" maxlength="25" cssClass="form-control" placeholder="PASSWORD" value=""/> --%>
								<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20" placeholder="PASSWORD"/>
							</div>
						</div>
						<div id="save-btn" class="form-group button">
							<button>로그인</button>
						</div>
					</form:form>
				</fieldset>
			</div>
		</div>
	</div>
	
</div>
<div class="copyright">
<p>ⓒ 2023. SJC all rights reserved. v1.0</p>
	</div>
</body>
</html>




