<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#modify_btn').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFY');
		doGetLoad('edit.do', $('form#bookRelayIndividualView').serialize());
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bookRelayIndividualView').serialize());
	});
	
});
</script>

<form:form modelAttribute="bookRelayIndividual" id="bookRelayIndividualView" >
<form:hidden path="homepage_id"/>
<form:hidden path="individual_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td>${getBookRelayIndividual.user_name}</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>${getBookRelayIndividual.user_phone}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${getBookRelayIndividual.user_email}</td>
			</tr>
			<tr>
				<th>학교 또는 직장명</th>
				<td>${getBookRelayIndividual.user_affiliation}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${getBookRelayIndividual.postcode}) ${getBookRelayIndividual.address_base} ${getBookRelayIndividual.address_detailed} </td>
			</tr>
			<tr>
				<th>도서영역</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayIndividual.book_area eq '0'}">성인</c:when>
						<c:when test="${getBookRelayIndividual.book_area eq '1'}">청소년</c:when>
						<c:when test="${getBookRelayIndividual.book_area eq '2'}">어린이</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>독서노트 신청수량</th>
				<td>${getBookRelayIndividual.book_quantity}권</td>
			</tr>
			<tr>
				<th>다독자 공모</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayIndividual.reader_contest eq 'Y'}">신청</c:when>
						<c:when test="${getBookRelayIndividual.reader_contest eq 'N'}">미신청</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>릴레이 계획</th>
				<td>${getBookRelayIndividual.relay_plan}</td>
			</tr>
			<tr>
				<th>릴레이 예상인원</th>
				<td>${getBookRelayIndividual.relay_personnel}명</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayIndividual.approval_status eq '0'}">신청</c:when>
						<c:when test="${getBookRelayIndividual.approval_status eq '1'}">승인</c:when>
						<c:when test="${getBookRelayIndividual.approval_status eq '2'}">취소</c:when>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">수정하기</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

