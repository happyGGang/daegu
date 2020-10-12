<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(function(){
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
			$('.ui-widget-overlay').removeClass('custom-overlay');
		},
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('form#humanApply_u'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					$(this).html('');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 350,
		height: 250
	});
	
	if($('select#human_apply_status').val() != '3') {
		$('input#unapproved_reasons').closest('tr').hide();
// 		$('input#unapproved_reasons').attr('disabled', true);
	}
	$('select#human_apply_status').on('change', function(e) {
		if($(this).val() == '3') {
			$('input#unapproved_reasons').closest('tr').show();
// 			$('input#unapproved_reasons').attr('disabled', false);
		} else {
			$('input#unapproved_reasons').closest('tr').hide();
			$('input#unapproved_reasons').val('');
// 			$('input#unapproved_reasons').attr('disabled', true);
		}
	});
	
});
</script>
<form:form modelAttribute="humanApply" id="humanApply_u" action="save.do" method="POST">
<form:hidden path="homepage_id" id="homepage_id_u"/>
<form:hidden path="editMode" id="editMode_u"/>
<form:hidden path="human_book_idx" id="human_book_idx_u"/>
<form:hidden path="human_apply_idx" id="human_apply_idx_u"/>
<div>
	<table>
		<tbody>
			<tr>
				<th width="80">상태</th>
				<td>
					<form:select path="human_apply_status" cssClass="selectmenu">
						<form:option value="0">신청</form:option>
						<form:option value="1">승인</form:option>
						<form:option value="2">취소</form:option>
						<form:option value="3">미승인</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>취소사유</th>
				<td>
					<form:input path="unapproved_reasons" cssClass="text"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>