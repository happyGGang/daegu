<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		doGetLoad('history.do', $('form#librarySearch').serialize());
	});

	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('history.do', param);
	});
	
	$('#select_manage').on('change', function() {
		$('#manageCode').val($(this).val());
		$('#viewPage').val(1);
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('history.do', param);
	});
});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>지난 대출도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<fieldset>
	<select name="manageCode" class="selectmenu" id="select_manage">
		<option value="" >전체</option>
		<c:forEach items="${homepageList}" var="mc">
		<c:if test="${not empty mc.manage_code}">
		<option value="${mc.manage_code}" ${librarySearch.manageCode eq mc.manage_code ? 'selected' : ''}>${mc.homepage_name}</option>
		</c:if>
		</c:forEach>
	</select>
</fieldset>

<div>
대출 권수 : ${fn:length(loanList)}<br/>
</div>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="manageCode"/>

	<div class="" style="padding:20px;text-align:center;border:1px solid #eaeaea;border-top:2px solid #000;margin-bottom:10px;">
		<label for="search_start_date" style="display:none1;">시작일</label>
		<form:input path="search_start_date" cssClass="text ui-calendar" cssStyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/> ~
		<label for="search_end_date" style="display: none1;">종료일</label>
		<form:input path="search_end_date" cssClass="text ui-calendar" csSstyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/>
		<a id="do-search" class="btn">검색</a>
	</div>

</form:form>

<div class="book-list">
<c:if test="${fn:length(loanList) < 1 }"> <h3>조회된 도서가 없습니다.</h3></c:if>
	<c:if test="${fn:length(loanList) > 0 }">
		<c:forEach items="${loanList}" var="i" varStatus="status">
		<div class="row">
			<div class="box">
				<div class="item">
					<div class="bif">
						<div class="top">
							<div class="b-title">
								<div class="box">${i.TITLE}</div>
							</div>
						</div>
					</div>
					<div class="bci">
						<table summary="신청정보">
							<tbody>
								<tr>
									<th>대출된 소장처명</th>
									<td>${i.LIB_NAME}</td>
								</tr>
								<!--
								<tr>
									<th>청구기호</th>
									<td>${i.CALL_NO}</td>
								</tr>
								<tr>
									<th>등록번호</th>
									<td>${i.REG_NO}</td>
								</tr>
								-->
								<tr>
									<th>대출일</th>
									<td>${i.LOAN_DATE}</td>
								</tr>
								<tr>
									<th>반납일</th>
									<td>${i.RETURN_DATE}</td>
								</tr>
								<!--
								<tr>
									<th>상태</th>
									<td>${i.STATUS}</td>
								</tr>
								-->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>

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

	</c:if>
</div>