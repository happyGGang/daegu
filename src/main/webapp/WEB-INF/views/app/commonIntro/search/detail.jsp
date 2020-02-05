<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" href="/resources/common/css/search/jqcloud.css" type="text/css">
<script type="text/javascript" src="/resources/common/js/jqcloud.js"></script>
<script type="text/javascript">
$(function() {

	$('a#resve-req').on('click', function(e) {
		e.preventDefault();
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}

		if ( doAjaxPost($('#resveReqForm')) ) {
			location.reload();
		}
	});

	<%-- 무인대출예약 신청 --%>
	$('a#unmanned-req').on('click', function(e) {
		e.preventDefault();
		$('form#unmannedReqForm').submit();
	});

	<%-- 야간대출예약 신청 --%>
	$('a#night-req').on('click', function(e) {
		e.preventDefault();
		$('form#nightReqForm').submit();
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

	$('a.addStorage').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */

		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=450, height=400");
	});

	$('a.addDelivery').on('click', function(e) {
		e.preventDefault();

	});

	<c:if test="${detail.SANGHO_REQ_YN eq 'Y'}">
	<%--상호대차 신청--%>
	$('a.sangho').on('click', function(e) {
		e.preventDefault();

		<c:if test="${detail.BOOK_STATUS eq '0'}">
		alert('대출중인도서는 상호대차 신청이 불가능합니다.');
		</c:if>
		<c:if test="${detail.BOOK_STATUS ne '0'}">
		$('form#sanghoReqForm').submit();
		</c:if>

	});
	</c:if>

	try {
		var words = JSON.parse('${data4ItemList}');
		$('#cloud').jQCloud(words, {
			autoResize: true
		});
	} catch (e) {
		// TODO: handle exception
	}

	$('div#bookReviewDiv').load('/${homepage.context_path}/module/bookReview/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&manage_code=${fn:escapeXml(detail.MANAGE_CODE)}&reg_no=${fn:escapeXml(detail.REG_NO)}');
});

</script>

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="itemEditMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${detail.PUBLISHER}">
	<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${detail.ST_CODE}">
	<input type="hidden" id="img_url" name="img_url" value="${detail.IMAGE}">
</form>

<form id="resveReqForm" action="resve/save.do" method="post" onsubmit="return false;">
	<input type="hidden" id="reserveMode" name="editMode" value="ADD">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
</form>

<form id="unmannedReqForm" action="unmanned/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="nightReqForm" action="night/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="basketReqForm" action="/${homepage.context_path}/intro/search/saveDeliveryBasket.do">
	<input type="hidden" id="book_key" name="book_key">
	<input type="hidden" name="editMode" value="ADD">
</form>

<c:if test="${detail.SANGHO_REQ_YN eq 'Y'}">
<form id="sanghoReqForm" action="sangho/form.do" method="post">
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>
</c:if>

<!-- contents-title-->
<div id="contents-title">
	<h2>도서의 상세 내용<span style="font-weight:300">을 확인하세요</span></h2>
</div>
<!-- /contents-title-->

