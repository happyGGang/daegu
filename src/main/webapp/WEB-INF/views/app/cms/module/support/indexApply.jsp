<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#dialog-3.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
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

	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 750,
		height: 600
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(supportList)}' > 0) {
			$('#apply').attr('action', 'excelDownload.do').submit();
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(supportList)}' > 0) {
			$('#apply').attr('action', 'csvDownload.do').submit();
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
});
</script>
<form:form modelAttribute="support" id="apply" action="excelDownload.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>

<div class="table-wrap">
	<div class="infodesk">
		검색 결과 : 총 ${fn:length(supportList)}건
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="120"/>
			<col width="90"/>
			<col width="160"/>
			<col width="80"/>					
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th>기관명</th>
				<th>담당자</th>
				<th>제목</th>
				<th>희망일자</th>				
				<th>진행상태</th>								
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${supportList}">
				<c:if test="${fn:length(supportList) < 1}">
				<tr>
					<td colspan="6">신청내역이 없습니다.</td>
				</tr>
				</c:if>
				<tr>
					<td>${i.req_name}</td>
					<td>${i.requer_name}</td>
					<td>${i.req_title}</td>
					<td>${i.hope_req_dt}</td>					
					<c:if test="${i.process_state eq 'Y' }">
						<td>완료</td>
					</c:if>
					<c:if test="${i.process_state eq 'N' }">
						<td>접수</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>