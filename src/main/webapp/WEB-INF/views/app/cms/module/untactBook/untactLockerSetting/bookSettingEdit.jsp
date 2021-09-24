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
		</tbody>
	</table>
	
</form:form>

