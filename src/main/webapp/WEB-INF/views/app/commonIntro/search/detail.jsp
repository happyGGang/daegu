<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="false" var="iamtester"></c:set>
<c:if test="${	member.web_id eq 'whale8' or
				member.web_id eq 'whale1' or
				member.web_id eq 'whalesoft' or
				member.web_id eq 'publib' or
				member.web_id eq 'namdong11' or
				member.web_id eq 'minsang777' or
				member.web_id eq 'inmypart'
				}">
<c:set value="true" var="iamtester"></c:set>
</c:if>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<style type="text/css">
.graphArea{clear:both;padding:30px 0 20px}
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
.fa-print {color: #4b9adc;font-size: 130%; padding-right: 3px; vertical-align: middle;}

#printDiv {display:none;}

.foldDispalyNone {display:none;}

.showDiv {border-bottom: 3px solid #5f6062;margin-top: 30px;}
.showDiv .showFold {font-size: 15px;font-weight: bold;background: white;border: 3px solid #5f6062;border-bottom: none;padding: 5px 11px;}

.doc-body {min-height:600px!important;}

.resve-req, .close-req {padding: 5px 13px;border: 1px solid #d5d5d5; border-radius: 3px; color: #4c4c4c;}
.resve-req:hover, .close-req:hover {color: #000;}

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
		$('#resveReqForm #vLoca').val($(this).attr('vLoca'));
		$('#resveReqForm #vAccNo').val($(this).attr('vAccNo'));
		$('#resveReqForm #vSubLoca').val($(this).attr('vSubLoca'));
		$('#resveReqForm #vCtrl').val($(this).attr('vCtrl'));

		if ( doAjaxPost($('#resveReqForm')) ) {

		}
	});

	$('a.close-req').on('click', function(e) {
		e.preventDefault();
		if (!confirm('보존서고 신청 하시겠습니까?')) {
			return false;
		}
		$('#closeReqForm #editMode').val('ADD');
		$('#closeReqForm #vLoca').val($(this).attr('vLoca'));
		$('#closeReqForm #vAccNo').val($(this).attr('vAccNo'));
		$('#closeReqForm #vSubLoca').val($(this).attr('vSubLoca'));
		$('#closeReqForm #vCtrl').val($(this).attr('vCtrl'));

		if(doAjaxPost($('#closeReqForm'))) {
			location.reload();
		}
	});

	$('a.pouch-req').on('click', function(e) {
		e.preventDefault();
		if (!confirm('야간대출 신청 하시겠습니까?')) {
			return false;
		}

		$('#pouchReqForm #editMode').val('ADD');
		$('#pouchReqForm #vLoca').val($(this).attr('vLoca'));
		$('#pouchReqForm #vAccNo').val($(this).attr('vAccNo'));
		$('#pouchReqForm #vSubLoca').val($(this).attr('vSubLoca'));

		if ( doAjaxPost($('#pouchReqForm')) ) {

		}
	});

	$('a.out-req').on('click', function(e){
		e.preventDefault();

		$('#outReqForm #editMode').val('ADD');
		$('#outReqForm #vLoca').val($(this).attr('vLoca'));
		$('#outReqForm #vAccNo').val($(this).attr('vAccNo'));
		$('#outReqForm #vSubLoca').val($(this).attr('vSubLoca'));
		$('#outReqForm #title').val($(this).attr('title1'));
		$('#outReqForm #out_check').val($('#hideCheck').val());
		$('#outReqForm #vCtrl').val($(this).attr('vCtrl'));

		$('form#outReqForm').submit();
	});

	$('#checkAll').on('click', function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});


	$('#bookStoreAdd').on('click', function(e) {
		e.preventDefault();

		var count = $('input:checkbox[name=print_param]:checked').length;

		if(Number(count) == 0) {
			alert('책읽는가게 도서신청할 도서를 선택해주세요.');
			return;
		}
		if(Number(count) > 1) {
			alert('책읽는가게 도서신청은 한권만 가능합니다.');
			return;
		}

		$('#storageReqForm').attr('action','/${homepage.context_path}/module/bookStore/save.do');
		$('#item_name').val($('input:checkbox[name=print_param]:checked').val());

		if ( doAjaxPost($('#storageReqForm')) ) {
			location.reload();
			$('#storageReqForm').attr('action','/${homepage.context_path}/module/myStorage/saveItem.do');
		}

	});

	$('a.addStorage').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */

		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=350, height=350");
	});

	$('a.goStorage').on('click', function(e) {
		e.preventDefault();
	});

	$('a.showSlide').on('click', function(e) {
		e.preventDefault();

		var bci = $(this).parents('div.bif').next('div.bci');
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
				$(bci).slideToggle();
			});
		} else {
			$(bci).slideToggle();
		}
	});

	//그래프 관련 (x축 값의 개수에 맞게 width값 자동 계산, 마우스 오버 시 addClass)
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

	$('ul#tagCloud a').on('click', function(e) {
		e.preventDefault();
		$('form#searchForm input#search_text').val($(this).attr('keyValue1'));
		$('form#searchForm').submit();
	});

	<%-- MARC 보기 --%>
	$('a#marcView').on('click', function(e){
		e.preventDefault();
		window.open('marcView.do?vCtrl=${fn:escapeXml(librarySearch.vCtrl)}', 'MARCVIEW', 'width=900,height=700,scrollbars=yes,resizable=yes,location=yes');
	});

	<%-- 접기, 펼치기 --%>
	$('.fold').on('click', function(e){
		e.preventDefault();

		// 해당 부모의 다음 형제 요소
		var $displayTable = $(this).parent().next();

		var browser = navigator.userAgent.toLowerCase();

		var thisHtml = $(this).html().split('&nbsp;');
		/*
		*	fold == on 펼치기
		* 	fold == off 접기
		*/
		if($displayTable.attr('fold') == 'on') {
			$displayTable.removeClass('foldDispalyNone');
			$displayTable.attr('fold', 'off');
			$(this).find('i').attr('class', 'fa fa-angle-down');
			$(this).parent().css('margin-bottom', '0px');
			if($(this).html().substr(0,4) == '권별정보') {
				$displayTable.next().removeClass('foldDispalyNone');
			}
		} else {
			$displayTable.addClass('foldDispalyNone');
			$displayTable.attr('fold', 'on');
			$(this).find('i').attr('class', 'fa fa-angle-up');
			if(thisHtml[0] == '권별정보') {
				$displayTable.next().addClass('foldDispalyNone');
				if('${homepage.homepage_id}' == 'h1') {
					$(this).parent().css('margin-bottom', '50px');
				} else {
					if (browser.indexOf('chrome') != -1){
						$(this).parent().css('margin-bottom', '50px');
					} else if (browser.indexOf('trident') != -1 || browser.indexOf('MSIE') != -1) {
						$(this).parent().css('margin-bottom', '20px');
					}
				}
			} else if(thisHtml[0] == '책소개') {
				$(this).parent().css('margin-bottom', '15px');
			}
		}

	});


	$('a.showFold').on('click', function(e){
		e.preventDefault();

		var $thisToggle = $(this).parent().next();
		var toggleState = $thisToggle.is(':hidden')
		var thisHtml = $(this).html().split('&nbsp;');

		if (toggleState) {
			if(thisHtml[0] == '권별정보' || thisHtml[0] == '책소개' || thisHtml[0] == '목차' || thisHtml[0] == '서평') {
				$(this).children().attr('class', 'fa fa-angle-down');
			} else {
				$(this).text('접기');
				$(this).append('&nbsp;<i class="fa fa-minus"></i>');
			}
			$thisToggle.slideToggle();
		} else {
			if(thisHtml[0] == '권별정보' || thisHtml[0] == '책소개' || thisHtml[0] == '목차' || thisHtml[0] == '서평') {
				$(this).children().attr('class', 'fa fa-angle-up');
			} else {
				$(this).text('더보기');
				$(this).append('&nbsp;<i class="fa fa-plus"></i>');
			}
			$thisToggle.slideToggle();
		}

	});

	// 서지정보 출력시 로고 이미지 경로의 유무 체크
    /* if(!$.UrlExists($('#printLogo').find('img').attr('src'))){
    	if('${homepage.homepage_id} == "h1"'){
    		$('#printLogo').find('img').attr('src', '/resources/homepage/lib/img/logo.png');
    	} else {
    		$('#printLogo').find('img').attr('src', '/resources/homepage/${homepage.context_path}/img/logo.png');
    	}
    } */

    $('div#bookReviewDiv').load('/${homepage.context_path}/module/bookReview/index.do?menu_idx=${fn:escapeXml(librarySearch.menu_idx)}&br_loca=${fn:escapeXml(detail.dsItemDetail[0].LOCA)}&br_ctrlno=${fn:escapeXml(detail.dsItemDetail[0].CTRLNO)}');
});

