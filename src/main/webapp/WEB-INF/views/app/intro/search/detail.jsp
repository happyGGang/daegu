<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default2.css"/>

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

	$('a#resve-req-not').on('click', function(e) {
		e.preventDefault();
		alert('허용 예약인원이 다 찼습니다. 이용에 불편함을 드려 죄송합니다.');
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
				location.href = '/${context_path}/intro/search/deliveryBasket/index.do?menu_idx=${deliveryMenuMenuIdx}';
			}
		}
	});

	$('a.addStorage').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */

		window.open("/${context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=450, height=400");
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

	<%--청구기호 인쇄--%>
	$('a#btn_print').on('click', function(e) {
		e.preventDefault();
		var url = location.href.replace('detail', 'print');

		window.open(url, '_blank', 'toolbar=yes,scrollbars=yes,resizable=yes,top=100,left=100,width=700,height=500');
	});


	
});

</script>

<form id="storageReqForm" action="/${context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="editMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${detail.PUBLISHER}">
	<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${detail.ST_CODE}">
	<input type="hidden" id="img_url" name="img_url" value="${detail.IMAGE}">
</form>

<form id="resveReqForm" action="resve/save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="editMode" value="ADD">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:startsWith(detail.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}">
</form>

<form id="unmannedReqForm" action="unmanned/form.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
</form>

<form id="nightReqForm" action="night/form.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
</form>

<form id="basketReqForm" action="/${context_path}/intro/search/saveDeliveryBasket.do">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" id="book_key" name="book_key">
	<input type="hidden" name="editMode" value="ADD">
</form>

<form id="sanghoReqForm" action="sangho/form.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
</form>

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
					<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="noImage"/>
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
					<li style="line-height:150%;"><b>${detail.TITLE_INFO}</b></li>
					<li><strong>저자사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					</c:if>
					<li><strong>분류기호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한국십진분류법 : ${detail.CLASS_NO}</li>
					<c:if test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib'}">
					<li><strong>521CODE</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.marc}</li>
					</c:if>
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
				<td>${detail.CALL_NO}<br/>
				<c:choose>
					<c:when test="${detail.WORKING_STATUS eq 'BOL112N'}">
						<c:choose>
							<c:when test="${detail.RESERVATION_CNT > 0}">

							</c:when>
							<c:otherwise>

											<a href="#" id="btn_print" class="btn btn2">청구기호출력</a>

								
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
				</td>
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
		<div>
			<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />
			<c:if test="${getIp eq '218.48.151.16'}">
KBILL_LILL_YN : ${detail.KBILL_LILL_YN} <br/>
SHELF_LOC_CODE : ${detail.SHELF_LOC_CODE} <br/>
SEPARATE_SHELF_CODE : ${detail.SEPARATE_SHELF_CODE} <br/>
REG_CODE : ${detail.REG_CODE}<br/>
LOAN_CODE : ${detail.LOAN_CODE}<br/>
RESERVE_CODE : ${detail.RESERVE_CODE}<br/>
CONTEXT_PATH : ${context_path}
			</c:if>
		</div>

<c:if test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english'}">

</c:if>

		<div class="sbtn" style="text-align:center;">

			<c:if test="${detail.WORKING_STATUS eq 'BOL112N'}">
			<!-- 북구통합도서관 상호대차 설정시작-->
			<c:choose>
				<c:when test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'GM'}">
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

				<c:when test="${context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol'}">

					<c:choose>
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${context_path eq 'junggu'}">
					<c:choose>
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib'}">

					<c:choose>
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${context_path eq 'donggu' || context_path eq 'sincheon' || context_path eq 'donggusm'}">

					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HP' || detail.MANAGE_CODE eq 'HQ'}">
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
AD02  고전(인문)
AD03 북큐레이션(인문)
AD04 인문자료실
AD06 어린이실
AD07 아동인문코너
AD08 북큐레이션(어린이)
AD14 유아실
AD18 치매도서코너
AD19 북큐레이션(종합)
AD20 종합자료실
-->
			<%
				org.joda.time.DateTime now = new org.joda.time.DateTime();
				int dayOfWeek = now.getDayOfWeek(); /* dayOfWeek 월 1 화 2 수 3 목 4 금 5 토 6 일 7 */
				int hour = now.getHourOfDay();
			%>
			<c:choose>
				<c:when test="${context_path eq 'jungang'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AD02' || detail.SHELF_LOC_CODE eq 'AD03' || detail.SHELF_LOC_CODE eq 'AD04' || detail.SHELF_LOC_CODE eq 'AD18' || detail.SHELF_LOC_CODE eq 'AD19' || detail.SHELF_LOC_CODE eq 'AD20'}">
					<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
					<!-- <a href="#night" id="night-req" class="btn">야간예약신청</a> -->
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${context_path eq '228'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AA04'}">
					<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
					<!-- <a href="#night" id="night-req" class="btn">야간예약신청</a> -->
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${context_path eq 'dmsl'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${sessionScope.member.user_class_code eq '701'}">
					<a href="#muin" id="unmanned-req" class="btn">별관 이동도서관 신청</a>
					</c:if>
					</c:if>
					</c:if>
				</c:when>

				<c:when test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english'}">
					<c:if test="${detail.MANAGE_CODE eq 'BU' || detail.MANAGE_CODE eq 'BV' || detail.MANAGE_CODE eq 'BW' || detail.MANAGE_CODE eq 'BX' || detail.MANAGE_CODE eq 'BY' || detail.MANAGE_CODE eq 'BZ'}">
						<c:if test="${detail.MEDIA_CODE eq 'PR'}">
							<c:choose>
								<c:when test="${detail.LOAN_CODE eq 'OK'}">
									<%
									if(dayOfWeek == 1 || dayOfWeek == 7)
									{
									%>
										<a href="#muin" onclick="alert('무인예약 신청가능 요일이 아닙니다.');" class="btn">무인예약신청</a>
									<%
									}
									else
									{
									%>
										<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
									<%
									}
									%>
									<!-- <a href="#" class="btn btn1" onclick="alert('무인예약 이용자가 많아 신청이 불가합니다.');">무인예약신청</a> -->
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
						<c:when test="${detail.RESERVE_CODE eq 'OK'}">
							<a href="#" id="resve-req" class="btn">예약신청</a>
						</c:when>
						<c:otherwise>
							<a href="#" id="resve-req-not" class="btn btn5">예약불가</a>
						</c:otherwise>
					</c:choose>

				</c:otherwise>
			</c:choose>

			<c:if test="${detail.WORKING_STATUS ne 'BOL112N' and param.booktype ne 'NONBOOK'}">
			</c:if>

			<a href="javascript:history.back();" id="goBack" class="btn"><i class="fa fa-book"></i><span>목록으로</span></a>
		</div>
	</div>
</div>
