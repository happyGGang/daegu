<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	
});
</script>
<form:form modelAttribute="facilityBook" action="apply.do" method="GET">
	<form:hidden path="homepage_id"/>
	
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col width="100"/>
				<col width="200"/>
				<col width="250"/>
				<col width=""/>
				<col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>신청인</th>
					<th>시설명</th>
					<th>이용시간</th>
					<th>승인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${applyList}">
					<tr>
						<td class="num">${paging.listRowNum - status.index}</td>
						<td>${i.apply_name}</td>
						<td>
							<c:if test="${i.facility_book_name eq '1'}">
							<span>4층 토론실(16석)</span>
							</c:if>
						</td>
						<td>
							${fn:substring(i.apply_date, 0, 10)}/
							<span>
							<c:choose>
								<c:when test="${i.apply_time_code eq '0'}">오전</c:when>
								<c:when test="${i.apply_time_code eq '1'}">오후</c:when>
							</c:choose>
							&nbsp;시간
							</span>
						</td>
						<td>
						<c:choose>
							<c:when test="${i.apply_status eq '0'}">대기</c:when>
							<c:when test="${i.apply_status eq '1'}">승인</c:when>
						</c:choose>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(applyList) < 1}">
					<tr>
						<td colspan="5">데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#libraryCheck"/>
	</jsp:include>
</form:form>
