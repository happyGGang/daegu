<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table id="accessTableData" class="chartData">
<thead>
	<tr>
		<c:choose>
			<c:when test="${archiveStatistics.date_type == 'TIME'}">
				<th width="200">시간</th>
			</c:when>
			<c:when test="${archiveStatistics.date_type == 'DAY'}">
				<th width="200">일</th>
			</c:when>
			<c:when test="${archiveStatistics.date_type == 'WEEK'}">
				<th width="200">요일</th>
			</c:when>
			<c:when test="${archiveStatistics.date_type == 'MONTH'}">
				<th width="200">월</th>
			</c:when>
		</c:choose>
		<th>방문수</th>
		<th>비율(%)</th>
		<th>비고</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="i" varStatus="status" items="${statisticsList}">
		<tr>
			<td class="left">
			<c:choose>
				<c:when test="${archiveStatistics.date_type == 'WEEK'}">
				<c:choose>
					<c:when test="${i.result_date eq '1'}">일</c:when>
					<c:when test="${i.result_date eq '2'}">월</c:when>
					<c:when test="${i.result_date eq '3'}">화</c:when>
					<c:when test="${i.result_date eq '4'}">수</c:when>
					<c:when test="${i.result_date eq '5'}">목</c:when>
					<c:when test="${i.result_date eq '6'}">금</c:when>
					<c:when test="${i.result_date eq '7'}">토</c:when>
				</c:choose>
				</c:when>
				<c:otherwise>
				${i.result_date}<c:if test="${archiveStatistics.date_type == 'TIME'}">시</c:if>
				</c:otherwise>
			</c:choose>
			</td>
			<td>${i.result_count}</td>
			<td>
			<c:choose>
				<c:when test="${total_count == 0}"><em>(0%)</em></c:when>
				<c:otherwise>
				<em>(<fmt:formatNumber value="${i.result_count / total_count * 100}" pattern="0.00"/>%)</em>
				</c:otherwise>
			</c:choose>
			</td>
			<td></td>
		</tr>
	</c:forEach>
</tbody>
<tfoot>
	<tr>
		<th>합계</th>
		<td colspan="3">${total_count}<em>(100%)</em></td>
	</tr>
</tfoot>
</table>