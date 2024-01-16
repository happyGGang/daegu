<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('a#set').on('click', function(e) {
		e.preventDefault();
		var user_max_lend = $('input[name="user_max_lend"]').val();
		var book_max_lend = $('input[name="book_max_lend"]').val();
		var max_reserve = $('input[name="max_reserve"]').val();
		var book_max_reserve = $('input[name="book_max_reserve"]').val();
		var lend_max_term = $('input[name="lend_max_term"]').val();
		var max_extention = $('input[name="max_extention"]').val();
		var ext_lend_term = $('input[name="ext_lend_term"]').val();

		if (user_max_lend == "") {
			alert("개인별 최대 대출 권수를 입력해주세요.");
			user_max_lend.focus();
			return false;
		}
		if (book_max_lend == "") {
			alert("도서별 최대 대출 권수를 입력해주세요.");
			return false;
		}
		if (max_reserve == "") {
			alert("개인별 최대 예약 권수를 입력해주세요.");
			return false;
		}
		if (book_max_reserve == "") {
			alert("도서별 최대 동시 예약자수를 입력해주세요.");
			return false;
		}
		if (lend_max_term == "") {
			alert("대출기간을 입력해주세요.");
			return false;
		}
		if (max_extention == "") {
			alert("연장 횟수를 입력해주세요.");
			return false;
		}
		if (ext_lend_term == "") {
			alert("연장 가능일을 입력해주세요.");
			return false;
		}
		//숫자만 입력가능
		if (isNaN(user_max_lend)) {
			alert("개인별 최대 대출 권수는 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(book_max_lend)) {
			alert("도서별 최대 대출 권수는 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(max_reserve)) {
			alert("개인별 최대 예약 권수는 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(book_max_reserve)) {
			alert("도서별 최대 동시 예약자수는 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(lend_max_term)) {
			alert("대출기간은 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(max_extention)) {
			alert("연장 횟수는 숫자만 입력 가능합니다.");
			return false;
		}
		if (isNaN(ext_lend_term)) {
			alert("연장 가능일은 숫자만 입력 가능합니다.");
			return false;
		}

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
	         	<td><form:input path="user_max_lend" class="text" cssStyle="width:100px" /> 권 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>도서별 최대 대출 권수</th>
	         	<td><form:input path="book_max_lend" class="text" cssStyle="width:100px" /> 권 (대출가능한 전자책)</td>
        	</tr>
			<tr>
	         	<th>개인별 최대 예약 권수</th>
	         	<td><form:input path="max_reserve" class="text" cssStyle="width:100px" /> 권 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>도서별 최대 동시 예약자수</th>
	         	<td><form:input path="book_max_reserve" class="text" cssStyle="width:100px" /> 명 (공급사 무관)</td>
        	</tr>
			<tr>
	         	<th>대출기간</th>
	         	<td><form:input path="lend_max_term" class="text" cssStyle="width:100px" /> 일</td>
        	</tr>
			<tr>
	         	<th>연장 횟수</th>
	         	<td><form:input path="max_extention" class="text" cssStyle="width:100px" /> 회</td>
        	</tr>
			<tr>
	         	<th>연장 가능일</th>
	         	<td><form:input path="ext_lend_term" class="text" cssStyle="width:100px" /> 일</td>
        	</tr>
		</tbody>
	</table>
</form:form>
