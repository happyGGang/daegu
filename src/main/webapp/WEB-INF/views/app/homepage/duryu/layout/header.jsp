<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>${homepage.homepage_name}
        <c:if test="${not empty menuOne.menu_name}"> > </c:if>
        ${menuOne.menu_full_path_name }</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
    <link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/default.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>

    <link rel="stylesheet" type="text/css" href="/resources/common/css/sub_design.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/main.css"/>

    <!--[if lte IE 7]>
    <link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
    <![endif]-->
    <!--[if lte IE 8]>
    <link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/ie.css"/>
    <![endif]-->
    <script src="/resources/homepage/${homepage.context_path}/plugin/jquery-3.7.1.min.js"></script>

    <script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
    <script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
    <script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
    <script type="text/javascript" src="/resources/common/js/default.js"></script>
    <script type="text/javascript" src="/resources/common/js/common.js"></script>

    <script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common.js"></script>
    <script type="text/javascript" src="/resources/common/js/kakao.min.js"></script>

    <!-- 공통 -->
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/common.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/font.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/footer.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/header.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/total-popup.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/slick.css"/>
    <link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/slick-theme.css"/>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-face.css"/>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-family.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.js"></script>
    <script src="/resources/homepage/${homepage.context_path}/js/common/common.js"></script>
    <script src="/resources/homepage/${homepage.context_path}/js/common/fullpage.js?v=1.0.1"></script>
    <script src="/resources/homepage/${homepage.context_path}/plugin/slick.min.js"></script>
    <script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
</head>