// 서지정보 출력시 로고 이미지 경로의 유무 체크
/* $.UrlExists = function(url) {
	var http = new XMLHttpRequest();
    http.open('HEAD', url, false);
    http.send();
    return http.status!=404;
} */


function contentPrint(e) {
	this.event.preventDefault();
	var browser = navigator.userAgent.toLowerCase();
    if (browser.indexOf('chrome') != -1){
    	var initBody = document.body.innerHTML;
		$('div#printDiv').printThis({
			pageTitle: "서지정보출력",
			printContainer: false,
			removeInline : true,
			removeInlineSelector : "*",
			loadCSS: "/resources/common/css/bookInfoPrint.css",
		});
    }else if (browser.indexOf('trident') != -1 || browser.indexOf('MSIE') != -1){
    	//window.open(location.href + "&printMode=true");
    	var printContent = document.getElementById('printDiv');
        var windowUrl = '';
        var uniqueName = new Date();
        var windowName = 'Print' + uniqueName.getTime();
        var printWindow = window.open(windowUrl, windowName, 'left=200,top=100,width=700,height=800');
        printWindow.document.write(printContent.innerHTML);
        printWindow.document.close();
        printWindow.focus();
        printWindow.print();
        printWindow.close();
    }
}

</script>

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="editMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${fn:escapeXml(detail.dsItemDetail[0].TITLE)}">
	<input type="hidden" id="author" name="author" value="${fn:escapeXml(detail.dsItemDetail[0].AUTHOR)}">
	<input type="hidden" id="publer" name="publer" value="${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER)}">
	<input type="hidden" id="loca" name="loca" value="${fn:escapeXml(librarySearch.vLoca)}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${fn:escapeXml(librarySearch.vCtrl)}">
	<input type="hidden" id="img_url" name="img_url" value="${fn:escapeXml(librarySearch.vImg)}">
