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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#codeGroup'))) {
						$(this).dialog('destroy');
// 						if ($('form#codeGroup > input#editMode').val() == 'MODIFY') {
// 							$('#tree1').tree('updateNode', current_node, {name:$('form#codeGroup > input#group_name').val()});
// 						}
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
		width: 400,
		height: 400
	});
});

</script>
<form:form id="codeGroup" modelAttribute="code" action="saveCodeGroup.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="mode"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody> 
		<tr>
			<th>코드그룹ID <em>*</em>
				<br> (10자이내)</th>
			<td>
			<c:choose>
			<c:when test="${code.editMode eq 'MODIFY'}">
				${code.group_id}
				<form:hidden path="group_id" />
			</c:when>
			<c:otherwise>
				<form:input path="group_id" cssStyle="width:178px;" cssClass="text" />
			</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<th>코드그룹명 <em>*</em>
				<br> (20자이내)</th>
			<td>
				<form:input path="group_name" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>홈페이지 사용 <em>*</em></th>
			<td>
				<form:select path="homepage_yn">
					<form:option value="Y">YES</form:option>
					<form:option value="N">NO</form:option>
				</form:select>
				<br/>
				*각 홈페이지에서도 사용하는 경우 YES
			</td>
		</tr>
		<tr>
			<th>설명
				<br> (100자이내)</th>
			<td>
				<form:input path="remark" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>