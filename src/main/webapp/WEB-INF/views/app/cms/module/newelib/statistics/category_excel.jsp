<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%
	response.setContentType("application/vnd.ms-excel");

	String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
	String filename = "전자도서관_카테고리별통계_" + today + ".xls";

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
%> 
<jsp:include page="/WEB-INF/views/app/cms/module/elib/statistics/category_included.jsp" flush="false"/>
	