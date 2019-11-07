<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
// 	$('tr.view-detail').on('click', function(e) {
// 		e.preventDefault();
// 		var close_no = $(this).data('close_no');
// 		location.href = 'detail.do?vSeqNo=' + close_no + '&menu_idx=${librarySearch.menu_idx}';
// 	});

	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('CLOSE');
		$('#excelDownForm #vLoca').val('${homepage.homepage_code}');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/excelDownload.do');
		$('#excelDownForm').submit();
	});

	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('CLOSE');
		$('#excelDownForm #vLoca').val('${homepage.homepage_code}');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/csvDownload.do');
		$('#excelDownForm').submit();
	});

	$('a.close-cancel').on('click', function(e) {
		$('#closeCancelForm #editMode').val('CANCEL');
		$('#closeCancelForm #vSeqNo').val($(this).attr('vSeqNo'));
		$('#closeCancelForm #vLoca').val($(this).attr('vLoca'));
		$('#closeCancelForm #title').val($(this).attr('vTitle'));

		if ( doAjaxPost($('#closeCancelForm')) ) {
			location.reload();
		}
		e.preventDefault();
	});
});

</script>

<form:form id="closeCancelForm" modelAttribute="librarySearch" action="save.do">
	<form:hidden path="editMode" value="CANCEL"/>
	<form:hidden path="vSeqNo"/>
	<form:hidden path="vLoca"/>
	<form:hidden path="title"/>
</form:form>

<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
	<form:hidden path="excel_type"/>
	<form:hidden path="vLoca"/>
</form:form>

<c:if test="${fn:length(closeList.dsMyLibraryList) > 0}">
	<div style="text-align: right">
		<a class="btn btn2 excel-btn">엑셀 저장</a>
		<a class="btn btn2 csv-btn">CSV 저장</a>
	</div>
</c:if>

<div class="book-list">
	<c:if test="${fn:length(closeList.dsMyLibraryList) < 1 }"> <h3>보존서고 신청중인 도서 내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(closeList.dsMyLibraryList) > 0 }">
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
				<c:forEach items="${closeList.dsMyLibraryList}" var="i" varStatus="status">
				<tr>
					<td class="center">${status.count}</td>
					<td>${i.TITLE}</td>
					<td>${i.BOOK_LOCA_NAME}</td>
					<td>
						<fmt:parseDate var="curDate" value="${i.REQST_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>&nbsp;
						<fmt:parseDate var="curDate2" value="${i.REQST_TIME}" pattern="HHmmss"/>
						<fmt:formatDate value="${curDate2}" type="both" pattern="HH:mm:ss"/>
					</td>
					<td>
						<c:choose>
						<c:when test="${i.STATUS_CODE eq 9999}">
						${i.STATUS_NAME}
						</c:when>
						<c:otherwise>
						<a href="" class="btn close-cancel" vSeqNo="${i.SEQ_NO}" vLoca="${i.BOOK_LOCA}" vTitle="${i.TITLE}">신청취소</a>
						</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>