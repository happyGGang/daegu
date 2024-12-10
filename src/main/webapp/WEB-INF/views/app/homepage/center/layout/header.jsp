<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>${homepage.homepage_name}<c:if test="${not empty menuOne.menu_name}"> > </c:if>${menuOne.menu_full_path_name }</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.23/fullpage.min.css" />
	<link href="/resources/homepage/center/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="/resources/homepage/center/css/swiper-bundle.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/fullpage.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/header.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/section1.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/section2.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/section3.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/section4.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/footer.css" />
	<link rel="stylesheet" href="/resources/homepage/center/css/sub.css" />
	<script src="/resources/homepage/center/plugin/jquery-3.7.1.min.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.23/fullpage.min.js"></script>
	<script src="/resources/homepage/center/plugin/swiper-bundle.min.js"></script>
	<script src="/resources/homepage/center/js/fullpage.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/header.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/section1.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/section2.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/section3.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/section4.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/footer.js" type="text/javascript"></script>
	<script src="/resources/homepage/center/js/sub.js" type="text/javascript"></script>
</head>
<body>
	<header class="header">
		<h1 aria-label="대구혁신도시 복합혁신센터도서관" onclick="location.href='/${homepage.context_path}/index.do'"></h1>
		<homepageTag:topMenu menuList="${menuTreeList}" />
		<ul class="authentication">
			<li>로그인</li>
			<li>통합회원인증</li>
			<li>회원가입</li>
			<li aria-label="메뉴 더보기"></li>
		</ul>
	</header>