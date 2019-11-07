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
			<th width="200">시설물명</th>
			<th width="200">이용가능연도</th>
			<th width="100">신청 제한 수</th>
			<th width="100">신청 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalLimitCount" value="0"/>
		<c:set var="totalApplyCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsListYear}">
			<c:set var="totalLimitCount" value="${totalLimitCount + i.limit_count}"/>
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.facility_name}</td>
				<td>${i.use_date}</td>
				<td>${i.limit_count}</td>
				<td>${i.apply_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="4">전체 신청 제한 수 : ${totalLimitCount}, 전체 신청 수 : ${totalApplyCount}</td>
		</tr>
	</tfoot>
</table>

<table class="chartData center">
	<thead>
		<tr>
			<th width="30">번호</th>
			<th width="200">시설물명</th>
			<th width="200">이용가능월</th>
			<th width="100">신청 제한 수</th>
			<th width="100">신청 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalLimitCount" value="0"/>
		<c:set var="totalApplyCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsListMonth}">
			<c:set var="totalLimitCount" value="${totalLimitCount + i.limit_count}"/>
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.facility_name}</td>
				<td>${i.use_date}</td>
				<td>${i.limit_count}</td>
				<td>${i.apply_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="4">전체 신청 제한 수 : ${totalLimitCount}, 전체 신청 수 : ${totalApplyCount}</td>
		</tr>
	</tfoot>
</table>

<table class="chartData center">
	<thead>
		<tr>
			<th width="30">번호</th>
			<th width="200">시설물명</th>
			<th width="200">이용가능일</th>
			<th width="100">신청 제한 수</th>
			<th width="100">신청 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalLimitCount" value="0"/>
		<c:set var="totalApplyCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsList}">
			<c:set var="totalLimitCount" value="${totalLimitCount + i.limit_count}"/>
			<c:set var="totalApplyCount" value="${totalApplyCount + i.apply_count}"/>
			<tr>
				<td>${status.count}</td>
				<td>${i.facility_name}</td>
				<td>${i.use_date}</td>
				<td>${i.limit_count}</td>
				<td>${i.apply_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="4">전체 신청 제한 수 : ${totalLimitCount}, 전체 신청 수 : ${totalApplyCount}</td>
		</tr>
	</tfoot>
</table>
