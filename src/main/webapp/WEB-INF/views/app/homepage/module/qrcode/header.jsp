<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>대구광역시 통합 도서관</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/homepage.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/aaa/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/aaa/css/content.css"/>
<link rel="stylesheet" type="text/css" href="/resources/module/qrcode/css/style.css"/>

<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/dge/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/common/js/gnb.js"></script>
<script type="text/javascript" src="/resources/board/js/common.js"></script>

<!-- <script type="text/javascript" src="/resources/homepage/dge/js/common.css"></script> -->
</head>

<!--[if lte IE 7]><body class="lte7"><![endif]-->
<!--[if IE 8]><body class="ie8"><![endif]-->
<!--[if IE 9]><body class="ie9"><![endif]-->
<!--[if gte IE 10]><body class="gte10"><![endif]-->
<!--[if !IE]><body><![endif]-->

<a href="#container" class="skip-to">본문 바로가기</a>
<a href="#navi" class="skip-to">메뉴 바로가기</a>