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
	$('select#com_code${sym}').select2();
});

function updateProviders() {
	$.get('/cms/module/elib/code/get_providers.do&type=${obj.type}', function(data) {
		var com_code = $('select#com_code${sym}').empty();
		$(data.data).sort(function(a, b) {
			return parseInt(a.comp_idx) > parseInt(b.comp_idx);
		}).each(function(i) {
			var attrs = { value: this.code_id, text: this.code_name };
			
			if('${obj.com_code}' == this.com_code) {
				attrs.selected = 'selected';
			}
			
			com_code.append($('<option>', attrs));
		});
		
		$('select#com_code${sym}').trigger('change');
	});
}
</script>
<form:select class="selectmenu-search" style="width:200px" id="com_code${sym}" path="com_code">
	<option value="">공급사 선택</option>
	<c:forEach var="i" varStatus="status" items="${compList}">
		<option value="${i.com_code}" <c:if test="${i.com_code eq obj.com_code }">selected="selected"</c:if>>${i.comp_name}</option>
	</c:forEach>
</form:select>
