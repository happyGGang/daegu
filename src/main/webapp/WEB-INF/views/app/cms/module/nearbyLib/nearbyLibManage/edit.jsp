<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#nearbyLibManage_edit'))) {
						$(this).dialog('destroy');
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			},{
				text: "삭제",
				"class": 'btn btn1',
				"id": 'del_btn',
				click: function() {
					if ( confirm("정말 삭제 하시겠습니까?") ) {
						$('input#editMode').val('DELETE');
						if(doAjaxPost($('#nearbyLibManage_edit'))) {
							$(this).dialog('destroy');
							location.reload();
						}
					}
				}
			}
		]
	});

	if($('input#editMode').val() == 'ADD'){
		$('input#weekdayArr1').prop('checked', true);
		$('#del_btn').hide();
	} else {
		var oneStartDate = '${nearbyLibManage.start_date}';
		var oneStartTime = '${nearbyLibManage.start_time}';
		var oneEndDate = '${nearbyLibManage.end_date}';
		var oneEndTime = '${nearbyLibManage.end_time}';
		var twoStartDate = '${nearbyLibManage2.start_date}';
		var twoStartTime = '${nearbyLibManage2.start_time}';
		var twoEndDate = '${nearbyLibManage2.end_date}';
		var twoEndTime = '${nearbyLibManage2.end_time}';

		$('input#start_date').val(twoStartDate);
		$('input#start_time').val(twoStartTime);
		$('input#end_date').val(twoEndDate);
		$('input#end_time').val(twoEndTime);

		$('#del_btn').show();
	}

	$('input[name=individual_yn]').on('click', function() {
		var val = $(this).val();

		if (val == 'Y') {
			$('input#start_date').val(oneStartDate);
			$('input#start_time').val(oneStartTime);
			$('input#end_date').val(oneEndDate);
			$('input#end_time').val(oneEndTime);
		} else {
			$('input#start_date').val(twoStartDate);
			$('input#start_time').val(twoStartTime);
			$('input#end_date').val(twoEndDate);
			$('input#end_time').val(twoEndTime);
		}


	});


	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 660,
		height: 260
	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input[name=weekdayArr]').on('click', function() {

		var idx = $('input[name=weekdayArr]').index($(this));

		if (idx == 0) {
			if ($(this).is(':checked')) {
				$('input[name=weekdayArr]').slice(1).prop('checked', false);
				$('input[name=weekdayArr]').slice(1).prop('disabled', true);
			} else {
				$('input[name=weekdayArr]').slice(1).prop('checked', false);
				$('input[name=weekdayArr]').slice(1).prop('disabled', false);
			}
		} else {
			var checkedLength = $('input[name=weekdayArr]:not(#weekdayArr1):checked').length;
			if ($(this).is(':checked')) {

				if (checkedLength == 7) {
					$('input[name=weekdayArr]').eq(0).prop('checked', true);
					$('input[name=weekdayArr]').eq(0).prop('disabled', false);
					$('input[name=weekdayArr]').slice(1).prop('checked', false);
					$('input[name=weekdayArr]').slice(1).prop('disabled', true);
				} else if (checkedLength > 0) {
					$('input[name=weekdayArr]').eq(0).prop('checked', false);
					$('input[name=weekdayArr]').eq(0).prop('disabled', true);
				} else {
					$('input[name=weekdayArr]').eq(0).prop('checked', false);
					$('input[name=weekdayArr]').eq(0).prop('disabled', false);
				}

			} else {
				if (checkedLength > 0) {
					$('input[name=weekdayArr]').eq(0).prop('checked', false);
					$('input[name=weekdayArr]').eq(0).prop('disabled', true);
				} else {
					$('input[name=weekdayArr]').eq(0).prop('checked', false);
					$('input[name=weekdayArr]').eq(0).prop('disabled', false);
				}
			}
		}
	});


});
</script>
<form:form modelAttribute="nearbyLibManage" id="nearbyLibManage_edit" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(nearbyLibManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="cm_idx"/>
<form:hidden path="group_idx"/>
<form:hidden path="date_type" value="1"/>
<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<c:if test="${nearbyLibManage.editMode ne 'ADD'}">
		<tr>
			<th>선택일자</th>
			<td>
				${nearbyLibManage.start_date}
			</td>
		</tr>
		</c:if>
		<tr>
			<th>예약불가 일정 일자</th>
			<td>
				<form:input type="text" id="start_date" path="start_date" class="text ui-calendar"/>
				<form:input path="start_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<span id="tilde" style="font-size:12px">~</span>
				<form:input type="text" id="end_date" path="end_date" class="text ui-calendar"/>
				<form:input path="end_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<div class="ui-state-highlight" id="weekDayDiv">
					매주 &nbsp;&nbsp;
					<form:checkboxes items="${weekdayList}" path="weekdayArr" itemLabel="code_name" itemValue="code_id" cssStyle="margin-left:5px;" />
				</div>
				<div class="ui-state-highlight">
					<em>* 시간 입력 ex) 10:30</em>
				</div>
			</td>
		</tr>
		<c:if test="${nearbyLibManage.group_count > 1}">
		<tr>
			<th>일괄수정</th>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="전체 반복일정 수정"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="선택한 일정만 수정"/>
				<c:if test="${nearbyLibManage.individual_yn ne 'Y'}">
				<form:radiobutton path="individual_yn" value="E" label="개별수정된 일정 제외 전체수정"/>
				<div class="ui-state-highlight">
					<em>* 개별수정된 일정 제외 전체수정 : 개별로 수정된 일정을 제외한 나머지 반복일정을 수정합니다.</em>
				</div>
				</c:if>
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
</form:form>