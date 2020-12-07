<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "엑셀저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(expApplyList)}' > 0) {
						$('#apply_edit2').attr('action', '/cms/module/expReservation/expReservationApply/excelDownloadDate.do').submit();
					} else {
						alert('해당 내역이 없습니다.');	
					}
				}
			},{
				text: "csv저장",
				"class": 'btn btn3',
				click: function() {		
					if('${fn:length(expApplyList)}' > 0) {
						$('#apply_edit2').attr('action', '/cms/module/expReservation/expReservationApply/csvDownloadDate.do').submit();
					} else {
						alert('해당 내역이 없습니다.');	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1400,
		height: 500
	});
	
	//신청자 수정버튼
	$('a.apply-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('/cms/module/expReservation/expReservationApply/edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&reservation_idx=' + $(this).attr('keyValue') + '&program_list_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	//승인처리 버튼
	$('a.state-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-4').load('/cms/module/expReservation/expReservationApply/stateEdit.do?editMode=STATEMODIFY&homepage_id=' + $('#homepage_id').val() + '&reservation_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
	});
	
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 정보를 삭제 하시겠습니까?')) {
			$('input#editMode').val('DELETE');
			$('input#reservation_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#apply_edit2'))) {
				$('#dialog-3').load('/cms/module/expReservation/expReservationApply/applyEdit.do?editMode=VIEW&homepage_id=' + $('#homepage_id').val() + '&program_list_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}
		}
	});
	
	//취소 여부
	$('a.cancel-modify').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 신청내역을 취소 하시겠습니까?')) {
			$('input#editMode').val('CANCEL');
			$('input#reservation_idx').val($(this).attr('keyValue'));
			$('input#cancel_yn').val('Y');
			
			if(doAjaxPost($('#apply_edit2'))) {
				$('#dialog-3').load('/cms/module/expReservation/expReservationApply/applyEdit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&reservation_idx=' + $(this).attr('keyValue') + '&program_list_idx=' + $(this).attr('keyValue2'));
			}
			
		}
	});
	
});
</script>
<form:form modelAttribute="expApply" id="apply_edit2" action="/cms/module/expReservation/expReservationApply/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="reservation_idx"/>
<form:hidden path="program_list_idx"/>
<form:hidden path="cancel_yn" value="${expApply.cancel_yn}" />
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="150"/>
			<col width="130"/>
			<col width="100"/>
			<col width="190"/>
			<col width="100"/>
			<col width="150"/>
			<col width="90"/>
			<col width="60"/>
			<col width="80"/>
			<col width="95"/>
			<col width=""/>
		</colgroup>
		<thead>
			<tr>
				<th>프로그램명</th>
				<th>비회원 신청여부</th>
				<th>신청구분</th>
				<th>예약일/시간</th>
				<th>신청일</th>
				<th>아이디</th>
				<th>성명</th>
				<th>인원</th>
				<th>승인여부</th>
				<th>취소여부</th>
				<c:if test="${expApply.editMode ne 'VIEW' }">
					<th>신청</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${expApplyList}">
				<c:if test="${fn:length(expApplyList) < 1}">
				<tr>
					<td colspan="9">데이터가 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<tr>
					<td>${i.program_name}</td>
					<td>${i.member_yn eq 'Y' ? '예' : '아니요'}</td>
					<td>${i.reservation_type eq 'individual' ? '개인신청' : '단체신청'}</td>
					<td>
						<fmt:parseDate value="${i.reservation_date}" pattern="yyyyMMdd" var="reservationDate" />
						<fmt:formatDate value="${reservationDate}" pattern="yyyy-MM-dd" /> / ${i.use_time}
					</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>${i.member_id}</td>
					<td>${i.member_name}</td>
					<td>${i.application_people}</td>
					<td>
						<c:set var="approve_yn" value="${i.approve_yn}" />
						<c:choose>
						    <c:when test="${approve_yn eq 'Y'}">
						        승인
						    </c:when>
						    <c:when test="${approve_yn eq 'N'}">
						         대기
						    </c:when>
						</c:choose>
					</td>
					<td>
						<c:set var="cancel_yn" value="${i.cancel_yn}" />
						<c:choose>
						    <c:when test="${cancel_yn eq 'Y'}">
						        취소완료
						    </c:when>
						    <c:when test="${cancel_yn eq 'N'}">
						        <a href="#" class="btn cancel-modify" keyValue="${i.reservation_idx}" keyValue2="${i.program_list_idx}">취소하기</a>
						    </c:when>
						</c:choose>
					</td>
					<c:if test="${expApply.editMode ne 'VIEW' }">
						<td>
							<c:if test="${cancel_yn eq 'N'}">
								<a href="#" class="btn state-modify" keyValue="${i.reservation_idx}">승인처리</a>
							</c:if>
							<a href="#" class="btn apply-modify" keyValue="${i.reservation_idx}" keyValue2="${i.program_list_idx}">수정</a>
							<a href="#" class="btn delete-btn" keyValue="${i.reservation_idx}" keyValue2="${i.program_list_idx}">삭제</a>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-4" class="dialog-common" title="승인처리"/>