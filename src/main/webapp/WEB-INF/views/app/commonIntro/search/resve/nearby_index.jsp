<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	$('a.reserveCancel2').on('click', function(e) {
		e.preventDefault();
		if ( confirm("예약 취소 하시겠습니까?") ) {
			$('input#book_key').val($(this).attr('keyValue2'));
			$('input#pk').val($(this).attr('keyValue1'));
			if (doAjaxPost($('form#neighborhoodLibraryCancelForm'))) {
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
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = 'excel_type=RESVE';
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});
});

</script>

<!-- contents-title
<div id="contents-title">
	<h2>현재 예약중인 자료<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
 /contents-title-->
<form id="neighborhoodLibraryCancelForm" action="/${homepage.context_path}/intro/search/resve/nearby_save.do" method="post">
	<input type="hidden" name="book_key" id="book_key"/>
	<input type="hidden" name="pk" id="pk"/>
	<input type="hidden" name="editMode" value="memberCancel"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="reserve_status" value="8"/>
</form> 

<form id="cancelForm" action="save.do" method="post">
	<input type="hidden" name="bookkey" id="bookkey"/>
	<input type="hidden" name="editMode" value="CANCEL"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
</form>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="book-list" style="border-top:none;">
	<div class="excel_btn_box_wrap02">
		<a href="#" id="excel-btn" class="btn excel-btn">리스트 다운로드</a>
	</div>

	<c:if test="${fn:length(resveList) < 1 }"> <h3 style="margin-top:0;">예약중인 도서 내역이 없습니다.</h3></c:if>
	<table summary="신청정보">
		<thead>
			<th style="width:5%">순번</th>
			<th style="width:18%">제목</th>
			<th style="width:15%">저자 / 발행자</th>
			<th style="width:17%">도서관명</th>
			<th style="width:10%">예약일</th>
			<th style="width:8%">예약순위</th>
			<th style="width:10%">예약만기일</th>
			<th style="width:8%">예약형태</th>
			<th style="width:9%">예약취소</th>
		</thead>
		<tbody>
		<c:forEach items="${resveList}" var="i">
					<tr>
						<td>${i.RNUM}</td>
						<td>${i.TITLE_INFO}</td>
						<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
						<td>${i.LIB_NAME}</td>
						<td>${i.RESERVATION_DATE}</td>
						<td>${i.RESERVE_RANK}</td>
						<td>${i.RESERVATION_EXPIRE_DATE }</td>
						<td>
							내집앞도서관예약	
						</td>
						<td>
							<c:if test="${i.UNMANNED_RESERVATION_LOAN eq 'Y'}">
								<c:if test="${i.STATUS eq '3'}">
									<a href="#" class="reserveCancel2" keyValue1="${i.PK}" keyValue2="${i.BOOK_KEY }">예약취소</a>
								</c:if>
							</c:if>									
						</td>						
					</tr>
		</c:forEach>
		<c:if test="${fn:length(resveList) < 1 }">
			<tr>
				<td colspan="9">
					<h2 style="margin-top:0;">예약중인 도서 내역이 없습니다.</h3>
				</td>
			</tr>
		</c:if>
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
</div>


