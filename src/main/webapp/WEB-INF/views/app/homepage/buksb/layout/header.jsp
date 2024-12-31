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

<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/default_new_fullpage.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/commons/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/board/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/book/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/common_toppopzone.css"/>
<link href="/resources/homepage/center/css/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main.css"/>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main0.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main1.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main2.css"/>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/font-style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/sub_design_new.css"/>

<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/default-new-fullpage.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/common.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/common_toppopzone.js"></script>

<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/kakao.min.js"></script>

</head>
<body>
<a href="#container" class="skip-to">본문 바로가기</a>
<a href="#navi" class="skip-to">메뉴 바로가기</a>