<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function excelUploadSave() {
	if($('input#mfile').val() == '') {
		alert('엑셀 파일을 선택해주세요.');
		return;
	}
	var form = $('form#excelUpload')[0];
	var data = new FormData(form);

	$.ajax({
		type : "POST",
		enctype: 'multipart/form-data',
		url : 'excelUploadSave.do',
		data : data,
		dataType : 'json',
		processData: false,
		contentType: false,
		success: function(response) {
			if(response.valid) {
				alert('엑셀데이터 일괄 회원가입에 성공하였습니다.');
			} else {
				alert(response.message);
			}
			location.reload();
		},
		error : function() {
			alert('엑셀등록에 실패했습니다.\n관리자에게 문의해 주세요.');
		}
	});
}
</script>
<form:form modelAttribute="supportMember" id="excelUpload" action="excelUploadSave.do" method="POST" enctype="multipart/form-data">
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>엑셀 파일(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="mfile" name="mfile" type="file"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>