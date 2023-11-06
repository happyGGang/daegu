<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('.btn-status').on('click', function(e) {
		e.preventDefault();
		$('#request_status').val($(this).attr('keyValue'));
		doGetLoad('list.do', serializeCustom($('#bookExpress')));
	});
	
	$('#request_status').on('change', function(e) {
		e.preventDefault();
		doGetLoad('list.do', serializeCustom($('#bookExpress')));
	});
	
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.book_check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.book_check').prop('checked', false);
		}
	});
	
	$('#all_status').on('click', function(e) {
		if($('.book_check:checked').length == 0) {
			alert('변경할 항목을 선택하세요.');
			return false;
		}
		
		if(confirm('선택도서를 수정하시겠습니까?')) {
			$('#request_status').val($('#select_status').val());
			$('#editMode').val('STATUS');
			if(doAjaxPost($('#bookExpress'))) {
				location.reload();
			}
		}
	});
	// 일괄 등록
	$('#all-check2').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.book_check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.book_check').prop('checked', false);
		}
	});
	
	
	$('#all_status2').on('click', function(e) {
		e.preventDefault();
		if($('.book_check:checked').length == 0) {
			alert('변경할 항목을 선택하세요.');
			return false;
		}
		var	express_idx = [];
		var txt_name = $(this).siblings('.txt_name2').val();
		var txt_phone = $(this).siblings('.txt_phone2').val();
		
		if(confirm('선택도서의 신청자를 등록하시겠습니까?')) {
			e.preventDefault();
			$('input[name="book_express_arr"]:checked').each(function(){
				express_idx.push($(this).val());
			});
				$('#book_express_arr').val(express_idx);
				$('#editMode').val('REQUEST');
				$('#request_name').val(txt_name);
				$('#request_phone').val(txt_phone);
			if(doAjaxPost($('#bookExpress'))){
				console.log("ajax종료");
				location.reload();
			}
		}
	});
	
	$('.add-reason').on('click', function(e) {
		e.preventDefault();
		var express_idx = $(this).attr('keyValue');
		var reason = $(this).siblings('.txt-reason').val();
		
		$('#editMode').val('REASON');
		$('#book_express_idx').val(express_idx);
		$('#reason').val(reason);
		doAjaxPost($('#bookExpress'));
	});
	
	$('.add-request').on('click', function(e) {
		e.preventDefault();
		var express_idx = $(this).attr('keyValue');
		var txt_name = $(this).siblings('.txt_name').val();
		var txt_phone = $(this).siblings('.txt_phone').val();
		
		$('#editMode').val('REQUEST');
		$('#book_express_idx').val(express_idx);
		$('#request_name').val(txt_name);
		$('#request_phone').val(txt_phone);
		doAjaxPost($('#bookExpress'));
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#bookExpress').attr('action', 'list.do');
		$('#bookExpress').attr('method', 'GET');
		$('#viewPage').val(1);
		doGetLoad('list.do', serializeCustom($('#bookExpress')));
	});
	
	$('a#btn-excel').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm').attr('action', 'excelDownload.do?request_status='+$('#request_status').val());
		$('#excelDownForm').submit();
	});
	
	$('a.cancel').on('click', function(e) {
		e.preventDefault();
		$('#book_express_idx').val($(this).attr('keyValue'));
		$('#editMode').val('CANCEL');
		if(doAjaxPost($('form#bookExpress'))) {
			location.reload();
		}
	});
	
});
</script>

<form:form id="excelDownForm" modelAttribute="bookExpress" action="excelDownload.do" method="POST">
</form:form>

<form:form modelAttribute="bookExpress" action="save.do" method="POST">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode" value="MODIFY"/>
<form:hidden path="book_express_idx"/>
<form:hidden path="reason"/>
<form:hidden path="request_name"/>
<form:hidden path="request_phone"/>
<div>
	<span><a href="#" class="btn-status" keyValue="">전체 : ${paging.totalDataCount}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="1" style="color: #AAAAAA;">신청중 : ${statusCount.STATUS1}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="2">처리중 : ${statusCount.STATUS2}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="3" style="color: #FF0000;">처리불가 : ${statusCount.STATUS3}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="4" style="color: #FF8800;">보류 : ${statusCount.STATUS4}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="5" style="color: #4488BB;">발송완료 : ${statusCount.STATUS5}</a></span>
	<span>|</span>
	<span><a href="#" class="btn-status" keyValue="6" style="color: #008800;">반납 : ${statusCount.STATUS6}</a></span>
</div>
<div>
	전체 ${paging.totalDataCount}개 (페이지 ${paging.viewPage}/${paging.totalPageCount})
	<a href="#" id="btn-excel" class="btn">EXCEL</a>
	<form:select path="request_status" cssClass="selectmenu">
		<form:option value="">전체</form:option>
		<form:option value="1">신청중</form:option>
		<form:option value="2">처리중</form:option>
		<form:option value="3">불가</form:option>
		<form:option value="4">보류</form:option>
		<form:option value="5">완료</form:option>
		<form:option value="6">반납</form:option>
	</form:select>
