<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('button').click(function(){
		doAjaxPost($('form#dm'));
	});
});	
</script>

<form id="dm" name="dm" action="saveinfo.do" method="post" onsubmit="return false;">
<table class="type2">
				<colgroup>
					<col width="150"/>
					<col width="300"/>
					<col width="150"/>
					<col width="300"/>
				</colgroup>
				<tbody>
					<tr>
						<th>원 게시판번호</th>
						<td>
							<input name="manager_seq" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
						
						
						<th>대상 게시판번호</th>
						<td>
							<input name="manage_idx" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
					</tr>
					<!-- <tr>
						<th>기존 컬럼명</th>
						<td>
							<input name="board_seq" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
						
						
						<th>대상 컬럼명</th>
						<td>
							<input name="board_idx" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
					</tr> -->
				</tbody>
			</table>
			<button>전송</button>
</form>
