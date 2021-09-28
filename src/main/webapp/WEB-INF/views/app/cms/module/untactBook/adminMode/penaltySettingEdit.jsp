<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
function penaltySettingSave() {
	if ( doAjaxPost($('#untactBookReservation')) ) {
		location.reload();
	}
}
</script>

<form:form modelAttribute="untactBookPenalty" action="penaltySettingSave.do" >
<form:hidden path="homepage_id" value="${untactBookPenalty.homepage_id}"/>
<form:hidden path="member_id" value="${untactBookPenalty.member_id}"/>
<form:hidden path="member_name" value="${untactBookPenalty.member_name}"/>
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
				<th>패널티사유</th>
			</tr>
			<tr>
				<td>${untactBookPenalty.homepage_id}</td>
				<td>${untactBookPenalty.member_id}</td>
				<td>${untactBookPenalty.member_name}</td>
				<td>
					<form:select path="penalty_reason">
						<form:option value="도서미수령" label="도서 미수령"/>
						<form:option value="신청중지" label="신청중지"/>
						<form:option value="분실및파손"label="분실 및 파손"/>
						<form:option value="기타1" label="기타1"/>
						<form:option value="기타2" label="기타2"/>
						<form:option value="기타3" label="기타3"/>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

