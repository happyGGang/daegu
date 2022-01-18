<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function bookSettingSave() {
	if ( doAjaxPost($('#untactBookSetting')) ) {
		location.reload();
	}
}

$('input#round_start_date').datepicker({
	dateFormat:'yy-mm-dd',
	minDate: 0,
	maxDate: $('input#round_end_date').val(), 
	onClose: function(selectedDate){
		$('input#round_end_date').datepicker('option', 'minDate', selectedDate);
	}
}).datepicker('setDate', '${untactBookSetting.round_start_date}');

$('input#round_end_date').datepicker({
	dateFormat:'yy-mm-dd',
	minDate: $('input#round_start_date').val(),
	onClose: function(selectedDate){
		$('input#round_start_date').datepicker('option', 'maxDate', selectedDate);
	}
}).datepicker('setDate', '${untactBookSetting.round_end_date}');
</script>

<form:form modelAttribute="untactBookSetting" action="bookSettingSave.do" >
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>홈페이지ID</th>
				<td>${untactBookSetting.homepage_id}</td>
			</tr>
			<tr>
				<th>사물함 사용여부(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="locker_use_yn" value="Y" label="사용" />
					<form:radiobutton path="locker_use_yn" value="N" label="미사용" />
				</td>
			</tr>
			<tr>
				<th>사물함 한줄당 갯수(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="row_count">
						<form:option value="1" label="1개"/>
						<form:option value="2" label="2개"/>
						<form:option value="3" label="3개"/>
						<form:option value="4" label="4개"/>
						<form:option value="5" label="5개"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>총 사물함 갯수(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="total_count" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>개
					<div class="ui-state-highlight">
						<em>숫자만 입력가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>예약기준 시간 설정(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					기준일 : 
					<form:input path="round_start_date" class="text ui-calendar" readonly="true" /> ~
					<form:input path="round_end_date" class="text ui-calendar" readonly="true" /> 
					<br>
					반복일 : 
					<form:input path="reservation_repeated_day" style="width:30px;"/>일
					<br>
					반복시간 : 
					<form:select path="start_hour" id="start_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${untactBookSetting.start_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="start_minute" id="start_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
					<div class="ui-state-highlight">
						<em>선택하신 기준일로부터 지정하신 일수와 시간에 맞춰 예약 기준 시간이 반복됩니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>사물함 타입 설정(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<input type="radio" name="locker_use_type" value="0" id="비밀번호" <c:if test="${untactBookSetting.locker_use_type eq '0'}">checked</c:if>><label for="비밀번호">&nbsp;비밀번호</label>&nbsp;
					<input type="radio" name="locker_use_type" value="1" id="QR코드" <c:if test="${untactBookSetting.locker_use_type eq '1'}">checked</c:if>><label for="QR코드">&nbsp;QR코드</label>&nbsp;
					<input type="radio" name="locker_use_type" value="2" id="사물함없음" <c:if test="${untactBookSetting.locker_use_type eq '2'}">checked</c:if>><label for="사물함없음">&nbsp;사물함없음</label>
				</td>
			</tr>
			<tr>
				<th>약관선택</th>
				<td>
					<c:forEach items="${termsList}" var="i" varStatus="status">
						<input type="checkbox" name="terms" id="terms${status.count}" value="${i.terms_idx}" ${fn:contains(untactBookSetting.terms, i.terms_idx) ? 'checked' : ''}>
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

