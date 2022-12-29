<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
function checkLoanDate(library_check_idx){
	var loan_start_date = $('input#loan_start_date').val();
	var loan_end_date = $('input#loan_end_date').val();
	
	var ajaxData = {
		'loan_start_date' : loan_start_date,
		'loan_end_date' : loan_end_date,
		'library_check_idx' : library_check_idx
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
					if(doAjaxPost($('#libraryCheckLoan'))) {
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
	
});

</script>
<form:form id="libraryCheckLoan" modelAttribute="libraryCheck" action="loanSave.do" method="POST">
	<form:hidden path="editMode" id="editMode_u"/>
	<form:hidden path="library_check_idx" id="library_check_idx_u"/>
	<form:hidden path="library_check_loan_idx" id="library_check_loan_idx_u"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>장서점검기</th>
				<td>장서점검기 ${libraryCheck.library_check_number}</td>
			</tr>
			<tr>
				<th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="loan_start_date" cssClass="text ui-calendar"/>
					<span>~</span>
					<form:input path="loan_end_date" cssClass="text ui-calendar" onchange="checkLoanDate('${libraryCheck.library_check_idx}');"/>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<th>방문예정일자(<span style="color: red;font-weight: bold;">*</span>)</th> -->
<!-- 				<td> -->
<%-- 					<form:input path="hope_date" cssClass="text ui-calendar"/> --%>
<!-- 					<div class="ui-state-highlight"> -->
<!-- 						<i class="fa fa-question-circle"></i> -->
<!-- 						<em>방문예정일자는 자동으로 대출시작일로 입력됩니다.</em> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>방문예정시간(<span style="color: red;font-weight: bold;">*</span>)</th> -->
<!-- 				<td> -->
<%-- 					<form:select path="hope_start_time" cssStyle="selectmenu"> --%>
<%-- 						<c:forEach var="i"  begin="9" end="18"> --%>
<%-- 					        <form:option value="${i}">${i>9?i:'0'}${i>9?'':i}</form:option> --%>
<%-- 					    </c:forEach> --%>
<%-- 					</form:select>&nbsp;: --%>
<%-- 					<form:select path="hope_start_minute" cssStyle="selectmenu"> --%>
<%-- 						<form:option value="00">00</form:option> --%>
<%-- 						<form:option value="30">30</form:option> --%>
<%-- 					</form:select> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<th>학교명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="school_name" cssClass="text" cssStyle="width:200px;"/>
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
				<th>학교 연락처(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="school_tel_1" cssClass="selectmenu">
						<form:option value="053">053</form:option>
					</form:select>
					<span>-</span>
					<form:input path="school_tel_2" cssClass="text" cssStyle="width:50px;"/>
					<span>-</span>
					<form:input path="school_tel_3" cssClass="text" cssStyle="width:50px;"/>
				</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
					<form:select path="request_status" cssClass="selectmenu">
						<form:option value="1">예약중</form:option>
						<form:option value="0">신청중</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납완료</form:option>
						<form:option value="4">관리자취소</form:option>
						<form:option value="5">반납요청완료</form:option>
						<form:option value="6">수리중</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td>
					<form:textarea path="remark" rows="10" cols="100" cssStyle="width:100%; height:100px;" title="장서점검기 대여 비고란" placeholder="대출기간 및 방문예정일자 등 특이사항을 기입해주세요."/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
