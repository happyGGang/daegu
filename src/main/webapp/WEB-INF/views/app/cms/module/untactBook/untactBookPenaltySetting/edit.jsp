<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script type="text/javascript">
/* function save(){
	if( doAjaxPost($('#untactBookPenaltySetting')) ){
		location.reload();
	}
} */
$(function(){
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					jQuery.ajaxSettings.traditional = true;
					$('td input:file').remove();
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#untactBookPenaltySettingForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#untactBookPenaltySettingForm').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
	width: 500,
	height: 360,
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

});

</script>
<form:form modelAttribute="untactBookPenaltySetting" id="untactBookPenaltySettingForm" action="save.do" method="POST" onsubmit="return false;">
	<form:hidden path="editMode" />
	<form:hidden path="homepage_id" />
	<form:hidden path="penalty_idx" />
	<table class="type2">
		<colgroup>
			<col width="160"/>
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>패널티기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					 <form:input path="start_date" class="text ui-calendar" readonly="true" /> ~ <form:input path="end_date" class="text ui-calendar" readonly="true" />
				</td>
			</tr>
			<tr>
				<th>패널티횟수 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="penalty_count" class="text" cssStyle="width:30px" maxlength="3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>회
					<div class="ui-state-highlight">
						<em>숫자만 입력가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>패널티일수 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="penalty_day" class="text" cssStyle="width:30px" maxlength="3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>일
					<div class="ui-state-highlight">
						<em>숫자만 입력가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>사용여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="use_yn" value="Y" /> <label for="use_yn1" style="cursor: pointer;">사용함</label>&nbsp; 
					<form:radiobutton path="use_yn" value="N" /> <label for="use_yn2" style="cursor: pointer;">사용안함</label>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>