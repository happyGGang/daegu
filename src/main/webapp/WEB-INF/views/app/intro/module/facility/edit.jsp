<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {

	if($("#facilityReqForm > input[id='editMode']").val() == 'ADD') {
		$('#start_date').val('${facility.start_date}');
		$('#end_date').val('${facility.end_date}');
		$('#start_time').val('${facility.start_time}');
		$('#end_time').val('${facility.end_time}');	
	}
	 
	$('input#start_date').datepicker({
		minDate: $('input#start_date').val(),
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
		}
	});
	
	$('#save-btn').on('click', function() {
		if($('#phone1').val() != "") {
			$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());	
		}
		if($('#cell_phone1').val() != "") {
			$('#cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());	
		}			
		var start_date = $('#start_date').val().replace(/-/gi,"");					
		var end_date = $('#end_date').val().replace(/-/gi,"");
		var start_time = $('#start_time').val().replace(":","");
		var end_time = $('#end_time').val().replace(":",""); 
		
		if(start_date > end_date) {
			alert('이용 종료일이 시작일 보다 작을 수 없습니다.');
			return;
		}
		
		if(start_time > end_time || start_time == end_time) {
			alert('이용 종료시간이 시작시간과 같거나 작습니다.');
			return;
		}
		doAjaxPost($('#facilityReqForm'));
	});
	
	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/facility/index.do';
		var formData = serializeParameter(['menu_idx']);
		doGetLoad(url, formData);
	});
	
	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});

</script>
<form:form id="facilityReqForm" modelAttribute="facilityReq" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>									
	<form:hidden path="req_idx"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="apply_id" value="${facilityReq.apply_id}"/>
	<table class="type1">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr style="height:50px;">
	         	<th>시설물명</th>
	         	<form:hidden path="facility_name" value="${facility.facility_name}"/>
	         	<td>${facility.facility_name}</td>
	        </tr>       			        
	        <tr style="height:50px;">
	         	<th>신청자명</th>
	         	<td><form:input path="req_name" class="text" readonly="true" value="${member.member_name}"/></td>
	        </tr>	         	
	        <tr style="height:50px;">
	         	<th>전화번호</th>
	         	<td>
	         		<form:hidden path="phone"/>
					<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberonly="true"/>
				 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>	
				</td>
	        </tr>
	        <tr style="height:50px;">
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="cell_phone"/>
					<form:input path="cell_phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberonly="true"/>
				 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				</td>
			</tr>
			<tr style="height:50px;">
				<th>사용목적</th>
				<td>
					<form:textarea path="purpose" class="text" cssStyle="width:100%; height:100px;"/>
				</td>
			</tr>
			<tr style="height:50px;">
				<th>방문자 수</th>
				<td>
					<form:input path="visits" class="text" cssStyle="width:60px;" maxlength="2" numberonly="true"/>
				</td>
			</tr>			
			<tr style="height:50px;">
				<th>이용일</th>
				<td>
					<form:input path="start_date" class="text ui-calendar" style="width:150px"/> ~ <form:input path="end_date" class="text ui-calendar" style="width:150px"/>
				</td>
			</tr>
			<tr style="height:50px;">
				<th>이용시간</th>
				<td>
					<form:input path="start_time" class="text" style="width:50px;"/> ~ <form:input path="end_time" class="text" style="width:50px;"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<br/>
<div align="center">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
