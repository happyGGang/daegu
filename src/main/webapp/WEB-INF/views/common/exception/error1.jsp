<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="utf-8"/>
<title>에러페이지</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="icon" type="image/x-icon" href="/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/aaa/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
</head>
<body>

<!-- 권한이 없습니다 -->
<div class="wrapper">
	<div class="dev-page-error-block">
		<i class="display fa fa-clock-o"></i>
		<h3>권한이 없습니다.</h3>
		<p class="txt">로그인 세션의 시간이 초과되어 로그아웃 되었습니다.<br/>
		5초 후 로그인 페이지로 이동합니다.</p>
		<p>
			<a href="#" class="lock-button"><i class="fa fa-lock"></i></a>
			<em>로그인 페이지 바로 이동</em>
		</p>
	</div>
</div>

</body>
</html>