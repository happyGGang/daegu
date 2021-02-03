<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a.delay-btn').on('click', function(e) {
		e.preventDefault();

		$('input#editMode').val('RENEW');
		$('input#loan_key').val($(this).attr('keyValue1'));

		if ( doAjaxPost($('form#renewForm')) ) {
			location.reload();
		}
	});
	
	$('#select_manage').on('change', function() {
		var menu_idx = '${librarySearch.menu_idx}';
		doGetLoad('index.do', 'menu_idx='+menu_idx+'&manageCode='+$(this).val());
	});
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = 'excel_type=LOAN';
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});

});
</script>

<form id="renewForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="loan_key" id="loan_key">
	<input type="hidden" name="editMode" value="RENEW">
</form>

<a href="#" id="excel-btn" class="btn btn2">EXCEL</a>

<!-- contents-title-->
<div id="contents-title">
	<h2>대출중인도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<fieldset>
	<select name="manageCode" class="selectmenu" id="select_manage">
		<option value="">전체</option>
		<c:forEach items="${homepageList}" var="mc">
		<c:if test="${not empty mc.manage_code}">
		<option value="${mc.manage_code}" ${librarySearch.manageCode eq mc.manage_code ? 'selected' : ''}>${mc.homepage_name}</option>
		</c:if>
		</c:forEach>
	</select>
</fieldset>

<div>
대출중 권수 : ${fn:length(loanList)}<br/>
대출연체 권수 : ${member.overdue_cnt}<br/>
대출정지만기일 : ${member.loan_stop_date eq 'null' ? '해당없음' : member.loan_stop_date}
</div>

<div class="book-list">

<c:if test="${fn:length(loanList) < 1 }"> <h3>현재 대출 중인 도서가 없습니다.</h3></c:if>

<table summary="신청정보">
	<thead>
		<th>순번</th>
		<th>제목</th>
		<th>저자 / 발행자</th>
		<th>도서관명</th>
		<th>대출일</th>
		<th>반납예정일</th>
		<th>상태</th>
	</thead>
	<tbody>
<c:forEach items="${loanList}" var="i">
		<tr>
			<td>${i.RNUM}</td>
			<td>${i.TITLE_INFO}</td>
			<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
			<td>${i.LIB_NAME}</td>
			<td>${i.LOAN_DATE}</td>
			<td>${i.RETURN_DATE}</td>
			<td><c:choose><c:when test="${i.STATUS eq '0'}">대출</c:when><c:when test="${i.STATUS eq '1'}">반납</c:when><c:when test="${i.STATUS eq '2'}">반납연기</c:when><c:when test="${i.STATUS eq '3'}">예약</c:when><c:when test="${i.STATUS eq '4'}">예약취소</c:when><c:otherwise></c:otherwise></c:choose></td>
		</tr>
</c:forEach>
		</tbody>
</table>
</div>