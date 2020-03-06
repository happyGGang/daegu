<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
	 	doAjaxPost($('#libraryCheckLoan'));
	});
	
	$('#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
<c:choose>
	<c:when test="${(not empty loginSupport and loginSupport.auth_group eq '1') or member.admin}">
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
	</c:when>
	<c:otherwise>
	var str_date1 = new Date($('#loan_start_date').val());
	if(str_date1.getDay() == 6) {
		str_date1.setDate(str_date1.getDate() + 6);
	}
	var str_date2 = new Date(str_date1);
	str_date2.setDate(str_date2.getDate() + 7);
	
	var minDate = str_date1.getFullYear()+'-'+(str_date1.getMonth()+1)+'-'+str_date1.getDate();
	var maxDate = str_date2.getFullYear()+'-'+(str_date2.getMonth()+1)+'-'+str_date2.getDate();
	
	$('input#loan_start_date').datepicker({
		minDate: minDate,
		maxDate: maxDate,
		onClose: function(selectedDate){
			$('input#loan_end_date').datepicker('option', 'minDate', selectedDate);
			var date = $(this).datepicker('getDate');
			date.setDate(date.getDate() + 6);
			var end_year = date.getFullYear();
			var end_month = (date.getMonth()+1 < 10 ? '0' : '') + (date.getMonth()+1);
			var end_date = (date.getDate() < 10 ? '0' : '') + date.getDate();
			$('input#loan_end_date').val(end_year+'-'+end_month+'-'+end_date);
		},
		beforeShowDay: function(date) {
			return [date.getDay() == 5];
		}
	});
	
	var end_date = new Date(str_date1);
	end_date.setDate(end_date.getDate() + 6);
	var end_year = end_date.getFullYear();
	var end_month = (end_date.getMonth()+1 < 10 ? '0' : '') + (end_date.getMonth()+1);
	var end_date = (end_date.getDate() < 10 ? '0' : '') + end_date.getDate();
	$('input#loan_end_date').val(end_year+'-'+end_month+'-'+end_date);
	</c:otherwise>
</c:choose>
	
	$('input#hope_date').datepicker();
	
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
					<form:input path="loan_end_date" cssClass="text ui-calendar" readonly="true"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>대출 요일은 금요일, 반납요일은 목요일로 대출기간은 1주입니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>방문예정일자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td><form:input path="hope_date" cssClass="text ui-calendar"/></td>
			</tr>
			<tr>
				<th>학교명</th>
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
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>연락처는 원화택배 발송을 위한 필수 정보입니다. 꼭 기입하여 주세요.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
				<c:choose>
					<c:when test="${loginSupport.auth_group eq '3'}">
					<form:hidden path="request_status" value="0"/>신청중
					</c:when>
					<c:otherwise>
					<form:select path="request_status" cssClass="selectmenu">
						<form:option value="0">신청중</form:option>
						<form:option value="1">예약상담중</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납완료</form:option>
						<form:option value="4">관리자취소</form:option>
						<form:option value="5">반납요청완료</form:option>
					</form:select>
					</c:otherwise>
				</c:choose>
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