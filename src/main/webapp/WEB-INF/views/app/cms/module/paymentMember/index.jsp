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
		doGetLoad('index.do', $('form#paymentMember').serialize());
	});
	
	$('input#join_start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#join_end_date').val(), 
		onClose: function(selectedDate){
			$('input#join_end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${paymentMember.join_start_date}');
	$('input#join_end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#join_start_date').val(), 
		onClose: function(selectedDate){
			$('input#join_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${paymentMember.join_end_date}');

	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#paymentMember').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#paymentMember').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#paymentMember').attr('action', 'excelDownload.do').submit();
		$('#paymentMember').attr('action', 'save.do');
		e.preventDefault();
	});
	
});

function viewFamilyMember(pay_member_idx) {
	var ajaxData = {
		'pay_member_idx' : pay_member_idx
	};

	$.ajax({
		url: 'viewFamilyMember.do',
		method: 'GET',
		data : ajaxData,
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '가족회원 리스트',
				open: function(){
					$('.ui-widget-overlay').addClass('custom-overlay');
				},
				close: function(){
				},
				buttons: [
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
				height: 500
			});
		},error: function(html) {
		}
	});
}

function modify(pay_member_idx) {
	var ajaxData = {
		'pay_member_idx' : pay_member_idx
	};

	$.ajax({
		url: 'modify.do',
		method: 'GET',
		data : ajaxData,
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '회원 수정',
				open: function(){
					$('.ui-widget-overlay').addClass('custom-overlay');
				},
				close: function(){
				},
				buttons: [
					{
						text : '저장',
						'class' : 'btn btn1',
						click : function() {
							savePaymentMember();
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
				width: 1500,
				height: 800
			});
		},error: function(html) {
		}
	});
}

function deleteMember(pay_member_idx) {
	var ajaxData = {
			'pay_member_idx' : pay_member_idx
	};
	if(confirm('회원을 삭제하시면 등록되어있는 가족정보도 같이 삭제 됩니다.\n삭제 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'deleteMember.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('회원정보가 삭제 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('회원정보 삭제에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
}

function changeApproveYn(pay_member_idx, $this) {

	var approve_yn = $this.val();
	
	var ajaxData = {
			'pay_member_idx' : pay_member_idx,
			'approve_yn' : approve_yn
	};
	
	$.ajax({
		type: "POST",
		url: 'changeApproveYn.do',
		data: {'pay_member_idx' : pay_member_idx, 'approve_yn' : approve_yn},
		success: function(response) {
			if(response.valid) {
				if(approve_yn == 'Y'){
					alert('승인 되었습니다.');
				} else {
					alert('미승인 되었습니다.');
				}
			} else {
				alert('수정에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
			location.reload();
		},
		error : function() {
			alert('수정에 실패했습니다.\n\n관리자에게 문의해 주세요.');
		}
	});
}
</script>
<form:form id="paymentMember" modelAttribute="paymentMember" method="POST" action="save.do">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="search">
<label class="blind">검색</label>
	검색 결과 : ${paymentMemberCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${paymentMemberCount}">전체 보기</form:option>
	</form:select>
	기간 : <form:input path="join_start_date" class="text ui-calendar"/> ~ <form:input path="join_end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
<!-- 	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a> -->
</div>

<table class="type1 center">
	<thead>
		<tr>
			<th width="5">번호</th>
			<th width="40">이름</th>
			<th width="50">대출번호</th>
			<th width="40">연락처</th>
			<th width="50">기간</th>
			<th width="50">금액</th>
			<th width="30">비고</th>
			<th width="30">기능</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(paymentMemberList) < 1}">
		<tr style="height:100%">
			<td colspan="9" style="background:#f8fafb;">등록된 회원이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${paymentMemberList}">
		<tr>
			<td width="5">${paging.listRowNum - status.index}</td>
			<td width="40">
				<c:choose>
					<c:when test="${not empty i.family_yn and i.family_yn eq 'Y'}">
						<a href="javascript:void(0);" class="btn" onclick="viewFamilyMember('${i.pay_member_idx}');">${i.pay_member_name}</a>
					</c:when>
					<c:otherwise>
						${i.pay_member_name}
					</c:otherwise>
				</c:choose>
			</td>
			<td width="50">
				<c:choose>
					<c:when test="${not empty i.loan_number and i.loan_number ne '0'}">
						${i.loan_number}
					</c:when>
					<c:otherwise>
						없음
					</c:otherwise>
				</c:choose>
			</td>
			<td width="40">${i.phone}</td>
			<td width="50">${i.join_start_date} ~ ${i.join_end_date}</td>
			<td width="50">${i.sponsorship_amount}원</td>
			<td width="30">
				<c:choose>
					<c:when test="${not empty i.etc}">
						<a href="javascript:void(0);" class="btn btn1" onclick="alert('${i.etc}');">보기</a>
					</c:when>
					<c:otherwise>
						없음
					</c:otherwise>
				</c:choose>
			</td>
			<td width="30">
				<form:select path="approve_yn" cssClass="selectmenu" onchange="changeApproveYn('${i.pay_member_idx}', $(this));">
					<option value="Y"<c:if test="${i.approve_yn eq 'Y'}">selected</c:if>>승인</option>
					<option value="N"<c:if test="${i.approve_yn eq 'N'}">selected</c:if>>미승인</option>
				</form:select>&nbsp;
				<a href="javascript:void(0);" class="btn btn4" onclick="modify('${i.pay_member_idx}');">수정</a>&nbsp;
				<a href="javascript:void(0);" class="btn btn5" onclick="deleteMember('${i.pay_member_idx}');">삭제</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#paymentMember"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="pay_member_name">이름</form:option>
			<form:option value="loan_number">대출번호</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>

<div class="ui-state-highlight">
	<em>* 등록된 가족회원이 있다면 이름에 버튼이 활성화 됩니다. 간단하게 등록된 가족을 확인하고 싶으시면 이름을 클릭하세요.</em>
</div>
	
</form:form>