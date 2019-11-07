<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
	$(function() {
		$('a.cancelBtn').on('click', function(e) {
			e.preventDefault();
			if (!confirm('상호대차를 취소하겠습니까?')) {
				return false;
			}

			$('#outCancelForm #editMode').val('CANCEL');
			$('#outCancelForm #vSeqNo').val($(this).attr('vSeqNo'));
			$('#outCancelForm #title').val($(this).attr('title1'));
			$('#outCancelForm #vItemLoca').val($(this).attr('vItemLoca'));
			

			if (doAjaxPost($('#outCancelForm'))) {
				location.reload();
			}
		});

		$('a.excel-btn').on('click',function(e) {
							e.preventDefault();
							$('#excelDownForm #excelStart').val(
									$('input#search_start_date').val());
							$('#excelDownForm #excelEnd').val(
									$('input#search_end_date').val());
							$('#excelDownForm #excel_type').val('OUT');
							$('#excelDownForm')
									.attr('action',
											'/${homepage.context_path}/intro/search/excelDownload.do');
							$('#excelDownForm').submit();
						});

		$('a.csv-btn').on('click',function(e) {
							e.preventDefault();
							$('#excelDownForm #excelStart').val(
									$('input#search_start_date').val());
							$('#excelDownForm #excelEnd').val(
									$('input#search_end_date').val());
							$('#excelDownForm #excel_type').val('OUT');
							$('#excelDownForm')
									.attr('action',
											'/${homepage.context_path}/intro/search/csvDownload.do');
							$('#excelDownForm').submit();
						});

		$('a#search-btn').on('click', function(e) {
			e.preventDefault();
			$('input#viewPage').val(1);
			doGetLoad('history.do', $('form#searchForm').serialize());
		});

		$('input#search_start_date').datepicker(
				{
					maxDate : $('input#search_end_date').val(),
					onClose : function(selectedDate) {
						$('input#search_end_date').datepicker('option',
								'minDate', selectedDate);
					}
				});
		$('input#search_end_date').datepicker(
				{
					minDate : $('input#search_start_date').val(),
					onClose : function(selectedDate) {
						$('input#search_start_date').datepicker('option',
								'maxDate', selectedDate);
					}
				});

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', parseInt($(this).attr('keyValue')));
			doGetLoad('history.do', serializeCustom($('#outListForm')));
		});

		$('a#board_btn_search').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			doGetLoad('history.do', serializeCustom($('#outListForm')));
		});

	});
</script>

<%-- <c:forEach items="${outList.dsMyLibraryList}" var="i"> --%>
<%-- 	등록번호: ${i.ACSSON_NO} <br> --%>
<%-- 	딸림자료: ${i.ADD_LOAN} <br> --%>
<%-- 	소장처코드: ${i.BOOK_LOCA} <br> --%>
<%-- 	소장처명: ${i.BOOK_LOCA_NAME} <br> --%>
<%-- 	취소사유: ${i.CANCEL_REASON} <br> --%>
<%-- 	대출가능일: ${i.LOAN_POSBL_DATE} <br> --%>	
<%-- 	등록번호 - 디스플레이용: ${i.PRINT_ACSSON_NO} <br> --%>
<%-- 	수령처 소장처코드: ${i.RECPT_LOCA} <br> --%>
<%-- 	수령처 소장처명: ${i.RECPT_LOCA_NAME} <br> --%>
<%-- 	신청일: ${i.REQST_DATE} <br> --%>
<%-- 	신청시간: ${i.REQST_TIME} <br> --%>
<%-- 	열번호: ${i.ROW_ID} <br>c --%>
<%-- 	상호대차 일련번호: ${i.SEQ_NO} <br> --%>
<%-- 	상태변경일: ${i.STATUS_CHANGE_DATE} <br> --%>
<%-- 	상태변경시간: ${i.STATUS_CHANGE_TIME} <br> --%>
<%-- 	상태코드: ${i.STATUS_CODE} <br> --%>
<%-- 	상태: ${i.STATUS_NAME} <br> --%>
<%-- 	서명: ${i.TITLE} <br> --%>
<%-- </c:forEach> --%>

