<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>경상북도교육청 안동도서관 새 책 드림 서비스</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<c:if test="${board.module eq 'bookDream'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/layout.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/content.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
</c:if>
<c:if test="${board.module ne 'bookDream'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/default.css"/>
</c:if>
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<!-- <script type="text/javascript" src="/resources/common/js/default.js"></script> -->
<!-- <script type="text/javascript" src="/resources/homepage/bookdream/js/common.js"></script> -->
</head>
<body>