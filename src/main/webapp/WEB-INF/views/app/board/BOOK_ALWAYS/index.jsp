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
	
	$(window).resize(function() {
		$('.search-results img').height($('img#refImg').width() * 0.6);
	}).trigger('resize');
});
</script>
<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y' and boardManage.manage_idx ne '195'}"></c:set>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="category1"/>
<form:hidden path="plan_date"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<c:if test="${fn:length(category1List) > 0}">
<div class="tabmenu tab1">
	<ul>
		<li class="${board.category1 eq null ? 'active':''}"><a href="" keyValue=""style="font-size: 13px;">전체</a></li>
		<c:forEach items="${category1List}" var="i" varStatus="status">
		<li class="${board.category1 eq i.code_id ? 'active':''}"><a href="" keyValue="${i.code_id}" style="font-size: 13px;">${i.code_name}</a></li>
		</c:forEach>
	</ul>
</div>
</c:if>
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
<div class="serial-wrap">
	<div class="smain">
		<div class="box">
			<div class="search-results">
				<c:forEach var="i" varStatus="status" items="${boardList}">
				<div class="row">
					<div class="thumb">
<%-- 					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
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
									<c:if test="${boardManage.manage_idx eq '195'}">
									<li>
										${i.imsi_v_18}
										<c:if test="${not empty i.imsi_v_17}"> [${i.imsi_v_17}]</c:if>
									</li>
									</c:if>
									<c:if test="${i.imsi_v_3 ne null and i.imsi_v_3 ne '' and i.imsi_v_3 ne '0'}">
									<li>저자 : ${fn:substring(i.imsi_v_3, 0, 20)}<c:if test="${fn:length(i.imsi_v_3) > 20}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_4 ne null and i.imsi_v_4 ne '' and i.imsi_v_4 ne '0'}">
									<li>출판사 : ${fn:substring(i.imsi_v_4, 0, 20)}<c:if test="${fn:length(i.imsi_v_4) > 20}">...</c:if></li>
									</c:if>
									<c:if test="${i.imsi_v_2 ne null and i.imsi_v_2 ne '0'}">
									<li>출판년도 : ${i.imsi_v_2}</li>
									</c:if>
									<c:if test="${boardManage.manage_idx ne '195'}">
									<c:if test="${i.imsi_v_6 ne null and i.imsi_v_6 ne '0'}">
									<li>소장자료실 : ${i.imsi_v_6}</li>
									</c:if>
									<c:if test="${i.imsi_v_7 ne null and i.imsi_v_7 ne '0'}">
									<li>청구기호 : ${i.imsi_v_7}</li>
									</c:if>
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