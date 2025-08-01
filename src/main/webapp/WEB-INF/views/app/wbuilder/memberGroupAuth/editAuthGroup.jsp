<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
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
	        $(this).dialog('destroy');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#memberGroupAuthEdit'))) {
						$(this).dialog('destroy');
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
	
	$("#dialog-1").dialog({
		width: 400,
		height: 500
	});
	
	$('input#checkAllModuleAuth').on('click', function() {
		$('tbody#moduleAuthList input:checkbox').prop('checked', $(this).is(':checked'));
	});
});

</script>
<form:form id="memberGroupAuthEdit" modelAttribute="memberGroupAuth" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="member_group_idx"/>
<form:hidden path="menu_idx"/>
<form:hidden path="module_idx"/>
<form:hidden path="moduleType"/>
<form:hidden path="module_type" value="MODULE"/>
<form:hidden path="site_id"/>
<table class="type2">
	<colgroup>
		<col width="30"/>
		<col width="150"/>
		<col width="*"/>
	</colgroup>
	<thead>
		<tr>
			<th><input type="checkbox" id="checkAllModuleAuth"/></th>
			<th>권한</th>
			<th>비고</th>
		</tr>	
	</thead>
	<tbody id="moduleAuthList">
		<c:forEach items="${moduleAuthList}" var="i" varStatus="status">
		<tr>
			<td><form:checkbox path="authCodeList" value="${memberGroupAuth.menu_idx}_${memberGroupAuth.module_idx}_${i.auth_code_id}"/> </td>
			<td>${i.auth_code_name}</td>
			<td>${i.remark}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</form:form>