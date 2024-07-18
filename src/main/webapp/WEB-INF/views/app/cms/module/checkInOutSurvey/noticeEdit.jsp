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
					if(doAjaxPost($('#checkInOutNoticeForm'))) {
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

	$("#dialog-4").dialog({
		width: 600,
		height: 270
	});

	$('input#checkinout_notice_start_date').datepicker({
		maxDate: $('input#checkinout_notice_end_date').val(),
		onClose: function(selectedDate){
			$('input#checkinout_notice_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#checkinout_notice_end_date').datepicker({
		minDate: $('input#checkinout_notice_start_date').val(),
		onClose: function(selectedDate){
			$('input#checkinout_notice_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

});

</script>
<form:form id="checkInOutNoticeForm" modelAttribute="checkInOut" method="post" action="noticeSave.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode" value="${checkInOut.editMode}"/>
	<c:if test="${checkInOut.checkinout_notice_idx ne '0'}">
		<form:hidden path="checkinout_notice_idx"/>
	</c:if>

	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
				<th>설문조사 제목</th>
				<td><form:input path="checkinout_notice_name" cssClass="text" cssStyle="width:100%"/></td>
			</tr>
	        <tr>
	         	<th>공지 기간</th>
	         	<td><form:input path="checkinout_notice_start_date" cssClass="text ui-calendar"/> ~ <form:input path="checkinout_notice_end_date" cssClass="text ui-calendar"/></td>
	        </tr>
			<tr>
				<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" value="Y" label="사용" cssStyle="vertical-align: middle;"/>
					<form:radiobutton path="use_yn" value="N" label="사용안함" cssStyle="vertical-align: middle;"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
