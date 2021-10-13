<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : 'POST',
 						data : $('#courseInfoEdit').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								$('#dialog-2').dialog('destroy');
								$('#dialog-3').dialog('destroy');
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
					$('#courseInfoEdit').ajaxSubmit(option);
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

	$('#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800
	});

	$('#dialog-2').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

	// datepicker 시작일
	$('input#view_start_date').datepicker({
		maxDate: $('input#view_end_date').val(),
		onClose: function(selectedDate){
			$('input#view_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	// datepicker 종료일
	$('input#view_end_date').datepicker({
		minDate: $('input#view_start_date').val(),
		onClose: function(selectedDate){
			$('input#view_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
});

</script>

<form:form modelAttribute="courseInfo" id="courseInfoEdit" action="save.do">
<form:hidden path="editMode"/>
<form:hidden path="course_id"/>
<form:hidden path="homepage_id"/>

	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="40%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>과정명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="course_title" cssClass="text" maxlength="20"  cssStyle="width: 90%"/>
					<div class="ui-state-highlight">
						<em>※ 20자리까지 입력 가능</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>과정노출시작기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="view_start_date" cssClass="text ui-calendar" readonly="true"/>
					<span> ※ 다른 과정과 중복될 수 없습니다.</span>
				</td>
			</tr>
			<tr>
				<th>과정노출종료기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="view_end_date" cssClass="text ui-calendar" readonly="true"/>
					<span> ※ 다른 과정과 중복될 수 없습니다.</span>
				</td>
			</tr>
			<tr>
				<th>사용여부(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="use_yn" cssClass="selectmenu">
						<form:option value="Y">사용</form:option>
						<form:option value="N">미사용</form:option>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

