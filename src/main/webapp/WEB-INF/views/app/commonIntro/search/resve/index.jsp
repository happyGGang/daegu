<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	$('a.reserveCancel').on('click', function(e) {
		e.preventDefault();
		if ( confirm("예약 취소 하시겠습니까?") ) {
			$('input#bookkey').val($(this).attr('keyValue'));
			if (doAjaxPost($('form#cancelForm'))) {
				location.reload();
			}
		}
	});

	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('index.do', param);
	});
});

</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>현재 예약중인 자료<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form id="cancelForm" action="save.do" method="post">
	<input type="hidden" name="bookkey" id="bookkey">
	<input type="hidden" name="editMode" value="CANCEL">
</form>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
</form:form>

<div class="book-list">
	<c:if test="${fn:length(resveList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:forEach items="${resveList}" var="i">
		<div class="row">
			<div class="box">
				<div class="item">
					<div class="bif">
						<div class="top">
							<div class="b-title">
								<div class="box"><a href="" class="name">${i.TITLE_INFO}</a></div>
							</div>
							<div class="control">
								<c:if test="${i.UNMANNED_RESERVATION_LOAN eq 'N'}">
									<c:if test="${i.STATUS eq '3'}">
									<a href="#" class="btn reserveCancel" keyValue="${i.PK}">예약취소</a>
									</c:if>
								</c:if>
								<c:if test="${i.UNMANNED_RESERVATION_LOAN eq 'Y'}">
									<a href="#" class="btn reserveCancel" keyValue="${i.PK}">예약취소</a>
								</c:if>
								<c:if test="${i.UNMANNED_RESERVATION_LOAN eq 'O'}">
								</c:if>
							</div>
						</div>
						<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLISHER}</em> </p>
					</div>
					<div class="bci">
						<table summary="신청정보">
							<tbody>
							<tr>
								<th>도서관명</th>
								<td>${i.LIB_NAME}</td>
							</tr>
							<tr>
								<th>예약일</th>
								<td>${i.RESERVATION_DATE}</td>
							</tr>
							<tr>
								<th>예약순위</th>
								<td>${i.RESERVE_RANK}</td>
							</tr>
							<tr>
								<th>예약만기일</th>
								<td>${i.RESERVATION_EXPIRE_DATE }</td>
							</tr>
							<tr>
								<th>예약형태</th>
								<td>
								<c:choose>
									<c:when test="${i.UNMANNED_RESERVATION_LOAN eq 'N'}">
									일반예약
									</c:when>
									<c:when test="${i.UNMANNED_RESERVATION_LOAN eq 'Y'}">
									무인예약신청
									</c:when>
									<c:when test="${i.UNMANNED_RESERVATION_LOAN eq 'O'}">
									무인예약대기
									</c:when>
									<c:otherwise>
									일반예약
									</c:otherwise>
								</c:choose>
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
</div>


