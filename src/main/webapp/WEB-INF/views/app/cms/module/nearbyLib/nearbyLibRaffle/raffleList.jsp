<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
</script>
<form:form id="raffleListForm" modelAttribute="nearbyLibRaffle" method="post" action="save.do">
	<div class="infodesk">
		당첨 결과 : 총 ${fn:length(winnerList)}건
	</div>
	
	<table class="type1 center">
		<colgroup>
			<col width="50"/>
			<col width="22%"/>
			<col width="22%"/>
			<col width="22%">
			<col width="22%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>회원ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>예약일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${winnerList}">
				<tr>
					<td>${status.count}</td>
					<td>${i.member_id}</td>
					<td>${i.name}</td>
					<td>${i.member_phone}</td>
					<td>${i.add_date}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(winnerList) eq 0}">
				<tr>
					<td colspan="4">당첨 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form:form>