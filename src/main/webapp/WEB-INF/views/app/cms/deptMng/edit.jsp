<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					if(doAjaxPost($('form#workEdit'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
// 					location.reload();
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 500
	});
	
	$('select#dept_idx').select2();
});
</script>
<style type="text/css">
	select {border: 1px solid #ccd2dc;-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;background: #fafafa;line-height: 27px;height: 27px;padding: 0 5px;vertical-align: middle;}
</style>
<form:form modelAttribute="deptMng" id="workEdit" action="save.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="work_idx"/>
	<table class="type2">
		<colgroup>
			<col width="130"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>부 서</th>
				<td>
					<form:select path="dept_idx" cssClass="selectmenu-search" cssStyle="width:146px;">
						<form:options items="${deptList}" itemLabel="dept_name" itemValue="dept_idx"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>직 위</th>
				<td>
					<form:input path="position" class="text"/>
				</td>
			</tr>
			<tr>
				<th>성 명</th>
				<td>
					<form:input path="worker" class="text"/>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<form:input path="phone" class="text"/>
				</td>
			</tr>
			<tr>
				<th>업무</th>
				<td>
					<form:textarea path="work_info" class="text" cssStyle="width:100%; height:130px;"/>
				</td>
			</tr>
			<tr>
				<th>출력순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>