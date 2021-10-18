
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
	
	<%-- 비대면 도서대출 신청 --%>
	$('a#untactBook-req').on('click', function(e) {
		e.preventDefault();
		$('form#untactBookReqForm').submit();
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
 	//$('div#bookReviewDiv').load('/${homepage.context_path}/module/bookReview/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&manage_code=${fn:escapeXml(detail.MANAGE_CODE)}&reg_no=${fn:escapeXml(detail.REG_NO)}');
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
	<input type="hidden" id="call_no" name="call_no" value="${fn:escapeXml(detail.CALL_NO)}">
	<input type="hidden" id="img_url" name="img_url" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="resveReqForm" action="resve/save.do" method="post" onsubmit="return false;">
	<input type="hidden" id="reserveMode" name="editMode" value="ADD">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:startsWith(detail.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}">
</form>

<form id="untactBookReqForm" action="untactBook/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
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


<form id="sanghoReqForm" action="sangho/form.do" method="post">
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>


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
					<c:when test="${(empty detail.aladin or empty detail.aladin.cover) and empty detail.imageUrl}">
				<p class="noImg">
					<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="noImage"/>
				</p>
					</c:when>
					<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
						<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.imageUrl}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;font-size:20px;"><b>${detail.TITLE_INFO}</b></li>
					<li><strong>저자사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					</c:if>
					<li><strong>분류기호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한국십진분류법 : ${detail.CLASS_NO}</li>
					<c:if test="${not empty detail.APPENDIX_INFO}">
					<c:if test="${detail.APPENDIX_LIST[0].LOAN_CODE eq 'OK'}">
					<li><strong>부록여부</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.APPENDIX_INFO[0].DESCRIPTION} (${detail.APPENDIX_INFO[0].APPENDIX_CNT}개)</li>
					</c:if>
					</c:if>
					<c:if test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
					<li><strong>영어독서 레벨</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.marc}</li>
					</c:if>
				</ul>
			</div>
		</div>
		<c:if test="${detail.SHELF_LOC_CODE eq 'AD36'}">
			* 소장위치가 대구전자도서관인 경우, 실시간 대출가능 확인이 어렵습니다. 정확한 대출가능여부 확인은 대구전자도서관에 접속 대출가능 확인이 가능합니다.
		</c:if>
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
						<c:when test="${detail.LOAN_CODE eq 'OK'}">
							대출가능
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.WORKING_STATUS == 'BOL211O'}">
									<span style="color:#ff0000">대출불가(관외대출중)</span>
								</c:when>
								<c:when test="${detail.WORKING_STATUS == 'BOL213O'}">
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
									<c:choose>
										<c:when test="${detail.RESERVATION_CNT > 0}">
											<span style="color:#ff0000">대출불가(예약대출 대기중)</span>
										</c:when>
										<c:otherwise>
											<span style="color:#ff0000">대출불가</span>
										</c:otherwise>
									</c:choose>
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
		<div style="margin-top:20px;">
			<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />

			<c:if test="${getIp eq '218.48.151.16'}">
			<ul class="con">
				<li style="background:none;">
					<ul>
						<li>KBILL_LILL_YN : ${detail.KBILL_LILL_YN} </li>
						<li>SHELF_LOC_CODE : ${detail.SHELF_LOC_CODE} </li>
						<li>SEPARATE_SHELF_CODE : ${detail.SEPARATE_SHELF_CODE} </li>
						<li>REG_CODE : ${detail.REG_CODE}</li>
						<li>LOAN_CODE : ${detail.LOAN_CODE}</li>
						<li>RESERVE_CODE : ${detail.RESERVE_CODE}</li>
						<li>CONTEXT_PATH : ${homepage.context_path}</li>
						<li>MANAGE_CODE : ${detail.MANAGE_CODE}</li>
					</ul>
				</li>
			</ul>
			</c:if>
		</div>

		<!-- <c:if test="${homepage.context_path eq 'dalseolib'}">
			<p style="color:#ff0000;font-weight:bold;text-align:center;">
				* 본리도서관 장서점검으로 인한 상호대차 및 무인예약 신청 중지(7/6~7/16)를 안내드리오니, 많은 양해 부탁드립니다.
			</p>
		</c:if> -->

		<p></p>
		
		
		<div class="sbtn" style="text-align:center;">
			<c:if test="${detail.SANGHO_REQ_YN eq 'Y'}">
			<!-- <a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a> -->
			</c:if>

			<c:if test="${detail.WORKING_STATUS eq 'BOL112N'}">
			<!-- 북구통합도서관 상호대차 설정시작-->
			<c:choose>
				<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'GM'  || detail.MANAGE_CODE eq 'GJ'}">
						<!-- 북구영어  제외 -->
						</c:when>
						<c:otherwise>

							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>

						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan'}">
	
					<c:choose>
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${homepage.context_path eq 'junggu'}">
					<c:choose>
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${homepage.context_path eq 'dalseolib'}">

					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'FD'}">
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${homepage.context_path eq 'donggu'}">

					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HQ'}">
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:otherwise>

				</c:otherwise>
			</c:choose>
			</c:if>



			<c:choose>
				<c:when test="${detail.MANAGE_CODE eq 'BR'}">

					<!--워킹스루 시작-->
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' }">

					<c:choose>
						<c:when test="${detail.RESERVATION_CNT > '0'}">

						</c:when>
						<c:otherwise>
							<c:if test="${detail.SHELF_LOC_CODE eq 'BR01' || detail.SHELF_LOC_CODE eq 'BR02' || detail.SHELF_LOC_CODE eq 'BR03' || detail.SHELF_LOC_CODE eq 'BR05' || detail.SHELF_LOC_CODE eq 'BR06' || detail.SHELF_LOC_CODE eq 'BR07'}">
							<%
							org.joda.time.DateTime now = new org.joda.time.DateTime();
							int dayOfWeek = now.getDayOfWeek(); /* dayOfWeek 월 1 화 2 수 3 목 4 금 5 토 6 일 7 */
							int hour = now.getHourOfDay();

							if(9 <= hour && hour < 17)
							{
							%>
								<!-- <a href="#night" id="night-req" class="btn">워킹스루예약신청</a> -->
							<%
							}
							else
							{
							%>
								<!-- <a href="#" class="btn btn1" onclick="alert('신청가능 시간이 아닙니다.');">워킹스루예약신청</a> -->
							<%
							}
							%>
							<!-- <a href="#night" id="night-req" class="btn">워킹스루예약신청</a> -->
							</c:if>
						</c:otherwise>
					</c:choose>

					</c:if>

				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>
