<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#code'))) {
						$(this).dialog('destroy');
						$(current_node).click();
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400, 
		height: 400
	});
	
	$('input#print_seq').spinner({
		min: 0,
		max: 2500,
		step: 1,
		start: 1000
	});
});

</script>
<form:form modelAttribute="code" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="group_id"/>
<form:hidden path="homepage_id"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody> 
		<tr>
			<th>코드그룹ID</th>
			<td>${code.group_id}</td>
		</tr>
		<tr>
			<th>코드ID <em>*</em></th>
			<td>
				<c:choose>
				<c:when test="${code.editMode eq 'MODIFY'}">
					${code.code_id}
					<form:hidden path="code_id" />
				</c:when>
				<c:otherwise>
					<form:input path="code_id" cssStyle="width:136px;" cssClass="text" maxlength="4"/>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>코드명  <em>*</em></th>
			<td>
				<form:input path="code_name" cssStyle="width:178px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:178px;" cssClass="text" maxlength="100"/>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<form:select path="use_yn" cssClass="select">
					<form:option value="Y">예</form:option>
					<form:option value="N">아니오</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>정렬순서</th>
			<td>
				<form:input path="print_seq" cssStyle="width:50px;" cssClass="text"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>