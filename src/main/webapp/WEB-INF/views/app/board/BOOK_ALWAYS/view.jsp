<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css">
<style type="text/css">
.graphArea{clear:both;padding:15px 0 20px}
.graphArea ul.num{width:52px;overflow:hidden}
.graphArea ul.num li{text-align:right;padding-right:8px;height:30px;line-height:30px}
.graphArea ul.num,
.graphArea .graphWrap .graph,
.graphArea .graphWrap .graph li,
.graphArea li .barWrap{height:210px;position:relative}
.graphArea ul.num,
.graphArea .graphWrap .graph{border-color:#ccc}
.graphArea .graphWrap{width:100%;float:left;margin-right:-52px}
.graphArea .graphWrap .graph{border:1px solid #ccc;border-right-width:0;border-top-width:0;margin-right:52px;background:url('../img/graphLine.gif') repeat-x}
.graphArea .graphWrap .graph li{float:left;text-align:center}
.graphArea ul.num{float:left;width:52px}
.graphArea ul.num li,
.graphArea *{
-webkit-transition:all 100ms ease;
-moz-transition:all 100ms ease;
-ms-transition:all 100ms ease;
-o-transition:all 100ms ease;
transition:all 100ms ease}
.graphArea li{z-index:9}
.graphArea li.on{z-index:10}
.graphArea li .txt{position:absolute;left:0;width:100%;color:#999;text-align:center;text-decoration:none;padding:5px 0 0;line-height:120%}
.graphArea li .txt:hover,.graphArea li .txt:active,.graphArea li .txt:visited{text-decoration:none}
.graphArea li.most .txt,
.graphArea li.on .txt{color:#000}
.graphArea li .barWrap{padding:0 1px}
.graphArea li .gauge{position:absolute;z-index:11;bottom:0;left:50%;width:70%;margin-left:-35%;background-color:#ccc;cursor:pointer}
.graphArea li .gauge1,
.graphArea li .gauge2{width:25%}
.graphArea li .gauge1{left:35%;margin-left:-15%}
.graphArea li .gauge2{left:25%;margin-left:30%}
.graphArea li .gauge_ly{display:none;position:absolute;z-index:12;top:-28px;height:28px;left:4px;background:url('../img/gauge_ly_line.gif') no-repeat 0 bottom;font-size:85%}
.graphArea li .gauge_ly p{padding:3px 6px 3px 7px;margin-left:5px;color:#fff;white-space:nowrap;display:block;background-color:#666867}
.graphArea li .gauge_ly p em{position:relative;top:1px;margin-right:-3px;font-weight:bold;font-family:arial;font-size:110%}
.graphArea li.on .gauge,
.graphArea li.on .gauge:hover{background-color:#78ac39}
.graphArea li.on .gauge1 .gauge_ly,
.graphArea li.on .gauge2 .gauge_ly{display:none}
.graphArea li.on .gauge_ly,
.graphArea li.on .gauge1:hover .gauge_ly,
.graphArea li.on .gauge2:hover .gauge_ly,
.graphArea li .gauge.most .gauge_ly{display:block}
.graphArea li.on .gauge1,
.graphArea li .gauge1{background-color:#343434}
.graphArea li.on .gauge2,
.graphArea li .gauge2{background-color:#78ac39}
.graphArea li .gauge1:hover{background-color:#5d5d5d!important}
.graphArea li .gauge2:hover{background-color:#93bd61!important}

.graphArea .graphLegend{clear:both;overflow:hidden;padding:35px 0 0;text-align:center}
.graphArea .graphLegend li,
.graphArea .graphLegend i,
.graphArea .graphLegend span{display:inline-block;zoom:1;*display:inline;vertical-align:middle}
.graphArea .graphLegend li{zoom:1;*display:inline;font-size:85%;margin:0 5px}
.graphArea .graphLegend i{font-style:normal;width:12px;height:12px;font-size:0;line-height:0;background-color:#ccc;border-radius:50%}
.graphArea .graphLegend span{margin-left:5px}

.resve-req{padding: 5px 13px;border: 1px solid #d5d5d5;border-radius: 3px;color: #4c4c4c;}
.resve-req:hover {color: #000;}

.bbs-view-header dd.file{padding:9px 15px;background:#f3f3f3}
.bbs-view-header dd.file li{padding:1px 0}
.bbs-view-header dd.file i{font-size:110%}
</style>
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
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>

<div class="search-wrap">
	<div class="sview">
		<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${fn:contains(board.preview_img, 'http')}">
				<img src="${board.preview_img}" alt="${board.title}">
					</c:when>
					<c:otherwise>
				<img src="/data/board/${board.manage_idx}/${boardFile[0].board_idx}/${boardFile[0].server_file_name}" alt="${board.title}">
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