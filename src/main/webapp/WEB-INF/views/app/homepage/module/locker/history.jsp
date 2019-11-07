<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<style>
	.view-detail { cursor: pointer; }
</style>
<script type="text/javascript">
$(function() {
	
	/* $('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('LOAN');
		$('#excelDownForm').submit();
	}); */
});
</script>
<%-- <c:if test="${fn:length(loanList.dsMyLibraryList) > 0}">
	<div style="text-align: right">
		<a class="btn btn2 excel-btn">엑셀 저장</a>
		<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
			<form:hidden path="excel_type"/>
			
		</form:form>
	</div>
</c:if> --%>

<div class="book-list">
<c:if test="${fn:length(historyList) < 1 }"> <h3>조회된 내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(historyList) > 0 }">
		<table summary="신청정보">
			<colgroup>
				<col width="100"/>
				<col width="100"/>
				<col width="60"/>
				<col width="100"/>
				<col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th>사용기간</th>
					<th>사물함명</th>
					<th>배정방식</th>
					<th>신청일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${historyList}" var="i" varStatus="status">
					<tr class="view-detail" >
						<td class="center">${i.start_date} ~ ${i.end_date}</td>
						<td><a>${i.locker_name}</a></td>
						<td>
							<c:choose>
								<c:when test="${i.locker_pre_type eq 'SELECT'}">선택배정</c:when>
								<c:when test="${i.locker_pre_type eq 'FIFO'}">순차배정</c:when>
								<c:when test="${i.locker_pre_type eq 'RANDOM'}">랜덤배정</c:when>
								<c:when test="${i.locker_pre_type eq 'LOTTERY'}">추첨배정</c:when>
							</c:choose>
						</td>
						<td>${i.add_date}</td>
						<td>
							<c:choose>
								<c:when test="${i.delete_yn eq 'Y'}">취소</c:when>
								<c:otherwise>
									${i.locker_idx > 0 ? '배정완료' : '대기'}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>

