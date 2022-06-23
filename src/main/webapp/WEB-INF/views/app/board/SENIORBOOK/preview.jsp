<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script type="text/javascript">
$(window).trigger('resize');
</script>
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
				<img src="/data/board/${param.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].real_file_name}" alt="${board.title}">
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
					<c:if test="${board.imsi_v_3 ne '' and board.imsi_v_3 ne '0'}">
					<li>저자 : ${board.imsi_v_3}</li>
					</c:if>
					<c:if test="${board.imsi_v_4 ne '' and board.imsi_v_4 ne '0'}">
					<li>출판사 : ${board.imsi_v_4}</li>
					</c:if>
					<c:if test="${board.imsi_v_2 ne null and board.imsi_v_2 ne '0'}">
					<li>출판년도 : ${board.imsi_v_2}</li>
					</c:if>
					<c:if test="${board.imsi_v_7 ne null and board.imsi_v_7 ne '0'}">
					<li>청구기호 : ${board.imsi_v_7}</li>
					</c:if>
				</ul>
			</div>
		</div>
		<div>
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
		</div>
		<div class="button bbs-btn center">
		* '미리보기' 기능은 제목과 내용 확인용으로만 제공되며 일반기능은 사용 불가능합니다.<br/>
		* 책 이미지의 경우 작성페이지에서 미리보기 가능합니다.
		</div>
<!-- 		<div class="button bbs-btn right"> -->
<!-- 			<a href="javascript:window.close();" class="btn"><i class="fa fa-window-close"></i><span>닫기</span></a> -->
<!-- 		</div> -->
	</div>
</div>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>