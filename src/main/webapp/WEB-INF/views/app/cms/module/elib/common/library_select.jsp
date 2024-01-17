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
	<option value="0">도서관 선택</option>
	<option value="10000009">대구전자도서관</option>
</form:select>

