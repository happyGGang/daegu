<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
function cancelReserve(request_number, member_id, member_name) {
	if(confirm('예약 취소 하시겠습까?')) {
		var ajaxData = {
				'request_number' : request_number,
				'member_id' : member_id,
				'member_name' : member_name
		};
		
		$.ajax({
			type: "POST",
			url: 'cancelReserve.do',
			data: ajaxData,
			success:  function(response) {
				if(response.valid) {
					alert('예약 취소 되었습니다.');
				}
				location.reload();
			},error: function() {
				alert('예약 취소에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
	}
}
</script>

<form:form modelAttribute="untactBookReservation" method="POST">

<div class="book-list" style="border-top:none;">
	<div class="excel_btn_box_wrap02">
		<a href="#" id="excel-btn" class="btn excel-btn">리스트 다운로드</a>
	</div><br>

	<c:if test="${fn:length(untactBookReservationList) < 1 }"> <h3 style="margin-top:0;">비대면도서대출 내역이 없습니다.</h3></c:if>
	
	<table summary="신청정보">
		<thead>
			<th style="width:6%">순번</th>
			<th style="width:12%">신청일</th>
			<th style="width:6%">사물함번호</th>
			<th style="width:8%">사물함비밀번호</th>
			<th style="width:8%">예약상태</th>
			<th style="width:16%">책이름</th>
			<th style="width:6%">예약취소</th>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
			<tr>
				<td>${untactBookReservation.listRowNum - status.index}</td>
				<td>${i.request_date}</td>
				<td>${i.locker_number}</td>
				<td>
				<c:choose>
					<c:when test="${i.locker_password eq 0}">
					미등록
					</c:when>
					<c:otherwise>
					${i.locker_password}	
					</c:otherwise>
				</c:choose>
				</td>
				<td>${i.reservation_step}</td>
				<td>${i.book_name}</td>
				<td><a href="#" class="btn reserveCancel" onclick="cancelReserve('${i.request_number}','${i.member_id}','${i.member_name}')">예약취소</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

</form:form>
