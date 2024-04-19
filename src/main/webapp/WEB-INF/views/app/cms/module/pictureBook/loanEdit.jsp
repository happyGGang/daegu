<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
function checkLoanDate(picture_book_idx){
	var loan_start_date = $('input#loan_start_date').val();
	var loan_end_date = $('input#loan_end_date').val();
	
	var ajaxData = {
		'loan_start_date' : loan_start_date,
		'loan_end_date' : loan_end_date,
		'picture_book_idx' : picture_book_idx
	};
	
	$.ajax({
		type: "POST",
		url: 'checkLoanDate.do',
		data: ajaxData,
		success: function(response) {
			if(response.valid) {
			} else {
				alert(response.message);
				location.reload();
			}
		},
		error : function() {
			alert('대출,예약 날짜 조회에 실패했습니다.\n관리자에게 문의해 주세요.');
		}
	});
}

$(function() {
	$('input#loan_start_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: +3,
		maxDate: $('input#loan_end_date').val(), 
		onClose: function(selectedDate){
			$('input#loan_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#loan_end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#loan_start_date').val(), 
		onClose: function(selectedDate){
			$('input#loan_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
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
					if($('#editMode_u').val() == 'ADD') {
						if($('#agreeChk').prop('checked') == false) {
							alert('신청 동의에 체크해주시기 바랍니다.');
							$('#agreeChk').focus();
							return false;
						}
						
						if($('#agreeChk2').prop('checked') == false) {
							alert('개인정보 동의에 체크해주시기 바랍니다.');
							$('#agreeChk2').focus();
							return false;
						}
					}
					
					if(doAjaxPost($('#pictureBookLoan'))) {
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

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 700
	});
	
});

</script>
<style>
input[type="checkbox"]:focus {outline: 1px solid red;}
.title-info h3 {display: inline-block;font-weight: bold;color: #e94949;padding: 10px 65px;background: url(/resources/common/img/icon0105.gif) no-repeat 0px;background-size: 50px;}
.title-info ul li {font-size: 14px;color: #222;margin-left: 20px;margin-bottom: 6px;list-style-type: disc;}
</style>
<form:form id="pictureBookLoan" modelAttribute="pictureBook" action="loanSave.do" method="POST">
	<form:hidden path="editMode" id="editMode_u"/>
	<form:hidden path="pay_yn" id="pay_yn_u"/>
	<form:hidden path="picture_book_idx" id="book_package_idx_u"/>
	<form:hidden path="picture_book_loan_idx" id="book_package_loan_idx_u"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>책 꾸러미명</th>
				<td>${pictureBook.picture_book_subject}</td>
			</tr>
			<tr>
				<th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="loan_start_date" cssClass="text ui-calendar"/>
					<span>~</span>
					<form:input path="loan_end_date" cssClass="text ui-calendar" onchange="checkLoanDate('${pictureBook.picture_book_idx}');"/>
				</td>
			</tr>
			<tr>
				<th>신청자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="request_name" cssClass="text" cssStyle="width:100px;"/>
				</td>
			</tr>
			<tr>
				<th>휴대폰(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="phone_1" cssClass="selectmenu">
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
				<th>학교 연락처(<span style="color: red;font-weight: bold;">*</span>)</th>
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
				<th>택배 배송장소(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="delivery_location" cssClass="selectmenu">
						<form:option value="행정실">행정실</form:option>
						<form:option value="도서실">도서실</form:option>
						<form:option value="택배보관실">택배보관실</form:option>
					</form:select>
					<form:input path="delivery_location2" cssClass="text" cssStyle="width:200px;"/>
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
						<form:option value="7">예약하기</form:option>
						<form:option value="1">신청하기</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납신청</form:option>
						<form:option value="4">반납요청완료</form:option>
						<form:option value="5">반납완료</form:option>
						<form:option value="6">대출불가</form:option>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
