<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function walkingThruSettingSave() {
	var rsh = $('select#reserve_start_hour').val();
	var rsm = $('select#reserve_start_minute').val();
	
	var start_time = rsh + ':' + rsm;
	
	var reh = $('select#reserve_end_hour').val();
	var rem = $('select#reserve_end_minute').val();
	
	var end_time = reh + ':' + rem;
	
	if(start_time > end_time){
		$('select#reserve_start_hour').focus();
		alert('예약가능 시작 시간은 예약가능 종료 시간보다 이후일 수 없습니다.');
		return false;
	}
	
	if(start_time == end_time){
		$('select#reserve_start_hour').focus();
		alert('예약가능 시작 시간과 예약가능 종료 시간이 같을수 없습니다.');
		return false;
	}
	
	var lsh = $('select#loan_start_hour').val();
	var lsm = $('select#loan_start_minute').val();
	
	var loan_start_time = lsh + ':' + lsm;
	
	var leh = $('select#loan_end_hour').val();
	var lem = $('select#loan_end_minute').val();
	
	var loan_end_time = leh + ':' + lem;
	
	if(loan_start_time > loan_end_time){
		$('select#loan_start_hour').focus();
		alert('대출가능 시작 시간은 대출가능 종료 시간보다 이후일 수 없습니다.');
		return false;
	}
	
	if(loan_start_time == loan_end_time){
		$('select#loan_start_hour').focus();
		alert('대출가능 시작 시간과 대출가능 종료 시간이 같을수 없습니다.');
		return false;
	}
	
	if ( doAjaxPost($('#walkingThruSetting')) ) {
		location.reload();
	}
}
</script>
<form:form modelAttribute="walkingThruSetting" action="walkingThruSettingSave.do" >
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>비밀번호 사용여부(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="password_yn" value="Y" label="사용" />
					<form:radiobutton path="password_yn" value="N" label="사용안함" />
				</td>
			</tr>
			<tr>
				<th>예약가능 시간 설정(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="reserve_start_hour" id="reserve_start_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${walkingThruSetting.reserve_start_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="reserve_start_minute" id="reserve_start_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
					~
					<form:select path="reserve_end_hour" id="reserve_end_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${walkingThruSetting.reserve_end_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="reserve_end_minute" id="reserve_end_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>대출가능 시간 설정(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="loan_time_choice" value="T" label="금일" />
					<form:radiobutton path="loan_time_choice" value="N" label="익일" />
					<br>
					<form:select path="loan_start_hour" id="loan_start_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${walkingThruSetting.loan_start_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="loan_start_minute" id="loan_start_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
					~
					<form:select path="loan_end_hour" id="loan_end_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${walkingThruSetting.loan_end_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="loan_end_minute" id="loan_end_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
					<div class="ui-state-highlight">
						<em>대기상태 변경시 설정하신 시간으로 문자가 발송됩니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>약관선택</th>
				<td>
					<c:forEach items="${termsList}" var="i" varStatus="status">
						<input type="checkbox" name="terms" id="terms${status.count}" value="${i.terms_idx}" ${fn:contains(walkingThruSetting.terms, i.terms_idx) ? 'checked' : ''}>
						<label for="terms${status.count}">${i.title}</label>
						<br>
					</c:forEach>
					<div class="ui-state-highlight">
						<em>홈페이지관리의 이용약관 관리에서 비대면대출 약관을 추가하시면 사용가능한 약관을 체크를 할 수 있습니다.</em>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>