<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script type="text/javascript">
	$(function() {
		$(window).resize(function() {
			
			$('.bbs_gallery img').height($('.bbs_gallery img').width() * 0.6);
		}).trigger('resize');

		$('img.previewImg').error(function() {
			var src=  $(this).attr('src');
			$(this).attr('src', src.replace('/thumb', ''));
			$(this).unbind("error").attr("src", src.replace('/thumb', ''));
		});
		
		var homepage_id = $("#homepage_id").val();
		var manage_idx = ${boardManage.manage_idx};		
		if(homepage_id == "h10" && manage_idx == "993"){
			$(document).bind("contextmenu", function (e) {
				e.preventDefault();
				return false;
			});
		}
	});	

</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<input type="hidden" id ="homepage_id" value ="${homepage.homepage_id}"/>
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<ul class="bbs_gallery" id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
			<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
			<li>
				<c:if test="${member.admin or authMBA}">
				<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
				</c:if>
				<div class="thumb">
					<c:choose>
					<c:when test="${i.preview_img ne null}">
						<c:choose>
							<c:when test="${fn:contains(i.preview_img, 'http')}">
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
							<img src="${i.preview_img}" alt="${i.title}"/>
						</a>
							</c:when>
							<c:otherwise>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
							<img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" alt="${i.title}"/>
						</a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}"></a>
					</c:otherwise>
					</c:choose>
				</div>
				<div class="info">
					<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">${i.title}</a>
					<div class="meta">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y'}">
						<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${i.user_name}"/>
						</c:otherwise>
						</c:choose>
						${i.secret_yn ne 'Y'? user_name:'비공개'}
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></abbr>
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatNumber value="${i.view_count}" pattern="#,###"/> </abbr>

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