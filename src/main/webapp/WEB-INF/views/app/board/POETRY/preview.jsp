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
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<dl>
				<dt>${board.title}</dt>
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
						<i>작성자</i><span>${user_name}<c:if test="${not empty authMBA and authMBA}">(${board.add_id})</c:if></span>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${board.user_ip ne null and board.user_ip ne ''}">
							<c:set value="${fn:split(board.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${not empty authMBA and authMBA}">
						<i>IP</i><span>${board.user_ip}</span>
								</c:when>
								<c:otherwise>
									<c:if test="${fn:length(user_ip) == 4}">
						<i>IP</i><span>*.*.*.${user_ip[3]}</span>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(board.content, crlf, '<br/>')}
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
		<div class="bbs-comment" id="bbs-comment">

		</div>
		<div class="button bbs-btn center">
		* '미리보기' 기능은 제목과 내용 확인용으로만 제공되며 일반기능은 사용 불가능합니다.
		</div>
<!-- 		<div class="button bbs-btn right"> -->
<!-- 			<a href="javascript:window.close();" class="btn"><i class="fa fa-window-close"></i><span>닫기</span></a> -->
<!-- 		</div> -->
	</div>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>