<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
function cancelSettingSave() {
	if ( doAjaxPost($('#untactBookReservation_1')) ) {
		location.reload();
	}
}
</script>

<form:form id="untactBookReservation_1" modelAttribute="untactBookReservation" action="cancelSettingSave.do">
<form:hidden path="homepage_id"/>
<form:hidden path="member_id"/>
<form:hidden path="member_name"/>
<form:hidden path="request_number"/>
	<table class="type2">
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="25%">
			<col width="25%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>홈페이지ID</th>
				<th>신청자ID</th>
				<th>신청자명</th>
				<th>취소사유</th>
			</tr>
			<tr>
				<td>${untactBookReservation.homepage_id}</td>
				<td>${untactBookReservation.member_id}</td>
				<td>${untactBookReservation.member_name}</td>
				<td>
					<form:select path="cancel_reason">
						<form:option value="처리중누락" label="처리중누락"/>
						<form:option value="단순변심" label="단순변심"/>
						<form:option value="희귀도서" label="희귀도서"/>
						<form:option value="기타1" label="기타1"/>
						<form:option value="기타2" label="기타2"/>
						<form:option value="기타3" label="기타3"/>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

