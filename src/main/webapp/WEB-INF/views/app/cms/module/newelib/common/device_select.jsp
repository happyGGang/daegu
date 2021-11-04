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
	$('select#device${sym}').select2();
});
</script>
<form:select class="selectmenu-search" style="width:200px" id="device${sym}" path="device">
	<option value="">지원 기기 선택</option>
	<option value="1" <c:if test="${obj.device == 1}">selected="selected"</c:if>>PC</option>
	<option value="2" <c:if test="${obj.device == 2}">selected="selected"</c:if>>PC, 태블릿</option>
	<option value="3" <c:if test="${obj.device == 3}">selected="selected"</c:if>>PC, 태블릿, 스마트폰</option>
</form:select>
