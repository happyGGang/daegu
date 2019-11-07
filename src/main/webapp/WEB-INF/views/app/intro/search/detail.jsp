<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
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
		$('#resveReqForm #vCtrl').val($(this).attr('vCtrl'));

		if ( doAjaxPost($('#resveReqForm')) ) {

		}
	});

	$('#btn_print').on('click', function(e) {
		e.preventDefault();
		var checkList = $('input[name="print_param"]:checked').clone();

		if ( checkList.length < 1 ) {
			alert("인쇄할 도서를 선택해주세요.");
			return false;
		}

		$('#printForm').append(checkList);
		var param = $('#printForm').serialize();

		jQuery.post('print.do',param,function(arg) {
			$("#print_iframe").contents().find("body").html(arg);
			frames["print_iframe"].focus();

			IEPageSetupX.header="";
			IEPageSetupX.footer="";
			IEPageSetupX.leftMargin=0;
			IEPageSetupX.rightMargin=1.5;
			IEPageSetupX.Orientation = 1.0;
	        IEPageSetupX.PrintBackground = false;
	        IEPageSetupX.topMargin=0.0;
	        IEPageSetupX.bottomMargin=1.0;
			//IEPageSetupX.Clear=true;
			IEPageSetupX.Print(false);//설정

			var loadingImg = '';

	        loadingImg += "<div id='loadingImg' style='position:relative; left:15%; top:0%; display:none; z-index:10000;'>";
	        loadingImg += " <font color='#FF0033' size='5' ><strong>선택한 내용을 인쇄처리중입니다.  잠시만 기다려주세요.</strong></font>";
	        loadingImg += "</div>";

	        $("#print_div").html(loadingImg);
	        //로딩중 이미지 표시
	        $('#loadingImg').show().delay(3000).fadeOut();
	        $('#printForm input:checkbox').remove();
	        $('input:checkbox').prop('checked', false);
		});
	});

	$('#checkAll').on('click', function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
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
	$('a.sub-qrcode').click();
	$('div#callNoDiv').load('callNoBrowsing.do?vCtrl=${fn:escapeXml(param.vCtrl)}');

	$('ul#tagCloud a').on('click', function(e) {
		e.preventDefault();
		$('form#searchForm input#search_text').val($(this).attr('keyValue1'));
		$('form#searchForm').submit();
	});
});

</script>
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
</style>
<form:form id="resveReqForm" modelAttribute="librarySearch" action="resve/save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vAccNo"/>
	<form:hidden path="vCtrl" htmlEscape="true"/>
</form:form>

<form:form id="searchForm" modelAttribute="librarySearch" action="index.do" method="post">
	<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
	<input type="hidden" name="libraryCodes" value="${fn:escapeXml(librarySearch.vLoca)}">
	<form:hidden path="search_text"/>
	<form:hidden path="menu_idx"/>
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
					<li><span class="con2">발행사항</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER)}, ${fn:escapeXml(detail.dsItemDetail[0].PUBLISHER_YEAR)}</span>
					</li>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<li><span class="con2">소장위치</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].SUB_LOCA_NAME)}
					</span></li>
					</c:if>
					<li><span class="con2">청구기호</span><span class="bar">|</span>
						<span class="txt">${fn:escapeXml(detail.dsItemDetail[0].CALL_NO_D)}</span>
					</li>
				</ul>
			</div>
			
		</div>
		<h4>소장위치</h4>
		<table summary="도서 상태 및 등록 정보">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkAll"/></th>
					<th>등록번호</th>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<th>소장위치</th>
					<th>서가명</th>
					</c:if>
					<th>청구기호</th>
					<th>상태</th>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<th>반납예정일</th>
					<th>예약</th>
