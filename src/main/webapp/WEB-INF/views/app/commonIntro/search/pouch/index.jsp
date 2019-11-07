<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('tr.view-detail').on('click', function(e) {
		e.preventDefault();
		var pouch_no = $(this).data('pouch_no');
		location.href = 'detail.do?vSeqNo=' + pouch_no + '&menu_idx=${librarySearch.menu_idx}';
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('POUCH');
		$('#excelDownForm #vLoca').val('${homepage.homepage_code}');
		$('#excelDownForm').submit();
	});
});

</script>

<c:if test="${fn:length(pouchList.dsMyLibraryList) > 0}">
	<div style="text-align: right">
		<a class="btn btn2 excel-btn">엑셀 저장</a>
		<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
			<form:hidden path="excel_type"/>
			<form:hidden path="vLoca"/>
		</form:form>
	</div>
</c:if>

<div class="book-list">
	<c:if test="${fn:length(pouchList.dsMyLibraryList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(pouchList.dsMyLibraryList) > 0 }">
		<table summary="신청정보">
			<colgroup>
				<col width="50px"/>
				<col/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>서명</th>
					<th>소장처명</th>
					<th>신청일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pouchList.dsMyLibraryList}" var="i" varStatus="status">
					<tr class="view-detail" data-pouch_no="${i.SEQ_NO}">
						<td class="center">${status.index+1}</td>
						<td><a>${i.TITLE}</a></td>
						<td>${i.BOOK_LOCA_NAME}</td>
						<td>
							<fmt:parseDate var="curDate" value="${i.REQST_DATE}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
							<fmt:parseDate var="curDate2" value="${i.REQST_TIME}" pattern="HHmmss"/>
							<fmt:formatDate value="${curDate2}" type="both" pattern="HH:mm:ss"/>
						</td>
						<td>${i.STATUS_NAME}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>
<%-- 

 --%>