</div>
<br>
<div>
	<table class="type2 center">
		<colgroup>
			<col width="60" />
			<col width="70" />
			<col width="*" />
			<col width="170" />
			<col width="100" />
			<col width="120" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>도서정보</th>
				<th>요청학교/신청자</th>
				<th>상태</th>
				<th>요청일</th>
				<th>처리일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bookExpressList}" var="i" varStatus="status">
			<tr>
				<td><form:checkbox path="book_express_arr" cssClass="book_check" value="${i.book_express_idx}"/></td>
				<td class="num">${paging.listRowNum - status.index}</td>
				<td class="left">
					<c:forEach items="${homepageList}" var="j">
					<c:if test="${j.lib_code eq i.library_code and j.homepage_id != 'h32'}">
					[${j.homepage_name}]
					</c:if>
					</c:forEach>
					<br>${i.book_name}
					<br>청구기호 : ${i.book_call_no}
					<br>등록번호 : ${i.book_reg_no}
					<c:if test="${i.request_status eq '3'}">
						<br><span style="color: red;">불가사유</span>&nbsp;:&nbsp;
						<c:choose>
							<c:when test="${loginPortal.auth_group eq '3'}">
								${i.reason}
							</c:when>
							<c:otherwise>
								<input type="text" class="txt-reason" value="${i.reason}" width="150">
								<a href="#" class="add-reason" keyValue="${i.book_express_idx}">[등록]</a>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td>
					${i.agency_name}<br>
					<c:choose>
						<c:when test="${i.request_status eq '1' and loginPortal.auth_group eq '3'}">
						<input type="text" class="txt_name" value="${i.request_name}" placeholder="신청자명"><br>
						<input type="text" class="txt_phone" value="${i.request_phone}" placeholder="연락처"><br>
						<a href="#" class="add-request" keyValue="${i.book_express_idx}">[등록]</a>
						</c:when>
						<c:when test="${not empty i.request_name and not empty i.request_phone}">
						${i.request_name}<br>
						${i.request_phone}
						</c:when>
						<c:otherwise>
							등록된 정보없음
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${i.request_status eq '1'}"><span style="color: #AAAAAA;">신청중</span></c:when>
						<c:when test="${i.request_status eq '2'}"><span>처리중</span></c:when>
						<c:when test="${i.request_status eq '3'}"><span style="color: #FF0000;">처리불가</span></c:when>
						<c:when test="${i.request_status eq '4'}"><span style="color: #FF8800;">보류</span></c:when>
						<c:when test="${i.request_status eq '5'}"><span style="color: #4488BB;">발송완료</span></c:when>
						<c:when test="${i.request_status eq '6'}"><span style="color: #008800;">반납</span></c:when>
					</c:choose>
					<c:if test="${i.request_status eq '1'}">
					<a href="#" style="display: block;" class="cancel" keyValue="${i.book_express_idx}">신청취소</a>
					</c:if>
				</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
				<td><fmt:formatDate value="${i.request_date}" pattern="yyyy.MM.dd"/></td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(bookExpressList) < 1}">
			<tr>
				<td colspan="7">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<c:if test="${loginPortal.auth_group eq '1' or loginPortal.auth_group eq '2'}">
	<br>
		<a href="#" id="all-check" class="btn" keyValue="N">전체 선택/해제</a>
		<span>선택도서를</span>
		<select	id="select_status" class="selectmenu">
			<option value="2">처리중</option>
			<option value="3">처리불가</option>
			<option value="4">보류</option>
			<option value="5">처리완료</option>
			<option value="6">반납완료</option>
		</select>
		으로
		<a href="#" id="all_status" class="btn">변경</a><br>
	</c:if>
	<div style="margin-top:10px;">
		<a href="#" id="all-check2" class="btn" keyValue="N">전체 선택/해제</a>
		<span style="float:right;">
			<span style="line-height:170%;">선택한 도서의 신청자명,연락처 정보 입력</span>
			<input type="text" class="txt_name2" placeholder="신청자명" style="padding:3px 10px 6px;border:1px solid #ddd;width:120px;">
			<input type="text" class="txt_phone2" placeholder="연락처" style="padding:3px 10px 6px;border:1px solid #ddd;width:120px;">
			<a href="#" id="all_status2" class="btn">등록</a>
		</span>
	</div>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookExpress"/>
	<jsp:param name="pagingUrl" value="list.do"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="book_name">도서명</form:option>
			<form:option value="book_call_no">청구기호</form:option>
			<form:option value="agency_name">요청학교명</form:option>
			<form:option value="library_code">도서관명</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
<div class="ui-state-highlight">
		<em>* 도서관명으로 검색 시, '시립 도서관명'으로 검색해주시기 바랍니다. (ex. 시립 두류 or 시립 수성도서관)</em><br/>
		<em>* 2.28기념도서관 검색 시, 반드시 '28기념'으로 검색해주시기 바랍니다.</em>
</div>
</form:form>