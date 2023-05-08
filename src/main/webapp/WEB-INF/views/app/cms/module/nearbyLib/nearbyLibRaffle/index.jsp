<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#nearbyStatusChange').serialize());
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibRaffle.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibRaffle.end_date}');
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#nearbyLibRaffleForm').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#nearbyLibRaffleForm').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
});

function nearbyLibRaffleEdit() {
	var url = 'edit.do';
	var param = 'editMode=ADD';
	doGetLoad(url, param);
}

function viewRaffle(raffle_idx) {
	var ajaxData = {
		'raffle_idx' : raffle_idx
	};

	$.ajax({
		url: 'viewRaffle.do',
		method: 'GET',
		data : ajaxData,
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '당첨자 명단',
				open: function(){
					$('.ui-widget-overlay').addClass('custom-overlay');
				},
				close: function(){
				},
				buttons: [
					{
						text: "확인",
						"class": 'btn btn_round btn_gray',
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});

			$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
				width: 1200,
				height: 800
			});
		},error: function(html) {
		}
	});
}

function deleteRaffle(raffle_idx) {
	var ajaxData = {
		'raffle_idx' : raffle_idx
	};
	if(confirm('등록된 추첨을 삭제 하시겠습니까?\n등록된 당첨자 정보도 전부 삭제되며 복구는 불가능합니다.')) {
		$.ajax({
			type: "POST",
			url: 'deleteRaffle.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('삭제 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('삭제에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	} 
}
</script>

<form:form id="nearbyLibRaffleForm"  modelAttribute="nearbyLibRaffle" action="index.do" >
	<div class="search">
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		추첨일 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	</div>
	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${nearbyLibRaffleCount}" pattern="#,###" />건
		<div class="button">
			<a href="javascript:void(0);" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="javascript:void(0);" class="btn btn5 dialog-add" onclick="nearbyLibRaffleEdit();"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="" />
			<col width="200" />
			<col width="170">
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>추첨명</th>
				<th>추첨일</th>
				<th>추첨현황</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${nearbyLibRaffleList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<th><a href="javascript:void(0);" onclick="viewRaffle('${i.raffle_idx}');">${i.raffle_name}</a></th>
					<td>${i.add_date}</td>
					<td>
						<a href="javascript:void(0);" class="btn btn1" onclick="viewRaffle('${i.raffle_idx}');">보기</a>
					</td>
					<td>
						<a href="javascript:void(0);" class="btn btn5" onclick="deleteRaffle('${i.raffle_idx}');">삭제</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${nearbyLibRaffleCount eq 0}">
				<tr>
					<td colspan="5">추첨된 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#nearbyLibRaffleForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="raffle_name">추첨명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>