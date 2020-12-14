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
});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>지난 대출도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
<c:set var="prefix" value="/intro/${context_path}/search/"></c:set>
<a href="${prefix}loan/index.do" class="bBtn">대출중인도서</a>
<a href="${prefix}loan/history.do" class="bBtn">대출내역조회</a>
<c:if test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks' || context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol' || context_path eq 'junggu' || context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib' || context_path eq 'donggu' || context_path eq 'sincheon' || context_path eq 'donggusm'}">
<a href="${prefix}sangho/index.do" class="bBtn">상호대차신청내역조회</a>
<a href="${prefix}sangho/history.do" class="bBtn">상호대차이용내역조회</a>
</c:if>
<a href="${prefix}resve/index.do" class="bBtn">대출예약조회</a>
<a href="${prefix}hope/index.do" class="bBtn">희망도서신청조회</a>
</div>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>

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
								<tr>
									<th>청구기호</th>
									<td>${i.CALL_NO}</td>
								</tr>
								<tr>
									<th>등록번호</th>
									<td>${i.REG_NO}</td>
								</tr>
								<tr>
									<th>대출일</th>
									<td>${i.LOAN_DATE}</td>
								</tr>
								<tr>
									<th>반납일</th>
									<td>${i.RETURN_DATE}</td>
								</tr>
								<tr>
									<th>상태</th>
									<td>
									<c:if test="${i.STATUS eq '0'}">대출</c:if>
									<c:if test="${i.STATUS eq '1'}">반납</c:if>
									<c:if test="${i.STATUS eq '2'}">반납연기</c:if>
									<c:if test="${i.STATUS eq '3'}">예약</c:if>
									<c:if test="${i.STATUS eq '4'}">예약취소</c:if>
									</td>
								</tr>
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