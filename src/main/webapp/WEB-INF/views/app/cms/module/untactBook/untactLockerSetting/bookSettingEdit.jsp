<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
function bookSettingSave() {
	if ( doAjaxPost($('#untactBookSetting')) ) {
		location.reload();
	}
}
</script>

<form:form modelAttribute="untactBookSetting" action="bookSettingSave.do" >
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="25%">
			<col width="75%">
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
					<form:input path="total_count"/>
				</td>
			</tr>
			<tr>
				<th>하루최대 대출가능 권수(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="reservation_max_count"/>
				</td>
			</tr>
			<tr>
				<th>대출가능 시간 설정(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="start_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test='${hour < 10}'>0</c:if>${hour}" ${untactBookSetting.start_hour eq hour ? 'selected' : ''}><c:if test='${hour < 10}'>0</c:if>${hour}</option>
						</c:forEach>
					</form:select>:
					<form:select path="start_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>~
					<form:select path="end_hour">
						<c:forEach var="hour" begin="0" end="23">
							<option value="<c:if test="${hour < 10}">0</c:if>${hour}" ${untactBookSetting.end_hour eq hour ? 'selected' : ''} ><c:if test="${hour < 10}">0</c:if>${hour}
						</c:forEach>
					</form:select>:
					<form:select path="end_minute">
						<form:option value="00">00</form:option>
						<form:option value="10">10</form:option>
						<form:option value="20">20</form:option>
						<form:option value="30">30</form:option>
						<form:option value="40">40</form:option>
						<form:option value="50">50</form:option>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

