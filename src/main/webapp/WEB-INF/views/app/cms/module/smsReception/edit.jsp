<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-1').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('form#smsReceptionEdit'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});	

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 300,
		height: 200
	});
	
});

</script>
<form:form modelAttribute="smsReception" id="smsReceptionEdit" method="post" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="reception_idx"/>
	<table class="type2">
		<colgroup>
			<col width="100" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>담당자명</th>
				<td>
					<form:input path="reception_name" class="text"/>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<form:input path="reception_phone" class="text"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
