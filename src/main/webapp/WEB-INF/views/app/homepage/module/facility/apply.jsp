<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	
	//신청자 수정버튼
	$('a.facility-cancel-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm("해당 신청내역을 취소 하시겠습니까?")) {
			$('#applyEdit #homepage_id').val($(this).attr('keyValue1'));
			$('#applyEdit #facility_idx').val($(this).attr('keyValue2'));
			$('#applyEdit #facility_req_idx').val($(this).attr('keyValue3'));
			
			if ( doAjaxPost($('#applyEdit')) ) {
				location.reload();
			}
		}
		
	});
	
	
});
</script>
<form:form modelAttribute="facilityReq" id="applyEdit" action="save.do" method="post">
	<form:hidden path="editMode" value="CANCEL"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="facility_req_idx"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="180"/>
			<col width="120"/>
			<col width="100"/>
			<col width=""/>
			<col width="80"/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>시설물 명</th>
				<th>이용가능일</th>
				<th>이용시간</th>
				<th>사용목적</th>
				<th>신청상태</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${applyList}">				
				<tr>
					<td>${i.facility_name}</td>
					<td>${i.use_date}</td>
					<td>${i.start_time}~${i.end_time}</td>
					<td>${i.apply_desc}</td>
					<td>${i.apply_status}</td>
					<td>
						<c:if test="${i.apply_status ne '취소'}">
							<a class="btn btn5 facility-cancel-btn" keyValue1="${i.homepage_id}" keyValue2="${i.facility_idx}" keyValue3="${i.facility_req_idx}">취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(applyList) < 1}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
