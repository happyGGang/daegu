<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	        location.reload();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('form#statusCnt'))) {
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 330
	});
	
	$(document).on('keyup', 'input.only_num', function() {
		$(this).val( $(this).val().replace(/[^0-9]/gi, '') );
	});
	
	$('select#division_idx').select2();
});
</script>
<style type="text/css">
	select {border: 1px solid #ccd2dc;-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;background: #fafafa;line-height: 27px;height: 27px;padding: 0 5px;vertical-align: middle;}
</style>
<form:form modelAttribute="organization" id="statusCnt" action="statusSave.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="status_idx"/>
	<table class="type2">
		<colgroup>
			<col width="130"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>직렬명</th>
				<td>
					<form:select path="division_idx" class="selectmenu-search" cssStyle="width:130px;">
						<form:options items="${divisionList}" itemLabel="division_name" itemValue="division_idx"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>직급</th>
				<td>
					<form:input path="rating" cssClass="text"/>
				</td>
			</tr>
			<tr>
				<th>정원</th>
				<td>
					<form:input path="max_cnt" cssClass="text spinner only_num" size="5"/>
				</td>
			</tr>
			<tr>
				<th>현원</th>
				<td>
					<form:input path="current_cnt" cssClass="text spinner only_num" size="5"/>
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