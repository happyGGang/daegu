<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
var started = false;
$(function() {
	$('a#excelUpload').on('click', function(e) {
		e.preventDefault();
	
		if($('input#mfile').val() == '') {
			alert('엑셀 파일을 선택해주세요.');
			return;
		}
	
		if(started) {
			alert('작업을 진행 중입니다. 잠시 기다려주세요.');
			return;
		}
	
		$('form#file-upload-form').submit();
	});
});
</script>

<form id="file-upload-form" name="file-upload-form" action="excelUpload.do" method="POST" enctype="multipart/form-data">
	<table class="type2">
		<tbody>
			<tr><th>엑셀 파일</th><td><input type="file" id="mfile" name="mfile"></td></tr>
			<tr>
				<th colspan="2" style="text-align: center;">
					<a href="#" id="excelUpload" class="btn btn">엑셀업로드</a><br/>
					* 엑셀 파일 용량에 따라 수십 초 ~ 수 분이 걸릴 수 있습니다
				</th>
			</tr>
		</tbody>
	</table>
</form>
