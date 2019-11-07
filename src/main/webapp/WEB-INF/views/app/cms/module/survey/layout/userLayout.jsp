<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
<title>설문조사 목록</title>
<link href="/resources/cms/survey/css/common.css" rel="stylesheet" type="text/css" title="style" />
<%-- <link href="/survey/resources/css/default.css" rel="stylesheet" type="text/css"> --%>
<script type="text/javascript" src="/resources/cms/survey/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/resources/cms/survey/js/jquery.selectbox-0.2.js"></script>
<script type="text/javascript" src="/resources/cms/survey/js/common.js"></script>
</head>
<body class="survey">
	<div id="wrap">
		<div id="contArea" class="wid800">
			<tiles:insertAttribute name="body" />
		</div>
<!-- 		<div id="footer">COPYRIGHT ⓒ Whalesoft. All RIGHTS RESERVED.</div> -->
	</div>
</body>
</html>