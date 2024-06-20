<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#checkInOutSurveyForm'))) {
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
		width: 600,
		height: 300
	});

	$('input#checkInOut_survey_start_date').datepicker({
		maxDate: $('input#checkInOut_survey_end_date').val(),
		onClose: function(selectedDate){
			$('input#checkInOut_survey_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#checkInOut_survey_end_date').datepicker({
		minDate: $('input#checkInOut_survey_start_date').val(),
		onClose: function(selectedDate){
			$('input#checkInOut_survey_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

});

</script>
<form:form id="checkInOutSurveyForm" modelAttribute="checkInOutSurvey" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="checkInOut_survey_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
	       <col width="150" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>설문조사 기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="checkInOut_survey_start_date" cssClass="text ui-calendar"/> ~ <form:input path="checkInOut_survey_end_date" cssClass="text ui-calendar"/></td>
	        </tr>
	        <tr>
	         	<th>설문조사 제목 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="checkInOut_survey_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
			<tr>
				<th>사용여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="use_yn" class="Y" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
