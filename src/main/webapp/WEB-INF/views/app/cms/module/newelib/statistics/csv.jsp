<%@ page language="java" contentType="application/csv; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils" %>
<%@ page import="kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%@ page import="kr.co.whalesoft.framework.utils.HangulEnDecoder" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	response.setContentType("application/csv");

	String csv_string = request.getParameter("csv_string") == null ? "" : request.getParameter("csv_string");
	String filename = request.getParameter("filename") == null ? "export.csv" : request.getParameter("filename");

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
	HangulEnDecoder.encodeDataOutput(csv_string, "UTF-8", "CP949", response);
%>