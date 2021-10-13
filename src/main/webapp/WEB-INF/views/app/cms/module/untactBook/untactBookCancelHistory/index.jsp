<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookCancelHistory').serialize());
	});
	
	$('input#cancel_start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#cancel_end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookCancelHistory.cancel_start_date}');
	$('input#cancel_end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#cancel_start_date').val(), 
		onClose: function(selectedDate){
			$('input#cancel_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookCancelHistory.cancel_end_date}');

	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookCancelHistory').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#untactBookCancelHistory').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
			$('#untactBookCancelHistory').attr('action', 'excelDownload.do').submit();
			$('#untactBookCancelHistory').attr('action', 'save.do')
		e.preventDefault();
	});
	
});
</script>
<form:form id="untactBookCancelHistory" modelAttribute="untactBookCancelHistory" method="POST" action="save.do">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="search">
<label class="blind">검색</label>
	검색 결과 : ${untactBookCancelHistoryCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${untactBookCancelHistoryCount}">전체 보기</form:option>
	</form:select>
	
	취소날짜 : <form:input path="cancel_start_date" class="text ui-calendar"/> ~ <form:input path="cancel_end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
</div>

<table class="type1 center">
	<thead>
		<tr>
			<th width="10">번호</th>
			<th width="50">사물함번호</th>
			<th width="50">신청자아이디</th>
			<th width="50">신청자명</th>
			<th width="50">취소날짜</th>
			<th width="50">취소사유</th>
			<th width="50">취소ID</th>
			<th width="50">취소IP</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(untactBookCancelHistoryList) < 1}">
		<tr style="height:100%">
			<td colspan="10" style="background:#f8fafb;">비대면 사물함 취소내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${untactBookCancelHistoryList}">
		<tr>
			<td width="50">${paging.listRowNum - status.index}</td>
			<td width="50">${i.locker_number}</td>
			<td width="50">${i.member_id}</td>
			<td width="50">${i.member_name}</td>
			<td width="50">${i.cancel_date}</td>
			<td width="50">${i.cancel_reason}</td>
			<td width="50">${i.cancel_id}</td>
			<td width="50">${i.cancel_ip}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#untactBookCancelHistory"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="member_id">신청자아이디</form:option>
			<form:option value="member_name">신청자명</form:option>
			<form:option value="cancel_id">취소아이디</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
	
</form:form>