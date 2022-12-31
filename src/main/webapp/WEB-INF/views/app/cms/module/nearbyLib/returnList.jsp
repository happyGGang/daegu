<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('.search_device').on('change',function(e){
		e.preventDefault();	 
		$('#device_idx').val($('.search_device option:selected').val());
		$('#search_nearbyLib').submit();
	});
	
	$('.reserve_save').on('click',function(e){
		e.preventDefault();
		if (!confirm('번호 ' + $(this).attr('keyValue1') + '번을 반납 완료처리 하시겠습니까?')) {
			return false;
		}
		$('#neighborhoodLibraryEdit #reserve_idx').val($(this).attr('keyValue6'));
		$('#neighborhoodLibraryEdit #device_code').val($(this).attr('keyValue5'));
		$('#neighborhoodLibraryEdit #device_idx').val($(this).attr('keyValue4'));
		$('#neighborhoodLibraryEdit #reserve_bundle_idx').val($(this).attr('keyValue3'));
		$('#neighborhoodLibraryEdit #reserve_status').val($(this).attr('keyValue2'));
		if (doAjaxPost($('form#search_nearbyLib'))) {
			location.reload();
		}
	});
});
</script>
<form:form modelAttribute="nearbyLib" id="search_nearbyLib" action="returnList.do">
<%-- 	<form:hidden path="device_idx"/> --%>
<!-- 	<div class="infodesk"> -->
<!-- 		<h3>내집앞도서관 반납 목록</h3><br/> -->
<!-- 		사물함 명 :  -->
<%-- 		<form:select class="search_device" style="width:300px" path="device_idx"> --%>
<%-- 			<c:forEach var="i" items="${deviceList}"> --%>
<%-- 				<option value="${i.device_idx}"<c:if test="${i.device_idx eq nearbyLib.device_idx }">selected="selected"</c:if>>${i.device_name}</option> --%>
<%-- 			</c:forEach> --%>
<%-- 		</form:select> --%>
<!-- 	</div> -->
	<table class="type1 center">
		<colgroup>
			<col width="30" />
			<col width="60" />
			<col width="100" />
			<col width="150" />
			<col width="120" />
			<col width="90" />
			<col width="90" />
			<col width="90" />
			<col width="90" />
			<col width="80" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="10" style="height: 36px;">반납 목록</th>						
			</tr>
			<tr style="outline:white 1px solid">
				<th>번호</th>
				<th>사물함번호</th>
				<th>예약번호</th>
				<th>도서명</th>
				<th>소장도서관</th>
				<th>등록번호</th>
				<th>대출자ID</th>
				<th>예약날짜</th>
				<th>예약확정일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${returnCount > 0 }">
			<c:forEach var="j" items="${returnList}" varStatus="status">
				<tr>
					<td>${returnCount - status.index }</td>
					<td>${j.locker_idx }</td>
					<td>${j.pk }</td>
					<td>${j.book_name }</td>
					<td>${j.lib_name }</td>
					<td>${j.reg_no }</td>
					<td>${j.member_id }</td>
					<td><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd" /></td>
					<td><fmt:formatDate value="${j.lend_date}" pattern="yyyy.MM.dd" /></td>
					<td>
						<a href="#" class="btn reserve_save" style="border:1px black solid; color:black;" keyValue1="${returnCount - status.index }" keyValue2="10" keyValue3="${j.device_idx }" keyValue4="${j.device_code}" keyValue5="${j.reserve_idx }" keyValue6="${j.reserve_bundle_idx }">반납완료</a>
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${returnCount <= 0 }">
				<tr>
					<td colspan="10">반납 데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form:form>