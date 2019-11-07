<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	        $('#lockerForm').submit();
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$('a#dialog-add2').on('click', function(e) {		
		$('#dialog-3').load('/cms/module/locker/pre/edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#dialog-modify2').on('click', function(e) {
		$('#dialog-3').load('/cms/module/locker/pre/edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if ( confirm('해당 기본설정을 삭제 하시겠습니까?\n설정에 등록된 모든 사물함 및 신청내역이 일괄삭제 됩니다.') ) {
			$('#lockerPre #locker_pre_idx').val($(this).attr('keyValue'));
			$('#lockerPre #editMode').val("DELETE");
			if(doAjaxPost($('#lockerPre'))) {
				$('#dialog-2').load('/cms/module/locker/pre/index.do?homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
					$('#dialog-2').dialog('open');
				});
			}
		}
		e.preventDefault();
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 850,
		height: 500
	});
	
});
</script>
<form:form modelAttribute="LockerPre" id="lockerPre" action="/cms/module/locker/pre/save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="locker_pre_idx"/>
<div class="table-wrap">
	<div class="infodesk">
		검색 결과 : 총 ${LockerPreCount}건
		<div class="button">
			<c:if test="${authC}">				
				<a href="" class="btn btn5 left" id="dialog-add2"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>			
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="150"/>
			<col width="80"/>
			<col width="180"/>							
			<col width="180"/>
			<col width="90"/>
			<col width=""/>
		</colgroup>
		<thead>
			<tr>
				<th>구분명</th>
				<th>배정방법</th>
				<th>신청접수 기간</th>
				<th>사용 기간</th>
				<th>사물함 개수</th>
				<th>기능</th>				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${LockerPreList}">
				<c:if test="${fn:length(LockerPreList) < 1}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<tr>					
					<td>${i.locker_pre_name}</td>
					<td>
						<c:choose>
							<c:when test="${i.locker_pre_type eq 'SELECT'}">선택배정</c:when>
							<c:when test="${i.locker_pre_type eq 'FIFO'}">순차배정</c:when>
							<c:when test="${i.locker_pre_type eq 'RANDOM'}">랜덤배정</c:when>
							<c:when test="${i.locker_pre_type eq 'LOTTERY'}">추첨배정</c:when>
						</c:choose>
					</td>
					<td>${i.apply_start_date} ${i.apply_start_time} ~<br/> ${i.apply_end_date} ${i.apply_end_time}</td>
					<td>${i.start_date} ~ ${i.end_date}</td>
					<td>${i.locker_count}</td>
					<td>
						<c:if test="${authU}">
						<a href="" class="btn" id="dialog-modify2" keyValue="${i.locker_pre_idx }" >수정</a>
						</c:if>
						<c:if test="${authD}">
						<a href="" class="btn" id="delete-btn" keyValue="${i.locker_pre_idx }">삭제</a>
						</c:if>					
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-3" class="dialog-common" title="사물함 기본설정 등록"></div>
