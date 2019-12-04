<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/intro/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/intro/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/board/js/common.js"></script>
<script type="text/javascript" src="/resources/book/intro/js/common.js"></script>
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

		if ( doAjaxPost($('#resveReqForm')) ) {

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

		if ( doAjaxPost($('#pouchReqForm')) ) {

		}
	});

	$('#checkAll').on('click', function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});

});

</script>

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="editMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.dsItemDetail[0].TITLE}">
	<input type="hidden" id="author" name="author" value="${detail.dsItemDetail[0].AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${detail.dsItemDetail[0].PUBLISHER}">
	<input type="hidden" id="loca" name="loca" value="${librarySearch.vLoca}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${librarySearch.vCtrl}">
	<input type="hidden" id="img_url" name="img_url" value="${librarySearch.vImg}">
</form>


<form:form id="resveReqForm" modelAttribute="librarySearch" action="resve/save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="vLoca"/>
	<form:hidden path="vAccNo"/>
	<form:hidden path="menu_idx"/>
</form:form>

<form:form id="pouchReqForm" modelAttribute="librarySearch" action="pouch/save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="vLoca"/>
	<form:hidden path="vAccNo"/>
	<form:hidden path="menu_idx"/>
</form:form>

<div class="search-wrap">
	<div class="sview">
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
					<img src="${librarySearch.vImg}" alt="${detail.dsItemDetail[0].TITLE}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;">
						<b>${detail.dsItemDetail[0].TITLE} / ${detail.dsItemDetail[0].AUTHOR}</b>
					</li>
					<li>${detail.dsItemDetail[0].PUBLISHER}, ${detail.dsItemDetail[0].PUBLISHER_YEAR}</li>
<%-- 					<li>${detail.dsItemDetail[0].LOCA_NAME} ${detail.dsItemDetail[0].SUB_LOCA_NAME}</li> --%>
					<li>${detail.dsItemDetail[0].SUB_LOCA_NAME}</li>
					<li>${detail.dsItemDetail[0].CALL_NO_D}</li>
					<li class="ibtn">
<!-- 						<a href="" class="btn">MARC</a> -->
<!-- 						<a href="" class="btn"><span>자세히보기</span><i class="fa fa-sort-down"></i></a> -->
					</li>
				</ul>
			</div>
		</div>
		<h4>소장위치</h4>
		<table summary="도서 상태 및 등록 정보">
			<thead>
				<tr>
					<th style="display: none;"><input type="checkbox" id="checkAll"/></th>
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
				<c:forEach items="${detail.dsItemDetail}" var="i" varStatus="status">
				<tr>
					<td style="display: none;"><input name="print_param" type="checkbox" value="${fn:replace(i.TITLE,',','.')}_${fn:replace(i.CALL_NO,',','.')}_${fn:replace(i.ACSSON_NO,',','.')}_${fn:replace(i.AUTHOR,',','.')}_${fn:replace(i.SUB_LOCA_NAME,',','.')}"/></td>
					<td>${i.PRINT_ACSSON_NO}</td>
					<td class="txt-left">${i.SUB_LOCA_NAME}</td>
					<td class="txt-left">${i.CALL_NO_D}</td>
					<td class="og">${i.DISPLAY_ITEM_STATUS}</td>
					<td>${i.RETURN_PLAN_DATE}</td>
					<td>
						<c:if test="${i.RESVE_CHECK eq 'Y'}">
						<a class="resve-req" vLoca="${i.LOCA}" vAccNo="${i.ACSSON_NO}">예약하기</a>
						</c:if>

						<c:if test="${not isTodayClosed and homepage.manage_code eq member.loca and member.login and i.LOAN_FLAG eq '0001' and i.LOCA eq '00147046'}">
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
						<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime}">
						<a style="display:none;" class="pouch-req" vLoca="${i.LOCA}" vAccNo="${i.ACSSON_NO}">[야간대출신청하기]</a>
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
		<div class="sbtn">
			<a href="javascript:window.close();" id="goBack" class="btn"><span>닫기</span></a>
		</div>
	</div>
</div>
