<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
function checkAll($this) { 
	$('input:checkbox[name=book_delivery_arr]').prop('checked', $this.is(':checked'));
}

$(function(){
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookDelivery').serialize());
	});
	
	$('select#status').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookDelivery').serialize());
	});
	
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookDelivery').serialize());
	});
	
	$('a#sampleDownload').on('click', function(e) {
		$('#bookDelivery').attr('action', 'sampleDownload.do').submit();
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#bookDelivery').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
	$('#allChk').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.delivery_chk').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.delivery_chk').prop('checked', false);
		}
	});
	
	$('#status-change').on('click', function(e) {
		e.preventDefault();
		
		if($('input[name="book_delivery_arr"]:checked').length < 1) {
			alert('변경할 꾸러미를 선택하세요.');
			return false;
		}
		
		if($('select#statusAll option:selected').val() == '') {
			alert('변경할 상태를 선택하세요.');
			return false;
		}
		
		$('select#status').val($('select#statusAll').val()).prop('selected', true);
		$('#editMode').val('MODIFYALL');
		$('#bookDelivery').attr('action', 'save.do');
		$('#bookDelivery').attr('method', 'POST');
		if(doAjaxPost($('#bookDelivery'))) {
			location.reload();
		}
	});
});

function excelUploadEdit() {
	$.ajax({
		url: 'excelUploadEdit.do',
		method: 'GET',
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '엑셀업로드',
				open: function(){
					$('.ui-widget-overlay').addClass('custom-overlay');
				},
				close: function(){
				},
				buttons: [
					{
						text: "취소",
						"class": 'btn btn_round btn_gray',
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});

			$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
				width: 700,
				height: 270
			});
		},error: function(html) {
		}
	});
}

function viewDetail(book_delivery_idx) {
	var ajaxData = {
		'book_delivery_idx' : book_delivery_idx
	};
	
	$.ajax({
		url: 'view.do',
		data : ajaxData,
		method: 'POST',
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '상세보기',
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
							save();
						}
					},
					{
						text: "취소",
						"class": 'btn btn_round btn_gray',
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});

			$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
				width: 700,
				height: 700
			});
		},error: function(html) {
		}
	});
}

function edit() {
	$.ajax({
		url: 'edit.do',
		method: 'POST',
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '등록하기',
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
						text: "취소",
						"class": 'btn btn_round btn_gray',
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});

			$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
				width: 700,
				height: 700
			});
		},error: function(html) {
		}
	});
}
</script>

<form:form modelAttribute="bookDelivery" action="index.do" method="POST">
<form:hidden path="editMode"/>
	<div class="search">
		검색 결과 : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> 건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		상태 : 
		<form:select path="status" cssClass="selectmenu">
			<form:option value="">전체</form:option>
			<form:option value="발송요청중">발송요청중</form:option>
    		<form:option value="발송완료">발송완료</form:option>
    		<form:option value="반송요청중">반송요청중</form:option>
    		<form:option value="반송중">반송중</form:option>
    		<form:option value="반송완료">반송완료</form:option>
		</form:select>
		<c:if test="${authD}">
			<a href="javascript:void(0);" id="sampleDownload" class="btn btn1">엑셀업로드샘플다운로드</a>
			<a href="javascript:void(0);" id="excelUploadEdit" class="btn btn4" onclick="excelUploadEdit();">엑셀업로드</a>
		</c:if>
			<a href="javascript:void(0);" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<c:if test="${authD}">
			<a href="javascript:void(0);" id="dialog-add" class="btn btn5 right" onclick="edit();"><i class="fa fa-plus"></i><span>등록</span></a>
		</c:if>
	</div>
	
	<table class="type1 center">
		<colgroup>
				<col width="3%"/>
				<col width="3%"/>
	 			<col width="6%"/>
	 			<col width="4%"/>
	 			<col width="9%"/>
	 			<col width="7%"/>
				<col width="8%"/>
				<col width="4%"/>
				<col width="8%"/>
<%-- 				<col width="7%"/> --%>
				<col width="8%"/>
				<col width="7%"/>
				<col width="3%"/>
				<col width="3%"/>
				<col width="3%"/>
				<col width="6%"/>
				<col width="6%"/>
			</colgroup>
		<thead>
			<tr>
				<th></th>
				<th>순번</th>
				<th>발송요청일</th>
				<th>주제</th>
				<th>책꾸러미명</th>
				<th>대출기간</th>
				<th>학교명</th>
				<th>신청자</th>
				<th>휴대폰</th>
<!-- 				<th>주소</th> -->
				<th>수령 및 반납장소</th>
				<th>학교연락처</th>
				<th>가방 수</th>
				<th>요금</th>
				<th>권수</th>
				<th>반송요청일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${bookDeliveryList}">
			<tr>
				<td><input type="checkbox" name="book_delivery_arr" class="delivery_chk" value="${i.book_delivery_idx}"/></td>
				<td>${paging.listRowNum - status.index}</td>
				<td>${i.request_date}</td>
				<td>${i.subject}</td>
				<td>${i.book_package_name}</td>
				<td>${fn:split(i.loan_date,'~')[0]}<br/>~<br/>${fn:split(i.loan_date,'~')[1]}</td>
				<td>${i.school_name}</td>
				<td>${i.member_name}</td>
				<td>${i.phone}</td>
<%-- 				<td>${i.address}</td> --%>
				<td>${i.return_plan_place}</td>
				<td>${i.school_phone}</td>
				<td>${i.bag_count}</td>
				<td>${i.fee}</td>
				<td>${i.book_count}권</td>
				<td>${i.return_plan_date}</td>
				<td>${i.status}<br/><a href="javascript:void(0);" class="btn btn1" onclick="viewDetail('${i.book_delivery_idx}');">상세보기</a></td>
			</tr>
		</c:forEach>
		<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="14">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<a href="#" id="allChk" keyValue="N">전체 선택/해제</a>
	<select id="statusAll" class="selectmenu">
		<option value="">상태전체</option>
		<option value="발송요청중">발송요청중</option>
		<option value="발송완료">발송완료</option>
		<option value="반송요청중">반송요청중</option>
		<option value="반송중">반송중</option>
		<option value="반송완료">반송완료</option>
	</select>
	<a href="#" id="status-change" class="btn btn">선택상태변경</a>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookDelivery"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="book_package_name">책꾸러미명</form:option>
				<form:option value="school_name">학교명</form:option>
				<form:option value="member_name">신청자</form:option>
				<form:option value="phone">휴대폰</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>