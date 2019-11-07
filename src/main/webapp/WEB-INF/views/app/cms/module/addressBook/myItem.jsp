<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('정말 삭제 하시겠습니까? 복구가 불가능합니다.') ) {
			var $form = $('#addressForm');
			$('input#editMode', $form).val('DELETE');
			$('input#address_idx', $form).val($(this).attr('keyValue2'));
			$('input#address_book_idx', $form).val($(this).attr('keyValue1'));
			
			
			if ( doAjaxPost($form) ) {
				$('#itemLayer').load('getItemList.do?address_book_idx=' + $('input#address_book_idx', $form).val());
			}	
		}
	});
	
	$('a.detail-btn').on('click', function(e) {
		e.preventDefault();
		var address_book_idx = $(this).attr('keyValue1');
		var address_idx = $(this).attr('keyValue2');
		var book_name = $('input#name_'+address_idx).val();
		var book_phone = $('input#phone_'+address_idx).val();
		var book_email = $('input#email_'+address_idx).val();
		
		if (book_name == '' || book_name.length == 0) {
			alert('이름은 필수 입력항목입니다.');
			$('input#name_'+address_idx).focus();
			return false;
		}
		
		var $form = $('#addressForm');
		$('input#editMode', $form).val('MODIFY');
		$('input#address_name', $form).val(book_name);
		$('input#address_email', $form).val(book_email);
		$('input#address_cell_phone', $form).val(book_phone);
		$('input#address_idx', $form).val(address_idx);
		$('input#address_book_idx', $form).val(address_book_idx);
		
		if ( doAjaxPost($form) ) {
		}	
		
	});
	
	$('a#address_add').on('click', function(e) {
		e.preventDefault();
		var $form = $('#addressForm');
		$('input#editMode', $form).val('ADD');
		$('input#address_name', $form).val($('input#nameTmp').val());
		$('input#address_email', $form).val($('input#emailTmp').val());
		$('input#address_cell_phone', $form).val($('input#phoneTmp').val());
		
		if ( doAjaxPost($form) ) {
			$('#itemLayer').load('getItemList.do?address_book_idx=' + $('input#address_book_idx', $form).val());
		}	
	});
	
	$('input#checkAll').on('click', function(e) {
		$('input[type=checkbox].addressOne').prop('checked', $(this).is(':checked'));
	});
	
	$('a#address_delete').on('click', function(e) {
		e.preventDefault();
		if ( confirm('선택된 주소를 삭제 하시겠습니까? 복구가 불가능합니다.') ) {
			var $form = $('#addressForm');
			$('input#editMode', $form).val('DELETEBATCH');
			if ( doAjaxPost($form) ) {
				$('#itemLayer').load('getItemList.do?address_book_idx=' + $('input#address_book_idx', $form).val());
			}	
		}
	});
	
	$('a#excel_upload').on('click', function(e) {
		e.preventDefault();
		if ($('input#uploadFile').val() == '') {
			alert('업로드할 파일을 선택해주세요.');
			return false;
		}
		var option = {
				url : 'excelView.do',
				type : 'post',										
				data : $('#addressForm').serialize(),	
				success: function(response) {
					response = eval(response);
					if(response.valid) {
						if (confirm(response.data + '건의 엑셀 데이터를 등록 하시겠습니까? 이름이 없는 경우 등록되지 않습니다.')) {
							excelList();
						}
					} else {
						alert(response.result[0].code);
					}
		        },
				error: function(jqXHR, textStatus, errorThrown) {
		            alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		        }
		};
		$('#addressForm').ajaxSubmit(option);
	});
	
	function excelList() {
		var $form = $('#addressForm');
		var option = {
				url : 'excelSave.do',
				type : 'post',										
				data : $('#addressForm').serialize(),	
				success: function(response) {
					response = eval(response);
		            if(response.valid) {
		                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
		                	 alert(response.message);
		                 }
		                 $('#itemLayer').load('getItemList.do?address_book_idx=' + $('input#address_book_idx', $form).val());
					} else {
						alert(response.result[0].code);
					}
		        },
				error: function(jqXHR, textStatus, errorThrown) {
		            alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		        }
		};
		$('#addressForm').ajaxSubmit(option);
		
	}
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<form:form id="addressForm" modelAttribute="addressBook" action="saveAddress.do" >
	<form:hidden path="editMode"/>
	<form:hidden path="member_id"/>
	<form:hidden path="address_book_idx"/>
	<form:hidden path="address_idx"/>
	<form:hidden path="address_name"/>
	<form:hidden path="address_email"/>
	<form:hidden path="address_cell_phone"/>

<div id="editDisable" class="disableBox" style="height:500px;">
	<div class="table-wrap" style="height:100%;">
		<div class="auto-scroll" style="height:100%;">
			<table class="type1 center" style="" >
				<colgroup>
					<col width="5%">
					<col>
					<col>
					<col>
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="checkAll"> </th>
						<th>이름</th>
						<th>휴대전화</th>
						<th>이메일</th>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(myAddressList) < 1}">
						<tr >
							<td colspan="5" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="i" varStatus="status" items="${myAddressList}">
						<tr id="idx_${i.address_idx}">
							<td ><form:checkbox path="address_idx_arr" cssClass="addressOne" value="${i.address_idx}"/></td>
							<td ><input type="text" class="text" id="name_${i.address_idx}" value="${i.address_name}"></td>
							<td ><input type="text" class="text" numberOnly="true" id="phone_${i.address_idx}" value="${i.address_cell_phone}"></td>
							<td ><input type="text" class="text" id="email_${i.address_idx}" value="${i.address_email}"></td>
							<td width="">
								<a class="btn btn detail-btn" keyValue1="${i.address_book_idx}" keyValue2="${i.address_idx}">수정</a>
								<a class="btn btn delete-btn" keyValue1="${i.address_book_idx}" keyValue2="${i.address_idx}">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="table-wrap">
	<table class="border-all">
		<thead>
			<tr>
				<th>이름</th>
				<th>휴대전화</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" id="nameTmp"  class="text"></td>
				<td><input type="text" id="phoneTmp" class="text"></td>
				<td><input type="text" id="emailTmp" class="text"></td>
			</tr>
		</tbody>
	</table>
	<div class="button" style="border-width:0px; float: right; text-align: right; width:100%; ">
		<input type="file" id="uploadFile" name="uploadFile" style="width: 30%">
		<c:if test="${authC}">
		<a href="" class="btn btn2" id="excel_upload"><i class="fa fa-arrow-up" aria-hidden="true"></i><span>엑셀업로드</span></a>
		<a href="excelDownloadSample.do" class="btn btn2" id="excel_down"><i class="fa fa-arrow-down" aria-hidden="true"></i><span>엑셀양식</span></a>
		<a href="" class="btn btn5" id="address_add"><i class="fa fa-plus"></i><span>등록</span></a>
		</c:if>
		<c:if test="${authD}">
		<a href="" class="btn btn6" id="address_delete"><i class="fa fa-minus"></i><span>선택삭제</span></a>
		</c:if>
	</div>
</div>	
</form:form>