<form:form id="outCancelForm" modelAttribute="librarySearch" action="save.do">
	<form:hidden path="editMode" />
	<form:hidden path="vSeqNo" />
	<form:hidden path="title" />
	<form:hidden path="vItemLoca" />
</form:form>

<form:form id="excelDownForm" modelAttribute="librarySearch"
	action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
	<form:hidden path="excel_type" />
	<form:hidden path="search_start_date" id="excelStart" />
	<form:hidden path="search_end_date" id="excelEnd" />
</form:form>
<div style="float:right; font-size: 14px; margin: 0 7px 7px 0;"><span>총 : ${totalCount} 건</span></div>

<form:form modelAttribute="librarySearch" id="searchForm" method="post" style="clear: both;">
	<div id="libraryList" class="bbs-notice" style="margin-top: 10px; margin-bottom: 10px; padding: 10px 5px; overflow: hidden;">
		<c:choose>
			<c:when test="${homepage.context_path eq 'app'}">
			</c:when>
			<c:otherwise>
				<c:if test="${fn:length(outList.dsMyLibraryList) > 0 }">
					<div class="downBtn" style="float:right;">
						<a class="btn btn2 excel-btn" title="엑셀 저장"><i class="fa fa-file-excel-o"></i>엑셀 저장</a>
						<a class="btn btn2 csv-btn" title="CSV저장"><i class="fa fa-file-excel-o"></i>CSV 저장</a>
					</div>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>
</form:form>

<form:form id="outListForm" modelAttribute="librarySearch" method="GET" onsubmit="return false;">
	<form:hidden path="viewPage" />
	<form:hidden path="menu_idx" />
	<%-- vSeqNo = ${i.SEQ_NO} 버튼에 넣어줍시다.--%>
	<c:if test="${fn:length(outList.dsMyLibraryList) < 1 }">
		<h3>조회된 상호대차내역이 없습니다.</h3>
	</c:if>
	<table summary="상호대차신청내역" class="type1 center">
		<colgroup>
			<col width="40" />
			<col width="240" />
			<col width="75" />
			<col width="75" />
			<col width="80" />
			<col width="73" />
			<col width="50" />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>서명</th>
				<th>제공도서관</th>
				<th>수령도서관</th>
				<th>신청일</th>
				<th>상태</th>
				<th>취소사유</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${outList.dsMyLibraryList}" var="i" varStatus="status">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td>${i.TITLE}</td>
					<td>${i.BOOK_LOCA_NAME}</td>
					<td>${i.RECPT_LOCA_NAME}</td>
					<td>
						<fmt:parseDate value="${i.REQST_DATE}" var="reqst_date" pattern="yyyymmdd" /> <fmt:formatDate value="${reqst_date}" pattern="yyyy-mm-dd"/> <br/> 
						<fmt:parseDate value="${i.REQST_TIME}" var="reqst_time" pattern="HHmmss" /> <fmt:formatDate value="${reqst_time}" pattern="HH:mm"/>
					</td>
					<td>${i.STATUS_NAME} <br/>
						<c:if test="${i.STATUS_CODE eq '0010'}">
							<a href="#" class="btn cancelBtn center" vSeqNo="${i.SEQ_NO}" title1="${i.TITLE}" vItemLoca="${i.BOOK_LOCA}" >취소</a>
						</c:if>
					</td>
					<td>${i.CANCEL_REASON}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="board_paging" class="dataTables_paginate">
		<c:if test="${librarySearch.firstPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${librarySearch.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${librarySearch.prevPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${librarySearch.prevPageNum}">이전</a>
		</c:if>
		<span> <c:forEach var="i" varStatus="status" begin="${librarySearch.startPageNum}" end="${librarySearch.endPageNum}">
				<c:choose>
					<c:when test="${i eq librarySearch.viewPage}">
						<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="" class="paginate_button" keyValue="${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach> <c:if test="${librarySearch.nextPageNum > 0}">
				<a href="" class="paginate_button next" keyValue="${librarySearch.nextPageNum}">다음</a>
			</c:if> <c:if
				test="${librarySearch.totalPageCount ne librarySearch.lastPageNum}">
				<a href="" class="paginate_button next" keyValue="${librarySearch.totalPageCount}">맨끝</a>
			</c:if>
		</span>
	</div>

</form:form>