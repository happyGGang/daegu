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
<title>대구광역시 도서관 통합 허브시스템</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=1"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/common/default.css"  />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/default.css"  />

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/board/js/common.js"></script>
<script type="text/javascript" src="/resources/book/intro/js/common.js"></script>
</head>
<!-- <body oncontextmenu='return false'> -->
<body>
<div id="wrap">