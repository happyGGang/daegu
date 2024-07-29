<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<tiles:insertAttribute name="header" />
<style>
iframe {margin:0;padding:0;width:100%;height:1760px;border:0;display:block;}
</style>
<iframe src="https://lib.daegu.go.kr/kioskY/gukbo/facility" ></iframe>
<jsp:include page="/WEB-INF/views/app/homepage/gukbo/kiosk/menuNavigation.jsp" flush="false" />
<tiles:insertAttribute name="footer" />
