<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<c:choose>
<c:when test="${empty tempFile}">
	<c:set var="h_id" value="${homepage_id}"/>
	<c:set var="m_idx" value="${menu_idx}"/>
</c:when>
<c:otherwise>
	<c:set var="h_id" value="${tempFile.homepage_id}"/>
	<c:set var="m_idx" value="${tempFile.menu_idx}"/>
</c:otherwise>
</c:choose>
<script>
jQuery(document).ready(function($) {
	$('table#tempfile_table a.tempfile_delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			var params = {
				homepage_id: '${h_id}',
				menu_idx: '${m_idx}',
				file_idx: $(this).data('file_idx')
			};
			$.post('delete_temp_file.do', params).done(function(data) {
				if(data.valid == false) {
					alert('오류가 발생했습니다. 다시 시도해주세요.');
				} else {
					load_tempfile_table(data.homepage_id, data.menu_idx);
				}
			}).fail(function() {
				alert('오류가 발생했습니다. 다시 시도해주세요.');
			});
		}
	});
	
	jQuery('table#tempfile_table a.tempfile_copy').on('click', function(e) {
		e.preventDefault();
		copyToClipboard($(this).text());
		alert('클립보드에 복사되었습니다.')
	});
});

function copyToClipboard(s) {
    var $temp = jQuery("<input>");
    jQuery("table#tempfile_table").append($temp);
    $temp.val(s).select();
    document.execCommand("copy");
    $temp.remove();
}
</script>
<div class="table-scroll">
	<table id="tempfile_table" class="">
		<thead>
			<tr class="center">
				<th style="width: 50px;">순번</th>
				<th>원본 파일명</th>
				<th>파일 경로(URL을 클릭하면 클립보드로 복사가 됩니다)</th>
				<th style="width: 80px;"></th>
			</tr>
		</thead>
		<tbody style="height: 185px">
		<c:forEach var="i" varStatus="status" items="${tempFileList}">
			<tr class="tempfile">
				<td style="width: 50px;">${status.index+1}</td>
				<td>${i.org_file_name}</td>
				<td><a href="#" class="tempfile_copy">/data/menuResources${i.path}</a></td>
				<td style="width: 80px;"><a href="#" class="tempfile_delete" data-file_idx="${i.file_idx}">삭제</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>