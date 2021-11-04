<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String sym = request.getParameter("sym") == null ? "" : request.getParameter("sym");
	pageContext.setAttribute("sym", sym);
%>
<form:select class="selectmenu-search" style="width:200px" id="cate1${sym}" path="parent_id">
	<option value="0">1차 카테고리 선택</option>
	<c:forEach var="i" varStatus="status" items="${cateList}">
		<option value="${i.cate_id}" <c:if test="${i.cate_id eq obj.parent_id}">selected="selected"</c:if>>${i.cate_name}</option>
	</c:forEach>
</form:select>
<script>
$(document).ready(function(e) {
	$('select#cate1${sym}').select2();
});
</script>