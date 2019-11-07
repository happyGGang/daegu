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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#authGroup'))) {
						$(this).dialog('destroy');
						treeOnLoad();
						$('td#auth_group_id_left').html('');
						$('td#auth_group_name_left').html('');
						$('td#remark_left').html('');
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
		width: 400,
		height: 300
	});
});

</script>
<form:form id="authGroup" modelAttribute="auth" action="saveAuthGroup.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>권한그룹ID <em>*</em></th>
			<td>
			<c:choose>
			<c:when test="${auth.editMode eq 'MODIFY'}">
				${auth.auth_group_id}
				<form:hidden path="auth_group_id" />
			</c:when>
			<c:otherwise>
				<form:input path="auth_group_id" cssStyle="width:178px;" cssClass="text" />
			</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<th>권한그룹명 <em>*</em></th>
			<td>
				<form:input path="auth_group_name" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>