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
		doGetLoad('edit.do', $('form#bookRelayClubView').serialize());
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bookRelayClubView').serialize());
	});
	
});
</script>

<form:form modelAttribute="bookRelayClub" id="bookRelayClubView" >
<form:hidden path="homepage_id"/>
<form:hidden path="club_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="5%">
			<col width="15%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th rowspan="3">동아리</th>
				<th>동아리명</th>
				<td>${getBookRelayClub.club_name}</td>
			</tr>
			<tr>
				<th>동아리 결성일</th>
				<td>${getBookRelayClub.club_date}</td>
			</tr>
			<tr>
				<th>동아리 회원수</th>
				<td>${getBookRelayClub.club_members}명</td>
			</tr>
			<tr>
				<th rowspan="4">대표자</th>
				<th>대표자명</th>
				<td>${getBookRelayClub.leader_name}</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>${getBookRelayClub.user_phone}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${getBookRelayClub.user_email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${getBookRelayClub.postcode}) ${getBookRelayClub.address_base} ${getBookRelayClub.address_detailed} </td>
			</tr>
			<tr>
				<th colspan="2">도서영역</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayClub.book_area eq '0'}">성인</c:when>
						<c:when test="${getBookRelayClub.book_area eq '1'}">청소년</c:when>
						<c:when test="${getBookRelayClub.book_area eq '2'}">어린이</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th colspan="2">독서노트 신청수량</th>
				<td>${getBookRelayClub.book_quantity}권</td>
			</tr>
			<tr>
				<th colspan="2">릴레이 계획</th>
				<td>${getBookRelayClub.relay_plan}</td>
			</tr>
			<tr>
				<th colspan="2">상태</th>
				<td>
					<c:choose>
						<c:when test="${getBookRelayClub.approval_status eq '0'}">신청</c:when>
						<c:when test="${getBookRelayClub.approval_status eq '1'}">승인</c:when>
						<c:when test="${getBookRelayClub.approval_status eq '2'}">취소</c:when>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	<br/>
	
	<div>
		<h4>릴레이 명단</h4>
		<table class="type1 center">
			<colgroup>
				<col width="10%" />
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>이름</th>
					<th>연락처</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${relayList}">
					<tr>
						<td>${i.relay_name}</td>
						<td>${i.relay_phone}</td>
						<td>${i.relay_etc}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">수정하기</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

