<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

</script>
<form:form id="untactBookReservation_1" modelAttribute="untactBookReservation" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="homepage_id" path="homepage_id"/>
<div id="editDisable" class="disableBox">
	<table class="type1 center">
		<thead>
			<tr>
				<th width="50">번호</th>
				<th width="50">신청자아이디</th>
				<th width="50">대출번호</th>
				<th width="50">신청자명</th>
				<th width="50">신청일</th>
				<th width="50">대출일</th>
				<th width="50">도서명</th>
				<th width="50">사물함번호</th>
				<th width="50">비밀번호</th>
				<th width="50">대출단계</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(untactBookReservationList) < 1}">
			<tr style="height:100%">
				<td colspan="10" style="background:#f8fafb;">비대면 사물함 신청내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
			<tr>
				<td width="50">${i.request_number}</td>
				<td width="50">${i.member_id}</td>
				<td width="50">${i.reg_no}</td>
				<td width="50">${i.member_name}</td>
				<td width="50">${i.request_date}</td>
				<td width="50">${i.loan_date}</td>
				<td width="50">${i.book_name}</td>
				<td width="50">${i.locker_number}</td>
				<c:choose>
					<c:when test="${i.locker_password eq 0}">
						<td width="50">비밀번호가 설정이 안되었습니다.</td>
					</c:when>
					<c:otherwise>
						<td width="50">${i.locker_password}</td>
					</c:otherwise>
				</c:choose>
				<td width="50">${i.reservation_step}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</form:form>