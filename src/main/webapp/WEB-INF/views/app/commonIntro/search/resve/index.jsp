<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('.view-detail').on('click', function(e) {
		e.preventDefault();
		var resve_no = $(this).data('resve_no');
		location.href = 'detail.do?vResveNo=' + resve_no + '&menu_idx=${librarySearch.menu_idx}';
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('RESVE');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/excelDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('RESVE');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/csvDownload.do');
		$('#excelDownForm').submit();
	});
});

</script>
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</c:when>
<c:otherwise>

<c:if test="${fn:length(resveList.dsMyLibraryList) > 0}">
	<div style="text-align: right">
		<a class="btn btn2 excel-btn">엑셀 저장</a>
		<a class="btn btn2 csv-btn">CSV 저장</a>
		<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
			<form:hidden path="excel_type"/>
		</form:form>
	</div>
</c:if>

</c:otherwise>
</c:choose>


<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/app/css/sub_layout.css"/>

<div class="subpage_title">
	<h4>예약중도서</h4>
</div>
<div class="mylibrary-btn-section">
	<ul>
		<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=5"><img src="/resources/homepage/app/img/mylib01.png" alt=""><br/>대출중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=11"><img src="/resources/homepage/app/img/mylib02.png" alt=""><br/>대출이력</a></li>
		<li><a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=12" class="on"><img src="/resources/homepage/app/img/mylib03.png" alt=""><br/>예약중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=13"><img src="/resources/homepage/app/img/mylib04.png" alt=""><br/>희망도서신청내역</a></li>
		<li><a href="/${homepage.context_path}/html.do?menu_idx=24"><img src="/resources/homepage/app/img/mylib05.png" alt=""><br/>희망도서신청</a></li>
	</ul>
</div>

<div class="book-list">
	<c:if test="${fn:length(resveList.dsMyLibraryList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(resveList.dsMyLibraryList) > 0 }">
	<div class="alarm_list">
		<ul>
		<c:forEach items="${resveList.dsMyLibraryList}" var="i" varStatus="status">
		<li class="view-detail" data-resve_no="${i.RESVE_NO}">
			<p class="book_title">${status.index+1}. ${i.TITLE} / ${i.LOCA_NAME}</p>
			<p class="book_status">${i.STATUS_NAME}</p>
			<p class="date">예약일 : <fmt:parseDate var="curDate" value="${i.RESVE_DATE}" pattern="yyyyMMdd"/>
			<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/></p>
		</li>
		</c:forEach>
		</ul>
	</div>
	</c:if>
</div>

</c:when>
<c:otherwise>

<div class="book-list">
	<c:if test="${fn:length(resveList.dsMyLibraryList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(resveList.dsMyLibraryList) > 0 }">
		<table summary="신청정보">
			<colgroup>
				<col width="50px"/>
				<col/>
				<col width="20%"/>
				<col width="15%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>타이틀</th>
					<th>소장처명</th>
					<th>예약일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resveList.dsMyLibraryList}" var="i" varStatus="status">
					<tr class="view-detail" data-resve_no="${i.RESVE_NO}">
						<td class="center">${status.index+1}</td>
						<td class="left"><a>${i.TITLE}</a></td>
						<td>${i.LOCA_NAME}</td>
						<td>
							<fmt:parseDate var="curDate" value="${i.RESVE_DATE}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
						</td>
						<td>${i.STATUS_NAME}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>

</c:otherwise>
</c:choose>
