<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#loginLog'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#loginLog'));
		doGetLoad('index.do', param);
	});
	
	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#loginLog'));
			doGetLoad('index.do', param);
		}
	});
});

</script>
<c:set var="menu_idx" value="${loginLog.menu_idx}"></c:set>
<!-- <div class="tabmenu"> -->
<!-- 	<ul>  -->
<%-- 		<li${boardHistory.historyType eq 'board' ? ' class="active"' : ''}><a href="index.do?historyType=board&menu_idx=${menu_idx}">게시글(${boardCount})</a></li> --%>
<%-- 		<li${boardHistory.historyType eq 'reply' ? ' class="active"' : ''}><a href="index.do?historyType=reply&menu_idx=${menu_idx}">댓글(${replyCount})</a></li> --%>
<!-- 	</ul> -->
<!-- </div> -->


<form:form modelAttribute="loginLog" action="index.do" method="get" onsubmit="return false;">
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
				<col width="20%">
				<col width="20%">
				<col width="12%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="mmm2">도서관</th>
					<th class="mmm2">기기</th>
					<th class="mmm2">운영체제</th>
					<th class="mmm2">브라우저</th>
					<th class="mmm1">IP</th>
					<th class="mmm2">일시</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${loginLogList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important num">${i.homepage_name}</td>
					<td class="important num">${i.category}</td>
					<td class="important num">${i.os}</td>
					<td class="important num">${i.browser}</td>
					<td class="important num">${i.ip}</td>
					<td class="important num">${i.login_date}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(loginLogList) < 1 }">
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
</div>
</form:form>
