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
					if(doAjaxPost($('#checkInOutSeurveyForm'))) {
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

	$("#dialog-1").dialog({
		width: 600,
		height: 260
	});

	$('input#checkinout_survey_start_date').datepicker({
		maxDate: $('input#checkinout_survey_end_date').val(),
		onClose: function(selectedDate){
			$('input#checkinout_survey_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#checkinout_survey_end_date').datepicker({
		minDate: $('input#checkinout_survey_start_date').val(),
		onClose: function(selectedDate){
			$('input#checkinout_survey_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

});

</script>
<form:form id="checkInOutSeurveyForm" modelAttribute="checkInOutSurvey" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="checkinout_survey_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
				<th>설문조사 제목</th>
				<td><form:input path="checkinout_survey_name" class="text" cssStyle="width:100%"/></td>
			</tr>
	        <tr>
	         	<th>설문조사 기간</th>
	         	<td><form:input path="checkinout_survey_start_date" cssClass="text ui-calendar"/> ~ <form:input path="checkinout_survey_end_date" cssClass="text ui-calendar"/></td>
	        </tr>
			<tr>
				<th>사용유무</th>
				<td>
					<form:radiobutton path="use_yn" cssClass="cancle_yn" value="Y" label="사용" cssStyle="cursor: pointer;"/>
					<form:radiobutton path="use_yn" cssClass="cancle_yn" value="N" label="미사용" cssStyle="cursor: pointer;"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
