<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="wrapper-bbs">
	<c:if test="${boardManager.board_add_html_yn eq 'Y'}">
	${boardManager.board_top_add_html}
	</c:if>
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${board.title}</dt>
				<jsp:include page="/WEB-INF/views/app/board/common/view/ebook.jsp" flush="false" />
				<dd class="info">
					<div class="panel-left">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y' and not authMBA}">
						<c:set var="user_name" value="${fn:substring(board.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${board.user_name}"/>
						</c:otherwise>
						</c:choose>
						<i>작성자</i><span>${user_name}<c:if test="${authMBA}">(${board.add_id})</c:if></span>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
					<c:if test="${fn:length(fieldList) > 1}">
					<div class="add-fields">
					<c:forEach var="i" varStatus="status" items="${fieldList}">
					<c:if test="${i.board_column ne 'title' and i.board_column ne 'view_count' and i.board_column ne 'user_name' and i.board_column ne 'add_date'}">
						<i>${i.board_content}</i><span>
						<c:choose>
						<c:when test="${i.board_column eq 'imsi_v_3' or i.board_column eq 'imsi_v_4' or i.board_column eq 'imsi_v_8'}">
							<boardTag:customBidFieldView board_value="${board[i.board_column]}"/>
						</c:when>
						<c:otherwise>
							${board[i.board_column]}
						</c:otherwise>
						</c:choose>
						</span>
					</c:if>
					</c:forEach>
					</div>
					</c:if>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(board.content, crlf, '<br/>')}
			<dl class="share">
				<dt>공유하기</dt>
				<dd>
					<a href="" class="facebook"><i class="fa fa-facebook"></i> <span>페이스북</span></a>
					<a href="" class="twitter"><i class="fa fa-twitter"></i> <span>트위터</span></a>
				</dd>
			</dl>
			<jsp:include page="/WEB-INF/views/app/board/common/view/approval.jsp" flush="false" />
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/view/beforeNext.jsp" flush="false" />
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>