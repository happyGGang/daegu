<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	
});
</script>
<form:form modelAttribute="support" id="apply" action="excelDownload.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>

<div class="table-wrap">
	<div class="infodesk">
		검색 결과 : 총 ${fn:length(supportList)}건
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="140"/>
			<col width="80"/>
			<col width="150"/>
			<col width="120"/>					
			<col width="120"/>
			<col width="120"/>
			<col width="120"/>
			<col width="120"/>
		</colgroup>
		<thead>
			<tr>
				<th>신청기관명</th>
				<th>신청자</th>
				<th>신청자휴대폰</th>
				<th>지원일자</th>
				<th>지원구분</th>
				<th>지원자</th>
				<th>협력업체</th>								
				<th>진행상태</th>								
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${supportList}">				
				<tr>
					<td>${i.req_name}</td>
					<td>${i.requer_name}</td>
					<td>${i.requer_tel}</td>
					<td>${i.hope_req_dt}</td>
					<td>
						<c:if test="${i.support_div eq '1' }">방문지원</c:if>
						<c:if test="${i.support_div eq '2' }">원격지원</c:if>
						<c:if test="${i.support_div eq '3' }">전화지원</c:if>					
					</td>
					<td>${i.supporter}</td>
					<td>${i.subcontractor}</td>					
					<td>
						<c:if test="${i.process_state eq 'Y' }">완료</c:if>
						<c:if test="${i.process_state eq 'N' }">접수</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(supportList) < 1}">
				<tr>
					<td colspan="9">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
</form:form>