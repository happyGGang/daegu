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
	
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
	 	doAjaxPost($('#libraryCheckLoan'));
	});
	
	$('#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
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
	<form:hidden path="menu_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="library_check_idx"/>
	<form:hidden path="library_check_loan_idx"/>
	<form:hidden path="search_type"/>
	<form:hidden path="search_text"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
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
			<tr>
				<th>학교명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<c:choose>
						<c:when test="${(not empty loginSupport and loginSupport.auth_group eq '1') or member.admin}">
							<form:input path="school_name" cssClass="text" cssStyle="width:200px;"/>
						</c:when>
						<c:otherwise>
							<form:hidden path="school_name" value="${loginSupport.school_name}"/>${loginSupport.school_name}
						</c:otherwise>
					</c:choose>
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
			<c:choose>
				<c:when test="${(not empty loginSupport and loginSupport.auth_group eq '1') or member.admin}">
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
				</c:when>
				<c:otherwise>
					<form:hidden path="request_status" value="1"/>
				</c:otherwise>
			</c:choose>
			<tr>
				<th>비고</th>
				<td>
					<form:textarea path="remark" rows="10" cols="100" cssStyle="width:100%; height:100px;" title="장서점검기 대여 비고란" placeholder="대출기간 및 방문예정일자 조정을 원하시는 분들은 기입 바랍니다."/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">목록</button>
</div>