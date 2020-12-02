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
		<c:choose>
		<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'HOMEPAGE'}">
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		if ( doAjaxPost($('#resveReqForm')) ) {
			location.reload();
		}
		</c:when>
		<c:otherwise>
		alert('로그인 후 이용 가능합니다.');
		location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&before_url='+encodeURIComponent(location.href);
		</c:otherwise>
		</c:choose>

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

	<%-- 야간대출예약 신청제한 --%>
	$('a#service-noreq').on('click', function(e) {
		e.preventDefault();
		alert('비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		return;
	});

	$('a#addStorage').on('click', function(e) {
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

	<c:if test="${not empty loginPortal and loginPortal.login}">
	<%-- 대표도서관 택배대출 관심도서 --%>
	$('#interest').on('click', function(e) {
		e.preventDefault();
		if(confirm('택배서비스 관심도서 추가하겠습니까?')) {
			doAjaxPost($('#bookExpressForm'));
		}
	});
	</c:if >

	if (document.referrer.indexOf('/intro/search/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}
	
	if (document.referrer.indexOf('/intro/search/indexAll.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}

	if (document.referrer.indexOf('/intro/search/newBook/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}

	if (document.referrer.indexOf('/intro/search/bestBook/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}
// 	$('div#bookReviewDiv').load('/${homepage.context_path}/module/bookReview/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&manage_code=${fn:escapeXml(detail.MANAGE_CODE)}&reg_no=${fn:escapeXml(detail.REG_NO)}');
});

</script>

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="itemEditMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" id="img_url" name="img_url" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="resveReqForm" action="resve/save.do" method="post" onsubmit="return false;">
	<input type="hidden" id="reserveMode" name="editMode" value="ADD">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:startsWith(detail.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}">
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

<c:if test="${not empty loginPortal and loginPortal.login}">
<form id="bookExpressForm" action="/${homepage.context_path}/module/bookExpress/save.do" method="post">
	<input type="hidden" name="editMode" value="INTEREST">
	<input type="hidden" name="book_name" value="${detail.TITLE_INFO} / ${detail.AUTHOR}">
	<input type="hidden" name="book_reg_no" value="${detail.REG_NO}">
	<input type="hidden" name="book_call_no" value="${detail.CALL_NO}">
	<input type="hidden" name="thumb_image" value="${detail.IMAGE}">
	<input type="hidden" name="library_code" value="${detail.LIB_CODE}">
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
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					</c:if>
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

			<c:if test="${detail.WORKING_STATUS eq 'BOL112N'}">
			<!-- 북구통합도서관 상호대차 설정시작-->
			<c:choose>
				<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj' || homepage.context_path eq 'buks'}">
					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'GM'}">
						<!-- 북구영어  제외 -->
						</c:when>
						<c:otherwise>

							<c:choose>
								<c:when test="${detail.SHELF_LOC_CODE eq 'BA01' || detail.SHELF_LOC_CODE eq 'BA02' || detail.SHELF_LOC_CODE eq 'BA03' || detail.SHELF_LOC_CODE eq 'BA04' || detail.SHELF_LOC_CODE eq 'BA06' || detail.SHELF_LOC_CODE eq 'BB01' || detail.SHELF_LOC_CODE eq 'BB02' || detail.SHELF_LOC_CODE eq 'BB03' || detail.SHELF_LOC_CODE eq 'BB04' || detail.SHELF_LOC_CODE eq 'BC01' || detail.SHELF_LOC_CODE eq 'BC02' || detail.SHELF_LOC_CODE eq 'BC03' || detail.SHELF_LOC_CODE eq 'GJ01' || detail.SHELF_LOC_CODE eq 'GL01' || detail.SHELF_LOC_CODE eq 'GL02' || detail.SHELF_LOC_CODE eq 'GM01' || detail.SHELF_LOC_CODE eq 'GN01' || detail.SHELF_LOC_CODE eq 'GP01' || detail.SHELF_LOC_CODE eq 'HB01' || detail.SHELF_LOC_CODE eq 'HD01' || detail.SHELF_LOC_CODE eq 'HE01'}">
									<c:if test="${detail.SEPARATE_SHELF_CODE eq 'BMG' || detail.SEPARATE_SHELF_CODE eq 'BMH' || detail.SEPARATE_SHELF_CODE eq 'BML' || detail.SEPARATE_SHELF_CODE eq 'BMM' || detail.SEPARATE_SHELF_CODE eq 'BMN' || detail.SEPARATE_SHELF_CODE eq 'BMP' || detail.SEPARATE_SHELF_CODE eq 'BMQ' || detail.SEPARATE_SHELF_CODE eq 'BMS' || detail.SEPARATE_SHELF_CODE eq 'BMT' || detail.SEPARATE_SHELF_CODE eq 'BMU' || detail.SEPARATE_SHELF_CODE eq 'BMW' || detail.SEPARATE_SHELF_CODE eq 'BMX' || detail.SEPARATE_SHELF_CODE eq 'BMY' || detail.SEPARATE_SHELF_CODE eq 'BMZ' || detail.SEPARATE_SHELF_CODE eq 'BNA' || detail.SEPARATE_SHELF_CODE eq 'BNB' || detail.SEPARATE_SHELF_CODE eq 'BNC' || detail.SEPARATE_SHELF_CODE eq 'BND' || detail.SEPARATE_SHELF_CODE eq 'BNE' || detail.SEPARATE_SHELF_CODE eq 'BNF' || detail.SEPARATE_SHELF_CODE eq null || detail.SEPARATE_SHELF_CODE eq 'null' || detail.SEPARATE_SHELF_CODE eq ''}">
										<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
									</c:if>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>

						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan' || homepage.context_path eq 'bookforest' || homepage.context_path eq 'mulmangi' || homepage.context_path eq 'padong' || homepage.context_path eq 'muhaksup' || context_path eq 'sawol'}">

					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'BD01' || detail.SHELF_LOC_CODE eq 'BD02' || detail.SHELF_LOC_CODE eq 'BD03' || detail.SHELF_LOC_CODE eq 'BD04' || detail.SHELF_LOC_CODE eq 'BE01' || detail.SHELF_LOC_CODE eq 'BE02' || detail.SHELF_LOC_CODE eq 'BE03' || detail.SHELF_LOC_CODE eq 'BE04' || detail.SHELF_LOC_CODE eq 'BE09' || detail.SHELF_LOC_CODE eq 'BF01' || detail.SHELF_LOC_CODE eq 'BF02' || detail.SHELF_LOC_CODE eq 'BF03' || detail.SHELF_LOC_CODE eq 'BG01' || detail.SHELF_LOC_CODE eq 'BG02' || detail.SHELF_LOC_CODE eq 'BG03' || detail.SHELF_LOC_CODE eq 'BH01' || detail.SHELF_LOC_CODE eq 'BH02' || detail.SHELF_LOC_CODE eq 'BH03' || detail.SHELF_LOC_CODE eq 'BH04' || detail.SHELF_LOC_CODE eq 'BJ01' || detail.SHELF_LOC_CODE eq 'BJ02' || detail.SHELF_LOC_CODE eq 'BJ03' || detail.SHELF_LOC_CODE eq 'BJ04' || detail.SHELF_LOC_CODE eq 'BK01' || detail.SHELF_LOC_CODE eq 'BK02' || detail.SHELF_LOC_CODE eq 'BK03' || detail.SHELF_LOC_CODE eq 'BK04' || detail.SHELF_LOC_CODE eq 'FG01'}">
							<c:if test="${detail.SEPARATE_SHELF_CODE eq 'BPL' || detail.SEPARATE_SHELF_CODE eq 'BPM' || detail.SEPARATE_SHELF_CODE eq 'BPN' || detail.SEPARATE_SHELF_CODE eq 'BPR' || detail.SEPARATE_SHELF_CODE eq 'BPS' || detail.SEPARATE_SHELF_CODE eq 'BPT' || detail.SEPARATE_SHELF_CODE eq 'BPU' || detail.SEPARATE_SHELF_CODE eq 'BPX' || detail.SEPARATE_SHELF_CODE eq 'BPY' || detail.SEPARATE_SHELF_CODE eq 'BPZ' || detail.SEPARATE_SHELF_CODE eq 'BQA' || detail.SEPARATE_SHELF_CODE eq 'BQB' || detail.SEPARATE_SHELF_CODE eq 'BQC' || detail.SEPARATE_SHELF_CODE eq 'BQD' || detail.SEPARATE_SHELF_CODE eq 'BQE' || detail.SEPARATE_SHELF_CODE eq 'BQG' || detail.SEPARATE_SHELF_CODE eq 'BQH' || detail.SEPARATE_SHELF_CODE eq 'BQJ' || detail.SEPARATE_SHELF_CODE eq 'BQK' || detail.SEPARATE_SHELF_CODE eq 'BQM' || detail.SEPARATE_SHELF_CODE eq 'BQN' || detail.SEPARATE_SHELF_CODE eq 'BQP' || detail.SEPARATE_SHELF_CODE eq 'BQQ' || detail.SEPARATE_SHELF_CODE eq 'BQR' || detail.SEPARATE_SHELF_CODE eq 'BQS' || detail.SEPARATE_SHELF_CODE eq 'BQU' || detail.SEPARATE_SHELF_CODE eq 'BQV' || detail.SEPARATE_SHELF_CODE eq 'BQW' || detail.SEPARATE_SHELF_CODE eq 'BQX' || detail.SEPARATE_SHELF_CODE eq 'BQY' || detail.SEPARATE_SHELF_CODE eq 'BQZ' || detail.SEPARATE_SHELF_CODE eq 'BRA' || detail.SEPARATE_SHELF_CODE eq 'BRB' || detail.SEPARATE_SHELF_CODE eq 'BRC' || detail.SEPARATE_SHELF_CODE eq 'BRD' || detail.SEPARATE_SHELF_CODE eq 'BRE' || detail.SEPARATE_SHELF_CODE eq 'BRF' || detail.SEPARATE_SHELF_CODE eq 'BRJ' || detail.SEPARATE_SHELF_CODE eq 'BRK' || detail.SEPARATE_SHELF_CODE eq 'BRQ' || detail.SEPARATE_SHELF_CODE eq 'BRT' || detail.SEPARATE_SHELF_CODE eq 'BRV' || detail.SEPARATE_SHELF_CODE eq 'BRW' || detail.SEPARATE_SHELF_CODE eq 'BRX' || detail.SEPARATE_SHELF_CODE eq 'BSJ' || detail.SEPARATE_SHELF_CODE eq null || detail.SEPARATE_SHELF_CODE eq 'null' || detail.SEPARATE_SHELF_CODE eq ''}">
								<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
							</c:if>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${homepage.context_path eq 'junggu'}">
					<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
				</c:when>

				<c:when test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'kids' || homepage.context_path eq 'seongseo' || homepage.context_path eq 'bolli' || homepage.context_path eq 'family' || homepage.context_path eq 'english' || homepage.context_path eq 'dssmalllib'}">

					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'BU01' || detail.SHELF_LOC_CODE eq 'BU02' || detail.SHELF_LOC_CODE eq 'BU03' || detail.SHELF_LOC_CODE eq 'BU04' || detail.SHELF_LOC_CODE eq 'BU06' || detail.SHELF_LOC_CODE eq 'BU07' || detail.SHELF_LOC_CODE eq 'BU08' || detail.SHELF_LOC_CODE eq 'BV01' || detail.SHELF_LOC_CODE eq 'BV02' || detail.SHELF_LOC_CODE eq 'BV03' || detail.SHELF_LOC_CODE eq 'BV04' || detail.SHELF_LOC_CODE eq 'BV09' || detail.SHELF_LOC_CODE eq 'BW01' || detail.SHELF_LOC_CODE eq 'BW02' || detail.SHELF_LOC_CODE eq 'BW03' || detail.SHELF_LOC_CODE eq 'BW04' || detail.SHELF_LOC_CODE eq 'BW05' || detail.SHELF_LOC_CODE eq 'BW09' || detail.SHELF_LOC_CODE eq 'BW13' || detail.SHELF_LOC_CODE eq 'BW14' || detail.SHELF_LOC_CODE eq 'BX01' || detail.SHELF_LOC_CODE eq 'BX02' || detail.SHELF_LOC_CODE eq 'BX03' || detail.SHELF_LOC_CODE eq 'BX04' || detail.SHELF_LOC_CODE eq 'BX05' || detail.SHELF_LOC_CODE eq 'BX13' || detail.SHELF_LOC_CODE eq 'BX14' || detail.SHELF_LOC_CODE eq 'BX19' || detail.SHELF_LOC_CODE eq 'BX20' || detail.SHELF_LOC_CODE eq 'BX21' || detail.SHELF_LOC_CODE eq 'BY01' || detail.SHELF_LOC_CODE eq 'BY02' || detail.SHELF_LOC_CODE eq 'BY03' || detail.SHELF_LOC_CODE eq 'BY06' || detail.SHELF_LOC_CODE eq 'BY08' || detail.SHELF_LOC_CODE eq 'BY10' || detail.SHELF_LOC_CODE eq 'BY11' || detail.SHELF_LOC_CODE eq 'BY13' || detail.SHELF_LOC_CODE eq 'BY15' || detail.SHELF_LOC_CODE eq 'BY16' || detail.SHELF_LOC_CODE eq 'BZ01' || detail.SHELF_LOC_CODE eq 'BZ02' || detail.SHELF_LOC_CODE eq 'BZ03' || detail.SHELF_LOC_CODE eq 'BZ04' || detail.SHELF_LOC_CODE eq 'BZ05' || detail.SHELF_LOC_CODE eq 'BZ06' || detail.SHELF_LOC_CODE eq 'BZ07' || detail.SHELF_LOC_CODE eq 'BZ08' || detail.SHELF_LOC_CODE eq 'FA01' || detail.SHELF_LOC_CODE eq 'FB01' || detail.SHELF_LOC_CODE eq 'FC01' || detail.SHELF_LOC_CODE eq 'FD01' || detail.SHELF_LOC_CODE eq 'FW01' || detail.SHELF_LOC_CODE eq 'FX01' || detail.SHELF_LOC_CODE eq 'GK01'}">
							<c:if test="${detail.SEPARATE_SHELF_CODE eq 'CCH' ||detail.SEPARATE_SHELF_CODE eq 'CCR' ||detail.SEPARATE_SHELF_CODE eq 'CCS' ||detail.SEPARATE_SHELF_CODE eq 'CCU' ||detail.SEPARATE_SHELF_CODE eq 'CCW' ||detail.SEPARATE_SHELF_CODE eq 'CCZ' ||detail.SEPARATE_SHELF_CODE eq 'CDA' ||detail.SEPARATE_SHELF_CODE eq 'CDC' ||detail.SEPARATE_SHELF_CODE eq 'CDD' ||detail.SEPARATE_SHELF_CODE eq 'CDH' ||detail.SEPARATE_SHELF_CODE eq 'CDJ' ||detail.SEPARATE_SHELF_CODE eq 'CDQ' ||detail.SEPARATE_SHELF_CODE eq 'CDU' || detail.SEPARATE_SHELF_CODE eq null || detail.SEPARATE_SHELF_CODE eq 'null' || detail.SEPARATE_SHELF_CODE eq ''}">
								<c:if test="${detail.REG_CODE eq 'DJR' || detail.REG_CODE eq 'DKC' || detail.REG_CODE eq 'DKM' || detail.REG_CODE eq 'DLB' || detail.REG_CODE eq 'DLN' || detail.REG_CODE eq 'DLP' || detail.REG_CODE eq 'DLY' || detail.REG_CODE eq 'DMN' || detail.REG_CODE eq 'DMZ' || detail.REG_CODE eq 'DNA' || detail.REG_CODE eq 'DNK' || detail.REG_CODE eq 'DNZ' || detail.REG_CODE eq 'DPK' || detail.REG_CODE eq 'DPV' || detail.REG_CODE eq 'DQK' || detail.REG_CODE eq 'DQV' || detail.REG_CODE eq 'DRE' || detail.REG_CODE eq 'DTA' || detail.REG_CODE eq 'DTG' || detail.REG_CODE eq 'DTM' || detail.REG_CODE eq 'DTT' || detail.REG_CODE eq 'DTU' || detail.REG_CODE eq 'DTV' || detail.REG_CODE eq 'DUB' || detail.REG_CODE eq 'DUC' || detail.REG_CODE eq 'DUJ' || detail.REG_CODE eq 'DUK' || detail.REG_CODE eq 'DUR' || detail.REG_CODE eq 'DUV' || detail.REG_CODE eq 'DUX' || detail.REG_CODE eq 'DVD'}">
								<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${homepage.context_path eq 'donggu' || homepage.context_path eq 'sincheon' || homepage.context_path eq 'donggusm'}">

					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'CA01' || detail.SHELF_LOC_CODE eq 'CA02' || detail.SHELF_LOC_CODE eq 'CB01' || detail.SHELF_LOC_CODE eq 'CB02' || detail.SHELF_LOC_CODE eq 'GR01' || detail.SHELF_LOC_CODE eq 'GS01' || detail.SHELF_LOC_CODE eq 'HJ02' || detail.SHELF_LOC_CODE eq 'FK01' || detail.SHELF_LOC_CODE eq 'GT01' || detail.SHELF_LOC_CODE eq 'FP01' || detail.SHELF_LOC_CODE eq 'FL01' || detail.SHELF_LOC_CODE eq 'GU01' || detail.SHELF_LOC_CODE eq 'GV01' || detail.SHELF_LOC_CODE eq 'GW01' || detail.SHELF_LOC_CODE eq 'GY01' || detail.SHELF_LOC_CODE eq 'FM01' || detail.SHELF_LOC_CODE eq 'GZ01' || detail.SHELF_LOC_CODE eq 'HK01' || detail.SHELF_LOC_CODE eq 'HL01' || detail.SHELF_LOC_CODE eq 'HM01' || detail.SHELF_LOC_CODE eq 'HN01' || detail.SHELF_LOC_CODE eq 'GX01' || detail.SHELF_LOC_CODE eq 'HP01' || detail.SHELF_LOC_CODE eq 'HQ02'}">
							<c:if test="${detail.SEPARATE_SHELF_CODE eq 'CEU' || detail.SEPARATE_SHELF_CODE eq 'CFB' || detail.SEPARATE_SHELF_CODE eq 'CFC' || detail.SEPARATE_SHELF_CODE eq 'CFD' || detail.SEPARATE_SHELF_CODE eq 'CFE' || detail.SEPARATE_SHELF_CODE eq 'CFH' || detail.SEPARATE_SHELF_CODE eq 'CFJ' || detail.SEPARATE_SHELF_CODE eq 'CFK' || detail.SEPARATE_SHELF_CODE eq 'CFM' || detail.SEPARATE_SHELF_CODE eq 'CFN' || detail.SEPARATE_SHELF_CODE eq null || detail.SEPARATE_SHELF_CODE eq 'null' || detail.SEPARATE_SHELF_CODE eq ''}">
								<c:if test="${detail.REG_CODE eq 'DVL' || detail.REG_CODE eq 'DVM' || detail.REG_CODE eq 'DVN' || detail.REG_CODE eq 'DVP' || detail.REG_CODE eq 'DVQ' || detail.REG_CODE eq 'DWC' || detail.REG_CODE eq 'DWD' || detail.REG_CODE eq 'DWE' || detail.REG_CODE eq 'DWR' || detail.REG_CODE eq 'DWX' || detail.REG_CODE eq 'DXD' || detail.REG_CODE eq 'DXK' || detail.REG_CODE eq 'DXL' || detail.REG_CODE eq 'DXS' || detail.REG_CODE eq 'DXY' || detail.REG_CODE eq 'DYE' || detail.REG_CODE eq 'DYL' || detail.REG_CODE eq 'DYS' || detail.REG_CODE eq 'DYY' || detail.REG_CODE eq 'DZE' || detail.REG_CODE eq 'DZL' || detail.REG_CODE eq 'DZS' || detail.REG_CODE eq 'DZY' || detail.REG_CODE eq 'DZZ' || detail.REG_CODE eq 'EAF' || detail.REG_CODE eq 'EAM' || detail.REG_CODE eq 'EAT' || detail.REG_CODE eq 'EAZ' || detail.REG_CODE eq 'EBF' || detail.REG_CODE eq 'EBM'}">
								<!-- <a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a> -->
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:otherwise>

				</c:otherwise>
			</c:choose>
			</c:if>



			<c:choose>
				<c:when test="${detail.MANAGE_CODE eq 'AL'}">

				</c:when>
				<c:otherwise>

			<!--워킹스루 시작-->
			<c:if test="${detail.WORKING_STATUS eq 'BOL112N' }">

			<c:if test="${detail.SHELF_LOC_CODE eq 'AD20' || detail.SHELF_LOC_CODE eq 'AD18' || detail.SHELF_LOC_CODE eq 'AD19' || detail.SHELF_LOC_CODE eq 'AD04' || detail.SHELF_LOC_CODE eq 'AD02' || detail.SHELF_LOC_CODE eq 'AD03' || detail.SHELF_LOC_CODE eq 'AD06' || detail.SHELF_LOC_CODE eq 'AD07' || detail.SHELF_LOC_CODE eq 'AD14' || detail.SHELF_LOC_CODE eq 'AD08' || detail.SHELF_LOC_CODE eq 'AD12' || detail.SHELF_LOC_CODE eq 'AD01' || detail.SHELF_LOC_CODE eq 'AD11' || detail.SHELF_LOC_CODE eq 'AD27' || detail.SHELF_LOC_CODE eq 'AH01' || detail.SHELF_LOC_CODE eq 'AH02' || detail.SHELF_LOC_CODE eq 'AH06' || detail.SHELF_LOC_CODE eq 'AH07' || detail.SHELF_LOC_CODE eq 'AH08' || detail.SHELF_LOC_CODE eq 'AH14' || detail.SHELF_LOC_CODE eq 'AH18' || detail.SHELF_LOC_CODE eq 'AH21' || detail.SHELF_LOC_CODE eq 'AH23' || detail.SHELF_LOC_CODE eq 'AH24' || detail.SHELF_LOC_CODE eq 'AH27' || detail.SHELF_LOC_CODE eq 'AG01' || detail.SHELF_LOC_CODE eq 'AG02' || detail.SHELF_LOC_CODE eq 'AG06' || detail.SHELF_LOC_CODE eq 'AG05' || detail.SHELF_LOC_CODE eq 'AG10' || detail.SHELF_LOC_CODE eq 'AG11' || detail.SHELF_LOC_CODE eq 'AG12' || detail.SHELF_LOC_CODE eq 'AG15' || detail.SHELF_LOC_CODE eq 'AG17' || detail.SHELF_LOC_CODE eq 'AA03' || detail.SHELF_LOC_CODE eq 'AA04' || detail.SHELF_LOC_CODE eq 'AA09' || detail.SHELF_LOC_CODE eq 'AA10' || detail.SHELF_LOC_CODE eq 'AA11' || detail.SHELF_LOC_CODE eq 'AA14' || detail.SHELF_LOC_CODE eq 'AA15' || detail.SHELF_LOC_CODE eq 'AA16' || detail.SHELF_LOC_CODE eq 'AA17' || detail.SHELF_LOC_CODE eq 'AA18' || detail.SHELF_LOC_CODE eq 'AA20' || detail.SHELF_LOC_CODE eq 'AA21' || detail.SHELF_LOC_CODE eq 'AA22' || detail.SHELF_LOC_CODE eq 'AA23' || detail.SHELF_LOC_CODE eq 'AA37' || detail.SHELF_LOC_CODE eq 'AA31' || detail.SHELF_LOC_CODE eq 'AA39' || detail.SHELF_LOC_CODE eq 'AA01' || detail.SHELF_LOC_CODE eq 'AA12' || detail.SHELF_LOC_CODE eq 'AA13' || detail.SHELF_LOC_CODE eq 'AA24' || detail.SHELF_LOC_CODE eq 'AA25' || detail.SHELF_LOC_CODE eq 'AA26' || detail.SHELF_LOC_CODE eq 'AA27' || detail.SHELF_LOC_CODE eq 'AA28' || detail.SHELF_LOC_CODE eq 'AF01' || detail.SHELF_LOC_CODE eq 'AF03' || detail.SHELF_LOC_CODE eq 'AF04' || detail.SHELF_LOC_CODE eq 'AF08' || detail.SHELF_LOC_CODE eq 'AF11' || detail.SHELF_LOC_CODE eq 'AF12' || detail.SHELF_LOC_CODE eq 'AF13' || detail.SHELF_LOC_CODE eq 'AE28' || detail.SHELF_LOC_CODE eq 'AC01' || detail.SHELF_LOC_CODE eq 'AC02' || detail.SHELF_LOC_CODE eq 'AC03' || detail.SHELF_LOC_CODE eq 'AC04' || detail.SHELF_LOC_CODE eq 'AC05' || detail.SHELF_LOC_CODE eq 'AC06' || detail.SHELF_LOC_CODE eq 'AC07' || detail.SHELF_LOC_CODE eq 'AC12' || detail.SHELF_LOC_CODE eq 'AB01' || detail.SHELF_LOC_CODE eq 'AB02' || detail.SHELF_LOC_CODE eq 'AB03' || detail.SHELF_LOC_CODE eq 'AB05' || detail.SHELF_LOC_CODE eq 'AB06' || detail.SHELF_LOC_CODE eq 'AJ01' || detail.SHELF_LOC_CODE eq 'AJ02' || detail.SHELF_LOC_CODE eq 'AJ09' || detail.SHELF_LOC_CODE eq 'AJ06' || detail.SHELF_LOC_CODE eq 'AJ07' || detail.SHELF_LOC_CODE eq 'AJ04' || detail.SHELF_LOC_CODE eq 'AJ48' || detail.SHELF_LOC_CODE eq 'AE01' || detail.SHELF_LOC_CODE eq 'AE05' || detail.SHELF_LOC_CODE eq 'AE12' || detail.SHELF_LOC_CODE eq 'AE19' || detail.SHELF_LOC_CODE eq 'AE03' || detail.SHELF_LOC_CODE eq 'AE11' || detail.SHELF_LOC_CODE eq 'AE20' || detail.SHELF_LOC_CODE eq 'AE22' || detail.SHELF_LOC_CODE eq 'AE23'}">

			<c:choose>
				<c:when test="${detail.RESERVATION_CNT > '0'}">

				</c:when>
				<c:otherwise>
					<%
					org.joda.time.DateTime now = new org.joda.time.DateTime();
					int dayOfWeek = now.getDayOfWeek(); /* dayOfWeek 월 1 화 2 수 3 목 4 금 5 토 6 일 7 */
					int hour = now.getHourOfDay();

					if(9 <= hour && hour < 17)
					{
					%>
						<!--<a href="#night" id="night-req" class="btn">워킹스루예약신청</a>-->
					<%
					}
					else
					{
					%>
						<!--<a href="#" class="btn btn1" onclick="alert('신청가능 시간이 아닙니다.');">워킹스루예약신청</a>-->
					<%
					}
					%>
				</c:otherwise>
			</c:choose>

			</c:if>

			</c:if>

				</c:otherwise>
			</c:choose>



			<c:choose>
				<c:when test="${homepage.context_path eq 'jungang'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AD02' || detail.SHELF_LOC_CODE eq 'AD03' || detail.SHELF_LOC_CODE eq 'AD04' || detail.SHELF_LOC_CODE eq 'AD06' || detail.SHELF_LOC_CODE eq 'AD07' || detail.SHELF_LOC_CODE eq 'AD08' || detail.SHELF_LOC_CODE eq 'AD12' || detail.SHELF_LOC_CODE eq 'AD14' || detail.SHELF_LOC_CODE eq 'AD18' || detail.SHELF_LOC_CODE eq 'AD19' || detail.SHELF_LOC_CODE eq 'AD20' || detail.SHELF_LOC_CODE eq 'AD01' || detail.SHELF_LOC_CODE eq 'AD11' || detail.SHELF_LOC_CODE eq 'AD27'}">

						<c:choose>
							<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
								<a href="#muin" id="service-noreq" class="btn">무인예약신청</a>
							</c:when>
							<c:otherwise>
								<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
							</c:otherwise>
						</c:choose>


					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq '228'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AA04'}">
					
						<c:choose>
							<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
								<a href="#muin" id="service-noreq" class="btn">무인예약신청</a>
							</c:when>
							<c:otherwise>
								<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
							</c:otherwise>
						</c:choose>
					
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq 'dmsl'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${sessionScope.member.user_class_code eq '701'}">
					<a href="#muin" id="unmanned-req" class="btn">별관 이동도서관 신청</a>
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq 'dal'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
					<!-- <a href="#night" id="night-req" class="btn">야간예약신청</a> -->
					</c:if>
					</c:if>
				</c:when>

				<c:when test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'kids' || homepage.context_path eq 'seongseo' || homepage.context_path eq 'bolli' || homepage.context_path eq 'family' || homepage.context_path eq 'english'}">
					<c:if test="${detail.MANAGE_CODE eq 'BU' || detail.MANAGE_CODE eq 'BV' || detail.MANAGE_CODE eq 'BW' || detail.MANAGE_CODE eq 'BX' || detail.MANAGE_CODE eq 'BY' || detail.MANAGE_CODE eq 'BZ'}">
					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'BU01' || detail.SHELF_LOC_CODE eq 'BU02' || detail.SHELF_LOC_CODE eq 'BU03' || detail.SHELF_LOC_CODE eq 'BU04' || detail.SHELF_LOC_CODE eq 'BU06' || detail.SHELF_LOC_CODE eq 'BU07' || detail.SHELF_LOC_CODE eq 'BU08' || detail.SHELF_LOC_CODE eq 'BV01' || detail.SHELF_LOC_CODE eq 'BV02' || detail.SHELF_LOC_CODE eq 'BV03' || detail.SHELF_LOC_CODE eq 'BV04' || detail.SHELF_LOC_CODE eq 'BV09' || detail.SHELF_LOC_CODE eq 'BW01' || detail.SHELF_LOC_CODE eq 'BW02' || detail.SHELF_LOC_CODE eq 'BW03' || detail.SHELF_LOC_CODE eq 'BW04' || detail.SHELF_LOC_CODE eq 'BW05' || detail.SHELF_LOC_CODE eq 'BW09' || detail.SHELF_LOC_CODE eq 'BW13' || detail.SHELF_LOC_CODE eq 'BW14' || detail.SHELF_LOC_CODE eq 'BX01' || detail.SHELF_LOC_CODE eq 'BX02' || detail.SHELF_LOC_CODE eq 'BX03' || detail.SHELF_LOC_CODE eq 'BX04' || detail.SHELF_LOC_CODE eq 'BX05' || detail.SHELF_LOC_CODE eq 'BX13' || detail.SHELF_LOC_CODE eq 'BX14' || detail.SHELF_LOC_CODE eq 'BX19' || detail.SHELF_LOC_CODE eq 'BX20' || detail.SHELF_LOC_CODE eq 'BX21' || detail.SHELF_LOC_CODE eq 'BY01' || detail.SHELF_LOC_CODE eq 'BY02' || detail.SHELF_LOC_CODE eq 'BY03' || detail.SHELF_LOC_CODE eq 'BY06' || detail.SHELF_LOC_CODE eq 'BY08' || detail.SHELF_LOC_CODE eq 'BY10' || detail.SHELF_LOC_CODE eq 'BY11' || detail.SHELF_LOC_CODE eq 'BY13' || detail.SHELF_LOC_CODE eq 'BY15' || detail.SHELF_LOC_CODE eq 'BY16' || detail.SHELF_LOC_CODE eq 'BZ01' || detail.SHELF_LOC_CODE eq 'BZ02' || detail.SHELF_LOC_CODE eq 'BZ03' || detail.SHELF_LOC_CODE eq 'BZ04' || detail.SHELF_LOC_CODE eq 'BZ05' || detail.SHELF_LOC_CODE eq 'BZ06' || detail.SHELF_LOC_CODE eq 'BZ07' || detail.SHELF_LOC_CODE eq 'BZ08' || detail.SHELF_LOC_CODE eq 'FA01' || detail.SHELF_LOC_CODE eq 'FB01' || detail.SHELF_LOC_CODE eq 'FC01' || detail.SHELF_LOC_CODE eq 'FD01' || detail.SHELF_LOC_CODE eq 'FW01' || detail.SHELF_LOC_CODE eq 'FX01' || detail.SHELF_LOC_CODE eq 'GK01'}">
							<c:if test="${detail.SEPARATE_SHELF_CODE eq 'CCH' ||detail.SEPARATE_SHELF_CODE eq 'CCR' ||detail.SEPARATE_SHELF_CODE eq 'CCS' ||detail.SEPARATE_SHELF_CODE eq 'CCU' ||detail.SEPARATE_SHELF_CODE eq 'CCW' ||detail.SEPARATE_SHELF_CODE eq 'CCZ' ||detail.SEPARATE_SHELF_CODE eq 'CDA' ||detail.SEPARATE_SHELF_CODE eq 'CDC' ||detail.SEPARATE_SHELF_CODE eq 'CDD' ||detail.SEPARATE_SHELF_CODE eq 'CDH' ||detail.SEPARATE_SHELF_CODE eq 'CDJ' ||detail.SEPARATE_SHELF_CODE eq 'CDQ' ||detail.SEPARATE_SHELF_CODE eq 'CDU' || detail.SEPARATE_SHELF_CODE eq null || detail.SEPARATE_SHELF_CODE eq 'null' || detail.SEPARATE_SHELF_CODE eq ''}">
								<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
								<c:if test="${detail.RESERVATION_CNT eq '0'}">
								<!-- <a href="#muin" id="unmanned-req" class="btn">무인예약신청</a> -->
								</c:if>
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					</c:if>
				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${detail.SHELF_LOC_CODE eq 'AD39' || detail.SHELF_LOC_CODE eq 'AD40'}">

				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${detail.WORKING_STATUS eq 'BOL112N'}">
							<c:choose>
								<c:when test="${detail.RESERVATION_CNT > 0}">
									<c:choose>
										<c:when test="${detail.RESERVATION_CNT < detail.RESERVATION_NUMBER}">

											<c:choose>
												<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
													<a href="#" id="service-noreq" class="btn">예약신청</a>
												</c:when>
												<c:otherwise>

													<c:choose>
														<c:when test="${detail.MANAGE_CODE eq 'AJ'}">
															<!-- <a href="#" id="resve-req-not" class="btn btn5">예약불가</a> -->
															<a href="#" id="resve-req" class="btn">예약신청</a>
														</c:when>
														<c:otherwise>
															<a href="#" id="resve-req" class="btn">예약신청</a>
														</c:otherwise>
													</c:choose>

												</c:otherwise>
											</c:choose>

										</c:when>
										<c:otherwise>
											<a href="#" id="resve-req-not" class="btn btn5">예약불가</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>

								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.RESERVATION_CNT < detail.RESERVATION_NUMBER}">

									<c:choose>
										<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
											<a href="#" id="service-noreq" class="btn">예약신청</a>
										</c:when>
										<c:otherwise>
													<c:choose>
														<c:when test="${detail.MANAGE_CODE eq 'AJ'}">
															<!-- <a href="#" id="resve-req-not" class="btn btn5">예약불가</a> -->
															<a href="#" id="resve-req" class="btn">예약신청</a>
														</c:when>
														<c:otherwise>
															<a href="#" id="resve-req" class="btn">예약신청</a>
														</c:otherwise>
													</c:choose>
										</c:otherwise>
									</c:choose>

								</c:when>
								<c:otherwise>
									<a href="#" id="resve-req-not" class="btn btn5">예약불가</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<a href="#" id="addStorage" class="btn"><span>관심도서 추가</span></a>

			<a href="index.do?menu_idx=${param.menu_idx}" id="goBack" class="btn"><i class="fa fa-book"></i><span>목록으로</span></a>

			<c:if test="${not empty loginPortal and loginPortal.login}">
			<a href="#" id="interest" class="btn"><span>교수학습 택배용 관심도서</span></a>
			</c:if>
		</div>

		<div style="padding-top:30px ;text-align:right">
			<a href="${detail.aladin.link}" target="_blank" style="color:#000">도서 정보 제공 : 알라딘 인터넷서점(www.aladin.co.kr)</a> <img src="/resources/common/img/aladin_01.png" alt="alandin" align="absmiddle"/>
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

		<h3 style="border-top: 1px solid #ccc; display: none;">서평</h3>
		<div class="showFoldDiv" id="bookReviewDiv"></div>
	</div>
</div>
