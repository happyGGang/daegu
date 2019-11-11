<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
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

table a.resve-req{cursor: pointer;}
</style>
<script type="text/javascript" src="http://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function() {
	var ua = window.navigator.userAgent;
	var msie = ua.indexOf("MSIE ");

	if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))  // If Internet Explorer, return version number
	{
// 	    alert(parseInt(ua.substring(msie + 5, ua.indexOf(".", msie))));
	}
	else  // If another browser, return 0
	{
		$('div#printMsg').hide();
		$('a#btn_print').hide();
	}

	$('a.resve-req').on('click', function(e) {
		e.preventDefault();
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		$('#resveReqForm #editMode').val('ADD');
		$('#resveReqForm #bookkey').val($(this).attr('bookkey'));
		$('#resveReqForm #booktype').val($(this).attr('booktype'));

		if ( doAjaxPost($('#resveReqForm')) ) {

		}
	});

	$('a.addBasket').on('click', function(e) {
		e.preventDefault();
		if (!confirm('택배 보관함에  추가 하시겠습니까?')) {
			return false;
		}
		$('#basketReqForm #book_key').val($(this).data('basket'));

		if ( doAjaxPost($('#basketReqForm')) ) {
			if (confirm('보관함에 추가되었습니다. 보관함으로 이동하시겠습니까?')) {
				location.href = '/${homepage.context_path}/intro/search/deliveryBasket/index.do?menu_idx=${deliveryMenuMenuIdx}';
			}
		}
	});

	$('#checkAll').on('click', function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});

	$('a.addStorage').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */

		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=450, height=400");
	});

	$('a.addDelivery').on('click', function(e) {
		e.preventDefault();

	});

	$('a.sangho').on('click', function(e) {
		e.preventDefault();

		<c:if test="${detail.BOOK_STATUS eq '0'}">
		alert('대출중인도서는 상호대차 신청이 불가능합니다.');
		</c:if>
		<c:if test="${detail.BOOK_STATUS ne '0'}">
		$('form#sanghoReqForm').submit();
		</c:if>

	});

	//그래프 관련 (x축 값의 개수에 맞게 width값 자동 계산, 마우스 오버 시 addClass)
	$('.graph').each(function(){
// 		var gN = $(this).children('li').length;
// 		var gW = 100/gN;
// 		$(this).children('li').each(function(e){
// 			$(this).css('width',gW+'%');
// 			$(this).on('mouseover',function(){
// 				$(this).addClass('on');
// 			});
// 			$(this).on('mouseleave',function(){
// 				$(this).removeClass('on');
// 			});
// 		});

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


});

</script>

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="editMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${detail.PUBLISHER}">
	<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${detail.ST_CODE}">
	<input type="hidden" id="img_url" name="img_url" value="${detail.IMAGE}">
</form>


<form:form id="resveReqForm" modelAttribute="librarySearch" action="resve/save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="bookkey"/>
	<form:hidden path="booktype"/>
	<form:hidden path="menu_idx"/>
</form:form>

<form id="basketReqForm" action="/${homepage.context_path}/intro/search/saveDeliveryBasket.do">
	<input type="hidden" id="book_key" name="book_key">
	<input type="hidden" name="editMode" value="ADD">
</form>

<form id="sanghoReqForm" action="/${homepage.context_path}/intro/search/sanghoForm.do" method="post">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
</form>

<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${empty detail.IMAGE}">
				<p class="noImg">
					<img src="/resources/common/img/noImg.gif" alt="noImage"/>
					<span>등록된 이미지가<br/>없습니다.</span>
				</p>
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.IMAGE}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;">
						<b>${detail.TITLE_INFO} / ${detail.AUTHOR}</b>
					</li>
					<li>출판사: ${detail.PUBLISHER}, 발행일자: ${detail.PUB_YEAR}</li>
<%-- 					<li>${detail.LOCA_NAME} ${detail.SUB_LOCA_NAME}</li> --%>
					<li>도서관명/자료실명: ${detail.LIB_NAME}/ ${detail.SHELF_LOC_NAME}</li>
					<li>제어번호: ${detail.MAT_CODE}</li>
