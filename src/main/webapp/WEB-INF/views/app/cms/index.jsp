<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>통합도서관</title>
</head>
<frameset cols="270,*" frameborder="0">

	<c:choose>
	<c:when test="${member.admin}">
	<frame src="aside.do" name="aside"></frame>
    <frame src="homepage/index.do" name="container"></frame>
	</c:when>
	
	
	<c:otherwise>
	<frame src="aside.do" name="aside"></frame>
    <frame src="ready.do" name="container"></frame>
	</c:otherwise>
	
	
	</c:choose>

    
</frameset>
<body>
<noframes>이 브라우저는 frame을 지원하지 않습니다.</noframes>
</body>
</html> 