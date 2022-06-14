<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
// 	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
	$('#dialog-4').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#applye_state'))) {
						$(this).dialog('destroy');
						$('#dialog-3').load('/cms/module/mediaFactory/apply/applyEdit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&mediaFactory_idx=${apply.mediaFactory_idx}&start_date=${apply.start_date}');
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
	
	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 250
	});
		
});
</script>
<form:form modelAttribute="mediaFactoryApply" id="applye_state" method="post" action="/cms/module/mediaFactory/apply/save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="apply_idx"/>
<form:hidden path="applicant_tel"/>
	<table class="type2">
		<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>승인상태</th>
			<td>
				<form:radiobutton path="apply_state" value="1"/><label for="apply_state1" style="cursor:pointer;">대기</label>&nbsp;
				<form:radiobutton path="apply_state" value="2"/><label for="apply_state2" style="cursor:pointer;">불가</label>&nbsp;
				<form:radiobutton path="apply_state" value="3"/><label for="apply_state3" style="cursor:pointer;">승인</label>&nbsp;
			</td>
		</tr>
	</tbody>
	</table>
</form:form>