<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String sym = request.getParameter("sym") == null ? "" : request.getParameter("sym");
	String noADO = request.getParameter("noADO") == null ? "" : request.getParameter("noADO");
	String JRN = request.getParameter("JRN") == null ? "" : request.getParameter("JRN");
	pageContext.setAttribute("sym", sym);
	pageContext.setAttribute("noADO", noADO);
	pageContext.setAttribute("JRN", JRN);
%>
<script>
$(document).ready(function(e) {
	$('select#type${sym}').select2();
});
</script>
<select class="selectmenu-search" style="width:200px" name="type" id="type${sym}">
	<c:if test="${noADO eq 'Y'}">
	<option value="">콘텐츠 선택</option>
	<option value="EBK" <c:if test="${obj.type == 'EBK'}">selected="selected"</c:if>>전자책</option>
	</c:if>
</select>
