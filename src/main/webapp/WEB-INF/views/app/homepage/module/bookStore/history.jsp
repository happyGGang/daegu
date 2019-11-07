<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#bookStore'));
		doGetLoad('history.do', param);
		e.preventDefault();
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#bookStore'));
		doGetLoad('history.do', param);
	});
	
	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#bookStore'));
			doGetLoad('history.do', param);
		}
	});
});

</script>
<c:set var="menu_idx" value="${bookStore.menu_idx}"></c:set>
<form:form modelAttribute="bookStore" action="history.do" method="get" onsubmit="return false;">
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<div class="wrapper-bbs">
	<div class="table-wrap">
		<table class="bbs center" summary="책읽는가게 신청 현황">
			<caption>책읽는가게 신청 현황</caption>
			<colgroup>
				<col width="7%">
				<col width="46%">
				<col width="20%">
				<col width="20%">
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="important">제목</th>
					<th class="mm2">등록번호</th>
					<th class="mm2">청구기호</th>
					<th class="important mmm1">신청일</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${bookStoreList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important left">${i.title}</td>
					<td class="mmm2">${i.regist_num}</td>
					<td class="mmm2">${i.claim_sign}</td>
					<td class="important num">${i.add_date}</td>
				</tr>
			</c:forEach>
		</table>
		<c:if test="${fn:length(bookStoreList) < 1}">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">조회된 자료가 없습니다.</td>
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
	
	<div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<label class="blind" for="search_type">검색조건</label>
			<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
				<form:option value="title">제목</form:option>
			</form:select>
			<form:input path="search_text" id="search_text_board" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
			<label for="search_text_board" class="blind">검색어</label>
			<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
		</fieldset>
	</div>
</div>
</form:form>
