<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('returnList.do', $('form#search_nearbyLib').serialize());
	});
	 
	$('.selectmenu-search').on('change',function(e){
		$('#viewPage').val(1);
		$('#search_nearbyLib').submit();
		e.preventDefault();
	});
	
	$('#manage_code_1').on('change',function(e){
		$('#viewPage').val(1);
		$('#search_nearbyLib').submit();
		e.preventDefault();
	});

	$('.search_device').on('change',function(e){
		e.preventDefault();	 
		$('#device_idx').val($('.search_device option:selected').val());
		$('#search_nearbyLib').submit();
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLib.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLib.end_date}');
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('returnList.do', $('form#search_nearbyLib').serialize());
	});
	
	$('.reserve_save').on('click',function(e){
		e.preventDefault();
		if (!confirm('번호 ' + $(this).attr('keyValue1') + '번을 반납 완료처리 하시겠습니까?')) {
			return false;
		}
		$('#neighborhoodLibraryEdit #reserve_idx').val($(this).attr('keyValue5'));
		$('#neighborhoodLibraryEdit #device_code').val($(this).attr('keyValue4'));
		$('#neighborhoodLibraryEdit #device_idx').val($(this).attr('keyValue3'));
		$('#neighborhoodLibraryEdit #reserve_bundle_idx').val($(this).attr('keyValue6'));
		$('#neighborhoodLibraryEdit #reserve_status').val($(this).attr('keyValue2'));
		if (doAjaxPost($('form#neighborhoodLibraryEdit'))) {
			location.reload();
		}
	});
});
</script>
<style>
table thead th, table tbody td {font-size:12px;}
</style>
<form:form modelAttribute="nearbyLib" id="neighborhoodLibraryEdit" action="save.do">
	<form:hidden path="reserve_status"/>
	<form:hidden path="reserve_idx"/>
	<form:hidden path="reserve_bundle_idx"/>
	<form:hidden path="device_idx"/>
	<form:hidden path="device_code"/>
</form:form>

<form:form modelAttribute="nearbyLib" id="search_nearbyLib" action="returnList.do">
	<form:hidden path="homepage_id"/>
	<div class="search">
		검색 결과 : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> 건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		
		<c:if test="${asideHomepageId eq 'h1'}">
			<form:hidden path="manage_code" id="manage_code_1" value="AA"/>
		</c:if>
		<c:if test="${asideHomepageId eq 'h5'}">
			<form:hidden path="manage_code" id="manage_code_1" value="AH"/>
		</c:if>
		<c:if test="${asideHomepageId eq 'h45'}">
			도서관 :
			<form:select id="manage_code_1" path="manage_code" class="selectmenu">
				<form:option value="CA">동구통합 안심도서관</form:option>
				<form:option value="CB">동구통합 신천도서관</form:option>
			</form:select>
		</c:if>
		<c:if test="${asideHomepageId eq 'h46'}">
			<form:hidden id="manage_code_1" path="manage_code" value="BA"/>
		</c:if>
		<c:if test="${asideHomepageId eq 'h90'}">
			도서관 :
			<form:select id="manage_code_1" path="manage_code" class="selectmenu">
				<form:option value="">전체</form:option>
				<form:option value="AA">대구2·28기념학생도서관</form:option>
				<form:option value="BA">북구구수산도서관</form:option>
				<form:option value="AH">대구광역시립 동부도서관</form:option>
				<form:option value="CA">동구통합 안심도서관</form:option>
				<form:option value="CB">동구통합 신천도서관</form:option>
			</form:select>
		</c:if>
		
		장비명 : 
		<form:select class="selectmenu-search" style="width:300px" path="return_device_code">
			<form:option value="0">전체</form:option>
			<form:option value="cgvreturn0001">연경CGV</form:option>
			<form:option value="emartreturn0001">이시아MEGABOX</form:option>
			<form:option value="NEARBY_ESIA01">반야월이마트</form:option>
		</form:select>
		
		반납일 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	</div>

	<table class="type1 center">
		<colgroup>
			<col width="30"/>
			<col width="60"/>
			<col width="100"/>
			<col width="150"/>
			<col width="120"/>
			<col width="90"/>
			<col width="90"/>
			<col width="90"/>
			<col width="90"/>
			<col width="90"/>
 			<col width="80"/>
 			<col width="30"/>
		</colgroup>
		<thead>
			<tr>
				<th colspan="12" style="height: 36px;">반납 목록</th>						
			</tr>
			<tr style="outline:white 1px solid">
				<th>번호</th>
				<th>사물함번호</th>
				<th>예약번호</th>
				<th>도서명</th>
				<th>소장도서관</th>
				<th>등록번호</th>
				<th>청구기호</th>
				<th>대출자ID</th>
				<th>예약날짜</th>
				<th>예약확정일</th>
				<th>반납일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${returnCount > 0 }">
			<c:forEach var="i" items="${returnList}" varStatus="status">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td>
						<c:choose>
							<c:when test="${i.locker_idx > 0}">
								${i.locker_idx}
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					<td>${i.pk}</td>
					<td>${i.book_name}</td>
					<td>${i.lib_name}</td>
					<td>${i.reg_no}</td>
					<td>${i.call_no}</td>
					<td>${i.member_id}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
					<td><fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd"/></td>
					<td>${i.return_date}</td>
 					<td>
						<a href="#" class="btn reserve_save" style="border:1px black solid; color:black;" keyValue1="${returnCount - status.index }" keyValue2="10" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">반납완료</a>
 					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${returnCount <= 0 }">
				<tr>
					<td colspan="12">반납 데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#search_nearbyLib"/>
		<jsp:param name="pagingUrl" value="returnList.do"/>
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