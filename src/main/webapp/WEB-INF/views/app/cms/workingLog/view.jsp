<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script>
$(function() {

	$('div#dialog-1').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$('div#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 780,
		height: 650
	});
	$('pre#queryString').text($('pre#queryString').text().trim());
});
</script>
<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>사이트 / 작업구분</th>
			<td>
				${workingLog.siteName} / ${workingLog.work_type eq 'W' ? '일반작업' : '개인정보' }
			</td>
		</tr>

		<tr>
			<th>작업명령어 / 내용</th>
			<td>
				${workingLog.work_command} / ${workingLog.work_comment}
			</td>
		</tr>

		<tr>
			<th>사용자 ID / IP</th>
			<td>
				${workingLog.member_id} / ${workingLog.work_ip}
			</td>
		</tr>

		<tr>
			<th>작업일시</th>
			<td>
				<fmt:formatDate value="${workingLog.work_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
		</tr>

		<tr>
			<th>작업사유</th>
			<td>
				${workingLog.work_reason}
			</td>
		</tr>

		<tr class="detailContent">
			<th>작업쿼리</th>
			<td>
<!-- 				<textarea style="width:100%; height : 300px;" id="queryString"> -->
<%-- 				${fn:trim(workingLog.work_query)} --%>
<!-- 				</textarea> -->
				<pre id="queryString" style="width:100%; ">
				${fn:trim(workingLog.work_query)}
				</pre>
			</td>
		</tr>
	</tbody>
</table>