<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${empty detail.aladin or empty detail.aladin.cover}">
				<p class="noImg">
					<img src="/resources/common/img/noImg2.png" alt="noImage"/>
					<span>등록된 이미지가<br/>없습니다.</span>
				</p>
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;"><b>${detail.TITLE_INFO}</b></li>
					<li><strong>저자사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					<li><strong>분류기호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한국십진분류법 : ${detail.CLASS_NO}</li>
				</ul>
			</div>
		</div>

		<div class="bookDetailInfo">
			<table class="bookDetailInfoTbl">
			<caption>도서 상태 및 등록 정보</caption>
			<colgroup>
				<col width="20%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<col width="20%">
			</colgroup>
			<thead>
			<tr>
				<th>청구기호</th>
				<th>등록번호</th>
				<th>자료실</th>
				<th>반납예정일</th>
				<th>대출상태</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>${detail.CALL_NO}</td>
				<td>${detail.REG_NO}</td>
				<td>${detail.SHELF_LOC_NAME}</td>
				<td>${detail.RETURN_PLAN_DATE}</td>
				<td>

					<!-- 대출가능 여부 [START] -->
					<c:choose>
						<c:when test="${detail.WORKING_STATUS == 'BOL112N'}">
							<c:choose>
								<c:when test="${detail.RESERVATION_CNT > '0'}">
									<span style="color:#ff0000">대출불가(예약도서)</span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${detail.USE_LIMIT_CODE eq 'CD'}">
											대출불가(열람제한도서)
										</c:when>
										<c:when test="${detail.USE_LIMIT_CODE eq 'IZ'}">
											귀중자료(관내열람만가능)
										</c:when>
										<c:otherwise>
											대출가능
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.WORKING_STATUS == 'BOL211O'}">
									<span style="color:#ff0000">대출불가(관외대출중)</span>
								</c:when>
								<c:when test="${detail.WORKING_STATUS == 'BOL212O'}">
									<span style="color:#ff0000">대출불가(관내대출중)</span>
								</c:when>
								<c:when test="${detail.WORKING_STATUS == 'BOL511O'}">
									<span style="color:#ff0000">대출불가(타관반납중)</span>
								</c:when>
								<c:when test="${detail.WORKING_STATUS == 'BOL611O'}">
									<span style="color:#ff0000">대출불가(타관대출중)</span>
								</c:when>
								<c:otherwise>
									<span style="color:#ff0000">대출불가</span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<!-- 대출가능 여부 [ END ] -->

				</td>
			</tr>
			</tbody>
			</table>
		</div>
		<div class="sbtn" style="text-align:center;">
			<c:if test="${detail.SANGHO_REQ_YN eq 'Y'}">
			<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
			</c:if>

			<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
<!--
			<a href="" id="unmanned-req" class="btn">무인예약신청</a>
			<a href="" id="night-req" class="btn">야간예약신청</a>
-->
			</c:if>

			<c:if test="${detail.WORKING_STATUS ne 'BOL112N' and param.booktype ne 'NONBOOK'}">
			<a href="#" id="resve-req" class="btn">예약신청</a>
			</c:if>

			<a href="javascript:history.back();" id="goBack" class="btn"><i class="fa fa-book"></i><span>목록으로</span></a>
		</div>

		<!-- 선호도정보 -->
		<h5 class="bookTitle">연령별 대출선호도 정보</h5>
		<div class="graphWrap">
			<!-- 막대그래프 -->
			<c:if test="${not empty data4ageList}">
			<div class="barGraph">
				<div class="graphBox">
					<ul class="axis-x clearfix">
						<c:forEach var="i" varStatus="stauts" items="${data4ageList}">
						<li>
							<span class="bar"><span class="fill" style="height:${(i.loanCnt/data4LoanCnt)*100}%;"><em class="num">${i.loanCnt}건</em></span></span>
							<p class="txt">${i.name}</p>
						</li>
						</c:forEach>
					</ul>
					<div class="axis-y">
						<span class="line"><span class="txt">100</span></span>
						<span class="line"><span class="txt">80</span></span>
						<span class="line"><span class="txt">60</span></span>
						<span class="line"><span class="txt">40</span></span>
						<span class="line"><span class="txt">20</span></span>
						<span class="line"><span class="txt">0</span></span>
					</div>
					<div class="end"></div>
				</div>
				<div class="end"></div>
			</div>
			</c:if>
			<c:if test="${empty data4ageList}">
			<div>데이터가 없습니다.</div>
			</c:if>
			<!-- //막대그래프 -->
		</div>
		<!-- 선호도정보 -->
		<div class="end"></div>

		<h5 class="bookTitle">이 책의 주요키워드</h5>
		<div class="tagCloud">
			<div id="cloud" class="jqcloud"></div>
		</div>
		<div class="end"></div>

		<!-- 도서정보목록 -->
		<h5 class="bookTitle">이 책과 같이 빌린 도서 정보</h5>
		<div class="kdcBookList">
			<ul class="bookListz">
				<c:forEach items="${data4recommandList}" var="i" varStatus="status" begin="1" end="5" step="1">
					<li>
						<div class="thumb">
							<a href="#None" class="cover" onclick="alert('이 책과 같이 빌린 도서 정보는 상세페이지를 지원하지 않습니다.')">
								<span class="img">
									<img src="${i.bookImageURL}" alt="${i.bookname}" >
								</span>
							</a>
						</div>
						<span class="tit">${i.bookname}</span>
						<span class="author">${i.authors}</span>
					</li>
				</c:forEach>
			</ul>
		</div>

		<h3 style="border-top: 1px solid #ccc;">서평</h3>
		<div class="showFoldDiv" id="bookReviewDiv"></div>
	</div>
</div>
