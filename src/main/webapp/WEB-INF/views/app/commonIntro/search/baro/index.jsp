<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(),
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(),
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a#do-search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		doGetLoad('index.do', $('form#librarySearch').serialize());
	});

	<%-- 페이징 --%>
	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('index.do', param);
	});
	
	$('select#transaction_code').on('change', function(e) {
		doGetLoad('index.do', $('form#librarySearch').serialize());
		e.preventDefault();
	});

});

</script>
<style>
	table td{text-align:center;font-size:14px;}
	table td.left{text-align:left;}
	table th.first, table td.first{border-left-width:1px;}
	table th.last, table td.last{border-right-width:1px;}
</style>

<form id="cancelForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="editMode" value="CANCEL"/>
	<input type="hidden" id="select_no" name="select_no"/>
</form>


<!-- contents-title-->
<c:choose>
<c:when test="${homepage.context_path eq 'dgportal'}">
<p class="txt-box-adv">희망도서 바로대출은 개별 도서관 홈페이지에서 신청가능합니다.</p>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>


<!-- /contents-title-->


<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="librarySearch" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<div class="loan_box02" style="padding:30px;">
	<label for="search_start_date" style="display:none1;"><b>시작일</b></label>
	<form:input path="search_start_date" cssClass="text ui-calendar new_text01" cssStyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/>
	<span style="margin-right:10px;"></span>
	<p class="m_br_box"></p>
	<label for="search_end_date" style="display: none1;"><b>종료일</b></label>
	<form:input path="search_end_date" cssClass="text ui-calendar new_text01" csSstyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/>
	<a id="do-search" class="btn btn1">검색</a>
</div>

<c:if test="${fn:length(hopeList) < 1 }"><div class="book-list" style="border-top:none;"><h3 style="margin-top:0;">희망도서 바로대출 신청 내역이 없습니다.</h3></div></c:if>

<div class="check-btn-box" style="margin:10px 0;">
	<ul>
		<li>
		<form:select path="transaction_code" class="selectmenu new_select_box">
			<form:option value="" label="전체"/>
			<form:option value="0" label="신청"/>
			<form:option value="1" label="신청취소"/>
			<form:option value="2" label="신청거절"/>
			<form:option value="4" label="승인"/>
			<form:option value="5" label="승인취소"/>
			<form:option value="6" label="대출대기"/>
			<form:option value="7" label="대출"/>
			<form:option value="8" label="반납"/>
		</form:select>
		</li>
	</ul>
</div>

<table summary="신청정보">
	<colgroup>
		<col width="5%">
		<col width="*">
		<col width="15%">
		<col width="15%">
		<col width="12%">
		<col width="12%">
		<col width="8%">
		<col width="13%">
	</colgroup>
	<thead>
		<th style="text-align:center;padding:15px 0;">순번</th>
		<th style="text-align:center;padding:15px 0;">서명</th>
		<th style="text-align:center;padding:15px 0;">저자/발행자/<br />출판년도</th>
		<th style="text-align:center;padding:15px 0;">도서관명</th>
		<th style="text-align:center;padding:15px 0;">신청일</th>
		<th style="text-align:center;padding:15px 0;">대출만기일</th>
		<th style="text-align:center;padding:15px 0;">상태</th>
		<th style="text-align:center;padding:15px 0;">사유</th>
	</thead>
	<tbody>
	<c:forEach varStatus="status" items="${hopeList}" var="i">
		<tr>
			<td>${paging.listRowNum - status.index}</td>
			<td class="left;">${i.title}</td>
			<td>${i.author}</td>
			<td>${i.lib_name}</td>
			<td>${i.req_date}</td>
			<td>${i.loan_expiry_date}</td>
			<td>${i.transaction_code_desc}</td>
			<td>
				<c:if test="${i.transaction_code eq '2'}">${i.req_reject_reason}</c:if>
				<c:if test="${i.transaction_code eq '5'}">${i.confirm_cancel_reason}</c:if>
				<c:if test="${i.transaction_code eq '6'}">${i.loan_stand_by_reason}</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

	<div id="board_paging" class="dataTables_paginate">
			<c:if test="${paging.firstPageNum > 0}">
				<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
			</c:if>
			<c:if test="${paging.prevPageNum > 0}">
				<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
			</c:if>
			<span>
				<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
					<c:choose>
						<c:when test="${i eq paging.viewPage}">
							<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="" class="paginate_button" keyValue="${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.nextPageNum > 0}">
					<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
				</c:if>
				<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
					<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
				</c:if>
			</span>
		</div>

</form:form>

