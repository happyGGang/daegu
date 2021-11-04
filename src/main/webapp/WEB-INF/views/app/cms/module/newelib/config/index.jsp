<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('a#set').on('click', function(e) {
		e.preventDefault();
		var ret = doAjaxPost($('form#configForm'));
		if(ret) {
			location.reload();
		};
	});
});
</script>
<div class="infodesk">
	<div class="button center">
		<c:if test="${authC}">
			<a href="" class="btn btn5 left" id="set"><i class="fa fa-plus"></i><span>저장</span></a>
		</c:if>
	</div>
</div>
<form:form id="configForm" modelAttribute="config" method="post" action="save.do" >
	<table class="type1">
		<colgroup>
	       <col width="230" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>개인별 최대 대출 권수</th>
	         	<td><form:input path="user_max_lend" class="text" cssStyle="width:100px"/> 권 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>도서별 최대 대출 권수</th>
	         	<td><form:input path="book_max_lend" class="text" cssStyle="width:100px"/> 권 (대출가능한 전자책)</td>
        	</tr>
			<tr>
	         	<th>개인별 최대 예약 권수</th>
	         	<td><form:input path="max_reserve" class="text" cssStyle="width:100px"/> 권 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>도서별 최대 동시 예약자수</th>
	         	<td><form:input path="book_max_reserve" class="text" cssStyle="width:100px"/> 명 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>대출기간</th>
	         	<td><form:input path="lend_max_term" class="text" cssStyle="width:100px"/> 일</td>
        	</tr>
			<tr>
	         	<th>연장 횟수</th>
	         	<td><form:input path="max_extention" class="text" cssStyle="width:100px"/> 회</td>
        	</tr>
			<tr>
	         	<th>연장 가능일</th>
	         	<td><form:input path="ext_lend_term" class="text" cssStyle="width:100px"/> 일</td>
        	</tr>
		</tbody>
	</table>
</form:form>
