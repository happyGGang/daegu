<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<meta property="og:type" content="website"/>
<meta property="og:title" content="${homepage.homepage_name}"/>
<meta property="og:description" content="${homepage.homepage_name}"/>
<meta property="og:url" content="${homepage.domain}/${homepage.context_path}/index.do"/>
<link rel="canonical" href="${homepage.domain}/${homepage.context_path}/index.do">
<title>${homepage.homepage_name}<c:if test="${not empty menuOne.menu_name}"> > </c:if>${menuOne.menu_full_path_name }</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default_new_fullpage_gukbo.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/common_toppopzone.css"/>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main.css"/>
<!--link rel="stylesheet" type="text/css" href="/resources/common/css/sub_contents.css"-->
<link rel="stylesheet" type="text/css" href="/resources/common/css/sub_design_new.css"/>
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/jungang/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default-new-fullpage.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/common/js/common_toppopzone.js"></script>

<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common.js"></script>
<script type="text/javascript" src="/resources/common/js/kakao.min.js"></script>
<!--
<script>

$(document).ready(function(){

	$(document).bind("contextmenu", function(e) {
		return false;
	});

});

$(document)[0].oncontextmenu = function() { return false; }

$(document).mousedown(function(e) {

	if( e.button == 2 ) 
	{
		alert('우측 마우스를 사용할 수 없습니다.');
		return false;
	} else {
		return true;
	}

});

</script>
-->
</head>
<!-- <body oncontextmenu='return false'> -->
<body>
<a href="#container" class="skip-to">본문 바로가기</a>
<a href="#navi" class="skip-to">메뉴 바로가기</a>