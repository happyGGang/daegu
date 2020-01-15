<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('button').click(function(){

		var a = doAjaxPost($('form#dm'));
		if (a) {
			alert('완료');
		}
	});

	$('input').on('paste', function(e){
	    var $this = $(this);
	    $.each(e.originalEvent.clipboardData.items, function(i, v){
	        if (v.type === 'text/plain'){
	            v.getAsString(function(text){
	                var x = $this.closest('td').index(),
	                    y = $this.closest('tr').index(),
	                    obj = {};
	                text = text.trim('\r\n');
	                $.each(text.split('\r\n'), function(i2, v2){
	                    $.each(v2.split('\t'), function(i3, v3){
	                        var row = y+i2, col = x+i3;
	                        obj['cell-'+row+'-'+col] = v3;
	                        $this.closest('table').find('tr:eq('+row+') td:eq('+(col-1)+') input').val(v3);
	                    });
	                });
	            });
	        }
	    });
	    return false;
	});

});
</script>
228민주도서관
<form id="dm" name="dm" action="saveminju.do" method="post" onsubmit="return false;">
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
						<th>원(MYSQL) 게시판번호(${i})</th>
						<td>
							<input name="manager_seq_arr[${i}]" cssClass="text" cssStyle="width:300px;" maxlength="50"/>
						</td>


						<th>대상(CMS) 게시판번호(${i})</th>
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
