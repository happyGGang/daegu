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
		doGetLoad('loanList.do', $('#pictureBook').serialize());
	});
});
</script>
<form:form modelAttribute="pictureBook" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>
<form:hidden path="pay_yn"/>
</form:form>
<div>
	<table class="type1">
		<colgroup>
			<col width="150"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>책 꾸러미명</th>
				<td>${pictureBook.picture_book_subject}</td>
			</tr>
			<tr>
				<th>대출기간</th>
				<td>${pictureBook.loan_year}년 ${pictureBook.loan_month}월</td>
			</tr>
			<tr>
				<th>신청자</th>
				<td>${pictureBook.request_name}</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>${pictureBook.phone}</td>
			</tr>
			<tr>
				<th>학교연락처</th>
				<td>${pictureBook.school_tel}</td>
			</tr>
			<tr>
				<th>신청사유</th>
				<td>${pictureBook.request_content}</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
				<c:choose>
					<c:when test="${pictureBook.request_status eq '7'}">예약완료</c:when>
					<c:when test="${pictureBook.request_status eq '1'}">신청완료</c:when>
					<c:when test="${pictureBook.request_status eq '2'}">대출중</c:when>
					<c:when test="${pictureBook.request_status eq '3'}">반납신청</c:when>
					<c:when test="${pictureBook.request_status eq '4'}">반납요청완료</c:when>
					<c:when test="${pictureBook.request_status eq '5'}">반납완료</c:when>
					<c:when test="${pictureBook.request_status eq '6'}">대출불가</c:when>
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