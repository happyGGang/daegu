<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<div class="infodesk">
		<span class="bbs-result">총 게시물 : <b>${paging.totalDataCount}</b>건</span>
		<div class="button btn-group inline">
			<label for="rowCount" />
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</form:select>
		</div>
	</div>
	
	<div class="table-wrap">
		<ul class="bbs_webzine" id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
			<li>
				<div class="thumb">
				<c:choose>
				<c:when test="${i.preview_img ne null}">
					<a href="" keyValue="${i.board_idx}" style="background:url(/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}) no-repeat center center"></a>
				</c:when>
				<c:otherwise>
					<a href="" keyValue="${i.board_idx}" style="background:url(/resources/common/img/noimage.gif) no-repeat center center"></a>
				</c:otherwise>
				</c:choose>
                </div>
                <div class="list-body">
	                <div class="flexbox">
	                	<a href="" keyValue="${i.board_idx}">
	                		<b>${i.title} <em>${i.view_count}</em></b>
	                	</a>
	                </div>
	                <div class="meta">
						${i.user_name}
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></abbr>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
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