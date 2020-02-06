<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="board_mode"/>
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center">
			<colgroup>
				<c:if test="${board.delete_yn eq 'Y'}">
				<col width="5%">
				</c:if>
				<col width="10%">
				<col>
				<col width="12%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<c:if test="${board.delete_yn eq 'Y'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th>번호</th>
					<th class="important">제목</th>
					<!-- <th>처리상태</th> -->
					<th class="important mmm2">작성자</th>
					<th class="mmm1">작성일</th>
					<th class="mmm1">파일</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
					<td class="num notice"><span>공지</span></td>
					<td class="important left">
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&viewPage=${board.viewPage}">
							<span>${i.title}</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="important mmm2">${i.user_name}</td>
					<td class="num mmm1"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<c:if test="${board.delete_yn eq 'Y'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important left" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&viewPage=${board.viewPage}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}${i.title}</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="important mmm2">${i.user_name}</td>
					<td class="num mmm1"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(boardList) < 1}">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">등록된 게시물이 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />

	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>