</form>


<form:form id="resveReqForm" modelAttribute="librarySearch" action="resve/save.do">
	<form:hidden path="editMode" htmlEscape="true"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
	<form:hidden path="vCtrl" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
</form:form>

<form:form id="closeReqForm" modelAttribute="librarySearch" action="close/save.do">
	<form:hidden path="editMode" htmlEscape="true"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
	<form:hidden path="vCtrl" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
	<form:hidden path="title" htmlEscape="true" value="${detail.dsItemDetail[0].TITLE}"/>
</form:form>

<form:form id="pouchReqForm" modelAttribute="librarySearch" action="pouch/save.do">
	<form:hidden path="editMode" htmlEscape="true"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
</form:form>

<form:form id="outReqForm" modelAttribute="librarySearch" action="out/edit.do">
	<form:hidden path="editMode" htmlEscape="true"/>
	<form:hidden path="title" htmlEscape="true"/>
	<form:hidden path="vCtrl" htmlEscape="true"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
	<form:hidden path="isbn" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
	<form:hidden path="out_check" htmlEscape="true"/>
	<input type="hidden" name="vImg" value="${fn:escapeXml(librarySearch.vImg)}">
	<input type="hidden" name="tid" value="${fn:escapeXml(librarySearch.tid)}"/>
</form:form>

<form:form id="searchForm" modelAttribute="librarySearch" action="index.do" method="post">
	<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
	<input type="hidden" name="libraryCodes" value="${fn:escapeXml(librarySearch.vLoca)}">
	<form:hidden path="search_text" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
</form:form>

<div class="search-wrap">
	<div class="sview">
		<b class="title">${fn:escapeXml(detail.dsItemDetail[0].TITLE)} / ${fn:escapeXml(detail.dsItemDetail[0].AUTHOR)}</b>
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${librarySearch.vImg eq '' or fn:contains(librarySearch.vImg, 'noimg')}">
				<p class="noImg">
					<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</p>
					</c:when>
					<c:otherwise>
				<p>
					<img src="${fn:escapeXml(librarySearch.vImg)}" alt="${fn:escapeXml(detail.dsItemDetail[0].TITLE)}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<%-- <div class="info">
				<ul>
					<li style="line-height: 150%;">
						<b>${fn:escapeXml(detail.dsItemDetail[0].TITLE)} / ${fn:escapeXml(detail.dsItemDetail[0].AUTHOR)}</b>
					</li>
					<li>${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER)}, ${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER_YEAR)}</li>
					<li>${fn:escapeXml(detail.dsItemDetail[0].LOCA_NAME)} ${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}</li>
					<li>${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}</li>
					<li>${fn:escapeXml(detail.dsItemDetail[0].CALL_NO_D)}</li>
					<li class="ibtn">
<!-- 						<a href="" class="btn">MARC</a> -->
<!-- 						<a href="" class="btn"><span>자세히보기</span><i class="fa fa-sort-down"></i></a> -->
					</li>
				</ul>
			</div> --%>

			<div class="info">
				<ul>
					<li><span class="con">표제/저자사항</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].TITLE)} / ${fn:escapeXml(detail.dsItemDetail[0].AUTHOR)}</span>
					</li>
					<li><span class="con">발행사항</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER)}, ${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER_YEAR)}</span>
					</li>
					<li><span class="con">자료이용하는 곳</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].LOCA_NAME)} ${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}
					</span>
					</li>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<li><span class="con">소장위치</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}
					</span></li>
					</c:if>
					<li><span class="con">청구기호</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].CALL_NO_D)}</span>
					</li>
					<c:if test="${not empty detail.dsItemDetail[0].marc_url}">
					<li><span class="con" style="vertical-align: middle;">전자책 바로보기</span><span class="bar">|</span>
						<a href="${fn:escapeXml(detail.dsItemDetail[0].marc_url)}" class="btn" target="_blank"><span>전자책 바로보기</span></a>
					</li>
					</c:if>
					<li class="ibtn">
