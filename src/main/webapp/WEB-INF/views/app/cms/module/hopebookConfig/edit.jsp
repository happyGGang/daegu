<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- <script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script> -->
<script type="text/javascript">
$(document).ready(function() {
	
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
					doAjaxPost($('form#hopebookConfigEdit'));
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
		width: 550,
		height: 360
	});
	
	$('input#str_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#str_date').val(),
		onClose: function(selectedDate){
			$('input#str_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});
</script>
<style type="text/css">
	textarea {border: 1px solid #ccd2dc;border-radius: 7px;}
</style>
<form:form modelAttribute="hopebookConfig" id="hopebookConfigEdit" method="post" action="save.do">
	<form:hidden path="homepage_id"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>소장위치</th>
				<td>${homepage.homepage_name}</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" label="사용" value="Y"/>
					<form:radiobutton path="use_yn" label="미사용" value="N"/>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<form:input path="str_date" class="text ui-calendar"/>
					<form:input path="str_time" class="text" cssStyle="width:50px;" maxlength="5"/>
					<span id="tilde" style="font-size:12px">~</span>
					<form:input path="end_date" class="text ui-calendar"/>
					<form:input path="end_time" class="text" cssStyle="width:50px;" maxlength="5"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>메세지</th>
				<td>
					<form:textarea path="res_msg" rows="4" cols="59"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>