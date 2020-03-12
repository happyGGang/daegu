<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css">
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
</form:form>

<div class="search-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb">
			<c:choose>
				<c:when test="${fn:contains(board.preview_img, 'http')}">
				<img src="${board.preview_img}" alt="${board.title}">
				</c:when>
				<c:otherwise>
				<img src="/data/board/${board.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}">
				</c:otherwise>
			</c:choose>
			</div>
			<div class="info">
				<ul>
					<li>
						<b>${board.title}</b>
					</li>
					<c:if test="${board.imsi_v_3 ne null and board.imsi_v_3 ne '' and board.imsi_v_3 ne '0'}">
					<li>저자 : ${board.imsi_v_3}</li>
					</c:if>
					<c:if test="${board.imsi_v_4 ne null and board.imsi_v_4 ne '' and board.imsi_v_4 ne '0'}">
					<li>출판사 : ${board.imsi_v_4}</li>
					</c:if>
					<c:if test="${board.imsi_v_2 ne null and board.imsi_v_2 ne '0'}">
					<li>출판년도 : ${board.imsi_v_2}</li>
					</c:if>
					<li>
						구분 : 
						<c:forEach items="${category1List}" var="cate1">
							<c:if test="${cate1.code_id eq board.category1}">${cate1.code_name}</c:if>
						</c:forEach>
					</li>
					<li>
						도서관명 : 
						<c:forEach items="${category2List}" var="cate2">
							<c:if test="${cate2.code_id eq board.category2}">${cate2.code_name}</c:if>
						</c:forEach>
					</li>
				</ul>
			</div>
		</div>
		<c:if test="${board.imsi_v_7 ne null and board.imsi_v_7 ne '0'}">
		<div>
			<h4>책 속 한 구절</h4>
			${board.imsi_v_7}
		</div>
		</c:if>
		<div class="bbs-view-body">
			<h4>책 소개</h4>
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
			<jsp:include page="/WEB-INF/views/app/board/common/view/approval.jsp" flush="false" />
		</div>
		<div class="bbs-view-header">
			<dl>
			</dl>
		</div>
		<div style="clear:both">&nbsp;</div>

		<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
	</div>
</div>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>