<!-- 					<th>기능</th> -->
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${detail.dsItemDetail}" var="i" varStatus="status">
				<tr>
					<td>
						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<c:if test="${i.DISPLAY_ITEM_STATUS ne '대출중' and i.DISPLAY_ITEM_STATUS ne '파오손' and i.DISPLAY_ITEM_STATUS ne '정리중' and i.DISPLAY_ITEM_STATUS ne '예약서가비치' and i.DISPLAY_ITEM_STATUS ne '희망도서 대출대기'}">
						<input name="print_param" type="checkbox" value="${fn:replace(fn:escapeXml(i.TITLE),',','.')}_${fn:replace(fn:escapeXml(i.CALL_NO),',','.')}_${fn:replace(fn:escapeXml(i.ACSSON_NO),',','.')}_${fn:replace(fn:escapeXml(i.AUTHOR),',','.')}_${fn:replace(fn:escapeXml(i.SUB_LOCA_NAME),',','.')}_${fn:replace(fn:escapeXml(i.PUBLISHER),',','.')}_${fn:replace(fn:escapeXml(i.PLACE_NO),',','.')}_${fn:replace(fn:escapeXml(i.BOOKSH_NAME),',','.')}"/>
						</c:if>
						</c:if>
					</td>
					<td>${fn:escapeXml(i.PRINT_ACSSON_NO)}</td>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<td class="txt-left">${fn:escapeXml(i.SUB_LOCA_NAME)}</td>
					<td class="txt-left">${fn:escapeXml(i.BOOKSH_NAME)}</td>
					</c:if>
					<td class="txt-left">${fn:escapeXml(i.LABEL_PLACE_NO_NAME)} ${fn:escapeXml(i.CALL_NO)}</td>
					<td class="og">${fn:escapeXml(librarySearch.vLoca ne '00000001' ? i.DISPLAY_ITEM_STATUS : '대출가능')}</td>
					<c:if test="${librarySearch.vLoca ne '00000001'}">
					<td>${fn:escapeXml(i.RETURN_PLAN_DATE)}</td>
					<td>
						<c:if test="${librarySearch.vLoca ne '00000001'}">
						<c:if test="${i.RESVE_CHECK eq 'Y'}">
						<a class="resve-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}">예약하기</a>
						</c:if>
						</c:if>
					</td>
					</c:if>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(detail.dsItemDetail) < 1 }">
				<tr>
					<td colspan="7">조회된 자료가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		
		<c:choose>
			<c:when test="${librarySearch.vLoca eq '00147003' || librarySearch.vLoca eq '00147013'}">
			<%-- 구미, 영일 --%>
		<div style="text-align: right;">* 예약 인원이 3명을 초과하면 예약하기 버튼이 활성화가 되지 않습니다.</div>
			</c:when>
			<c:otherwise>
		<div style="text-align: right;">* 예약 인원이 5명을 초과하면 예약하기 버튼이 활성화가 되지 않습니다.</div>
			</c:otherwise>
		</c:choose>
		<div class="sbtn">
			<a href="" class="btn btn1" style="display: none;"><i class="fa fa-cart-arrow-down"></i><span>보관함담기</span></a>
			<a href="" class="btn btn2" style="display: none;"><i class="fa fa-shopping-cart"></i><span>보관함보기</span></a>
			<a href="javascript:history.back();" id="goBack" class="btn"><span>뒤로가기</span></a>
			<c:if test="${fn:length(detail.dsItemDetail) > 0}">
				<a href="#" id="btn_print" class="btn btn2" style="background-color: #266ac4; border-color: #1557af; color: #fff;">청구기호 인쇄</a>
			</c:if>
		</div>

		<c:if test="${descIndex.data[0].description ne null and descIndex.data[0].description ne '' and descIndex.data[0].description ne 'null'}">
		<h4>서평 정보</h4>
		<table summary="서평 정보" class="bookintro">
			<tbody>
				<tr>
					<td style="text-align: left;">${fn:escapeXml(descIndex.data[0].description)}</td>
				</tr>
			</tbody>
		</table>
		</c:if>

		<c:if test="${descIndex.data[0].index_content ne null and descIndex.data[0].index_content ne '' and descIndex.data[0].index_content ne 'null'}">
		<h4>목차 정보</h4>
		<div class="listArea">
			${fn:escapeXml(descIndex.data[0].index_content)}
		</div>
		</c:if>

		<br/>
		<c:forEach items="${ageChart.data}" var="i" varStatus="status">
			<fmt:parseNumber var="currCount" value="${i.COUNT}" />
			<c:if test="${status.first}">
				<fmt:parseNumber var="maxCount" value="${i.COUNT}" />
			</c:if>
			<c:if test="${!status.first}">
				<c:if test="${maxCount < currCount}">
					<fmt:parseNumber var="maxCount" value="${i.COUNT}" />
				</c:if>
			</c:if>
		</c:forEach>
		<h4>연령별 선호도</h4>
		<div id="graph1" class="graphArea">
			<ul class="num" style="display: none;">
				<li><fmt:formatNumber value="${ageChart.data[0].COUNT}" type="number"/></li>
				<li><fmt:formatNumber value="${(ageChart.data[0].COUNT / 6) * 5}" pattern="0"/></li>
				<li><fmt:formatNumber value="${(ageChart.data[0].COUNT / 6) * 4}" pattern="0"/></li>
				<li><fmt:formatNumber value="${(ageChart.data[0].COUNT / 6) * 3}" pattern="0"/></li>
				<li><fmt:formatNumber value="${(ageChart.data[0].COUNT / 6) * 2}" pattern="0"/></li>
				<li><fmt:formatNumber value="${(ageChart.data[0].COUNT / 6) * 1}" pattern="0"/></li>
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
		<h4>함께 빌려본 다른 도서 추천</h4>
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
									<p>${fn:escapeXml(i.author)}</p>
									<p>${fn:escapeXml(i.publisher)} ${fn:escapeXml(i.YEAR)}</p>
									<p>${fn:escapeXml(i.libName)}</p>
									<div class="stat">
										<a href="#" class="showSlide" vLoca="${fn:escapeXml(i.libCode)}" vCtrl="${fn:escapeXml(i.rec_key)}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
										<span><b>${fn:escapeXml(i.placeName)}</b> [${fn:escapeXml(i.callno)}]</span>
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

		<div id="callNoDiv">
		</div>

		<c:if test="${fn:length(sameBook) > 0}">
		<h4>같은 책 소장정보</h4>
		<table summary="같은 책 소장정보">
			<thead>
				<tr>
					<th>도서관명</th>
					<th>등록번호</th>
					<th>소장위치</th>
					<th>서가명</th>
					<th>청구기호</th>
					<th>상태</th>
					<th>반납예정일</th>
					<th style="display: none;">예약</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="is_reservable" value="false"/>
				<c:forEach items="${sameBook}" var="j" varStatus="statusj">
					<c:forEach items="${j.dsItemDetail}" var="i" varStatus="status">

				<tr>
					<td>${fn:escapeXml(i.LOCA_NAME)}</td>
					<td>${fn:escapeXml(i.PRINT_ACSSON_NO)}</td>
					<td class="txt-left">${fn:escapeXml(i.SUB_LOCA_NAME)}</td>
					<td class="txt-left">${fn:escapeXml(i.BOOKSH_NAME)}</td>
					<td class="txt-left">${fn:escapeXml(i.LABEL_PLACE_NO_NAME)} ${fn:escapeXml(i.CALL_NO)}</td>
					<td class="og">${fn:escapeXml(i.DISPLAY_ITEM_STATUS)}</td>
					<td>${fn:escapeXml(i.RETURN_PLAN_DATE)}</td>
					<td style="display: none;">
						<c:choose>
						<c:when test="${i.RESVE_CHECK eq 'Y'}">
						<c:set var="is_reservable" value="true"/>
						<a class="resve-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}" vCtrl="${i.CTRLNO}"><i class="fa fa-calendar-check-o"></i>예약하기</a>
						</c:when>
						<c:when test="${is_reservable}">
						
						</c:when>
						<c:otherwise>
						예약불가
						</c:otherwise>
						</c:choose>
						<c:if test="${not isTodayClosed and homepage.homepage_code eq member.loca and member.login and i.LOAN_FLAG eq '0001' and (i.LOCA eq '00147046' or i.LOCA eq '00147018')}">
						<jsp:useBean id="toDay1" class="java.util.Date"></jsp:useBean>
						<c:set var="startTime1" value="09:00:00"></c:set>
						<c:set var="endTime1" value="16:00:00"></c:set>
						<fmt:parseDate var="dateStr11" value="${startTime1}" pattern="HH:mm:ss"/>
						<fmt:parseDate var="dateStr21" value="${endTime1}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="dateStr31" value="${toDay1}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="startTime1" value="${dateStr11}" pattern="HH:mm:ss"/>
						<fmt:formatDate var="endTime1" value="${dateStr21}" pattern="HH:mm:ss"/>
						<c:if test="${i.RESVE_CHECK eq 'Y'}">
						<br/>
						</c:if>
							<c:if test="${i.LOCA eq '00147046'}">
								<c:if test="${startTime1 <= dateStr31 and dateStr31 <= endTime1}">
						<a style="display:none" class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}">[야간대출신청하기]</a>
								</c:if>
							</c:if>
							<c:if test="${i.LOCA eq '00147018'}">
								<c:if test="${startTime1 <= dateStr31 and dateStr31 <= endTime1}">
						<a class="pouch-req" vLoca="${fn:escapeXml(i.LOCA)}" vAccNo="${fn:escapeXml(i.ACSSON_NO)}">[야간대출신청하기]</a>
								</c:if>
							</c:if>
						</c:if>
					</td>
				</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table>
		</c:if>

		<c:if test="${fn:length(tagCloud.data) > 0}">
		<h4>태그 클라우드</h4>
		<ul id="tagCloud">
			<c:forEach items="${tagCloud.data}" var="i" varStatus="status">
			<li style="float: left; padding-right: 5px;">
				<a href="#" keyValue="${fn:escapeXml(i.TAG_TYPE)}" keyValue1="${fn:escapeXml(i.TAG)}">#${fn:escapeXml(i.TAG)}</a>
			</li>
			</c:forEach>
		</ul>
		</c:if>




		<c:if test="${fn:length(naverDetail) > 0}">
<!-- 		<h4 style="clear: both;">포털 사이트 연동 상세정보</h4> -->
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
</div>
<form id="printForm" name="printForm" hidden="hidden">
	<input id="print_cmd_page" name="print_cmd_page" type="hidden" value="DETAIL">
</form>
<iframe name="print_iframe" id="print_iframe"  src="?page_id=prints"  frameborder="no" style="display:;height:0px;width:0px;" ></iframe>
<div id="print_div"  style="height:25px"></div>

<OBJECT id="IEPageSetupX" classid="clsid:41C5BC45-1BE8-42C5-AD9F-495D6C8D7586" codebase="/resources/common/activeX/IEPageSetupX.cab#version=1,4,0,3" >
	<param name="copyright" value="http://isulnara.com">
	<div id="printMsg"><FONT style='font-family: "굴림", "Verdana"; font-size: 9pt; font-style: normal;'>
	<BR>  인쇄 여백제어 컨트롤이 설치되지 않았습니다.    <a href="/resources/common/activeX/IEPageSetupX.exe"><font color="red">이곳</font></a>을 클릭하여 수동으로 설치하시기 바랍니다.  </FONT>
	</div>
</OBJECT>
