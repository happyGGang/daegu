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
		doGetLoad('edit.do', $('form#bookRelayGroupView').serialize());
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bookRelayGroupView').serialize());
	});
	
});
</script>

<form:form modelAttribute="bookRelayGroup" id="bookRelayGroupView" >
<form:hidden path="homepage_id"/>
<form:hidden path="group_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>기관명</th>
				<td>${getBookRelayGroup.group_name}</td>
			</tr>
			<tr>
				<th>대표번호</th>
				<td>${getBookRelayGroup.main_number}</td>
			</tr>
			<tr>
				<th>담당자명</th>
				<td>${getBookRelayGroup.manager_name}</td>
			</tr>
			<tr>
				<th>직장전화</th>
				<td>${getBookRelayGroup.work_number}</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>${getBookRelayGroup.user_phone}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${getBookRelayGroup.postcode}) ${getBookRelayGroup.address_base} ${getBookRelayGroup.address_detailed} </td>
			</tr>
			<tr>
				<th>도서영역</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayGroup.book_area eq '0'}">성인</c:when>
						<c:when test="${getBookRelayGroup.book_area eq '1'}">청소년</c:when>
						<c:when test="${getBookRelayGroup.book_area eq '2'}">어린이</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>독서노트 신청수량</th>
				<td>${getBookRelayGroup.book_quantity}권</td>
			</tr>
			<tr>
				<th>릴레이 계획</th>
				<td>${getBookRelayGroup.relay_plan}</td>
			</tr>
			<tr>
				<th>릴레이 예상인원</th>
				<td>${getBookRelayGroup.relay_personnel}명</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayGroup.approval_status eq '0'}">신청</c:when>
						<c:when test="${getBookRelayGroup.approval_status eq '1'}">승인</c:when>
						<c:when test="${getBookRelayGroup.approval_status eq '2'}">취소</c:when>
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

