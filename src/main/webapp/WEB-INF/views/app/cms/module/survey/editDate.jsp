<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		if ( doAjaxPost($('#survey')) ) {
			var url = 'index.do';
			var formData = serializeParameter(['viewPage', 'homepage_id']);
			
			doGetLoad(url, formData);
		}
	});
	
	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		
		var url = 'index.do';
		var formData = serializeParameter(['viewPage', 'homepage_id']);
		
		doGetLoad(url, formData);
	});
	
	$('input#survey_start_date').datepicker({
		maxDate: $('input#survey_end_date').val(), 
		onClose: function(selectedDate){
			$('input#survey_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#survey_end_date').datepicker({
		minDate: $('input#survey_start_date').val(), 
		onClose: function(selectedDate){
			$('input#survey_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
		
});
</script>
<style>
table tbody th{text-align: center; font-weight: bold !important;}
</style>
<form:form modelAttribute="survey" method="POST" action="saveDate.do">
<form:hidden path="homepage_id" />
<form:hidden path="survey_idx" />
<form:hidden path="editMode"/>
	<fieldset>			
		<table class="type2" summary="새로운 설문을 등록할 수 있습니다.">
			<h5>설문조사 기본설정</h5>
			<colgroup>
				<col width="20%" />
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th>조사자</th>
					<td>${survey.add_id}</td>
				</tr>
				<tr>
					<th>조사명</th>
					<td>${survey.survey_title}</td>
				</tr>
				<tr>
					<th>설문기간</th>
					<td>
						<form:input type="text" id="survey_start_date" path="survey_start_date" class="text ui-calendar"/>
						<span id="tilde" style="font-size:12px">~</span>
						<form:input type="text" id="survey_end_date" path="survey_end_date" class="text ui-calendar"/>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>
</form:form>
<div class="button" style="text-align: center; padding-top: 20px;">
	<a href="" id="save_btn" class="btn btn1"><span>저장</span></a>
	<a href="" id="list_btn" class="btn"><span>목록</span></a>
</div>