<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	<%-- 희망도서 신청 취소 --%>
	$('a.cancel-btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('취소하시겠습니까?')) {
			$('#select_no').val($(this).attr('keyValue1'));
			if ( doAjaxPost($('#cancelForm')) ) {
				location.reload();
			}
		}
	});

	<%-- 페이징 --%>
	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('index.do', param);
	});
	
	$('select#furnish_status').on('change', function(e) {
		doGetLoad('index.do', $('form#librarySearch').serialize());
		e.preventDefault();
	});
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = 'excel_type=HOPE';
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});

});

</script>
<form id="cancelForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="editMode" value="CANCEL"/>
	<input type="hidden" id="select_no" name="select_no"/>
</form>


<!-- contents-title-->
<c:choose>
<c:when test="${homepage.context_path eq 'dgportal'}">
<p class="txt-box-adv">희망도서는 개별 도서관 홈페이지에서 신청가능합니다.</p>
</c:when>
<c:otherwise>
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 확인 하고 싶으세요?</span></h2>
</div>
</c:otherwise>
</c:choose>


<!-- /contents-title-->

<a href="#" id="excel-btn" class="btn btn2">EXCEL</a>

<form:form modelAttribute="librarySearch" action="index.do" method="get" onsubmit="return false;">
<fieldset>
	<form:select path="furnish_status" class="selectmenu">
		<form:option value="" label="전체"/>
		<form:option value="1" label="신청중"/>
		<form:option value="2" label="처리중"/>
		<form:option value="3" label="소장중"/>
		<form:option value="4" label="취소"/>
	</form:select>
</fieldset>
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<div class="book-list">
	<c:if test="${fn:length(hopeList) < 1 }"> <h3>희망도서신청 내역이 없습니다.</h3></c:if>

<table summary="신청정보">
	<thead>
		<th style="width:6%">순번</th>
		<th style="width:18%">제목</th>
		<th style="width:15%">저자 / 발행자 / 출판년도</th>
		<th style="width:17%">도서관명</th>
		<th style="width:10%">신청일</th>
		<th style="width:10%">처리일</th>
		<th style="width:8%">상태</th>
		<th style="width:8%">취소사유</th>
		<th style="width:8%">취소</th>
	</thead>
	<tbody>


	<c:forEach items="${hopeList}" var="i">
		<tr>
			<td>${i.RNUM}</td>
			<td>${i.TITLE}</td>
			<td>${i.AUTHOR} / ${i.PUBLISHER} / ${i.PUBLISH_YEAR}</td>
			<td>${i.LIB_NAME}</td>
			<td>${i.APPLICANT_DATE}</td>
			<td>${i.FURNISH_DATE}</td>
			<td>
				<c:if test="${i.FURNISH_STATUS eq '1'}">신청</c:if>
				<c:if test="${i.FURNISH_STATUS eq '2'}">처리중</c:if>
				<c:if test="${i.FURNISH_STATUS eq '3'}">비치완료</c:if>
				<c:if test="${i.FURNISH_STATUS eq '4'}">취소</c:if>
			</td>
			<td>${i.CANCEL_REASON}</td>
			<td>
				<c:if test="${i.FURNISH_STATUS eq '1'}">
				<a href="#" class="btn cancel-btn" title="취소" keyValue1="${i.REC_KEY}" >취소</a>
				</c:if>
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
</div>
</form:form>

