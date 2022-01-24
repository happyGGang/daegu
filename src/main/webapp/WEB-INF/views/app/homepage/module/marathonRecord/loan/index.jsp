<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	

});
</script>
<jsp:useBean id="now" class="java.util.Date"/>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="manageCode"/>
	<form:hidden path="excel_type" value="LOAN"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<!-- contents-title
<div id="contents-title">
	<h2>대출중인도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
/contents-title-->

<div id="contents-title">
	<h2><span style="font-weight:300">대출내역을 통해 </span>도서를 선택<span style="font-weight:300">하실 수 있습니다.</span></h2>
</div>

	<table summary="신청정보">
		<thead>
			<th>순번</th>
			<th>제목</th>
			<th>저자 / 발행자</th>
			<th>도서관명</th>
			<th>대출일</th>
			<th>반납예정일</th>
			<th>상태</th>
			<th>선택</th>
		</thead>
		<tbody>
			<c:if test="${fn:length(loanList) < 1}"><tr><td colspan="8">대출중인 도서가 없습니다.</td></tr></c:if>
			<c:forEach items="${loanList}" var="i">
			<tr>
				<td>${i.RNUM}</td>
				<td>${i.TITLE_INFO}</td>
				<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
				<td>${i.LIB_NAME}</td>
				<td>${i.LOAN_DATE}</td>
				<td>${i.RETURN_PLAN_DATE}</td>
				<td>
				<fmt:parseDate value="${i.RETURN_PLAN_DATE}" pattern="yyyy/MM/dd" var="rpd"/>
				<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowDate"/>
				<fmt:formatDate value="${rpd}" pattern="yyyyMMdd" var="endDate"/>
				<c:choose>
					<c:when test="${(nowDate - endDate) > 0}">연체</c:when>
					<c:when test="${i.STATUS eq '0'}">대출</c:when>
					<c:when test="${i.STATUS eq '1'}">반납</c:when>
					<c:when test="${i.STATUS eq '2'}">반납연기</c:when>
					<c:when test="${i.STATUS eq '3'}">예약</c:when>
					<c:when test="${i.STATUS eq '4'}">예약취소</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				</td>
				<td>
					<a href="#" id="selectOne" class="btn btn1" style="width:30%;height:10%;">선택</a>
					<span data="${fn:replace(fn:replace(i.TITLE_INFO, '</b>', ''), '<b>', '')}//${i.AUTHOR}//${i.PUBLISHER}//${i.CALL_NO}//${i.REG_NO}//${i.MANAGE_CODE}//${i.LIB_NAME}"></span>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>