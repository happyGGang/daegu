<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="libraryCheck" action="index.do" method="GET">
<table>
	<tr>
		<th style="text-align: center;">장서점검기 ${libraryCheck.library_check_number}</th>
	</tr>
	<tr>
		<td style="padding: 30px 15px;">${libraryCheck.content}</td>
	</tr>
</table>
</form:form>