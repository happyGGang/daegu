<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	var $form = $('#facilityBookStatus');
		
	$('select.apply_status_change').on('change', function(e) {
		e.preventDefault();
		if(confirm('선택한 신청 상태를 변경하시겠습니까?')) {
			$('#statusMode').val('STATUS');
			$('#status_facility_book_idx').val($(this).attr('keyValue'));
			$('#status_apply_status').val($(this).val());
			$('#status_view_page').val($('#viewPage').val());
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	$('a#chk-delete').on('click', function(e) {
		e.preventDefault();
		
		$('input[name=facility_book_arr]:checked').each(function() {
		    $form.append('<input type="hidden" name="facility_book_arr" value="' + $(this).val() + '"/>');
		});
		
		if(confirm('선택 삭제 하시겠습니까?')) {
			$('#statusMode').val('DELETE_REQ');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	$('a#chk-status').on('click', function(e) {
		e.preventDefault();
		
		$('input[name=facility_book_arr]:checked').each(function() {
		    $form.append('<input type="hidden" name="facility_book_arr" value="' + $(this).val() + '"/>');
		});
		
		if(confirm('선택 일괄 승인 하시겠습니까?')) {
			$('#statusMode').val('STATUS_CHK');
			$('#facility_book_arr').val($(''));
			$('#status_apply_status').val(1);
			$('#status_view_page').val($('#viewPage').val());
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
});
</script>
<form:form modelAttribute="facilityBook" id="facilityBookStatus" action="save.do" method="POST">
<form:hidden path="editMode" id="statusMode"/>
<form:hidden path="homepage_id" id="status_homepage_id"/>
<form:hidden path="facility_book_idx" id="status_facility_book_idx"/>
<form:hidden path="apply_status" id="status_apply_status"/>
<form:hidden path="viewPage" id="status_view_page"/>
</form:form>
<form:form modelAttribute="facilityBook" id="facilityBookApply" action="apply.do" method="GET">

	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col width="60"/>
				<col width="100"/>
				<col width="200"/>
				<col width="250"/>
				<col width=""/>
				<col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>번호</th>
					<th>신청인</th>
					<th>시설명</th>
					<th>이용시간</th>
					<th>승인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${applyList}">
					<tr>
						<td>
							<input type="checkbox" name="facility_book_arr" value="${i.facility_book_idx}">
						</td>
						<td class="num">${paging.listRowNum - status.index}</td>
						<td>${i.apply_name}</td>
						<td>
							<c:if test="${i.facility_book_name eq '1'}">
							<span>4층 토론실(16석)</span>
							</c:if>
						</td>
						<td>
							${fn:substring(i.apply_date, 0, 10)}/
							<span>
							<c:choose>
								<c:when test="${i.apply_time_code eq '0'}">오전</c:when>
								<c:when test="${i.apply_time_code eq '1'}">오후</c:when>
							</c:choose>
							시간
							</span>
						</td>
						<td>
							<select class="apply_status_change" keyValue="${i.facility_book_idx}">
								<option value="0" ${i.apply_status eq '0' ? 'selected' :  ''} label="대기" />
								<option value="1" ${i.apply_status eq '1' ? 'selected' :  ''} label="승인" />
							</select>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(applyList) < 1}">
					<tr>
						<td colspan="5">데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<br>
		<div class="button">
			<a href="#" id="chk-delete" class="btn btn2">선택 삭제</a>
			<a href="#" id="chk-status" class="btn btn3">선택 승인</a>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/cms/module/facilityBook/paging.jsp" flush="false">
		<jsp:param name="formId" value="#facilityBookApply"/>
		<jsp:param name="pagingUrl" value="applyList.do"/>
		<jsp:param name="ajaxBody" value="apply_list_box"/>
	</jsp:include>
</form:form>
