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

	<%-- 상세보기 --%>
	$('div.row a').on('click', function(e) {
		e.preventDefault();
		$('#board_idx').val($(this).attr('keyValue'));
		var url = 'view.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

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

// 	$('a#board_manage_btn').on('click', function(e) {
// 		e.preventDefault();
// 		var url = '../board/index.do';
// 		$('input#board_mode').val('admin');
// 		var formData = serializeCustom($form);
// 		doGetLoad(url, formData);
// 	});

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
			doGetLoad('index.do', serializeCustom($('#board')));

		});

		$('a#monthSelect').on('click', function() {
			var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
			$('#plan_date').val(planDate);
			$('#viewPage').val('1');
			doGetLoad('index.do', serializeCustom($('#board')));
		});
		
	});
});
</script>
<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y' and boardManage.manage_idx ne '195'}"></c:set>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="plan_date"/>
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<c:if test="${boardManage.manage_idx eq '195'}">
<div style="float: left;">
도서관 :
	<form:select path="homepage_id" cssClass="selectmenu" cssStyle="width:250px;" title="도서관 선택">
		<form:option value="" label="-전체-"></form:option>
		<c:forEach var="i" varStatus="status" items="${homepageList}">
		<c:if test="${i.homepage_id ne 'h31' and i.homepage_id ne 'h33' and i.homepage_id ne 'h34'}">
		<form:option value="${i.homepage_id}" label="${i.homepage_name}" />
		</c:if>
		</c:forEach>
	</form:select>
	<a href="#" id="libSelect" class="btn1 btn">이동</a>
</div>
</c:if>
<div class="txt-left">
	구분 :
	<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu">
		<form:option value="" label="전체"/>
		<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
	</form:select>
	
	도서관명:
	<form:select path="category2" cssStyle="width:160px;" cssClass="selectmenu">
		<form:option value="" label="전체"/>
		<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
	</form:select>
</div>
<div class="txt-right ym_btns">
	추천년월 :
	<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
	<label for="plan_year"></label>
	<form:select path="plan_year" class="" style="width:80px;height:28px;"></form:select>
	<label for="plan_month"></label>
	<form:select path="plan_month" class="" style="width:65px;height:28px;"></form:select>
	<a href="#" id="monthSelect" class="btn btn1">이동</a>
	<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
</div>
<div class="serial-wrap">
	<div class="smain">
		<div class="box">
			<div class="search-results">
				<c:forEach var="i" varStatus="status" items="${boardList}">
				<div class="row">
					<div class="thumb">
					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
						<c:choose>
							<c:when test="${i.preview_img ne null}">
								<c:choose>
									<c:when test="${fn:contains(i.preview_img, 'http')}">
								<a href="" keyValue="${i.board_idx}">
									<img src="${i.preview_img}" alt="${i.title}" title="${i.title}"/>
								</a>
									</c:when>
									<c:otherwise>
								<a href="" keyValue="${i.board_idx}">
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
								</a>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<a href="" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}"></a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="box">
						<div class="item">
							<div class="bif">
								<a href="" class="name" keyValue="${i.board_idx}" title="${i.title}">
									${fn:substring(i.title, 0, 30)}<c:if test="${fn:length(i.title) > 30}">...</c:if>
								</a>
								<ul class="con2">
									<c:if test="${i.imsi_v_3 ne null and i.imsi_v_3 ne '' and i.imsi_v_3 ne '0'}">
									<li>저자 : ${fn:substring(i.imsi_v_3, 0, 20)}<c:if test="${fn:length(i.imsi_v_3) > 20}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_4 ne null and i.imsi_v_4 ne '' and i.imsi_v_4 ne '0'}">
									<li>출판사 : ${fn:substring(i.imsi_v_4, 0, 20)}<c:if test="${fn:length(i.imsi_v_4) > 20}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_2 ne null and i.imsi_v_2 ne '0'}">
									<li>출판년도 : ${i.imsi_v_2}</li>
									</c:if>
									<li>
										구분 :
										<c:forEach items="${category1List}" var="cate1">
											<c:if test="${cate1.code_id eq i.category1}">${cate1.code_name}</c:if>
										</c:forEach>
									</li>
									<li>
										도서관명 :
										<c:forEach items="${category2List}" var="cate2">
											<c:if test="${cate2.code_id eq i.category2}">${cate2.code_name}</c:if>
										</c:forEach>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				<c:if test="${fn:length(boardList) < 1}">
				<div class="nodata">
					<i class="fa fa-frown-o"></i>
					<p>등록된 데이터가 없습니다.</p>
				</div>
				</c:if>

			</div>
			<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />

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

<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">