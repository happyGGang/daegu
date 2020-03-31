<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
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
<div class="serial-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${fn:contains(board.preview_img, 'http')}">
				<img src="${board.preview_img}" alt="${board.title}">
					</c:when>
					<c:otherwise>
				<img src="/data/board/${param.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}">
					</c:otherwise>
				</c:choose>
<!-- 				<p class="noImg"> -->
<!-- 					<img src="/resources/common/img/noImg.gif" alt="noImage"/> -->
<!-- 				</p> -->
			</div>
			<div class="info">
				<ul>
					<li>
						<b>${board.title}</b>
					</li>
					<c:if test="${board.imsi_v_1 ne ''}">
					<li>상영일시 : ${board.imsi_v_1}
						<c:if test="${board.imsi_v_3 ne '' and board.imsi_v_4 ne ''}">${board.imsi_v_3}:${board.imsi_v_4}</c:if>
					</li>
					</c:if>
					<c:if test="${board.imsi_v_6 ne null and board.imsi_v_6 ne '0'}">
					<li>상영장소 : ${board.imsi_v_6}</li>
					</c:if>
					<c:if test="${board.imsi_v_13 ne null and board.imsi_v_13 ne '0'}">
					<li>상영시간 : ${board.imsi_v_13}(분)</li>
					</c:if>
					<c:if test="${board.imsi_v_7 ne null and board.imsi_v_7 ne '0'}">
					<li>감독 : ${board.imsi_v_7}</li>
					</c:if>
					<c:if test="${board.imsi_v_8 ne null and board.imsi_v_8 ne '0'}">
					<li>출연 : ${board.imsi_v_8}</li>
					</c:if>
					<c:if test="${board.imsi_v_9 ne null and board.imsi_v_9 ne '0'}">
					<li>장르 : ${board.imsi_v_9}</li>
					</c:if>
					<c:if test="${board.imsi_v_12 ne null and board.imsi_v_12 ne '0'}">
					<li>등급 : ${board.imsi_v_12}</li>
					</c:if>
				</ul>
			</div>
		</div>
		<div>
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
		</div>
<!-- 		<div class="sbtn"> -->
<!-- 			<a href="" class="btn"><span>목록으로</span></a> -->
<!-- 		</div> -->
		<div class="bbs-view">
			<div class="bbs-comment" id="bbs-comment">
		
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
	</div>
</div>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>