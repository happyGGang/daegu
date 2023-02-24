<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function save() {
	if ( doAjaxPost($('#nearbyLibPenaltyEdit')) ) {
		location.reload();
	}
}

function searchMember() {
	$('#dialog-search').load('/cms/module/nearbyLib/nearbyLibPenalty/searchMember.do?penalty_member_id=' + $('#penalty_member_id').val(), function( response, status, xhr ) {
		$('#dialog-search').dialog('open');
	});
}
</script>

<form:form id="nearbyLibPenaltyEdit" modelAttribute="nearbyLibPenalty" action="save.do" >
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>아이디(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="homepage_id"/>
					<form:hidden path="manage_code"/>
					<form:hidden path="penalty_date"/>
					<form:input path="penalty_member_id" cssClass="text"/><a class="btn btn1 teacher-btn" onclick="searchMember();">검색</a>
				</td>
			</tr>
			<tr>
				<th>페널티사유</th>
				<td>
					<form:textarea path="penalty_reason" class="text" cssStyle="width:100%;" rows="5" />
				</td>
			</tr>
		</tbody>
	</table>
</form:form>

<div id="dialog-search" class="dialog-common" title="회원 검색"></div>