<!-- 
			<%
				org.joda.time.DateTime now = new org.joda.time.DateTime();
				int dayOfWeek = now.getDayOfWeek(); /* dayOfWeek 월 1 화 2 수 3 목 4 금 5 토 6 일 7 */
				int hour = now.getHourOfDay();
			%>
			 -->
			<!--비대면도서대출 버튼-->
			<c:if test="${sessionScope.member.member_id eq 'info8910' || sessionScope.member.member_id eq 'hwani6865'}">
				<a href="#untact" id="untactBook-req" class="btn btn2"><span>비대면 도서대출</span></a>
			</c:if>
			
			<c:choose>
				<c:when test="${homepage.context_path eq 'jungang'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AD46' || detail.SHELF_LOC_CODE eq 'AD47' || detail.SHELF_LOC_CODE eq 'AD48' || detail.SHELF_LOC_CODE eq 'AD49' || detail.SHELF_LOC_CODE eq 'AD51' || detail.SHELF_LOC_CODE eq 'AD52'}">

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
					<c:if test="${detail.SHELF_LOC_CODE eq 'AA03' || detail.SHELF_LOC_CODE eq 'AA04' || detail.SHELF_LOC_CODE eq 'AA09' || detail.SHELF_LOC_CODE eq 'AA10' || detail.SHELF_LOC_CODE eq 'AA11' || detail.SHELF_LOC_CODE eq 'AA14' || detail.SHELF_LOC_CODE eq 'AA15' || detail.SHELF_LOC_CODE eq 'AA16' || detail.SHELF_LOC_CODE eq 'AA17' || detail.SHELF_LOC_CODE eq 'AA18' || detail.SHELF_LOC_CODE eq 'AA20' || detail.SHELF_LOC_CODE eq 'AA21' || detail.SHELF_LOC_CODE eq 'AA22' || detail.SHELF_LOC_CODE eq 'AA23'}">
					
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
				<c:when test="${homepage.context_path eq 'dalseolib'}">
					<c:if test="${detail.MANAGE_CODE eq 'BU' || detail.MANAGE_CODE eq 'BV' || detail.MANAGE_CODE eq 'BW' || detail.MANAGE_CODE eq 'BY' || detail.MANAGE_CODE eq 'BX' || detail.MANAGE_CODE eq 'BZ'}">
						<c:if test="${detail.MEDIA_CODE eq 'PR'}">
							<c:choose>
								<c:when test="${detail.LOAN_CODE eq 'OK'}">
									<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
									<!-- <a href="#" class="btn btn1" onclick="alert('무인예약 이용자가 많아 신청이 불가합니다');">무인예약신청</a> -->
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>


			<c:choose>
				<c:when test="${detail.SHELF_LOC_CODE eq 'AD39' || detail.SHELF_LOC_CODE eq 'AD40' || detail.SHELF_LOC_CODE eq 'BA08' || detail.SHELF_LOC_CODE eq 'BA01' || detail.SHELF_LOC_CODE eq 'BD10'}">

				</c:when>
				<c:otherwise>

					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'FP'}">

						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.RESERVE_CODE eq 'OK'}">
									<a href="#" id="resve-req" class="btn btn1" style="padding:8.5px 2%">예약신청(${detail.RESERVATION_CNT} / ${detail.RESERVATION_NUMBER})</a>
								</c:when>
								<c:otherwise>
									<a href="#" id="resve-req-not" class="btn btn5" style="padding:8.5px 2%">예약불가(${detail.RESERVATION_CNT} / ${detail.RESERVATION_NUMBER})</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>

				</c:otherwise>
			</c:choose>

			<a href="#" id="addStorage" class="btn btn4"><span>관심도서 추가</span></a>

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
