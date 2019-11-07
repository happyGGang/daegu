<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
});
</script>
<style type="text/css">
	div.optionBox {margin-top: 20px;}
	div#optionBox1 {margin-top: 0px;}
</style>
<form:form  modelAttribute="options" action="index.do">
<form:hidden path="homepage_id"/>

	<div class="infodesk">
		<div class="button">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	
	<c:forEach var="i" items="${optionCode}" varStatus="status">
	<div class="optionBox" id="optionBox${status.count}">
		<h3>${i.code_name}</h3>
		<table class="type1 center">
			<colgroup>
				<col width="80">
				<col width="100">
				<col width="120">
				<col width="30">
				<col width="30">
			</colgroup>
			<thead>
				<tr>
					<th>소장위치</th>
					<th>자료실명</th>
					<th>사용기간</th>
					<th>사용여부</th>
					<th>기타</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	</c:forEach>
	
</form:form>

<div id="dialog-1" class="dialog-common" title="기능제한 등록/수정"></div>
