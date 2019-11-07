<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('button').click(function(){
		var isBook = $('input#book').is(':checked');
		var isMovie = $('input#movie').is(':checked');
		if (isBook) {
			$('form#dm').attr('action', 'savejc2.do');
		} else if (isMovie) {
			$('form#dm').attr('action', 'savejc3.do');
		} else {
			$('form#dm').attr('action', 'savejc.do');
		}
		var a = doAjaxPost($('form#dm'));
		if (a) {
			alert('완료');
		} 
	});
});	
</script>
<input type="checkbox" id="book"><label for="book">추천도서</label>
<input type="checkbox" id="movie"><label for="movie">영화상영</label>

<form id="dm" name="dm" action="savejc.do" method="post" onsubmit="return false;">
<table class="type2">
				<colgroup>
					<col width="150"/>
					<col width="300"/>
					<col width="150"/>
					<col width="300"/>
				</colgroup>
				<tbody>
					<c:forEach begin="0" step="1" var="i" end="19">
					<tr>
						<th>원 게시판번호(${i})</th>
						<td>
							<input name="manager_seq_arr[${i}]" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
						
						
						<th>대상 게시판번호(${i})</th>
						<td>
							<input name="manage_idx_arr[${i}]" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>
					</tr>
					</c:forEach>
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