<!-- 						<a href="" class="btn">MARC</a> -->
<!-- 						<a href="" class="btn"><span>자세히보기</span><i class="fa fa-sort-down"></i></a> -->
					</li>
				</ul>
			</div>
		</div>

		<div class="botbutton">
			<a href="#" class="blue_s" id="marcView"><img src="/resources/book/search/img/btn_mview.png" alt="MARC 보기">MARC 보기</a>
			<a href="#" class="blue_s" onclick="contentPrint(); return false;"><i class="fa fa-print" aria-hidden="true"></i>서지정보 출력</a>
			<div class="button1">
				<a href="#" class="addStorage orange_s">내보관함 담기</a>
				<!-- <a href="#" class="goStorage orange_s">내보관함 보기</a> -->
			</div>
		</div>


		<h3><a href="#" class="showFold">권별정보&nbsp;<i class="fa fa-angle-down"></i></a></h3>
		<div class="showFoldDiv">
			<table summary="도서 상태 및 등록 정보">
				<thead>
					<tr>
						<c:if test="${homepage.context_path eq 'yd' and member.bookStore}">
						<th><input type="checkbox" id="checkAll"/></th>
						</c:if>
						<th>등록번호</th>
						<th>청구기호</th>
						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<th>자료위치</th>
						</c:if>
						<th>자료상태</th>
						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<th>반납예정일</th>
						<th>예약</th>
						<c:if test="${iamtester}">
						<th>서비스</th>
						</c:if>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:set var="is_reservable" value="false"/>
					<c:forEach items="${detail.dsItemDetail}" var="i" varStatus="status">
					<tr>
						<c:if test="${homepage.context_path eq 'yd' and member.bookStore}">
						<td><input name="print_param" type="checkbox" value="${fn:escapeXml(fn:replace(i.TITLE,',','.'))}_${fn:escapeXml(fn:replace(i.CALL_NO_D,',','.'))}_${fn:escapeXml(fn:replace(i.ACSSON_NO,',','.'))}_${fn:escapeXml(fn:replace(i.AUTHOR,',','.'))}_${fn:escapeXml(fn:replace(i.SUB_LOCA_NAME,',','.'))}"/></td>
						</c:if>

						<td>${fn:escapeXml(i.PRINT_ACSSON_NO)}</td>

						<td class="txt-left" style="text-align:center!important;">${fn:escapeXml(i.CALL_NO_D)}</td>

						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<td class="txt-left" style="text-align:center!important;">${fn:escapeXml(i.SUB_LOCA_NAME)}</td>
						</c:if>

						<td class="og">${fn:escapeXml(librarySearch.vLoca ne '00000001' ? i.DISPLAY_ITEM_STATUS : '대출가능')}</td>

						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<td>${fn:escapeXml(i.RETURN_PLAN_DATE)}</td>
						<td>
							<c:if test="${librarySearch.vLoca ne '00000001'}">
							<c:choose>
							<c:when test="${i.RESVE_CHECK eq 'Y'}">
							<c:set var="is_reservable" value="true"/>
							<a class="resve-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vCtrl="${i.CTRLNO}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}"><i class="fa fa-calendar-check-o"></i>예약하기</a>
							</c:when>
							<c:when test="${is_reservable}">

							</c:when>
							<c:otherwise>
							예약불가
							</c:otherwise>
							</c:choose>
							<c:if test="${member.web_id eq 'whale8' or member.web_id eq 'inmypart'}">
							<a class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">[야간대출신청하기]</a>
							</c:if>
							<c:if test="${not isTodayClosed and homepage.homepage_code eq member.loca and member.login and i.LOAN_FLAG eq '0001' and (i.LOCA eq '00147046' or i.LOCA eq '00147018' or i.LOCA eq '00147014')}">

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
										<c:if test="${member.web_id eq 'whale8' or member.web_id eq 'inmypart'}">
							<a class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">[야간대출신청하기]</a>
										</c:if>
										<c:if test="${member.web_id ne 'whale8'}">
							<a style="display:none" class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">[야간대출신청하기]</a>
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${i.LOCA eq '00147014'}">
									<c:if test="${member.web_id eq 'whale8' or member.web_id eq 'inmypart'}">
							<a class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" s="${startTime}" d3="${dateStr3}" e="${endTime }" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">[야간대출신청하기1]</a>
									</c:if>
									<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime}">
							<a class="pouch-req" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vLoca="${fn:escapeXml(i.LOCA)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}" >[야간대출신청하기]</a>
									</c:if>
								</c:if>
								<c:if test="${i.LOCA eq '00147018'}">
									<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime}">
							<a class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">[야간대출신청하기]</a>
									</c:if>
								</c:if>
							</c:if>
							</c:if>
						</td>
						<c:if test="${iamtester}">
						<td>
							<input type="hidden" id="hideCheck" value="${fn:escapeXml(i.OUT_CHECK)}"/>
							<!--0001 : 대출가능 0002 : 대출중 0003 : 상호대차 처리중 -->
							<c:if test="${fn:escapeXml(i.BOOK_STATE_CODE eq '0001' and i.OUT_CHECK eq 'Y')}">
								<a class="out-req btn" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}" vIsbn="${fn:escapeXml(i.ISBN)}" title1="${fn:escapeXml(detail.dsItemDetail[0].TITLE)}" vCtrl="${i.CTRLNO }"><i class="fa fa-truck"></i>상호대차신청</a>
							</c:if>
							<c:if test="${i.CLOSEDACCESS_CHECK eq 'Y'}">
							<a class="close-req btn" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vCtrl="${i.CTRLNO}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}"><i class="fa fa-calendar-check-o"></i>보존서고신청</a>
							</c:if>
						</td>
						</c:if>
						</c:if>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(detail.dsItemDetail) < 1 }">
					<tr>
						<td colspan="8">조회된 자료가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			<c:choose>
				<c:when test="${librarySearch.vLoca eq '00000001'}">
				</c:when>
				<c:when test="${librarySearch.vLoca eq '00147003' || librarySearch.vLoca eq '00147013' || librarySearch.vLoca eq '00147008'}">
				<%-- 구미, 영일 --%>
			<div style="text-align: right;">* 예약 : 예약 인원이 3명을 초과하면 예약하기 버튼이 활성화가 되지 않습니다.</div>
				</c:when>
				<c:otherwise>
			<div style="text-align: right;">* 예약 : 예약 인원이 5명을 초과하면 예약하기 버튼이 활성화가 되지 않습니다.</div>
				</c:otherwise>
			</c:choose>
			<c:if test="${iamtester}">
			<div style="text-align: right;">* 서비스 : 상호대차 등 서비스 가능한 경우에만 서비스 버튼이 활성화됩니다.</div>
			</c:if>
		</div>
		<div class="sbtn">
			<%-- <a href="" class="btn btn1 addStorage" ><i class="fa fa-cart-arrow-down"></i><span>보관함담기</span></a>
			<a href="" class="btn btn2 goStorage" style="display:none;"><i class="fa fa-shopping-cart"></i><span>보관함보기</span></a>
			<a href="javascript:history.back();" id="goBack" class="btn" style="display: none;"><span>뒤로가기</span></a>
			--%>
			<c:if test="${homepage.context_path eq 'yd' and member.bookStore}">
				<a href="#" id="bookStoreAdd" class="btn btn1"><span>책읽는가게 도서신청</span></a>
			</c:if>
		</div>

		<c:if test="${descIndex.data[0].description ne null and descIndex.data[0].description ne '' and descIndex.data[0].description ne 'null'}">
		<h3><a href="#" class="showFold">책소개&nbsp;<i class="fa fa-angle-down"></i></a></h3>
		<div class="showFoldDiv">
			<table summary="책소개" class="bookintro">
				<tbody>
					<tr>
						<td style="text-align: left;">${fn:escapeXml(descIndex.data[0].description)}</td>
					</tr>
				</tbody>
			</table>
		</div>
		</c:if>

	<c:if test="${descIndex.data[0].index_content ne null and descIndex.data[0].index_content ne '' and descIndex.data[0].index_content ne 'null'}">
		<h3><a href="#" class="showFold">목차 정보&nbsp;<i class="fa fa-angle-down"></i></a></h3>
		<div class="showFoldDiv">
			<div class="listArea">
				${fn:escapeXml(descIndex.data[0].index_content)}
			</div>
		</div>
	</c:if>


		<br/>
		<c:forEach items="${ageChart.data}" var="i" varStatus="status">
			<fmt:parseNumber var="currCount" value="${fn:escapeXml(i.COUNT)}" />
			<c:if test="${status.first}">
				<fmt:parseNumber var="maxCount" value="${fn:escapeXml(i.COUNT)}" />
			</c:if>
			<c:if test="${!status.first}">
				<c:if test="${maxCount < currCount}">
					<fmt:parseNumber var="maxCount" value="${fn:escapeXml(i.COUNT)}" />
				</c:if>
			</c:if>
		</c:forEach>

		<div class="showDiv">
			<a href="#" class="showFold">더보기&nbsp;<i class="fa fa-plus"></i></a>
		</div>

		<div id="showFoldDiv" style="display: none;">
			<h3>연령별 선호도</h3>
			<div id="graph1" class="graphArea">
				<ul class="num" style="display: none;">
					<li><fmt:formatNumber value="${maxCount}" type="number"/></li>
					<li><fmt:formatNumber value="${(maxCount / 6) * 5}" pattern="0"/></li>
					<li><fmt:formatNumber value="${(maxCount / 6) * 4}" pattern="0"/></li>
					<li><fmt:formatNumber value="${(maxCount / 6) * 3}" pattern="0"/></li>
					<li><fmt:formatNumber value="${(maxCount / 6) * 2}" pattern="0"/></li>
					<li><fmt:formatNumber value="${(maxCount / 6) * 1}" pattern="0"/></li>
					<li>0</li>
				</ul>
				<div class="graphWrap">
					<ul class="graph">
						<c:forEach var="i" varStatus="status" items="${ageChart.data}">
							<li>
								<div class="chart-info">
									<div class="barWrap">
										<div class="gauge" style="height:${i.COUNT / maxCount * 100}%;">
											<div class="gauge_ly"><p><em>${fn:escapeXml(i.COUNT)}</em> 명</p></div>
										</div>
									</div>
									<p class="txt">
										${fn:escapeXml(i.GRADE_CODE_NAME)}
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div style="clear:both">&nbsp;</div>
			<br/>

			<c:if test="${fn:length(withBook.data) > 0}">
			<h3>함께 빌려본 다른 도서 추천</h3>
			<div class="smain">
				<div class="box">
					<div id="search-results" class="search-results wide">
					<c:forEach items="${withBook.data}" var="i">
						<div class="row">
							<p class="admin">
							</p>
							<div class="thumb">
								<c:if test="${i.img eq ''}">
								<a vLoca="${fn:escapeXml(i.libCode)}" vCtrl="${fn:escapeXml(i.rec_key)}" vImg="${fn:escapeXml(i.img)}" isbn="${fn:escapeXml(i.isbn)}" tid="${fn:escapeXml(i.tid)}" class="goDetail">
									<img src="/resources/homepage/geic/img/noimg2.png" alt="noImage"/>
									<span>등록된 이미지가<br/>없습니다.</span>
								</a>
								</c:if>
								<c:if test="${i.img ne ''}">
								<a vLoca="${fn:escapeXml(i.libCode)}" vCtrl="${fn:escapeXml(i.rec_key)}" vImg="${fn:escapeXml(i.img)}" isbn="${fn:escapeXml(i.isbn)}" tid="${fn:escapeXml(i.tid)}" class="goDetail"><img src="${fn:escapeXml(i.img)}" alt="cover"/></a>
								</c:if>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<a vLoca="${fn:escapeXml(i.libCode)}" vCtrl="${fn:escapeXml(i.rec_key)}" vImg="${fn:escapeXml(i.img)}" isbn="${fn:escapeXml(i.isbn)}" tid="${fn:escapeXml(i.tid)}" class="name goDetail">${fn:escapeXml(i.title)}</a>
										<span class="txt"><span class="tit">저자: </span>${fn:escapeXml(i.author)}</span><span class="bar">|</span>
										<span class="txt"><span class="tit">발행처: </span>${fn:escapeXml(i.publisher)} ${fn:escapeXml(i.YEAR)}</span><span class="bar">|</span>
										<span class="txt"><span class="tit">자료이용하는 곳: </span>${fn:escapeXml(i.libName)}</span><span class="bar">|</span>
										<span class="txt"><span class="tit">소장위치: </span>${fn:escapeXml(i.placeName)}</span><span class="bar">|</span>
										<span class="txt"><span class="tit">청구기호: </span>${fn:escapeXml(i.callno)}</span>
										<div class="stat">
											<a href="#" class="showSlide" vLoca="${fn:escapeXml(i.libCode)}" vCtrl="${fn:escapeXml(i.rec_key)}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
										</div>
									</div>
									<div class="bci" style="display: none;">
										<!-- ajax_area -->
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
			</div>
			</c:if>

			<c:if test="${fn:length(sameAuthorBookList.dsResult) > 0}">
			<h3>동일 저자 다른 책 정보</h3>
			<table summary="동일 저자 다른 책 정보">
				<colgroup>
					<col/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="5%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th>서명</th>
						<th>저자</th>
						<th>출판사</th>
						<th>청구기호</th>
						<th>출간년도</th>
						<th>소장처</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sameAuthorBookList.dsResult}" var="i" varStatus="status">
					<tr>
						<td class="txt-left">${fn:escapeXml(i.DISP01)}</td>
						<td class="txt-left">${fn:escapeXml(i.DISP02)}</td>
						<td class="txt-left">${fn:escapeXml(i.DISP03)}</td>
						<td>${fn:escapeXml(i.DISP04)}</td>
						<td>${fn:escapeXml(i.DISP06)}</td>
						<td>
							<c:choose>
							<c:when test="${fn:indexOf('00147002', i.DISP07) > -1}">
							고령도서관
							</c:when>
							<c:when test="${fn:indexOf('00147003', i.DISP07) > -1}">
							구미도서관
							</c:when>
							<c:when test="${fn:indexOf('00147004', i.DISP07) > -1}">
							삼국유사군위도서관
							</c:when>
							<c:when test="${fn:indexOf('00147006', i.DISP07) > -1}">
							점촌도서관가은분관
							</c:when>
							<c:when test="${fn:indexOf('00147007', i.DISP07) > -1}">
							봉화도서관
							</c:when>
							<c:when test="${fn:indexOf('00147008', i.DISP07) > -1}">
							상주도서관
							</c:when>
							<c:when test="${fn:indexOf('00147009', i.DISP07) > -1}">
							성주도서관
							</c:when>
							<c:when test="${fn:indexOf('00147010', i.DISP07) > -1}">
							안동도서관
							</c:when>
							<c:when test="${fn:indexOf('00147011', i.DISP07) > -1}">
							안동도서관용상분관
							</c:when>
							<c:when test="${fn:indexOf('00147012', i.DISP07) > -1}">
							영양도서관
							</c:when>
							<c:when test="${fn:indexOf('00147013', i.DISP07) > -1}">
							영일도서관
							</c:when>
							<c:when test="${fn:indexOf('00147014', i.DISP07) > -1}">
							금호도서관
							</c:when>
							<c:when test="${fn:indexOf('00147015', i.DISP07) > -1}">
							예천도서관
							</c:when>
							<c:when test="${fn:indexOf('00147016', i.DISP07) > -1}">
							외동도서관
							</c:when>
							<c:when test="${fn:indexOf('00147017', i.DISP07) > -1}">
							울릉도서관
							</c:when>
							<c:when test="${fn:indexOf('00147018', i.DISP07) > -1}">
							울진도서관
							</c:when>
							<c:when test="${fn:indexOf('00147019', i.DISP07) > -1}">
							의성도서관
							</c:when>
							<c:when test="${fn:indexOf('00147020,00147006', i.DISP07) > -1}">
							점촌도서관
							</c:when>
							<c:when test="${fn:indexOf('00147021', i.DISP07) > -1}">
							청도도서관
							</c:when>
							<c:when test="${fn:indexOf('00147022', i.DISP07) > -1}">
							청송도서관
							</c:when>
							<c:when test="${fn:indexOf('00147023', i.DISP07) > -1}">
							칠곡도서관
							</c:when>
							<c:when test="${fn:indexOf('00147024', i.DISP07) > -1}">
							영주선비도서관풍기분관
							</c:when>
							<c:when test="${fn:indexOf('00147031', i.DISP07) > -1}">
							영덕도서관
							</c:when>
							<c:when test="${fn:indexOf('00147032', i.DISP07) > -1}">
							영주선비도서관
							</c:when>
							<c:when test="${fn:indexOf('00147039', i.DISP07) > -1}">
							안동도서관풍산분관
							</c:when>
							<c:when test="${fn:indexOf('00147040', i.DISP07) > -1}">
							상주도서관화령분관
							</c:when>
							<c:when test="${fn:indexOf('00147046', i.DISP07) > -1}">
							경상북도교육청정보센터
							</c:when>
							<c:when test="${fn:indexOf('00147105', i.DISP07) > -1}">
							경상북도교육청문화원
							</c:when>
							<c:when test="${fn:indexOf('00347034', i.DISP07) > -1}">
							경상북도교육청연수원
							</c:when>
							<c:otherwise>
							${fn:escapeXml(i.DISP07)}
							</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>

			<c:if test="${fn:length(callNoBrowsing.dsCallNoNext) > 0 || fn:length(callNoBrowsing.dsCallNoPrev) > 0}">
			<h3>동일 주제 다른 책 정보</h3>
			<table summary="동일 주제 다른 책 정보">
				<colgroup>
					<col/>
					<col width="20%"/>
					<col width="15%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th>서명</th>
						<th>저자</th>
						<th>등록번호</th>
						<th>청구기호</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${callNoBrowsing.dsCallNoPrev}" var="i" varStatus="status">
					<tr>
						<td class="txt-left">${fn:escapeXml(i.TITLE)}</td>
						<td class="txt-left">${fn:escapeXml(i.AUTHOR)}</td>
						<td class="txt-left">${fn:escapeXml(i.ACSSON_NO)}</td>
						<td class="txt-left">${fn:escapeXml(i.CALL_NO)}</td>
					</tr>
					</c:forEach>
					<c:forEach items="${callNoBrowsing.dsCallNoNext}" var="i" varStatus="statusi">
					<tr>
						<td class="txt-left">${fn:escapeXml(i.TITLE)}</td>
						<td class="txt-left">${fn:escapeXml(i.AUTHOR)}</td>
						<td class="txt-left">${fn:escapeXml(i.ACSSON_NO)}</td>
						<td class="txt-left">${fn:escapeXml(i.CALL_NO)}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<br/>
			<br/>
			</c:if>

			<c:if test="${fn:length(sameBook) > 0}">
			<h3>같은 책 소장정보</h3>
			<table summary="같은 책 소장정보">
				<thead>
					<tr>
						<th>도서관명</th>
						<th>등록번호</th>
						<th>소장위치</th>
						<th>청구기호</th>
						<th>상태</th>
						<th>반납예정일</th>
						<th style="display: none;">예약</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sameBook}" var="j" varStatus="statusj">
						<c:forEach items="${j.dsItemDetail}" var="i" varStatus="status">
					<tr>
						<td>${fn:escapeXml(i.LOCA_NAME)}</td>
						<td>${fn:escapeXml(i.PRINT_ACSSON_NO)}</td>
						<td class="txt-left">${fn:escapeXml(i.SUB_LOCA_NAME)}</td>
						<td class="txt-left">${fn:escapeXml(i.LABEL_PLACE_NO_NAME)} ${fn:escapeXml(i.CALL_NO)}</td>
						<td class="og">${fn:escapeXml(i.DISPLAY_ITEM_STATUS)}</td>
						<td>${fn:escapeXml(i.RETURN_PLAN_DATE)}</td>
					</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
			</table>
			</c:if>

			<c:if test="${fn:length(tagCloud.data) > 0}">
			<h3>태그 클라우드</h3>
			<ul id="tagCloud">
				<c:forEach items="${tagCloud.data}" var="i" varStatus="status">
				<li style="float: left; padding-right: 5px;">
					<a href="#" keyValue="${fn:escapeXml(i.TAG_TYPE)}" keyValue1="${fn:escapeXml(i.TAG)}">#${fn:escapeXml(i.TAG)}</a>
				</li>
				</c:forEach>
			</ul>
			</c:if>

			<c:if test="${fn:length(naverDetail) > 0}">
	<!-- 		<h3>포털 사이트 연동 상세정보</h3> -->
	<!-- 		<h3 style="clear: both;">포털 사이트 연동 상세정보</h3> -->
			<table summary="포털 사이트 연동 상세정보" style="display: none;">
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
						<td style="text-align: left;">${fn:escapeXml(i.author)} </td>
					</tr>
					<tr>
						<th>출판사</th>
						<td style="text-align: left;">${fn:escapeXml(i.publisher)} </td>
					</tr>
					<tr>
						<th>출간일</th>
						<td style="text-align: left;">${fn:escapeXml(i.pubdate)}</td>
					</tr>
					<tr>
						<th>ISBN</th>
						<td style="text-align: left;">${fn:escapeXml(i.isbn)} </td>
					</tr>
					<tr>
						<th>정가</th>
						<td style="text-align: left;">
							<c:if test="${i.price ne ''}">
							${fn:escapeXml(i.price)}
							</c:if>
							<c:if test="${i.price eq ''}">
							절판
							</c:if>
						</td>
					</tr>
					<tr>
						<th>요약</th>
						<td style="text-align: left;">${fn:escapeXml(i.description)} </td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
		</div>

		<h3>서평</h3>
		<div class="showFoldDiv" id="bookReviewDiv">

		</div>
	</div>
