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
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});
	
	$('a#readingNotes').on('click', function(e) {
		e.preventDefault();
		location.href='/${homepage.context_path}/module/readingNotes/edit.do?editMode=ADD&menu_idx=${fn:escapeXml(noteMenuIdx)}&book_name='+encodeURIComponent($(this).data('title'))+'&author='+encodeURIComponent($(this).data('author'))+'&publisher='+encodeURIComponent($(this).data('publisher'))+'&isbn='+$(this).data('isbn');
	});
});
</script>

<!-- contents-title
<div id="contents-title">
	<h2>지난 대출도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
/contents-title-->



<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="manageCode"/>
	<form:hidden path="excel_type" value="HISTORY"/>

	<div class="loan_box02" style="padding:30px;">
		<label for="search_start_date" style="display:none1;"><b>시작일</b></label>
		<form:input path="search_start_date" cssClass="text ui-calendar new_text01" cssStyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/>
		<span style="margin-right:10px;"></span>
		<p class="m_br_box"></p>
		<label for="search_end_date" style="display: none1;"><b>종료일</b></label>
		<form:input path="search_end_date" cssClass="text ui-calendar new_text01" csSstyle="border:1px solid #c9c9c9;border-radius:4px;height:30px"/>
		<a id="do-search" class="btn btn1">검색</a>
	</div>

</form:form>

<!-- <div class='history-wrap'>
	<div class='loan-status'>
		<b>대출 권수 :</b> $ { librarySearch.totalDataCount}<br/>
	</div>
</div> -->

<div class="new_select_box_wrap">
	<select name="manageCode" class="selectmenu new_select_box" id="select_manage">
		<option value="" >전체</option>
		<c:forEach items="${homepageList}" var="mc">
		<c:if test="${not empty mc.manage_code}">
		<c:choose>
			<c:when test="${mc.manage_code eq 'BW'}">
			<option value="${mc.manage_code},BU,BV,BX,BY,BZ,FA,FB,FC,FD,FW,FX,GK" ${librarySearch.manageCode eq 'BW,BU,BV,BX,BY,BZ,FA,FB,FC,FD,FW,FX,GK' ? 'selected' : ''}>${mc.homepage_name}</option>
			</c:when>
			<c:when test="${mc.manage_code eq 'BL'}">
			<option value="${mc.manage_code},BQ,BP,BM,BN,GQ,FU,FZ,FH" ${librarySearch.manageCode eq 'BL,BQ,BP,BM,BN,GQ,FU,FZ,FH' ? 'selected' : ''}>${mc.homepage_name}</option>
			</c:when>
			<c:otherwise>
				<option value="${mc.manage_code}" ${librarySearch.manageCode eq mc.manage_code ? 'selected' : ''}>${mc.homepage_name}</option>
			</c:otherwise>
		</c:choose>
		</c:if>
		</c:forEach>
	</select>
</div>

<div class="excel_btn_box_wrap">
	<a href="#" id="excel-btn" class="btn excel-btn">리스트 다운로드</a>
</div>

<div class="book-list" style="padding-top:10px;">

	<c:if test="${fn:length(loanList) < 1 }"> <h3 style="margin-top:0;">조회된 도서가 없습니다. <span>(대출 권수 : ${librarySearch.totalDataCount})</span></h3></c:if>
	<c:if test="${fn:length(loanList) > 0 }">
	<table summary="신청정보">
		<colgroup>
			<col width="5%"/>
			<col width=""/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="7%"/>
			<c:if test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'gosan' || homepage.context_path eq 'yonghak'}">
			<col width="15%"/>
			</c:if>
		</colgroup>
		<thead>
			<th>순번</th>
			<th>제목 / 등록번호</th>
			<th>저자 / 발행자</th>
			<th>도서관명</th>
			<th>대출일</th>
			<th>반납일</th>
			<th>상태</th>
			<c:if test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'gosan' || homepage.context_path eq 'yonghak'}">
			<th>독서노트</th>
			</c:if>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${homepage.context_path eq 'dgportal'}">
				<c:set var="menuIdx" value="7"/>
			</c:when>
			<c:when test="${homepage.context_path eq '228lib'}">
				<c:set var="menuIdx" value="125"/>
			</c:when>
			<c:when test="${homepage.context_path eq 'dmsl' || homepage.context_path eq 'namdm' || homepage.context_path eq 'namic' || homepage.context_path eq 'dalseolib' || homepage.context_path eq 'dalseonglib' || homepage.context_path eq 'donggu' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj' || homepage.context_path eq 'buktj' || homepage.context_path eq 'buks' || homepage.context_path eq 'beomeo' || homepage.context_path eq 'seogulib' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan' || homepage.context_path eq 'junggu'}">
				<c:set var="menuIdx" value="9"/>
			</c:when>
			<c:otherwise>
				<c:set var="menuIdx" value="13"/>
			</c:otherwise>
		</c:choose>
		<c:forEach items="${loanList}" var="i" varStatus="status">
			<tr>
				<td>${i.RNUM}</td>
				<td><a
						href="https://library.daegu.go.kr/${homepage.context_path}/intro/search/detail.do?menu_idx=${menuIdx}&isbn=${i.ISBN}&regNo
						=${i.REG_NO}&manageCode=${i.MANAGE_CODE}">${i.TITLE}</a><br>(${i.REG_NO})</td>
				<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
				<td>${i.LIB_NAME}</td>
				<td>${i.LOAN_DATE}</td>
				<td>${i.RETURN_DATE}</td>
				<td><c:choose><c:when test="${i.STATUS eq '0'}">대출</c:when><c:when test="${i.STATUS eq '1'}">반납</c:when><c:when test="${i.STATUS eq '2'}">반납연기</c:when><c:when test="${i.STATUS eq '3'}">예약</c:when><c:when test="${i.STATUS eq '4'}">예약취소</c:when><c:otherwise></c:otherwise></c:choose></td>
				<c:if test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'gosan' || homepage.context_path eq 'yonghak'}">
				<td><a href="#" class="btn btn1" id="readingNotes" data-title="${i.TITLE}" data-author="${i.AUTHOR}" data-publisher="${i.PUBLISHER}" data-isbn="${i.ISBN}">독서노트작성</a></td>
				</c:if>
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

	</c:if>
</div>
