<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	var $form = $('form#pictureBook');

	$('#list-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('loanList.do', $('#libraryCheck').serialize());
	});
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="libraryCheck" action="loanList.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>
</form:form>
<div>
	<table class="type1">
		<colgroup>
			<col width="150"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>장서점검기</th>
				<td>장서점검기${libraryCheck.library_check_number}</td>
			</tr>
			<tr>
				<th>대출기간</th>
				<td>${libraryCheck.loan_start_date} ~ ${libraryCheck.loan_end_date}</td>
			</tr>
			<tr>
				<th>학교명</th>
				<td>${libraryCheck.school_name}</td>
			</tr>
			<tr>
				<th>신청자</th>
				<td>${libraryCheck.request_name}</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>${libraryCheck.phone}</td>
			</tr>
			<tr>
				<th>학교연락처</th>
				<td>${libraryCheck.school_tel}</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
				<c:choose>
					<c:when test="${libraryCheck.request_status eq '0'}">신청중</c:when>
					<c:when test="${libraryCheck.request_status eq '1'}">예약상담중</c:when>
					<c:when test="${libraryCheck.request_status eq '2'}">대출중</c:when>
					<c:when test="${libraryCheck.request_status eq '3'}">반납완료</c:when>
					<c:when test="${libraryCheck.request_status eq '4'}">관리자취소</c:when>
					<c:when test="${libraryCheck.request_status eq '5'}">반납요청완료</c:when>
				</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<br>
<div>
	<a href="#" id="list-btn" class="btn btn3">목록으로</a>
</div>