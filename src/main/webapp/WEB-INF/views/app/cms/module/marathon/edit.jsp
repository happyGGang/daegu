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
				click: function() {
					if($('input#contest_name').val() == ''){
						alert('대회명을 입력해 주세요.');
						$('input#contest_name').focus();
						return false;
					}
					
					if($('input#application_start_day').val() == ''){
						alert('접수기간 시작 일자를 입력해 주세요.');
						$('input#application_start_day').focus();
						return false;
					}
					
					if($('input#application_end_day').val() == ''){
						alert('접수기간 종료 일자를 입력해 주세요.');
						$('input#application_end_day').focus();
						return false;
					}
					
					if($('input#contest_start_day').val() == ''){
						alert('대회기간 시작 일자를 입력해 주세요.');
						$('input#contest_start_day').focus();
						return false;
					}
					
					if($('input#contest_end_day').val() == ''){
						alert('대회기간 종료 일자를 입력해 주세요.');
						$('input#contest_end_day').focus();
						return false;
					}
					
					if($('input#application_start_day').val() > $('input#application_end_day').val()){
						alert('접수 기간 시작 일자는 접수 기간 종료 일자보다 이후일 수 없습니다.');
						return false;
					}
					
					if($('input#contest_start_day').val() > $('input#contest_end_day').val()){
						alert('대회 기간 시작 일자는 대회 기간 종료 일자보다 이후일 수 없습니다.');
						return false;
					}
					
					if($('input#application_end_day').val() > $('input#contest_end_day').val()){
						alert('접수 기간 종료 일자는 대회 기간 종료 일자보다 이후일 수 없습니다.');
						return false;
					}
					
					if($('input:radio[name = use_yn]:checked').length < 1){
						alert('사용여부를 입력해 주세요.');
						return false;
					}
					
					if (doAjaxPost($('form#marathon'))) {
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
		height: 500
	});
	
	$('input#application_start_day').datepicker({
		maxDate : $('input#application_end_day').val(),
		onClose : function(selectedDate){
			$('input#application_end_day').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#application_end_day').datepicker({
		minDate : $('input#application_start_day').val(),
		onClose : function(selectedDate){
			$('input#application_start_day').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#contest_start_day').datepicker({
		maxDate : $('input#contest_end_day').val(),
		onClose : function(selectedDate){
			$('input#contest_end_day').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#contest_end_day').datepicker({
		minDate : $('input#contest_start_day').val(),
		onClose : function(selectedDate){
			$('input#contest_start_day').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#finish_day').datepicker({
		minDate : $('input#contest_end_day').val(),
		onClose : function(selectedDate){
			$('input#finish_day').datepicker();
		}
	});
});
</script>
<form:form modelAttribute="marathon" method="POST" action="save.do" onsubmit="return false;">
	<form:hidden path="homepage_id" />
	<form:hidden path="contest_idx" />
	<form:hidden path="editMode" />
	<table class="type2">
		<colgroup>
			<col width="160" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>대회명</th>
				<td><form:input path="contest_name" cssClass="text" size="30"/></td>
			</tr>
			<tr>
				<th>접수기간</th>
				<td><form:input path="application_start_day" cssClass="text" size="10" maxlength="10"/>
				~ <form:input path="application_end_day" cssClass="text" size="10" maxlength="10"/></td>
			</tr>
			<tr>
				<th>대회기간</th>
				<td><form:input path="contest_start_day" cssClass="text" size="10" maxlength="10"/>
				~ <form:input path="contest_end_day" cssClass="text" size="10" maxlength="10"/></td>
			</tr>
			<tr>
				<th>완주확정일</th>
				<td><form:input path="finish_day" cssClass="text" size="10" maxlength="10"/></td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" id="use_yn_yes" value="Y"/>
					<label for="use_yn_yes">예</label>
					<form:radiobutton path="use_yn" id="use_yn_no" value="N"/>
					<label for="use_yn_no">아니오</label>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>