<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	
});
</script>

<table id="statisticsResult" class="chartData center">
	<thead>
		<tr>
			<th width="100">대분류</th>	
			<th width="100">중분류</th>	
			<th width="100">소분류</th>	
			<th width="200">강좌명</th>	
			<th width="200">기간</th>	
			<th width="100">강사명</th>
			<th width="130">모집인원 / 참여인원</th>
			<th width="100">수료 / 미수료</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="total_teach_count" value="0"/>
		<c:set var="total_join_count" value="0"/>
		<c:set var="total_cert_ok_count" value="0"/>
		<c:set var="total_cert_fail_count" value="0"/>	
		<c:forEach var="i" varStatus="status" items="${statisticsList}">
			<c:set var="total_teach_count" value="${total_teach_count + i.teach_limit_count + i.teach_backup_count + i.teach_offline_count }"/>
			<c:set var="total_join_count" value="${total_join_count + i.join_count}"/>
			<c:set var="total_cert_ok_count" value="${total_cert_ok_count + i.cert_ok_count}"/>
			<c:set var="total_cert_fail_count" value="${total_cert_fail_count + (i.join_count - i.cert_ok_count)}"/>
			<tr>
				<td>${i.large_category_name}</td>
				<td>${i.group_name}</td>
				<td>${empty i.category_name ? '-' : i.category_name}</td>
				<td>${i.teach_name}</td>
				<td>${i.start_date} ~ ${i.end_date}</td>
				<td>${i.teacher_name}</td>
				<td>${i.teach_limit_count + i.teach_backup_count + i.teach_offline_count} / ${i.join_count}</td>
				<td>${i.join_count - i.cert_ok_count} / ${i.cert_ok_count}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th>합계</th>
			<td colspan="7">전체 모집 인원 : ${total_teach_count}, 전체 참여 인원 : ${total_join_count}, 전체 수료 인원 : ${total_cert_fail_count}, 전체 미수료 인원 : ${total_cert_ok_count}</td>
			<!-- <td colspan="2">4321 <em>(100%)</em></td> -->
		</tr>
	</tfoot>
</table>
