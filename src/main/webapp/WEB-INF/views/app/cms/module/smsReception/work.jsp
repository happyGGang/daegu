<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<style type="text/css">
.chk_yn {margin-right: 5px;}
</style>
<script type="text/javascript">
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('form#smsReceptionWork'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});	

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 180
	});
	
});
</script>

<form:form modelAttribute="smsReception" id="smsReceptionWork" method="post" action="workSave.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="reception_idx"/>
	<table class="type2">
		<colgroup>
			<col width="100" />
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>업무 및 수신여부</th>
<!-- 				<th>수신여부</th> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${workCodeList}" var="i" varStatus="status">
			<tr>
				<td>
					<form:checkbox path="reception_list[${status.index}].reception_yn" cssClass="chk_yn" value="Y" label="${i.code_name}"/>
					<form:hidden path="reception_list[${status.index}].work_code" value="${i.code_id}"/>
					<form:hidden path="reception_list[${status.index}].work_idx"/>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
