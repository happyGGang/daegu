<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	
});
</script>


<table class="chartData center">
	<thead>
		<tr>
			<th width="30">번호</th>
			<th width="200">연별</th>
			<th width="100">견학 등록수</th>
			<th width="100">견학 신청수</th>
			<th width="100">견학 승인처리 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalExcursionCount" value="0"/>
		<c:set var="totalApplyCount" value="0"/>
		<c:set var="totalApplyOkCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsListYear}">
			<c:set var="totalExcursionCount" value="${totalExcursionCount + i.excursions_count}"/>
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<c:set var="totalApplyOkCount" value="${totalApplyOkCount + i.apply_ok_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.start_date}</td>
				<td>${i.excursions_count}</td>
				<td>${i.apply_count}</td>
				<td>${i.apply_ok_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="4">전체 견학일 : ${totalExcursionCount}, 전체 견학 신청수 : ${totalApplyCount}, 전체 승인처리 수 : ${totalApplyOkCount}</td>
		</tr>
	</tfoot>
</table>

<table class="chartData center">
	<thead>
		<tr>
			<th width="30">번호</th>
			<th width="200">월별</th>
			<th width="100">견학 등록수</th>
			<th width="100">견학 신청수</th>
			<th width="100">견학 승인처리 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalExcursionCount" value="0"/>
		<c:set var="totalApplyCount" value="0"/>
		<c:set var="totalApplyOkCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsListMonth}">
			<c:set var="totalExcursionCount" value="${totalExcursionCount + i.excursions_count}"/>
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<c:set var="totalApplyOkCount" value="${totalApplyOkCount + i.apply_ok_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.start_date}</td>
				<td>${i.excursions_count}</td>
				<td>${i.apply_count}</td>
				<td>${i.apply_ok_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="4">전체 견학일 : ${totalExcursionCount}, 전체 견학 신청수 : ${totalApplyCount}, 전체 승인처리 수 : ${totalApplyOkCount}</td>
		</tr>
	</tfoot>
</table>

<table class="chartData center">
	<thead>
		<tr>
			<th width="30">번호</th>
			<th width="200">일별</th>
			<th width="100">견학 신청수</th>
			<th width="100">견학 승인처리 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalApplyCount" value="0"/>
		<c:set var="totalApplyOkCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsList}">
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<c:set var="totalApplyOkCount" value="${totalApplyOkCount + i.apply_ok_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.start_date}</td>
				<td>${i.apply_count}</td>
				<td>${i.apply_ok_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="3"> 전체 견학일 : ${fn:length(statisticsList)}, 전체 견학 신청수 : ${totalApplyCount}, 전체 승인처리 수 : ${totalApplyOkCount}</td>
		</tr>
	</tfoot>
</table>
