<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script type="text/javascript">
$(document).ready(function() {
	var $form = $('#board');

	<%-- 등록 --%>
	$('a#board_edit_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'edit.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});


	<c:choose>
		<c:when test="${boardManage.manage_idx == 236}">
	<%-- 상세보기 --%>
	$('div.row a').on('click', function(e) {
		e.preventDefault();
		location.href = $(this).attr('keyValue2');
	});
		</c:when>
		<c:otherwise>
	<%-- 상세보기 --%>
	$('div.row a').on('click', function(e) {
		e.preventDefault();
		$('#board_idx').val($(this).attr('keyValue'));
		var url = 'view.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
		</c:otherwise>
	</c:choose>

	$('div.tabmenu a').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		$('input#category1').attr('value', $(this).attr('keyValue'));
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('select#rowCount').on('change', function() {
		var url = 'index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	<c:if test="${authMBA}">
	$('a#board_deleteRecovery_btn').on('click', function(e) {
		e.preventDefault();
		var url = '../boardDelete/index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a#board_manage_btn').on('click', function(e) {
		e.preventDefault();
		var url = '../board/index.do';
		$('input#board_mode').val('admin');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});


	$('a#board_normal_btn').on('click', function(e) {
		e.preventDefault();
		var url = '../board/index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	</c:if>
});
</script>
<script type="text/javascript">
$(function() {

	$(window).resize(function() {
		$('.search-results img').height($('img#refImg').width() * 0.6);
		<c:choose>
		<c:when test="${isMobile}">
		$('div.thumb img').height($('div.thumb img').width() * 1.7);
		</c:when>

		<c:otherwise>
		$('div.thumb img').height($('div.thumb img').width() * 1.5);
		</c:otherwise>
		</c:choose>
	}).trigger('resize');

	var heights = $(".search-results img").map(function(){
	    return $(this).height();
	}).get(),
	maxHeight = Math.max.apply(null, heights);

	$(window).resize(function() {
		<c:choose>
		<c:when test="${isMobile}">
// 		$('.row').height(maxHeight+60);
		</c:when>

		<c:otherwise>
// 		$('.row').height(maxHeight+10);
		</c:otherwise>
		</c:choose>
	}).trigger('resize');

	$(function(){

		var sysDate = new Date();
		var year = sysDate.getFullYear();
		var month = sysDate.getMonth()+1;
		//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
		var planDate = '${board.plan_date}'.split('-');
		for ( var i = 0; i < 15; i ++ ) {
			var optionYear = (year + 1 - i);
			var selectedAttr = '';

			if ( optionYear == planDate[0] ) {
				selectedAttr = 'selected="selected"';
			}

			$('#plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
		}
		// 월 초기화
		for ( var j = 1; j < 13; j ++ ) {
			var valueMonth = '0'+j;
			var selectedAttr = '';
			valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

			if ( j == planDate[1] ) {
				selectedAttr = 'selected="selected"';
			}

			$('#plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
		}

		$('#plan_year,#plan_month').on('change', function(e) {
// 			var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
// 			$('#plan_date').val(planDate);
// 			doGetLoad('index.do', serializeCustom($('#board')));
		});

		$('a#monthSelect').on('click', function() {
			var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
			$('#plan_date').val(planDate);
			$('#viewPage').val('1');
			doGetLoad('index.do', serializeCustom($('#board')));
		});

		$('a#before-btn').on('click', function(event) {
			event.preventDefault();

			var year = $('#plan_year').val();
			var month = $('#plan_month').val();

			if(month == 1) {
				year = parseInt(year)-1;
				month = 12;
			} else {
				month =  parseInt(month)-1;
			}
			month = month < 10 ? "0"+month : month;
			var planDate = year + '-' + month;
			$('#plan_date').val(planDate);
			$('#viewPage').val('1');
			doGetLoad('index.do', serializeCustom($('#board')));

		});

		$('a#next-btn').on('click', function(event) {
			event.preventDefault();

			var year = $('#plan_year').val();
			var month = $('#plan_month').val();

			if(month == 12) {
				year = parseInt(year)+1;
				month = 1;
			} else {
				month =  parseInt(month)+1;
			}

			month = month < 10 ? "0"+month : month;

			var planDate = year + '-' + month;
			$('#plan_date').val(planDate);
			$('#viewPage').val('1');
			doGetLoad('index.do', serializeCustom($('#board')));

		});

		<c:if test="${boardManage.manage_idx eq '236' }">
		$('a#libSelect').on('click', function() {
			doGetLoad('index.do', serializeCustom($('#board')));
		});
		$('select#homepage_id').on('change', function() {
// 			doGetLoad('index.do', serializeCustom($('#board')));
		});
		</c:if>
	});
});
</script>
<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y'}"></c:set>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="category1"/>
<form:hidden path="plan_date"/>
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<c:if test="${fn:length(category1List) > 0}">
<div class="tabmenu tab1">
	<ul>
		<li class="${board.category1 eq null ? 'active':''}"><a href="" keyValue="">전체</a></li>
		<c:forEach items="${category1List}" var="i" varStatus="status">
		<li class="${board.category1 eq i.code_id ? 'active':''}"><a href="" keyValue="${i.code_id}">${i.code_name}</a></li>
		</c:forEach>
	</ul>
</div>
</c:if>
<c:choose>
	<c:when test="${boardManage.manage_idx eq '236' }">
		<div class="ym_btns" style="float: left; width: 200px;">
			<form:select path="homepage_id" cssClass="selectmenu" cssStyle="width: 250px;" title="도서관 선택">
				<form:option value="" label="전체도서관" />
				<c:forEach var="i" varStatus="status" items="${homepageList}">
				<c:if test="${i.homepage_type eq '2'}">
				<c:if test="${i.homepage_id ne 'h1' and i.homepage_id ne 'h33' and i.homepage_id ne 'h28' and i.homepage_id ne 'h30' and i.homepage_id ne 'h29' and i.homepage_id ne 'h32'}">
				<form:option value="${i.homepage_id}" label="${i.homepage_name}" />
				</c:if>
				</c:if>
				</c:forEach>
			</form:select>
			<a href="#" id="libSelect" class="btn1 btn">이동</a>
		</div>
		<div style="float:right;" class="txt-right ym_btns">
			<a id="before-btn" href="#prev" class="btn prev new_btn01"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<form:select path="plan_year" class="new_select_box" style="width:80px;" title="년"></form:select>
			<form:select path="plan_month" class="new_select_box" style="width:65px;" title="월"></form:select>
			<a href="#" id="monthSelect" class="btn btn1">이동</a>
			<a id="next-btn" href="#next" class="btn next new_btn01"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="txt-right ym_btns">
			<a id="before-btn" href="#prev" class="btn prev new_btn01"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<form:select path="plan_year" class="new_select_box" style="width:80px;" title="년"></form:select>
			<form:select path="plan_month" class="new_select_box" style="width:65px;" title="월"></form:select>
			<a href="#" id="monthSelect" class="btn btn1">이동</a>
			<a id="next-btn" href="#next" class="btn next new_btn01"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
		</div>
	</c:otherwise>
</c:choose>

<div class="serial-wrap" style="clear: both;">
	<div class="smain">
		<div class="box">
			<div class="search-results">
				<c:forEach var="i" varStatus="status" items="${boardList}">
				<div class="row">
					<div class="thumb">
<%-- 					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
					<c:if test="${not empty authMBA and authMBA or member.admin}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
						<c:choose>
							<c:when test="${i.preview_img ne null}">
								<c:choose>
									<c:when test="${fn:contains(i.preview_img, 'http')}">
								<a href="" keyValue="${i.board_idx}" keyValue2="/${i.imsi_v_19}/board/view.do?menu_idx=${i.imsi_n_2}&board_idx=${i.board_idx}&manage_idx=${i.manage_idx}">>
									<img src="${i.preview_img}" alt="${i.title}"/>
								</a>
									</c:when>
									<c:otherwise>
								<a href="" keyValue="${i.board_idx}" keyValue2="/${i.imsi_v_19}/board/view.do?menu_idx=${i.imsi_n_2}&board_idx=${i.board_idx}&manage_idx=${i.manage_idx}">
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/>
								</a>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<a href="" keyValue="${i.board_idx}" keyValue2="/${i.imsi_v_19}/board/view.do?menu_idx=${i.imsi_n_2}&board_idx=${i.board_idx}&manage_idx=${i.manage_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}"></a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="box">
						<div class="item">
							<div class="bif">
								<a href="" class="name" title="${i.title}" style="padding: 0px;" keyValue="${i.board_idx}" keyValue2="/${i.imsi_v_19}/board/view.do?menu_idx=${i.imsi_n_2}&board_idx=${i.board_idx}&manage_idx=${i.manage_idx}">
									${fn:substring(i.title, 0, 15)}<c:if test="${fn:length(i.title) > 15}">...</c:if>
								</a>
								<ul class="con2" style="padding: 0px;">
									<c:if test="${boardManage.manage_idx eq '236'}">
									<li class="${i.imsi_v_19}" style="font-weight: bold; font-size: 18px;">${i.imsi_v_18}</li>
									</c:if>
									<c:if test="${i.imsi_v_1 ne '' and i.imsi_v_2 ne ''}">
									<li style="font-size: 15px;">상영일시 : <strong>${i.imsi_v_1}-${i.imsi_v_2}</strong>
										<c:if test="${i.imsi_v_3 ne null and i.imsi_v_4 ne null}"><strong>${i.imsi_v_3}:${i.imsi_v_4}</strong></c:if>
									</li>
									</c:if>
									<c:if test="${i.imsi_v_6 ne null and i.imsi_v_6 ne '0'}">
									<li>상영장소 : ${i.imsi_v_6}</li>
									</c:if>
									<c:if test="${i.imsi_v_13 ne null and i.imsi_v_13 ne '0'}">
									<li>상영시간 : ${i.imsi_v_13}(분)</li>
									</c:if>
									<c:if test="${i.imsi_v_7 ne null and i.imsi_v_7 ne '0'}">
									<li>감독 : ${fn:substring(i.imsi_v_7, 0, 15)}<c:if test="${fn:length(i.imsi_v_7) > 15}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_8 ne null and i.imsi_v_8 ne '0'}">
									<li>출연 : ${fn:substring(i.imsi_v_8, 0, 15)}<c:if test="${fn:length(i.imsi_v_8) > 15}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_9 ne null and i.imsi_v_9 ne '0'}">
									<li>장르 : ${fn:substring(i.imsi_v_9, 0, 15)}<c:if test="${fn:length(i.imsi_v_9) > 15}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_12 ne null and i.imsi_v_12 ne '0'}">
									<li>등급 :${fn:substring(i.imsi_v_12, 0, 15)}<c:if test="${fn:length(i.imsi_v_12) > 15}">...</c:if></li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				<c:if test="${fn:length(boardList) < 1}">
				<div class="nodata">
					<i class="fa fa-frown-o"></i>
					<c:choose>
					<c:when test="${param.manage_idx eq '728'}">
					<p>코로나-19로 인해 토요일 어린이(가족)영화 상영은 중단되었습니다</p>
					</c:when>
					<c:otherwise>
					<p>등록된 데이터가 없습니다.</p>
					</c:otherwise>
					</c:choose>
				</div>
				</c:if>

			</div>
			<c:if test="${boardManage.manage_idx ne '236' }">
			<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
			</c:if>
			<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
				<jsp:param name="formId" value="#board"/>
			</jsp:include>
		</div>
	</div>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>

<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="noImage" style="display: none; width: 310px;">