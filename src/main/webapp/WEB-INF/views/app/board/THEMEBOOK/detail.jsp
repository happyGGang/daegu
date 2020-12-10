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
<script type="text/javascript">
$(document).ready(function() {
	
	
});
</script>

<script>
function goBack() {
  window.history.back();
}
</script>

<style>
	.thumb{position:relative;float:left;width:160px;margin-right:20px;}
	.thumb img{width:160px;}
	.info{position:relative;float:left;width:790px;}
	.info ul li strong{margin-right:13px;}
</style>

<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />

<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<c:if test="${board.delete_yn eq 'Y'}">
<form:hidden path="boardIdxArray"/>
</c:if>
</form:form>

<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${empty detail.aladin or empty detail.aladin.cover}">
				<p class="noImg">
					<img src="/resources/common/img/noImg2.png" alt="noImage"/>
					<span>등록된 이미지가<br/>없습니다.</span>
				</p>
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">				
				<h3>${detail.TITLE_INFO}</h3>
				<ul class="con">
					<li><strong>저자사항</strong>${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>ISBN : ${detail.ISBN}</li>
					</c:if>
					<li><strong>분류기호</strong>한국십진분류법 : ${detail.CLASS_NO}</li>
				</ul>
			</div>
		</div>
		<div style="clear:both;float:none;"></div>
		<div style="position:relative;width:100%;text-align:center;margin-top:40px;">			
			<a href="#" onclick="goBack()" class="btn btn1"><span>뒤로가기</span></a>
		</div>
	</div>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>