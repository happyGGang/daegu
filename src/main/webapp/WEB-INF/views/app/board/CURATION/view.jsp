<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css">

<script type="text/javascript" src="http://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(window).trigger('resize');
$(document).ready(function() {
	$('.graph').each(function(){
		var gN = $(this).children('li').length;
		var gW = 100/gN;
		$(this).children('li').each(function(e){
			$(this).css('width',gW+'%');
			$(this).on('mouseover',function(){
				$(this).addClass('on');
			});
			$(this).on('mouseleave',function(){
				$(this).removeClass('on');
			});
		});

		//가장 큰 수 addClass most
		$(this).find('.gauge').addClass('most');
// 		var gaugeH = $(this).find('.gauge').map(function(){
// 			return $(this).height();
// 		}).get(),
// 		maxH = Math.max.apply(null, gaugeH);
// 		$(this).addClass('a'+maxH);
// 		$(this).find('.gauge').each(function(){
// 			var thisH = $(this).height();
// 			if(thisH == maxH){
// 				$(this).addClass('most');
// 			}
// 		});
	});

	$('a.showSlide').on('click', function(e) {
		e.preventDefault();
		var bci = $(this).parents('div.bif').next('div.bci');
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('/${homepage.context_path}/intro/search/index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
				$(bci).slideToggle();
			});
		} else {
			$(bci).slideToggle();
		}
	});

	$('a.resve-req').on('click', function(e) {
		e.preventDefault();
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		$('#resveReqForm #editMode').val('ADD');
		$('#resveReqForm #vLoca').val($(this).attr('vLoca'));
		$('#resveReqForm #vAccNo').val($(this).attr('vAccNo'));
		$('#resveReqForm #vSubLoca').val($(this).attr('vSubLoca'));
		$('#resveReqForm #vCtrl').val($(this).attr('vCtrl'));

		if ( doAjaxPost($('#resveReqForm')) ) {

		}
	});
	
	$('img.smallImg').on('mouseover', function() {
		var preview_img = $(this).data('idx');
		$('.thumb .largeOne img').attr('src', '/data/board/${board.manage_idx}/${board.board_idx}/'+preview_img);
	});
	
	$('.bx-slider-zone-example').bxSlider({
		mode: 'horizontal',
		auto:false,
		pager: false,
		maxSlides: 4,
		moveSlides: 1,
		slideMargin: 5,
		slideWidth: 41,
		slideHeight: 60
	});
	
	$('.bx-prev, .bx-next').on('click', function() {
		$('img.smallImg').unbind();
		$('img.smallImg').mouseover(function () {
			var preview_img = $(this).data('idx');
			$('.thumb .largeOne img').attr('src', '/data/board/${board.manage_idx}/${board.board_idx}/'+preview_img);
		});
	});
});
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

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="search-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb">
				<div class="largeOne">
				<c:choose>
					<c:when test="${fn:contains(board.preview_img, 'http')}">
				<img src="${board.preview_img}" alt="${board.title}">
					</c:when>
					<c:otherwise>
<%-- 				<img src="/data/board/${board.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}"> --%>
				<img src="/data/board/${board.manage_idx}/${board.board_idx}/${board.preview_img}" alt="${board.title}" title="${board.title}" class="switch"/>
					</c:otherwise>
				</c:choose>
<!-- 				<p class="noImg"> -->
<!-- 					<img src="/resources/common/img/noImg.gif" alt="noImage"/> -->
<!-- 				</p> -->
				</div>
				<div class="smallBox">
					<ul class="bx-slider-zone-example">
						<c:forEach var="i" varStatus="status" items="${imgServerFileNameList}">
							<li class="smallOne"><img src="/data/board/${board.manage_idx}/${board.board_idx}/${i}" class="smallImg" style="cursor:pointer" data-idx="${i}"></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="info">
				<ul>
					<li>
						<b>${board.title}</b>
					</li>
					<li>작성자 : 관리자</li>
					<li>조회 : ${board.view_count}</li>
					<c:if test="${board.imsi_v_1 ne null and board.imsi_v_1 ne '' and board.imsi_v_1 ne '0'}">
					<li>전시기간 : ${board.imsi_v_1}</li>
					</c:if>
					<c:if test="${board.imsi_v_2 ne null and board.imsi_v_2 ne '0'}">
					<li>전시장소 : ${board.imsi_v_2}</li>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="bbs-view-body">
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
			<jsp:include page="/WEB-INF/views/app/board/common/view/approval.jsp" flush="false" />
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
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