<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
</script>
<form:form id="raffleListForm" modelAttribute="nearbyLibRaffle" method="post" action="save.do">
	<div class="infodesk">
		예약내역 : 총 ${fn:length(memberList)}건
	</div>
	
	<table class="type1 center">
		<colgroup>
			<col width="3%"/>
 			<col width="10%"/>
 			<col width="4%"/>
 			<col width="4%"/>
			<col width="4%"/>
			<col width="7%"/>
			<col width="10%"/>
			<col width="7%"/>
			<col width="7%"/>
			<col width="4%"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>			
				<th>소장처</th>
				<th>사물함</th>
				<th>회원ID</th>
				<th>수령장소</th>
				<th>도서명</th>
				<th>신청날짜</th>
				<th>예약확정시간</th>
				<th>SMS발송<br/>여부</th>
				<th>대출상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${memberList}">
				<tr>
					<td>${status.count}</td>				
					<td>${i.lib_name}</td>
					<td>
						<c:choose>
							<c:when test="${i.locker_idx > 0 }">
								${i.locker_idx}번
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${i.member_id}</td>
					<td>${i.device_name}</td>
					<c:choose>
						<c:when test="${fn:length(i.book_name) > 8}">
							<td>${fn:substring(i.book_name,0,7)}..</td>
						</c:when>
						<c:otherwise>
							<td>${i.book_name}</td>
						</c:otherwise>
					</c:choose>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /><br/><fmt:formatDate value="${i.add_date}" pattern="HH:mm" /></td>
					<td>
						<c:choose>
							<c:when test="${i.lend_date eq null or i.lend_date eq ''}">
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd" /><br/><fmt:formatDate value="${i.lend_date}" pattern="HH:mm" />
							</c:otherwise>					
						</c:choose>					
					</td>
					<td>
						<c:choose>
							<c:when test="${i.sms_send_yn eq 'Y'}">
								발송완료
							</c:when>
							<c:otherwise>
								미발송
							</c:otherwise>					
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${i.reserve_status eq '1'}">
								예약
							</c:when>
							<c:when test="${i.reserve_status eq '2'}">
								예약확정
							</c:when>
							<c:when test="${i.reserve_status eq '3'}">
								사물함투입
							</c:when>
							<c:when test="${i.reserve_status eq '4'}">
								대출
							</c:when>
							<c:when test="${i.reserve_status eq '5'}">
								회수대기
							</c:when>
							<c:when test="${i.reserve_status eq '6'}">
								회수중
							</c:when>
							<c:when test="${i.reserve_status eq '7'}">
								회수완료
							</c:when>							
							<c:when test="${i.reserve_status eq '8'}">
								취소
							</c:when>
							<c:when test="${i.reserve_status eq '9'}">
								반납
							</c:when>
							<c:when test="${i.reserve_status eq '10'}">
								반납완료
							</c:when>	
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(memberList) eq 0}">
				<tr>
					<td colspan="10">이전 예약 내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form:form>