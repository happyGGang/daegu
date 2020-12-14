<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script type="text/javascript">
$(document).ready(function() {
	var $form = $('#board');
	
	<%-- 상세보기 --%>
	$('div.row a').on('click', function(e) {
		e.preventDefault();
		$('#board_idx').val($(this).attr('keyValue'));
		var url = 'view.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	
	$('select#rowCount').on('change', function() {
		var url = 'index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	
});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="infodesk">
	<div class="button btn-group inline">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<span>(페이지 ${paging.viewPage}/${paging.totalPageCount})</span>
	</div>
</div>
<div class="serial-wrap" style="clear: both;">
	<div class="smain">
		<div class="box">
			<div class="search-results">
				<c:forEach var="i" varStatus="status" items="${boardList}">
				<div class="row">
					<div class="thumb">
					<c:choose>
						<c:when test="${i.preview_img ne null}">
						<a href="" keyValue="${i.board_idx}"><img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/></a>
						</c:when>
						<c:otherwise>
						<a href="" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}"></a>
						</c:otherwise>
					</c:choose>
					</div>
					<div class="box">
						<div class="item">
							<div class="bif">
								<a href="" class="name" keyValue="${i.board_idx}">
								${fn:substring(i.title, 0, 30)}<c:if test="${fn:length(i.title) > 30}">...</c:if>
								</a>
								<ul class="con2">
									<li>전시기간 : ${i.imsi_v_1} ~ ${i.imsi_v_2}</li>
									<li>전시장소 : ${fn:substring(i.imsi_v_20, 0, 20)}<c:if test="${fn:length(i.imsi_v_20) > 20}">...</c:if></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				<c:if test="${fn:length(boardList) < 1}">
				<div class="nodata" style="text-align: center;">
					<i class="fa fa-frown-o"></i>
					<p>등록된 데이터가 없습니다.</p>
				</div>
				</c:if>
			</div>
			<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
	
			<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
				<jsp:param name="formId" value="#board"/>
			</jsp:include>
		</div>
	</div>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>

<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">