<!-- 				<li>청구기호: ${detail.CALL_NO}</li> -->
					<li>ISBN: ${detail.ST_CODE}</li>
					<li>형태사항: ${detail.BOOK_SIZE}</li>
					<li>가격: ${detail.PRICE}</li>
					<li>책소개: ${detail.DESCRIPTION }</li>
					<li class="ibtn">
						<!-- <a href="" class="btn">MARC</a> -->
<!-- 						<a href="" class="btn"><span>자세히보기</span><i class="fa fa-sort-down"></i></a> -->
					</li>
				</ul>
			</div>
		</div>
<!-- 		<h4>소장위치</h4> -->

		<div class="sbtn">
			<!-- MA북구 무료택배  105 어르신, 106 장애인, 107 다문화, 108 다자녀, 109 아가맘,110 임산부, 111 새터민 -->
			<!-- MB중앙 201 장애인, 202 아기맘, 203 다자녀, 204 노인택배, 205 다문화 -->
			 <c:if test="${sessionScope.member.login && sessionScope.member.member_class eq '0'}"> <!--로그인이면서 (0 : 정회원, 1 : 비회원, 2 : 준회원) MA : 북구 , MB 중앙-->
<%-- 				 <c:if test="${(detail.MANAGE_CODE eq 'MA' and detail.MEDIA_CODE eq 'PR' and --%>
<%-- 				 (sessionScope.member.user_class_code eq '105' || --%>
<%-- 				 sessionScope.member.user_class_code eq '106' || sessionScope.member.user_class_code eq '107' || --%>
<%-- 				 sessionScope.member.user_class_code eq '108' || sessionScope.member.user_class_code eq '109' || --%>
<%-- 				 sessionScope.member.user_class_code eq '110' || sessionScope.member.user_class_code eq '111') ) --%>
<%-- 				 or --%>
<%-- 				 (detail.MANAGE_CODE eq 'MB' and (detail.MEDIA_CODE eq 'PR' or detail.MEDIA_CODE eq 'PD') and --%>
<%-- 				 (sessionScope.member.user_class_code eq '201' || --%>
<%-- 				 sessionScope.member.user_class_code eq '202' || sessionScope.member.user_class_code eq '203' || --%>
<%-- 				 sessionScope.member.user_class_code eq '204' || sessionScope.member.user_class_code eq '205' || --%>
<%-- 				 sessionScope.member.user_class_code eq '206')) --%>
<%-- 				 }"> --%>
				 <c:if test="${
				 (
				 (detail.MANAGE_CODE eq 'MA' and detail.MEDIA_CODE eq 'PR') or
				 (detail.MANAGE_CODE eq 'MB' and (detail.MEDIA_CODE eq 'PR' or detail.MEDIA_CODE eq 'PD')) or
				 (detail.MANAGE_CODE eq 'MD' and detail.MEDIA_CODE eq 'PR')
				 )
				 and
				 (sessionScope.member.user_class_code eq '105' ||
				 sessionScope.member.user_class_code eq '106' || sessionScope.member.user_class_code eq '107' ||
				 sessionScope.member.user_class_code eq '108' || sessionScope.member.user_class_code eq '109' ||
				 sessionScope.member.user_class_code eq '110' || sessionScope.member.user_class_code eq '111' ||
				 sessionScope.member.user_class_code eq '201' ||
				 sessionScope.member.user_class_code eq '202' || sessionScope.member.user_class_code eq '203' ||
				 sessionScope.member.user_class_code eq '204' || sessionScope.member.user_class_code eq '205' ||
				 sessionScope.member.user_class_code eq '206' ||
				 sessionScope.member.user_class_code eq '301' ||
				 sessionScope.member.user_class_code eq '302' ||
				 sessionScope.member.user_class_code eq '303')
				 }">
