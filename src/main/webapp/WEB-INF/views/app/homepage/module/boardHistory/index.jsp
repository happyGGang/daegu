<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#boardHistory'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#boardHistory'));
		doGetLoad('index.do', param);
	});
	
	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#boardHistory'));
			doGetLoad('index.do', param);
		}
	});
});

</script>
<c:set var="menu_idx" value="${boardHistory.menu_idx}"></c:set>
<div class="tabmenu">
	<ul> 
		<li${boardHistory.historyType eq 'board' ? ' class="active"' : ''}><a href="index.do?historyType=board&menu_idx=${menu_idx}">게시글(${boardCount})</a></li>
		<li${boardHistory.historyType eq 'reply' ? ' class="active"' : ''}><a href="index.do?historyType=reply&menu_idx=${menu_idx}">댓글(${replyCount})</a></li>
		<li${boardHistory.historyType eq 'elib' ? ' class="active"' : ''}><a href="index.do?historyType=elib&menu_idx=${menu_idx}">서평(${elibCommentCount})</a></li>
	</ul>
</div>


<form:form modelAttribute="boardHistory" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="historyType"/>
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<div class="wrapper-bbs">
	<div class="table-wrap">
		<table class="bbs center" summary="게시물/게시글 현황">
			<caption>게시물/게시글 현황</caption>
			<colgroup>
				<col width="10%">
				<col width="20%">
				<col width="20%">
				<col>
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="mmm2">도서관명</th>
					<c:choose>
					<c:when test="${boardHistory.historyType eq 'elib'}">
					<th class="mmm2">서명</th>
					</c:when>
					<c:otherwise>
					<th class="mmm2">게시판명</th>
					</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${boardHistory.historyType eq 'board'}">
					<th class="important">제목</th>
						</c:when>
						<c:when test="${boardHistory.historyType eq 'reply'}">
					<th class="important">댓글</th>
						</c:when>
						<c:when test="${boardHistory.historyType eq 'elib'}">
					<th class="important">서평</th>
						</c:when>
						<c:otherwise>
					<th class="important">제목</th>
						</c:otherwise>
					</c:choose>
					<th class="important mmm1">작성일</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			
			<c:choose>
				<c:when test="${boardHistory.historyType eq 'board'}">
			<c:forEach var="i" varStatus="status" items="${boardHistoryList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="mmm2"><a href="/${i.imsi_v_18}/index.do">${i.imsi_v_19}</a></td>
					<td class="mmm2"><a href="/${i.imsi_v_18}/board/index.do?manage_idx=${i.manage_idx}&menu_idx=${i.imsi_n_1}">${i.imsi_v_20}</a></td>
					<td class="important left" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<a href="/${i.imsi_v_18}/board/view.do?menu_idx=${i.imsi_n_1}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" target="_blank" title="${i.title}">
							<span title="${i.title}">${i.title}</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="important num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
				</tr>
			</c:forEach>
				</c:when>
				<c:when test="${boardHistory.historyType eq 'reply'}">
			<c:forEach var="i" varStatus="status" items="${boardHistoryList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="mmm2"><a href="/${i.imsi_v_18}/index.do">${i.imsi_v_19}</a></td>
					<td class="mmm2"><a href="/${i.imsi_v_18}/board/index.do?manage_idx=${i.manage_idx}&menu_idx=${i.imsi_n_1}">${i.imsi_v_20}</a></td>
					<td class="important left">
						<a href="/${i.imsi_v_18}/board/view.do?menu_idx=${i.imsi_n_1}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" target="_blank" title="${i.comment_content}">
							<span title="${i.comment_content}">${i.comment_content}</span>
						</a>
					</td>
					<td class="important num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
				</tr>
			</c:forEach>
				</c:when>
				<c:when test="${boardHistory.historyType eq 'elib'}">
			<c:forEach var="i" varStatus="status" items="${boardHistoryList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="mmm2"><a href="/elib/index.do">전자도서관</a></td>
					<td class="mmm2"><a href="/elib/module/elib/book/view.do?menu_idx=${i.menu_idx}&menu=NEW&&type=${i.type}&book_idx=${i.book_idx}">${i.book_name}</a></td>
					<td class="important left">
						<a href="/elib/module/elib/book/view.do?menu_idx=${i.menu_idx}&menu=NEW&&type=${i.type}&book_idx=${i.book_idx}&show_comments=Y" target="_blank" title="새창으로 열기">
							<span title="${i.user_comment}">${i.user_comment}</span>
						</a>
					</td>
					<td class="important num">${i.regdt}</td>
				</tr>
			</c:forEach>
				</c:when>
			</c:choose>
			
			
			</tbody>
		</table>
		<c:if test="${fn:length(boardHistoryList) < 1}">
		<table class="bbs center">
			<tr>
			<c:choose>
				<c:when test="${boardHistory.historyType eq 'board'}">
				<td class="dataEmpty">등록된 게시물이 없습니다.</td>
				</c:when>
				<c:when test="${boardHistory.historyType eq 'reply'}">
				<td class="dataEmpty">등록된 댓글이 없습니다.</td>
				</c:when>
				<c:otherwise>
				<td class="dataEmpty">등록된 글이 없습니다.</td>
				</c:otherwise>
			</c:choose>
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
				<c:choose>
					<c:when test="${boardHistory.historyType eq 'board'}">
				<form:option value="title+content">제목+내용</form:option>
				<form:option value="title">제목</form:option>
				<form:option value="content">내용</form:option>
					</c:when>
					<c:otherwise>
				<form:option value="title">서명</form:option>
				<form:option value="content">서평</form:option>
					</c:otherwise>
				</c:choose>
			</form:select>
			<form:input path="search_text" id="search_text_board" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
			<label for="search_text_board" class="blind">검색어</label>
			<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
		</fieldset>
	</div>
</div>
</form:form>
