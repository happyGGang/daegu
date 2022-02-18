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

<style>
	table thead th{text-align:center;}
</style>

<h4>
	<span style="font-weight:300">대출내역을 통해 </span>도서를 선택<span style="font-weight:300">하실 수 있습니다.</span>
</h4>

<div class="rsv-info"></div>
<div class="auto-scroll">
	<table>
		<colgroup>
			<col width="3%">
			<col width="">
			<col width="5">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="7%">
			<col width="8%">
		</colgroup>
		<thead>
			<th>순번</th>
			<th>제목</th>
			<th>청구기호</th>
			<th>저자 / 발행자</th>
			<th>도서관명</th>
			<th>대출일</th>
			<th>반납예정일</th>
			<th>상태</th>
			<th>선택</th>
		</thead>
		<tbody>
			<c:if test="${fn:length(loanList) < 1}"><tr><td colspan="9">대출중인 도서가 없습니다.</td></tr></c:if>
			<c:forEach items="${loanList}" var="i">
			<tr>
				<th style="text-align:center;">${i.RNUM}</th>
				<td>${i.TITLE_INFO}</td>
				<td>${i.CALL_NO}</td>
				<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
				<td style="text-align:center;">${i.LIB_NAME}</td>
				<td style="text-align:center;">${i.LOAN_DATE}</td>
				<td style="text-align:center;">${i.RETURN_PLAN_DATE}</td>
				<td style="text-align:center;">
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
				<td style="text-align:center;">
					<a href="#" id="selectOne" class="btn btn1">선택</a>
					<span data="${fn:replace(fn:replace(i.TITLE_INFO, '</b>', ''), '<b>', '')}//${i.AUTHOR}//${i.PUBLISHER}//${i.CALL_NO}//${i.REG_NO}//${i.MANAGE_CODE}//${i.LIB_NAME}"></span>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
	$(function() {

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', $(this).attr('keyValue'));
			doAjaxLoad('div#loanBox', 'loan/index.do', $('form#librarySearch').serialize());
		});

		$('a#selectOne').on('click', function(e) {
			e.preventDefault();
			var data = $(this).next('span').attr('data').split('//');
			$('input#book_name').val(data[0].replace(/(<([^>]+)>)/ig,""));
			$('input#book_author').val(data[1].replace(/(<([^>]+)>)/ig,""));
			$('input#publisher').val(data[2].replace(/(<([^>]+)>)/ig,""));
			$('input#call_no').val(data[3].replace(/(<([^>]+)>)/ig,""));
			$('input#reg_no').val(data[4].replace(/(<([^>]+)>)/ig,""));
			
			$('input#book_name').attr('readonly', true);
			$('input#book_author').attr('readonly', true);
			$('input#publisher').attr('readonly', true);
			$('input#call_no').attr('readonly', true);
			$('input#reg_no').attr('readonly', true);
			$('input#book_name').focus();
			
			var manage_code = data[5].replace(/(<([^>]+)>)/ig,"");
			
			$('span#writing').hide();
			$('span#selectButton').show();
			if (manage_code == 'BY') {
				$('select#book_resources').val('100').prop('selected', true);
			} else if (manage_code == 'BW') {
				$('select#book_resources').val('200').prop('selected', true);
			} else if (manage_code == 'BV') {
				$('select#book_resources').val('300').prop('selected', true);
			} else if (manage_code == 'BZ') {
				$('select#book_resources').val('400').prop('selected', true);
			} else if (manage_code == 'BX') {
				$('select#book_resources').val('600').prop('selected', true);
			} else if (manage_code == 'BU') {
				$('select#book_resources').val('700').prop('selected', true);
			} else {
				$('select#book_resources').val('write').prop('selected', true);
				$('input#book_resources_1').css('display', '');
				$('input#book_resources_1').val(data[6].replace(/(<([^>]+)>)/ig,""));
			}
			
			$('select#book_resources').attr('onfocus', 'this.initialSelect = this.selectedIndex');
			$('select#book_resources').attr('onchange', 'this.selectedIndex = this.initialSelect');
			$('input#book_resources_1').attr('readonly', true);
			
			$('input#loan_choice').val('Y');
		});
	});
</script>