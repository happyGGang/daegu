<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
	});
	
	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#accessHistory'));
			doGetLoad('index.do', param);
		}
	});
	
	$('a.open_viewer').on('click', function(e) {
		var win = window.open('view.do?book_idx=' + $(this).data('book_idx'), '', 'scrollbars=no,toolbar=no,menubar=no,location=no,width=1000,height=650,location=no');
	});
});

</script>

<form:form id="archiveBookListForm" modelAttribute="archive" action="index.do" >
<form:hidden path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${archiveBookListCount}" pattern="#,###" />건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">20개씩 보기</form:option>
			<form:option value="50">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="150" />
			<col width="" />
			<col width="100">
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th></th>
				<th>서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>청구기호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${archiveBookList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td><img src="/data/archive/${i.book_idx}/${i.server_file_name}" alt="${i.subject}"></td>
					<td><a href="#" class="open_viewer" data-book_idx="${i.book_idx}">${i.subject}</a></td>
					<td>${i.author}</td>
					<td>${i.publisher}</td>
					<td>${i.callnumber}</td>
				</tr>
			</c:forEach>
			<c:if test="${archiveBookListCount eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#archiveBookListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="regnumber">등록번호</form:option>
				<form:option value="callnumber">청구기호</form:option>
				<form:option value="subject">제목</form:option>
				<form:option value="year">발행년도</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<%--

<form:form modelAttribute="accessHistory" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<div class="wrapper-bbs">
	<div class="table-wrap">
		<table class="bbs center" summary="홈페이지 접속기록">
			<caption>홈페이지 접속기록</caption>
			<colgroup>
				<col width="10%">
				<col>
				<col width="20%">
				<col width="12%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="mmm2">도서관</th>
					<th class="mmm2">접속 브라우저</th>
					<th class="mmm1">접속IP</th>
					<th class="mmm2">접속일시</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${accessHistoryList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important num">${i.homepage_name}</td>
					<td class="important num">${i.browser_type} ${i.browser_version}</td>
					<td class="important num">${i.access_ip}</td>
					<td class="important num"><fmt:formatDate value="${i.access_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(accessHistoryList) < 1 }">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">접속 이력이 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>

	<form:hidden path="viewPage"/>
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
	
	<div class="search txt-center mmm2" style="margin-top:25px; display: none;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<label class="blind" for="search_type">검색조건</label>
			<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
				<form:option value="title+content">제목+내용</form:option>
				<form:option value="title">제목</form:option>
				<form:option value="content">내용</form:option>
			</form:select>
			<form:input path="search_text" id="search_text_board" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
			<label for="search_text_board" class="blind">검색어</label>
			<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
		</fieldset>
	</div>
</div>
</form:form>


--%>