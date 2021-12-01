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
<p class="txt-box-adv">희망도서는 개별 도서관 홈페이지에서 신청가능합니다.</p>
</c:when>
<c:otherwise>
<!-- <div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 확인 하고 싶으세요?</span></h2>
</div> -->
</c:otherwise>
</c:choose>


<!-- /contents-title-->



<form:form modelAttribute="librarySearch" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>

<c:if test="${fn:length(hopeList) < 1 }"><div class="book-list" style="border-top:none;"><h3 style="margin-top:0;">희망도서신청 내역이 없습니다.</h3></div></c:if>

<div class="check-btn-box" style="margin:10px 0;">
	<ul>
		<li>
		<form:select path="furnish_status" class="selectmenu new_select_box">
			<form:option value="" label="전체"/>
			<form:option value="1" label="신청중"/>
			<form:option value="2" label="처리중"/>
			<form:option value="3" label="소장중"/>
			<form:option value="4" label="취소"/>
		</form:select>
		</li>
		<li><a href="#" id="excel-btn" class="btn excel-btn">리스트 다운로드</a></li>
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
		<col width="7%">
		<col width="13%">
		<col width="5%">
	</colgroup>
	<thead>
		<th style="text-align:center;padding:15px 0;">순번</th>
		<th style="text-align:center;padding:15px 0;">제목</th>
		<th style="text-align:center;padding:15px 0;">저자/발행자/<br />출판년도</th>
		<th style="text-align:center;padding:15px 0;">도서관명</th>
		<th style="text-align:center;padding:15px 0;">신청일</th>
		<th style="text-align:center;padding:15px 0;">처리일</th>
		<th style="text-align:center;padding:15px 0;">상태</th>
		<th style="text-align:center;padding:15px 0;">취소사유</th>
		<th style="text-align:center;padding:15px 0;">취소</th>
	</thead>
	<tbody>
	<c:forEach items="${hopeList}" var="i">
		<tr>
			<td>${i.RNUM}</td>
			<td class="left;">${i.TITLE}</td>
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

</form:form>

