<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#bookPackageLoan'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 600
	});
	
	$('input#loan_start_date').datepicker({
		maxDate: $('input#loan_end_date').val(),
		onClose: function(selectedDate){
			$('input#loan_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#loan_end_date').datepicker({
		minDate: $('input#loan_start_date').val(),
		onClose: function(selectedDate){
			$('input#loan_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('#school_name').focus();
	
});

</script>
<form:form id="bookPackageLoan" modelAttribute="bookPackage" action="loanSave.do" method="POST">
	<form:hidden path="editMode" id="editMode_u"/>
	<form:hidden path="book_package_idx" id="book_package_idx_u"/>
	<form:hidden path="book_package_loan_idx" id="book_package_loan_idx_u"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>책 꾸러미명</th>
				<td>${bookPackage.book_package_subject}</td>
			</tr>
			<tr>
				<th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="loan_start_date" cssClass="text ui-calendar" readonly="true"/>
					<span>~</span>
					<form:input path="loan_end_date" cssClass="text ui-calendar" readonly="true"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>대출 기간은 택배 배송 소요일을 포합합니다. 반납일 3일전 반납 신청해주시길 바랍니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>학교명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="school_name" cssClass="text" cssStyle="width:200px;"/>
				</td>
			</tr>
			<tr>
				<th>신청자</th>
				<td>
					<form:input path="request_name" cssClass="text" cssStyle="width:100px;"/>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>
					<form:select path="phone_1" cssStyle="selectmenu">
						<form:option value="010">010</form:option>
						<form:option value="011">012</form:option>
						<form:option value="016">016</form:option>
						<form:option value="017">017</form:option>
						<form:option value="018">018</form:option>
						<form:option value="019">019</form:option>
					</form:select>
					<span>-</span>
					<form:input path="phone_2" cssClass="text" cssStyle="width:50px;"/>
					<span>-</span>
					<form:input path="phone_3" cssClass="text" cssStyle="width:50px;"/>
				</td>
			</tr>
			<tr>
				<th>학교 연락처</th>
				<td>
					<form:select path="school_tel_1" cssClass="selectmenu">
						<form:option value="053">053</form:option>
					</form:select>
					<span>-</span>
					<form:input path="school_tel_2" cssClass="text" cssStyle="width:50px;"/>
					<span>-</span>
					<form:input path="school_tel_3" cssClass="text" cssStyle="width:50px;"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>연락처는 원화택배 발송을 위한 필수 정보입니다. 꼭 기입하여 주세요.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>신청사유</th>
				<td>
					<form:textarea path="request_content" cols="60" rows="5" cssStyle="width:95%;"/>
				</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
					<form:select path="request_status" cssClass="selectmenu">
						<form:option value="0">신청중</form:option>
						<form:option value="1">예약상담중</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납완료</form:option>
						<form:option value="4">관리자취소</form:option>
						<form:option value="5">반납요청완료</form:option>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
