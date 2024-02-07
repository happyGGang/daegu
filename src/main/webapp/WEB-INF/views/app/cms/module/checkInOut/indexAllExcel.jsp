<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%
	response.setContentType("application/vnd.ms-excel");

	String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
	String filename = "입출입시스템 통계_" + today + ".xls";

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
%> 
<h3>전체</h3>
<jsp:include page="/WEB-INF/views/app/cms/module/checkInOut/all_statistics.jsp" flush="false"/>
<br/>

<h3>순이용자수(중복제외)</h3>
<jsp:include page="/WEB-INF/views/app/cms/module/checkInOut/distinct_statistics.jsp" flush="false"/>
<br/>

<h3>신규이용자수</h3>
<jsp:include page="/WEB-INF/views/app/cms/module/checkInOut/bringIn_statistics.jsp" flush="false"/>
