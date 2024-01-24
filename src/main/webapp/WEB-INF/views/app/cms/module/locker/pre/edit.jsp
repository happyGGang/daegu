<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function() {
	$('#dialog-3.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('#dialog-3.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('#dialog-3.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {					
					jQuery.ajaxSettings.traditional = true;
					
					var tmpImageTag = $('#lockerPreEdit td.imageFile input');
					if ( $('#lockerPreEdit td.imageFile input').val() == '' ) {
						$('#lockerPreEdit td.imageFile input').remove();
					}
					
					var option = {
						url : '/cms/module/locker/pre/save.do',
						type : 'POST',
						data : $('#lockerPreEdit').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-2').load('/cms/module/locker/pre/index.do?homepage_id=' + $('#homepage_id').val());
								$('#dialog-3').dialog('destroy');
							} else {
								$('#lockerPreEdit td.imageFile').append(tmpImageTag);
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
				        	 $('#lockerPreEdit td.imageFile').append(tmpImageTag);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#lockerPreEdit').ajaxSubmit(option);
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
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 750,
		height: 550
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
	
	$('input#assign_start_date').datepicker({
		maxDate: $('input#assign_end_date').val(), 
		onClose: function(selectedDate){
			$('input#assign_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#assign_end_date').datepicker({
		minDate: $('input#assign_start_date').val(), 
		onClose: function(selectedDate){
			$('input#assign_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#apply_start_date').datepicker({
		maxDate: $('input#apply_end_date').val(), 
		onClose: function(selectedDate){
			$('input#apply_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#apply_end_date').datepicker({
		minDate: $('input#apply_start_date').val(), 
		onClose: function(selectedDate){
			$('input#apply_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a.delete-file-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 파일을 정말 삭제 하시겠습니까? 실제 파일이 지워집니다.') ) {
			$('#lockerPreEdit #editMode').val('DELETE-FILE');
			if ( doAjaxPost($('#lockerPreEdit')) ) {
				
			}	
		}
	});
	
});

</script>
<form:form id="lockerPreEdit" modelAttribute="lockerPre" method="post" action="/cms/module/locker/pre/save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="locker_pre_idx"/>
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>	        
	        <tr>
	         	<th>구분명</th>
	         	<td>
	         		<form:input path="locker_pre_name" class="text" />
	         		<div class="ui-state-highlight">
						* 사물함 배치도 이미지 안에 들어갈 이름 입니다. ex) 사물함
					</div>
	         	</td>
	        </tr>
	        <tr>
	        	<th>배정방법</th>
	        	<td>
	        		<form:radiobutton path="locker_pre_type" value="SELECT" label="선택배정"/>
	        		<form:radiobutton path="locker_pre_type" value="FIFO" label="순차배정"/>
	        		<form:radiobutton path="locker_pre_type" value="RANDOM" label="랜덤배정"/>
	        		<form:radiobutton path="locker_pre_type" value="LOTTERY" label="추첨배정"/>
					<div class="ui-state-highlight">
						* 선택 배정 : 사용자가 선택하여 신청하고 해당 사물함 즉시 배정 됩니다.
					</div>
					<div class="ui-state-highlight">
						* 순차 배정 : 사물함 순차, 신청자 순차 방식으로 배정 됩니다.
					</div>
					<div class="ui-state-highlight">
						* 랜덤 배정 : 사물함 랜덤, 신청자 랜덤 방식으로 배정 됩니다.
					</div>
					<div class="ui-state-highlight">
						* 추첨 배정 : 사물함 랜덤, 사물함 수 만큼의 선착순 인원에 대하여 랜덤 방식으로 배정 됩니다.
					</div>
	        	</td>
	        </tr>
	        <tr>
	         	<th>신청접수 기간</th>
	         	<td>
	         		<form:input path="apply_start_date" class="text ui-calendar"/> <form:input path="apply_start_time" class="text" style="width:50px;" maxlength="5"/> 
	         		~ <form:input path="apply_end_date" class="text ui-calendar"/> <form:input path="apply_end_time" class="text" style="width:50px;" maxlength="5"/>
	         		<div class="ui-state-highlight">
						* 시간 입력 ex) 10:30
					</div>
	         	</td>
	        </tr>
	        <tr>
	         	<th>신청대기인원</th>
	         	<td>
	         		<form:input path="apply_backup_count" class="text" cssStyle="width:30px" maxlength="5"/>
	         		<div class="ui-state-highlight">
						* 신청인원수는 사물함 개수 + 신청대기인원 입니다.
					</div>
	         	</td>
	        </tr>
	        <tr>
	         	<th>배정기간</th>
	         	<td>
	         		<form:input path="assign_start_date" class="text ui-calendar"/> ~ <form:input path="assign_end_date" class="text ui-calendar"/>
         		</td>
	        </tr>
	        <tr>
	         	<th>사용기간</th>
	         	<td>
	         		<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
         		</td>
	        </tr>
	        <tr>
	         	<th>사물함 개수</th>	         	
	         	<td>
	         		<c:if test="${lockerPre.editMode eq 'MODIFY' }">
	         			<form:input path="locker_count" class="text" readonly="true"/>
	         		</c:if>
	         		<c:if test="${lockerPre.editMode ne 'MODIFY' }">
		         		<form:input path="locker_count" class="text" />
	         		</c:if>
	         	</td>
	        </tr>
	        <tr>
	         	<th>이미지 파일</th>	         	
	         	<td class="imageFile">
         			<input type="file" id="image_file" name="image_file" class="text" />
	         	</td>
	        </tr>	       
	        <tr>
	        	<th>현재 이미지</th>
	        	<td>
		        	<c:if test="${lockerPre.real_file_name ne null and lockerPre.real_file_name ne ''}">
		        		${lockerPre.image_file_name}.${lockerPre.image_file_extension} <a href="" class="btn btn1 delete-file-btn"> 파일 삭제</a>
		        		<img alt="${lockerPre.image_file_name}" src="/data/lockerPre/${lockerPre.homepage_id}/${lockerPre.real_file_name}"/>
		        	</c:if>
        		</td>
	        </tr>
		</tbody>
	</table>
</form:form>
