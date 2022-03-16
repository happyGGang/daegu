<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>

<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css">


<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
<c:if test="${board.delete_yn eq 'Y'}">
<form:hidden path="boardIdxArray"/>
</c:if>
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="search-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb" style= "height: 230px;">
				<img src="/data/board/${board.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}" onError="this.src='/resources/common/img/noimg-gall.png'" style="height: 230px;">
		
				<!-- 				<p class="noImg"> -->
				<!-- 					<img src="/resources/common/img/noImg.gif" alt="noImage"/> -->
				<!-- 				</p> -->
			</div>
			<div class="info">
				<ul>
					<li><b>제목 : ${board.title}</b></li>
					<li>작성자 : ${board.user_name}</li>
					<li>작성일 : <fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd" /></li>
					<c:if test="${board.imsi_v_2 ne null and board.imsi_v_2 ne '' and board.imsi_v_2 ne '0'}">
					<li>서명 : ${board.imsi_v_2}</li>
					</c:if>
					<c:if test="${board.imsi_v_3 ne null and board.imsi_v_3 ne '' and board.imsi_v_3 ne '0'}">
					<li>저자 : ${board.imsi_v_3}</li>
					</c:if>
					<c:if test="${board.imsi_v_5 ne null and board.imsi_v_5 ne '' and board.imsi_v_5 ne '0'}">
					<li>출판사 : ${board.imsi_v_5}</li>
					</c:if>
					<c:if test="${board.imsi_v_4 ne null and board.imsi_v_4 ne '' and board.imsi_v_4 ne '0'}">
					<li>등록번호 : ${board.imsi_v_4}</li>
					</c:if>
					<c:if test="${board.imsi_v_6 ne null and board.imsi_v_6 ne '' and board.imsi_v_6 ne '0'}">
					<a href="${board.imsi_v_6}" class="btn view" target="_blank">바로보기</a>
					</c:if>
					<c:if test="${fn:length(boardFile) > 0}">
						<c:forEach var="i" varStatus="status" items="${boardFile}">
									<a href="${getContextPath}/board/boardFile/download/${board.manage_idx}/${i.board_idx}/${i.file_idx}.do" class="btn view" ><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>다운로드</span></a>
						</c:forEach>
					</c:if>
				<c:if test="${board.user_ip ne null and board.user_ip ne ''}">
					<c:set value="${fn:split(board.user_ip, '.')}" var="user_ip"></c:set>
					<c:choose>
						<c:when test="${authMBA}">
							<!-- <i>IP</i><span>${board.user_ip}</span> -->
						</c:when>
						<c:otherwise>
							<c:if test="${fn:length(user_ip) == 4}">
								<!-- <i>IP</i><span>*.*.*.${user_ip[3]}</span> -->
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
		</div>
		<div class="bbs-view-header">
		</div>
		<div class="bbs-comment" id="bbs-comment"></div>
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false"/>
	</div>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
	${boardManage.bottom_html}
</c:if>
