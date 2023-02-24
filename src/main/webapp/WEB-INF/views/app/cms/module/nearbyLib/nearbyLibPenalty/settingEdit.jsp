<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function saveSetting() {
	if ( doAjaxPost($('#nearbyLibPenaltySetting')) ) {
		location.reload();
	}
}

</script>

<form:form id="nearbyLibPenaltySetting" modelAttribute="nearbyLibPenalty" action="saveSetting.do" >
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>페널티기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="penalty_period" cssClass="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>일
					<div class="ui-state-highlight">
						<em>숫자만 입력가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>페널티횟수기준(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="penalty_standard_count" cssClass="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>회
					<div class="ui-state-highlight">
						<em>숫자만 입력가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>페널티사용유무(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<input type="radio" name="use_yn" value="Y" id="사용함" <c:if test="${nearbyLibPenalty.use_yn eq 'Y'}">checked</c:if>><label for="사용함">&nbsp;사용함</label>&nbsp;
					<input type="radio" name="use_yn" value="N" id="사용안함" <c:if test="${nearbyLibPenalty.use_yn eq 'N'}">checked</c:if>><label for="사용안함">&nbsp;사용안함</label>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

