<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>CMS 관리자 로그인</title>
	<link rel="stylesheet" href="/resources/cms/css/login.css">
	<link rel="stylesheet" href="/resources/common/css/fontawesome.min.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<script>
	function showLoader() {
		const btn = document.querySelector('.custom-login-btn');
		btn.querySelector('.btn-text').style.display = 'none';
		btn.querySelector('.loader').style.display = 'inline-block';
		return true;
	}

	document.addEventListener('DOMContentLoaded', function () {
		const form = document.querySelector('form');
		const inputs = form.querySelectorAll('input');

		inputs.forEach(input => {
			input.addEventListener('keydown', function (e) {
				if (e.key === 'Enter') {
					e.preventDefault();
					form.submit();
				}
			});
		});
	});
</script>

<body>
<div class="login-box">
	<img src="/resources/cms/img/logo.png" alt="로고" class="logo"/>
	<h2>도서관 통합 허브시스템</h2>

	<form:form modelAttribute="login" action="login.do" method="post" onsubmit="return showLoader()" autocomplete="off">
		<div class="input-group">
			<i class="fa fa-user"></i>
			<form:input path="member_id" maxlength="25" placeholder="아이디" autocomplete="off"/>
		</div>
		<div class="input-group">
			<i class="fa fa-lock"></i>
			<form:password path="member_pw" maxlength="25" placeholder="비밀번호" autocomplete="off"/>
		</div>
		<button type="submit" class="custom-login-btn">
			<span class="btn-text">로그인</span>
			<span class="loader"></span>
		</button>
	</form:form>

	<div class="copyright">
		COPYRIGHT(C) 2025 SJS.
	</div>
</div>

<script>
	function showLoader() {
		const btn = document.querySelector('.custom-login-btn');
		btn.querySelector('.btn-text').style.display = 'none';
		btn.querySelector('.loader').style.display = 'inline-block';
		return true;
	}
</script>
</body>
</html>
