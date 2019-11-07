<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-1.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					if ( doAjaxPost($('#schoolSupportForm')) ) {
						location.reload();
					}
				}
			<c:if test="${schoolSupport.editMode eq 'MODIFY'}">
			},{
				text: "삭제",
				"class": 'btn btn2',
				click: function() {
					if (confirm('삭제하시겠습니까? 삭제된 정보는 복구가 불가능합니다.')) {
						jQuery.ajaxSettings.traditional = true;
						$('form#schoolSupportForm input#editMode').val('DELETE');
						if ( doAjaxPost($('#schoolSupportForm')) ) {
							location.reload();
						}
					}
				}
			</c:if>
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('close');
				}
			}
			
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 400
	});
	
	$('input#first_start_date').datepicker({
		maxDate: $('input#first_end_date').val(), 
		onClose: function(selectedDate){
			$('input#first_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#first_end_date').datepicker({
		minDate: $('input#first_start_date').val(), 
		onClose: function(selectedDate){
			$('input#first_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#second_start_date').datepicker({
		maxDate: $('input#second_end_date').val(), 
		onClose: function(selectedDate){
			$('input#second_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#second_end_date').datepicker({
		minDate: $('input#second_start_date').val(), 
		onClose: function(selectedDate){
			$('input#second_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('select#area_code').select2({
		minimumResultsForSearch: Infinity
	});
	
});

</script>

<form:form id="schoolSupportForm" modelAttribute="schoolSupport" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="support_idx"/>			
	<form:hidden path="editMode"/>
										
	<table class="type2">
       	<tr>
       		<th>지역</th>
       		<td>
       			<label for="are_code" class="blind">지역선택</label>
       			<form:select path="area_code" class="selectmenu-search" cssStyle="width:100px;" >
       				<form:options items="${areaList}" itemLabel="code_name" itemValue="code_id"/>
       			</form:select>
       		</td>
       	</tr>
       	<tr>
       		<th>학교명</th>
       		<td>
       			<form:input path="school_name" cssClass="text" cssStyle="width:96%"/>
       		</td>
       	</tr>
       	<tr>
       		<th>1지원요청내용</th>
       		<td><form:input path="support_req_first" cssClass="text" cssStyle="width:96%"/></td>
       	</tr>
       	<tr>
       		<th>1지원희망 요청일</th>
       		<td class="left">
       			<form:input path="first_start_date" class="text ui-calendar"/> ~ <form:input path="first_end_date" class="text ui-calendar"/>
       		</td>
       	</tr>
       	<c:if test="${schoolSupport.editMode eq 'MODIFY'}">
       		<tr>
	       		<th>2지원요청내용</th>
	       		<td><form:input path="support_req_second" cssClass="text" cssStyle="width:96%"/></td>
	       	</tr>
	       	<tr>
	       		<th>2지원희망 요청일</th>
	       		<td class="left">
	       			<form:input path="second_start_date" class="text ui-calendar"/> ~ <form:input path="second_end_date" class="text ui-calendar"/>
	       		</td>
	       	</tr>
	       	<tr>
				<th>상태</th>
	       		<td>
	       			<form:select path="support_status" cssClass="selectmenu" cssStyle="width:150px">
		       			<form:option value="0" label="신청"/>
		       			<form:option value="1" label="1지망 확정"/>
		       			<form:option value="2" label="2지망 확정"/>
		       		</form:select>
	       		</td>
	       	</tr>
       	</c:if>
	</table>
</form:form>
