<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	
});
</script>

<table class="chartData center">
	<thead>
		<tr>
			<th width="200">사물함 설정명</th>
			<th width="100">배정방식</th>
			<th width="200">사용기간</th>
			<th width="100">사물함 수</th>
			<th width="100">사물함 사용 수</th>
			<th width="100">사물함 미사용 수</th>	
			<th width="100">사물함 신청 수</th>	
			<th width="100">사물함 예약 수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="totalLockerCount" value="0"/>
		<c:set var="totalLockerReqCount" value="0"/>
		<c:set var="totalLockerUseCount" value="0"/>
		<c:set var="totalLockerNoUseCount" value="0"/>
		<c:forEach var="i" varStatus="status" items="${statisticsList}">
			<c:set var="totalLockerCount" value="${totalLockerCount + i.locker_count}"/>
			<c:set var="totalLockerReqCount" value="${totalLockerReqCount + i.locker_req_count}"/>
			<c:set var="totalLockerUseCount" value="${totalLockerUseCount + i.locker_use_count}"/>
			<c:set var="totalLockerNoUseCount" value="${totalLockerNoUseCount + (i.locker_count - i.locker_use_count)}"/>
			<tr>
				<td>${i.locker_pre_name}</td>
				<td>
					<c:choose>
						<c:when test="${i.locker_pre_type eq 'SELECT'}">선택배정</c:when>
						<c:when test="${i.locker_pre_type eq 'FIFO'}">순차배정</c:when>
						<c:when test="${i.locker_pre_type eq 'RANDOM'}">랜덤배정</c:when>
						<c:when test="${i.locker_pre_type eq 'LOTTERY'}">추첨배정</c:when>
					</c:choose>
				</td>
				<td>${i.start_date} ~ ${i.end_date}</td>
				<td>${i.locker_count}</td>
				<td>${i.locker_use_count}</td>
				<td>${i.locker_count - i.locker_use_count}</td>
				<td>${i.locker_req_count}</td>
				<td>${i.locker_req_count - i.locker_use_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="8">전체 사물함 수 : ${totalLockerCount}, 전체 사물함 신청 수 : ${totalLockerReqCount}, 전체 사물함 사용 수 : ${totalLockerUseCount}, 전체 사물함 미사용 수 : ${totalLockerNoUseCount}</td>
		</tr>
	</tfoot>
</table>