</div>

<div id="printDiv">
	<div id="printTitle" style="margin-top: 50px;border: 5px solid #d6d6d6;padding: 10px;border-bottom: 1px solid #d6d6d6;">
		서지정보 출력
	</div>
	<div id="printContent" style="border: 5px solid #d6d6d6;padding: 20px;padding-bottom:0px;;border-top: 1px solid #d6d6d6;">
		<div id="printBookName" style="font-size: 20px;font-weight: bold;margin-top: 10px;margin-bottom: 10px;">
			${fn:escapeXml(detail.dsItemDetail[0].TITLE)}
		</div>
		<table style="border-top: 3px solid black;width: 100%;margin-bottom: 15px;">
			<thead>
				<tr height="50">
					<th style="background: white;border: none;border-bottom: 1px solid #d6d6d6;">표제/저자사항</th>
					<td style="border: none;border-bottom: 1px solid #d6d6d6;">${fn:escapeXml(detail.dsItemDetail[0].TITLE)} / ${fn:escapeXml(detail.dsItemDetail[0].AUTHOR)}</td>
				</tr>
				<tr height="50">
					<th style="background: white;border: none;border-bottom: 1px solid #d6d6d6;">발행사항</th>
					<td style="border: none;border-bottom: 1px solid #d6d6d6;">${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER)}, ${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER_YEAR)}</td>
				</tr>
				<tr height="50">
					<th style="background: white;border: none;border-bottom: 1px solid #d6d6d6;">자료이용하는 곳</th>
					<td style="border: none;border-bottom: 1px solid #d6d6d6;">${fn:escapeXml(detail.dsItemDetail[0].LOCA_NAME)} ${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}</td>
				</tr>
				<tr height="50">
					<th style="background: white;border: none;border-bottom: 1px solid #d6d6d6;">소장위치</th>
					<td style="border: none;border-bottom: 1px solid #d6d6d6;">${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}</td>
				</tr>
				<tr height="50">
					<th style="background: white;border: none;border-bottom: 1px solid #d6d6d6;">청구기호</th>
					<td style="border: none;border-bottom: 1px solid #d6d6d6;">${fn:escapeXml(detail.dsItemDetail[0].CALL_NO_D)}</td>
				</tr>
			</thead>
		</table>
		<%-- <div id="printLogo" style="margin-top: 35px; margin-left: 64%;">
			<img src="/resources/homepage/${homepage.context_path}/img/logo.jpg" alt="${homepage.homepage_name}"/>
		</div> --%>
	</div>
</div>
