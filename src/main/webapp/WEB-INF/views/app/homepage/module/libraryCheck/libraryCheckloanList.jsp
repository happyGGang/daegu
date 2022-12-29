<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form modelAttribute="libraryCheck">
<table>
	<tbody>
		<c:forEach items="${libraryCheckList}" var="i" varStatus="status">
		<tr>
			<td>${i.loan_start_date} ~ ${i.loan_end_date}</td>
			<td style="text-align:center;">
				<c:choose>
					<c:when test="${i.request_status eq '0'}">예약중</c:when>
					<c:when test="${i.request_status eq '1'}">예약중</c:when>
					<c:when test="${i.request_status eq '2'}">신청중</c:when>
					<c:when test="${i.request_status eq '3'}">대출중</c:when>
					<c:when test="${i.request_status eq '4'}">반납완료</c:when>
					<c:when test="${i.request_status eq '5'}">관리자취소</c:when>
					<c:when test="${i.request_status eq '6'}">반납요청완료</c:when>
					<c:when test="${i.request_status eq '7'}">수리중</c:when>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	<c:if test="${fn:length(libraryCheckList) < 1}">
	  <div align="center">
	    <h3>예약정보가 없습니다.</h3>
	  </div>
	</c:if>
</table>
</form:form>