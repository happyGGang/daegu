<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<link rel="stylesheet" href="/resources/board/css/qna_board.css" />
<c:if test="${boardManage.manage_idx eq '742'}">
<link rel="stylesheet" href="/resources/board/css/qna_board_02.css" />
</c:if>
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center" summary="질문답변 게시판입니다.">
			<caption>QNA 게시판</caption>
			<colgroup>
<%-- 				<c:if test="${board.delete_yn eq 'Y'}"> --%>
				<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
				<col width="5%">
				</c:if>
				<col/>
				<c:if test="${boardManage.manage_idx eq '742' || boardManage.manage_idx eq '630'}">
					<col class="important mmm2"/>
				</c:if>
				<col class="important"/>
				<col class="important"/>
				<col class="important mmm2"/>
				<col class="mmm1"/>
				<col class="mmm1"/>
				<col class="mmm1"/>
			</colgroup>
			<thead>
				<tr>
			<%--<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th style="width:7%">번호</th>
				<c:if test="${boardManage.manage_idx eq '742' || boardManage.manage_idx eq '630'}">
					<th class="category">도서관</th>
				</c:if>
					<th class="important" >제목</th>
					<th class="important state_wid">처리상태</th>
					<th class="important mmm2" style="width:11%">작성자</th>
					<th class="mmm1" style="width:8%">작성일</th>
					<th class="mmm1" style="width:10%">조회수</th>
					<th class="mmm1" style="width:7%">파일</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td></td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '742' || boardManage.manage_idx eq '630'}">
						<td></td>
					</c:if>
					<td class="num notice"><span>공지</span></td>
					<td class="left important" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>${i.title}</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="important"></td>
					<td class="important mmm2">${i.user_name}</td>
					<td class="num mmm1"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<c:if test="${boardManage.manage_idx eq '742' || boardManage.manage_idx eq '630'}">
						<td class="category important td2">
							<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
						</td>
					</c:if>
					<td class="left important" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>${i.title}</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="important">${i.notice_yn eq 'Y' ? '' : i.request_state_str}</td>
					<c:choose>
					<c:when test="${authMBA or (not empty loginSupport and loginSupport.admin)}">
					<c:set var="user_name" value="${i.user_name}"/>
					</c:when>
					<c:when test="${boardManage.anonymize_yn eq 'Y'}">
					<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
					</c:when>
					<c:otherwise>
					<c:set var="user_name" value="${i.user_name}"/>
					</c:otherwise>
					</c:choose>
					<td class="important mmm2">${i.secret_yn ne 'Y'? user_name : (authMBA or (not empty loginSupport and loginSupport.admin) ? i.user_name : '비공개')}</td>
					<td class="num mmm1"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
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
		<table class="bbs center" summary="질문답변 게시판입니다.">
			<caption>QNA 게시판</caption>
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