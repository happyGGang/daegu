<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {

	//신청자 수정버튼
	$('a#delete-btn').on('click', function(event) {
		if(confirm("해당 신청내역을 삭제 하시겠습니까?\n삭제된 데이터는 복구가 불가합니다.")) {
			$.ajax({
				url : '/${homepage.context_path}/module/excursions/save.do?editMode=DELETE&apply_idx=' + $(this).attr("keyValue") + '&homepage_id=' + $('#homepage_id').val(),
				async : false,
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
				}
			});
		}
	});


});
</script>
<form:form modelAttribute="apply" id="applyEdit" action="/${homepage.context_path}/module/excursions/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="apply_idx"/>
<form:hidden path="pageType"/>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="130"/>
			<col width="90"/>
			<col width="120"/>
			<col width="120"/>
			<col width="100"/>
			<col width="70"/>
			<col width="70"/>
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th>기관명</th>
				<th>신청자 성명</th>
				<th>신청자 전화번호</th>
				<th>방문일자</th>
				<th>견학 시간</th>
				<th>방문인원</th>
				<th>승인여부</th>
				<th>신청</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${applyList}">
				<tr>
					<td>${i.agency_name}</td>
					<td>${i.applicant_name}</td>
					<td>${i.applicant_tel}</td>
					<td>${i.start_date}</td>
					<td>${i.start_time}<span id="tilde" style="font-size:12px">~</span>${i.end_time}</td>
					<td>${i.personnel}</td>
					<td>
						<c:set var="apply_state" value="${i.apply_state}" />
						<c:choose>
						    <c:when test="${apply_state eq '3'}">
						        승인
						    </c:when>
						    <c:when test="${apply_state eq '2'}">
						        불가
						    </c:when>
						    <c:otherwise>
						        대기
						    </c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:if test="${apply_state eq '3'}">
							취소불가
						</c:if>
						<c:if test="${apply_state ne '3'}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.apply_idx}">신청취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(applyList) < 1}">
				<tr>
					<td colspan="8">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
</form:form>