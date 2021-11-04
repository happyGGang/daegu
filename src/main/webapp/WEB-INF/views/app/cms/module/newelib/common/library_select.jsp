<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String sym = request.getParameter("sym") == null ? "" : request.getParameter("sym");
	pageContext.setAttribute("sym", sym);
%>
<script>
$(document).ready(function(e) {
	$('select#library_code${sym}').select2();
});
</script>
<form:select class="selectmenu-search" style="width:200px" id="library_code${sym}" path="library_code">
	<option value="">도서관 선택</option>
	<c:forEach var="i" varStatus="status" items="${homepageList}">
		<option value="${i.lib_code}" <c:if test="${i.lib_code eq obj.library_code }">selected="selected"</c:if>>${i.homepage_name}</option>
	</c:forEach>
</form:select>
