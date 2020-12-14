<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	
	$('.dialog-common').dialog({
		autoOpen: false,
		resizable: true,
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
				click: function(){
					if(doAjaxPost($('form#marathonType'))){
						location.reload();
					}
				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});
	
	$('#dialog-1').dialog({
		width: 800,
		height: 600
	});
	
	$('#add-btn').on('click', function(e) {
		e.preventDefault();
		var clonebtr = $('form#marathonType table tbody tr:last').clone();

		clonebtr.find('th').text('종목' + $('form#marathonType table tbody tr').length);
		clonebtr.find('input').eq(0).attr('id', 'typeList' + ($('form#marathonType table tbody tr').length-1) + '.contest_type');
		clonebtr.find('input').eq(0).attr('name', 'typeList[' + ($('form#marathonType table tbody tr').length-1) + '].contest_type');
		clonebtr.find('input').eq(1).attr('id', 'typeList' + ($('form#marathonType table tbody tr').length-1) + '.page_count');
		clonebtr.find('input').eq(1).attr('name', 'typeList[' + ($('form#marathonType table tbody tr').length-1) + '].page_count');
		clonebtr.find('input').eq(2).attr('id', 'typeList' + ($('form#marathonType table tbody tr').length-1) + '.application_subject');
		clonebtr.find('input').eq(2).attr('name', 'typeList[' + ($('form#marathonType table tbody tr').length-1) + '].application_subject');

		$('form#marathonType table tbody').append('<tr>' + clonebtr.html() + '</tr>');
		
	});
	
	$('#delete-btn').on('click', function(e) {
		e.preventDefault();
		if($('form#marathonType table tbody tr').length > 2){
			$('form#marathonType table tbody tr:last').remove();
		}
	});
});
</script>
<!-- 
<form id="asdf" method="POST" action="save.do">
<input type="hidden" name="contest_type"/>
</form> -->
<form:form modelAttribute="marathonType" method="POST" action="save.do" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="contest_type_idx"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
			<col width="160"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<c:choose>
				<c:when test="${marathonType.editMode eq 'ADD'}">
					<div class="button" style="text-align: right;">
						<a href="" id="add-btn" class="btn btn1" style="height:20px;"><span>종목 추가</span></a>
						<a href="" id="delete-btn" class="btn" style="height:20px;"><span>종목 삭제</span></a>				
					</div>
					<tr>
						<th>대회명</th>
						<td>
							<form:select path="contest_idx" cssClass="text" readonly="true">
								<c:forEach items="${marathonList}" var="i">
									<form:option value="${i.contest_idx}">${i.contest_name}</form:option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<c:forEach begin="0" end="3" step="1" var="i" varStatus="status">
					<tr>
						<th>종목${status.count}</th>
						<td style="padding:10px;border-bottom:1px solid #a0a0a0;">
							종목명 : <form:input path="typeList[${i}].contest_type" cssClass="text"/><br/>
							쪽수&nbsp;&nbsp;&nbsp; : <form:input path="typeList[${i}].page_count" cssClass="text"/><br/>
							대상&nbsp;&nbsp;&nbsp; : 
							<form:select path="typeList[${i}].application_subject" cssClass="selectmenu">
								<form:option value="ele_low">초등1~3학년</form:option>
								<form:option value="ele_high">초등4~6학년</form:option>
								<form:option value="middle,high,adult">중학생 이상, 일반인</form:option>
								<form:option value="all">초등생~성인</form:option>
							</form:select>
						</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:when test="${marathonType.editMode eq 'MODIFY'}">
					<tr>
						<th>대회명</th>
						<td>
							<form:select path="contest_idx" cssClass="text" readonly="true">
								<c:forEach items="${marathonList}" var="i">
									<form:option value="${i.contest_idx}">${i.contest_name}</form:option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>종목</th>
						<td>
							종목명 : <form:input path="contest_type" cssClass="text"/><br/>
							쪽수&nbsp;&nbsp;&nbsp; : <form:input path="page_count" cssClass="text"/><br/>
							
							대상&nbsp;&nbsp;&nbsp; : 
							<form:select path="application_subject" cssClass="selectmenu">
								<form:option value="ele_low">초등1~3학년</form:option>
								<form:option value="ele_high">초등4~6학년</form:option>
								<form:option value="middle,high,adult">중학생 이상, 일반인</form:option>
								<form:option value="all">초등생~성인</form:option>
							</form:select>
						</td>
					</tr>
				</c:when>
			</c:choose>
			
		</tbody>
	</table>
</form:form>