<%-- 					 	<a href="#" class="btn btn2 addBasket" data-basket="${detail.TITLE_INFO}//${detail.AUTHOR}//${detail.PUBLISHER}//${detail.PUB_YEAR}//${detail.LIB_NAME}//${detail.SHELF_LOC_NAME}//${detail.MAT_CODE}//${detail.ST_CODE}//${detail.BOOK_SIZE}//${detail.PRICE}//${detail.BOOK_KEY}//${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}//${detail.MANAGE_CODE}" ><i class="fa fa-archive"></i><span>택배대출 보관함 추가</span></a> --%>
						<c:choose>
					 	<c:when test="${detail.LIB_CODE eq '123007' and (detail.USE_LIMIT_CODE eq 'CD' or detail.USE_LIMIT_CODE eq 'IZ')}">
						</c:when>
						<c:when test="${fn:indexOf(detail.CALL_NO, 'R') > -1}">
						</c:when>
						<c:when test="${detail.RESERVATION_CNT ne '0'}">
						</c:when>
						<c:otherwise>
								<c:if test="${fn:length(detail.RETURN_PLAN_DATE) > 1 }">
								</c:if>
								<c:if test="${fn:length(detail.RETURN_PLAN_DATE) < 1 }">
					 	<a href="#" class="btn btn2 addBasket" data-basket="${detail.TITLE_INFO}//${detail.AUTHOR}//${detail.PUBLISHER}//${detail.PUB_YEAR}//${detail.LIB_NAME}//${detail.SHELF_LOC_NAME}//${detail.MAT_CODE}//${detail.ST_CODE}//${detail.BOOK_SIZE}//${detail.PRICE}//${detail.BOOK_KEY}//${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}//${detail.MANAGE_CODE}" ><i class="fa fa-archive"></i><span>택배대출 보관함 추가</span></a>
<%-- 					 	<a href="deliveryForm.do?manageCode=${detail.MANAGE_CODE}&publish_form_code=${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}&bookkey=${detail.BOOK_KEY}" class="btn btn2" ><i class="fa fa-archive"></i><span>택배대출신청</span></a> --%>
								</c:if>
						</c:otherwise>
						</c:choose>
				 </c:if>
<%--
				<c:choose>
				<c:when test="${detail.RESERVATION_CNT ne '0'}">
				</c:when>
				<c:otherwise>
					<c:if test="${fn:length(detail.RETURN_PLAN_DATE) > 1 }">
					</c:if>
					<c:if test="${fn:length(detail.RETURN_PLAN_DATE) < 1 }">
					<c:choose>
					<c:when test="${(detail.WORKING_STATUS eq 'BOL112N' or detail.WORKING_STATUS eq 'SEL212N')}">
						<c:choose>
							<c:when test="${detail.MANAGE_CODE eq ''}">
							</c:when>
							<c:otherwise>
								<a href="" class="btn btn3 sangho" isbn="${detail.ST_CODE}" manageCode="${detail.MANAGE_CODE}" regNo="${detail.REG_NO}"><span>상호대차 신청</span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					</c:if>
				</c:otherwise>
				</c:choose>
--%>
			 </c:if>
			 <c:if test="${sessionScope.member.member_id eq 'whale1' }">
				 	<a href="#" class="btn btn2 addBasket" data-basket="${detail.TITLE_INFO}//${detail.AUTHOR}//${detail.PUBLISHER}//${detail.PUB_YEAR}//${detail.LIB_NAME}//${detail.SHELF_LOC_NAME}//${detail.MAT_CODE}//${detail.ST_CODE}//${detail.BOOK_SIZE}//${detail.PRICE}//${detail.BOOK_KEY}//${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}//${detail.MANAGE_CODE}" ><i class="fa fa-archive"></i><span>택배대출 보관함 추가</span></a>
			 </c:if>
			<a href="" class="btn btn1 addStorage" target="_blank"><i class="fa fa-cart-arrow-down"></i><span>보관함담기</span></a>
			<a href="/${homepage.context_path}/module/myStorage/index.do?menu_idx=${myStorageMenuIdx}" class="btn btn2 goStorage"><i class="fa fa-shopping-cart"></i><span>보관함보기</span></a>
			<a href="javascript:history.back();" id="goBack" class="btn"><span>뒤로가기</span></a>
		</div>
	</div>
</div>
