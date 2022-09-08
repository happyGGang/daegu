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
});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>

<form:form id="resveReqForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/resve/save.do">
	<form:hidden path="editMode" htmlEscape="true"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
	<form:hidden path="vCtrl" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<div class="search-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${fn:contains(board.preview_img, 'http')}">
						<c:choose>
							<c:when test="${fn:contains(board.preview_img, 'noimg')}">
								<a href="" keyValue="${board.board_idx}">
									<img src="/resources/common/img/noimg-gall.png" alt="${board.title}" title="${board.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
								</a>
							</c:when>
							<c:otherwise>
								<a href="" keyValue="${board.board_idx}">
									<img src="${board.preview_img}" alt="${board.title}" title="${board.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
								</a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${not empty boardFile[0].server_file_name}">
						<img src="/data/board/${board.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}" onError="this.src='/resources/common/img/noimg-gall.png'">
					</c:when>
					<c:otherwise>
						<img src="/resources/common/img/noimg-gall.png" alt="${board.title}" onError="this.src='/resources/common/img/noimg-gall.png'">
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
					<c:if test="${board.imsi_v_3 ne null and board.imsi_v_3 ne '' and board.imsi_v_3 ne '0'}">
					<li>저자 : ${board.imsi_v_3}</li>
					</c:if>
					<c:if test="${board.imsi_v_4 ne null and board.imsi_v_4 ne '' and board.imsi_v_4 ne '0'}">
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
		<div class="bbs-view-header">
			<dl>
			</dl>
		</div>
		<h4 style="display: none;">소장위치</h4>
		<table summary="도서 상태 및 등록 정보" style="display: none;">
			<thead>
				<tr>
					<th>등록번호</th>
					<th>소장위치</th>
					<th>청구기호</th>
					<th>상태</th>
					<th>반납예정일</th>
					<th>예약</th>
<!-- 					<th>기능</th> -->
				</tr>
			</thead>
			<tbody>
				<c:set var="is_any_reservable" value="false"/>
				<c:forEach items="${detail.dsItemDetail}" var="i" varStatus="status">
				<tr>
					<td>${i.PRINT_ACSSON_NO}</td>
					<td class="txt-left">${i.SUB_LOCA_NAME}</td>
					<td class="txt-left">${LABEL_PLACE_NO_NAME} ${i.CALL_NO}</td>
					<td class="og">${i.DISPLAY_ITEM_STATUS}</td>
					<td>${i.RETURN_PLAN_DATE}</td>
					<td>
						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<c:choose>
						<c:when test="${i.RESVE_CHECK eq 'Y'}">
						<c:set var="is_any_reservable" value="true"/>
						<a class="resve-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vCtrl="${i.CTRLNO}"><i class="fa fa-calendar-check-o"></i>예약하기</a>
						</c:when>
						<c:when test="${is_any_reservable}">

						</c:when>
						<c:otherwise>
						예약불가
						</c:otherwise>
						</c:choose>

						<c:if test="${not isTodayClosed and homepage.homepage_code eq member.loca and member.login and i.LOAN_FLAG eq '0001' and (i.LOCA eq '00147046' or i.LOCA eq '00147018')}">
						<jsp:useBean id="toDay" class="java.util.Date"></jsp:useBean>
						<c:set var="startTime" value="09:00:00"></c:set>
						<c:set var="endTime" value="16:00:00"></c:set>
						<fmt:parseDate var="dateStr1" value="${startTime}" pattern="HH:mm:ss"/>
						<fmt:parseDate var="dateStr2" value="${endTime}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="dateStr3" value="${toDay}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="startTime" value="${dateStr1}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="endTime" value="${dateStr2}" pattern="HH:mm:ss"/>
						<c:if test="${i.RESVE_CHECK eq 'Y'}">
						<br/>
						</c:if>
							<c:if test="${i.LOCA eq '00147046'}">
								<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime}">
						<a style="display:none" class="pouch-req" vLoca="${i.LOCA}" vAccNo="${i.ACSSON_NO}">[야간대출신청하기]</a>
								</c:if>
							</c:if>
							<c:if test="${i.LOCA eq '00147018'}">
								<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime}">
						<a class="pouch-req" vLoca="${i.LOCA}" vAccNo="${i.ACSSON_NO}">[야간대출신청하기]</a>
								</c:if>
							</c:if>
						</c:if>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(detail.dsItemDetail) < 1 }">
				<tr>
					<td colspan="7">조회된 자료가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>

		<div style="clear:both">&nbsp;</div>

		<c:if test="${fn:length(naverDetail) > 0}">
		<h4 style="clear: both;">포털 사이트 연동 상세정보</h4>
		<table summary="포털 사이트 연동 상세정보">
			<colgroup>
				<col width="10%"/>
				<col/>
			</colgroup>
			<tbody>
				<c:forEach items="${naverDetail}" var="i" varStatus="status">
				<c:if test="${status.count > 1}">
				<tr>
					<td colspan="2" style="text-align: left;"></td>
				</tr>
				</c:if>
				<tr>
					<th>저자</th>
					<td style="text-align: left;">${i.author} </td>
				</tr>
				<tr>
					<th>출판사</th>
					<td style="text-align: left;">${i.publisher} </td>
				</tr>
				<tr>
					<th>출간일</th>
					<td style="text-align: left;">${i.pubdate}</td>
				</tr>
				<tr>
					<th>ISBN</th>
					<td style="text-align: left;">${i.isbn} </td>
				</tr>
				<tr>
					<th>정가</th>
					<td style="text-align: left;">
						<c:if test="${i.price ne ''}">
						${i.price}
						</c:if>
						<c:if test="${i.price eq ''}">
						절판
						</c:if>
					</td>
				</tr>
				<tr>
					<th>요약</th>
					<td style="text-align: left;">${i.description} </td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
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