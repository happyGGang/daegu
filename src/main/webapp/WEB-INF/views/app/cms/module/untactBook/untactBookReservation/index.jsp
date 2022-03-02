<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function checkAll($this) { 
	$('input:checkbox[name=request_number_arr]').prop('checked', $this.is(':checked'));
}

$(function(){
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.black_idx').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.black_idx').prop('checked', false);
		}
	});
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookReservation').serialize());
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookReservation.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookReservation.end_date}');

	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookReservation').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#untactBookReservation').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#untactBookReservation').attr('action', 'excelDownload.do').submit();
		$('#untactBookReservation').attr('action', 'save.do');
		e.preventDefault();
	});
	
});

function smsWrite() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('SMS발송을 하실 체크박스를 선택해주세요.');
	} else {
		modal_layer_add('dialog_layer');
		$.ajax({
			type: "POST",
			url: 'smsWrite.do',
			data: $('input[name=request_number_arr]').serialize(),
			success: function(html) { 
					$('#dialog_layer').html(html);
					$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
						resizable: false,
						modal: true,
						title: '관리자 SMS 발송',
						open: function(){
							$('.ui-widget-overlay').addClass('custom-overlay');
						},
						close: function(){
						},
						buttons: [
							{
								text: "닫기",
								"class": 'btn btn_round btn_gray',
								click: function() {
									$(this).dialog('close');
								}
							}
						]
					});

					$("#dialog_layer").dialog({
						width: 600,
						height: 500
					});
			},
			error : function() {
				alert('SMS발송에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
	}
}
</script>
<form:form id="untactBookReservation" modelAttribute="untactBookReservation" method="POST" action="save.do">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="search">
<label class="blind">검색</label>
	검색 결과 : ${untactBookReservationListCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${untactBookReservationListCount}">전체 보기</form:option>
	</form:select>
	대출단계 : 
	<form:select path="reservation_step" cssClass="selectmenu">
		<form:option value="">전체보기</form:option>
		<form:option value="1">예약</form:option>
		<form:option value="4">대출</form:option>
	</form:select>
	신청일 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
	<a href="#" class="btn btn1 btnuntact" onclick="smsWrite();">SMS발송</a>
</div>

<table class="type1 center">
	<thead>
		<tr>
			<th width="20"><input type="checkbox" onchange="checkAll($(this));"></th>
			<th width="5">번호</th>
			<th width="40">신청자아이디</th>
			<th width="50">대출번호</th>
			<th width="40">신청자명</th>
			<th width="50">신청일</th>
			<th width="50">비치일</th>
			<th width="50">도서명</th>
			<th width="30">사물함번호</th>
			<th width="40">비밀번호</th>
			<th width="30">대출단계</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(untactBookReservationList) < 1}">
		<tr style="height:100%">
			<td colspan="11" style="background:#f8fafb;">비대면 사물함 신청내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
		<tr>
			<td width="10"><form:checkbox path="request_number_arr" cssClass="black_idx" value="${i.request_number}"/></td>
			<td width="5">${paging.listRowNum - status.index}</td>
			<td width="40">${i.member_id}</td>
			<td width="50">${i.reg_no}</td>
			<td width="40">${i.member_name}</td>
			<td width="50">${i.request_date}</td>
			<td width="50">${i.loan_date}</td>
			<td width="50">${i.book_name}</td>
			<td width="30">${i.locker_number}</td>
			<c:choose>
				<c:when test="${i.locker_password eq 0}">
					<td width="40">미등록</td>
				</c:when>
				<c:otherwise>
					<td width="40">${i.locker_password}</td>
				</c:otherwise>
			</c:choose>
			<td width="30">${i.reservation_step_code_name}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#untactBookReservation"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="member_id">신청자아이디</form:option>
			<form:option value="reg_no">대출번호</form:option>
			<form:option value="member_name">신청자명</form:option>
			<form:option value="book_name">도서명</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
	
</form:form>