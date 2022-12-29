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
	
	if(${disabledList} =="" || ${disabledList} == null){
		$('input#loan_start_date').datepicker({
			minDate: 0,
			maxDate: $('input#loan_start_date').val() + 21,
			beforeShowDay: function(date){
				//매주 금요일만 예약날짜 활성화
				var day = date.getDay();
				return [(day != 0 && day != 1 && day != 2 && day != 3 && day != 4 && day != 6)];
			},
			onClose: function(selectedDate){
				var loanMinDate = $('input#loan_start_date').datepicker("getDate");
				loanMinDate.setDate(loanMinDate.getDate() + 6);
				$('input#loan_end_date').datepicker('option', 'minDate', loanMinDate);
				
				var loanMaxDate = $('input#loan_start_date').datepicker("getDate");
				loanMaxDate.setDate(loanMaxDate.getDate() + 14);
				$('input#loan_end_date').datepicker('option', 'maxDate', loanMaxDate);
			}
		});
	} else {
		$('input#loan_start_date').datepicker({
			minDate: 0,
			maxDate: $('input#loan_start_date').val() + 21,
			beforeShowDay: function(date){
				//매주 금요일이며 예약이 되어있지 않은 날짜들만 예약날짜 활성화
				var day = date.getDay();
				var disabledDays = ${disabledList};
				var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
			    for (i = 0; i < disabledDays.length; i++) {
			        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1 || day == 0 || day == 1 || day == 2 || day == 3 || day == 4 || day == 6) {
			            return [false];
			        }
			    }
			    return [true];
			},
			onClose: function(selectedDate){
				var loanMinDate = $('input#loan_start_date').datepicker("getDate");
				loanMinDate.setDate(loanMinDate.getDate() + 6);
				$('input#loan_end_date').datepicker('option', 'minDate', loanMinDate);
				
				var loanMaxDate = $('input#loan_start_date').datepicker("getDate");
				loanMaxDate.setDate(loanMaxDate.getDate() + 14);
				$('input#loan_end_date').datepicker('option', 'maxDate', loanMaxDate);
			}
		});
	}
	
	$('input#loan_end_date').datepicker({
		beforeShowDay: function(date){
			var day = date.getDay();
			return [(day != 0 && day != 1 && day != 2 && day != 3 && day != 5 && day != 6)];
		},
		onClose: function(){
			$('input#hope_date').val($('input#loan_start_date').val());
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
					<form:input path="loan_start_date" cssClass="text ui-calendar" readonly="true"/>
					<span>~</span>
					<form:input path="loan_end_date" cssClass="text ui-calendar" readonly="true"/>
<!-- 					<div class="ui-state-highlight"> -->
<!-- 						<i class="fa fa-question-circle"></i> -->
<!-- 						<em>대출 요일은 금요일, 반납요일은 목요일로 최대 2주동안 대출이 가능합니다.</em> -->
<!-- 					</div> -->
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<th>방문예정일자(<span style="color: red;font-weight: bold;">*</span>)</th> -->
<!-- 				<td> -->
<%-- 					<form:input path="hope_date" cssClass="text" readonly="true" cssStyle="width:100px;"/> --%>
<!-- 					<div class="ui-state-highlight"> -->
<!-- 						<i class="fa fa-question-circle"></i> -->
<!-- 						<em>방문예정일자는 자동으로 대출시작일로 입력됩니다.</em> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<th>방문예정시간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="hope_start_time" cssStyle="selectmenu">
						<c:forEach var="i"  begin="9" end="18">
					        <form:option value="${i}">${i>9?i:'0'}${i>9?'':i}</form:option>
					    </c:forEach>
					</form:select>&nbsp;:
					<form:select path="hope_start_minute" cssStyle="selectmenu">
						<form:option value="00">00</form:option>
						<form:option value="30">30</form:option>
					</form:select>
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
								<form:option value="1">신청중</form:option>
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