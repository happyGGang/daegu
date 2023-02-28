<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
function checkAll($this) {
	$('input:checkbox[name=penalty_idx_arr]').prop('checked', $this.is(':checked'));
}

$(function() {
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#nearbyLibPenalty').serialize());
	});
	
	$('.selectmenu-search').on('change',function(e){
		$('#viewPage').val(1);
		$('#nearbyLibPenalty').submit();
		e.preventDefault();
	});

	$('input#search_start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#search_end_date').val(), 
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibPenalty.search_start_date}');
	$('input#search_end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#search_start_date').val(), 
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibPenalty.search_end_date}');

	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#nearbyLibPenalty').serialize());
	});
	
	$('#excelDownload').on('click', function(e) {
		$('#nearbyLibPenalty').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
});

function checkBook() {
	if($('input:checkbox[name=reserve_key_arr]:checked').length < 1) {
		alert('찾음 처리를 하실 체크박스 선택해 주세요.');
	} else {
		if(confirm('찾음처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'checkBook.do',
				data: $('input[name=reserve_key_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('찾음처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('찾음처리에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

function settingEdit() {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'settingEdit.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '페널티 설정',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '저장하기',
				'class' : 'btn btn1',
				click : function() {
					saveSetting();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 360
	});
}

function edit() {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'edit.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '페널티 등록',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '등록하기',
				'class' : 'btn btn1',
				click : function() {
					save();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 340
	});
}

function modify(penalty_idx) {
	var ajaxData = {
		'penalty_idx' : penalty_idx
	};
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'edit.do',
		method: 'GET',
		data : ajaxData,
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '페널티 등록',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '수정하기',
				'class' : 'btn btn1',
				click : function() {
					modify();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 340
	});
}

function deletePenalty(penalty_idx, penalty_member_id) {
	var ajaxData = {
		'penalty_idx_arr' : penalty_idx,
		'penalty_member_id' : penalty_member_id
	};
	
	if(confirm('ID:' + penalty_member_id + '님의 페널티를 삭제 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'delete.do',
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
				alert('페널티 삭제에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	} 
}
</script>

<div class="infodesk">
	<div class="button">
		<a href="javascript:void(0);" class="btn btn1 left" onclick="settingEdit();"><i class="fa fa-plus"></i><span>페널티설정</span></a>
		<a href="javascript:void(0);" class="btn btn5 left" onclick="edit();"><i class="fa fa-plus"></i><span>페널티등록</span></a>
	</div>
</div>

<form:form id="nearbyLibPenalty" modelAttribute="nearbyLibPenalty">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="search">
<label class="blind">검색</label>
	검색 결과 : ${nearbyLibPenaltyCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${nearbyLibPenaltyCount}">전체 보기</form:option>
	</form:select>
	등록일자 : <form:input path="search_start_date" class="text ui-calendar"/> ~ <form:input path="search_end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
</div>

<table class="type1 center">
	<thead>
		<tr>
			<th width="10"><input type="checkbox" onchange="checkAll($(this));"></th>
			<th width="5">번호</th>
			<th width="40">아이디</th>
			<th width="50">사유</th>
			<th width="40">위반일자</th>
			<th width="50">등록일자</th>
			<th width="30">기능</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(nearbyLibPenaltyList) < 1}">
		<tr style="height:100%">
			<td colspan="11" style="background:#f8fafb;">페널티 내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${nearbyLibPenaltyList}">
		<tr>
			<td><form:checkbox path="penalty_idx_arr" value="${i.penalty_idx}"/></td>
			<td>${paging.listRowNum - status.index}</td>
			<td>${i.penalty_member_id}</td>
			<td>${i.penalty_reason}</td>
			<td>${i.penalty_date}</td>
			<td>${i.penalty_add_date}</td>
			<td><a href="javascript:void(0);" class="btn btn3" onclick="modify('${i.penalty_idx}');">수정</a><a href="javascript:void(0);" class="btn btn5" onclick="deletePenalty('${i.penalty_idx}', '${i.penalty_member_id}');">삭제</a></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#nearbyLibPenalty"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="penalty_member_id">아이디</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
	
</form:form>