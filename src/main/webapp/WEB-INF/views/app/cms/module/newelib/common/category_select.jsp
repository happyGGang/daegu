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
<form:select class="selectmenu-search" style="width:200px" id="cate2${sym}" path="cate_id">
	<option value="0">2차 카테고리 선택</option>
</form:select>
<script>
$(document).ready(function(e) {
	$('select#cate1${sym}').select2();
	$('select#cate2${sym}').select2();
	$('select#cate1${sym}').on('change', function(e) {
		updateSubcategory${sym}($(this).val());
	});
	updateSubcategory${sym}($('select#cate1${sym}').val());
});

function updateSubcategory${sym}(cate_id) {
	if(cate_id != null && cate_id != '' && cate_id != '0') {
		$.get('/cms/module/elib/category/EBK/getSubcategories.do?cate_id=' + cate_id, function(data) {
			var cate2 = $('select#cate2${sym}').empty();
			var selected = null;
			
			cate2.append($('<option>', { value: '0', text: '2차 카테고리 선택'}));
			$(data.data).each(function(i) {
				var attrs = { value: this.cate_id, text: this.cate_name };
				
				if('${obj.cate_id}' == this.cate_id) {
					attrs.selected = 'selected';
				}
				
				cate2.append($('<option>', attrs));
			});
			
			cate2.select2('destroy');
			cate2.select2('');
		});
	}
}
</script>