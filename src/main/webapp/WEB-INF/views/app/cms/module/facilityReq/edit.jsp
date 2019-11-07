<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					
					$('#facility_idx').val($('#facility_idx_1').val());
					if($('#phone1').val() != "" && $('#phone2').val() != "" && $('#phone3').val() != "") {
						$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());	
					}
					if($('#cell_phone1').val() != "" && $('#cell_phone2').val() != "" && $('#cell_phone3').val() != "") {
						$('#cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());	
					}

					
					if ( $('#editMode').val() == 'ADD' ) {
						if($('#facility_idx').val() == 0) {
							alert('시설물을 선택하세요.');
							return;
						}	
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
					
					if ( doAjaxPost($('#facilityReqForm')) ) {
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
		width: 550,
		height: 600
	});
 
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('#start_time').focus();
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('#start_time').focus();
		}
	});
	
	$('select#facility_idx_1').on('change', function(e) {
		if($(this).val() != '') {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&facility_idx=' + $(this).val() , function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}
		
		e.preventDefault();
	});
	
	$('a.idCheck').on('click', function(e) {
		$('#facilityReqForm #req_name').val("");
		$.get('/cms/module/facilityReq/checkId.do?homepage_id=' + $('#homepage_id').val() + '&apply_id='+ $('#apply_id').val() + '&search_api_type=' + $('[name="search_api_type"]:checked').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);	
			}
			else {
				$('#facilityReqForm #member_key').val(response.memberInfo.SEQ_NO);
				$('#facilityReqForm #req_name').val(response.memberInfo.USER_NAME);
			}
		});
		e.preventDefault();
	});
	
	
	//휴관일 disable	
// 	var closed_date = '${closed_date}';
	
// 	var arrDisabledDates = {};
//     arrDisabledDates[new Date('[2016/12/30, 2016/12/30]')] = new Date('[2016/12/30, 2016/12/30]');
	
	if($("#facilityReqForm > input[id='editMode']").val() == 'ADD') {
		
		$('#start_date').val('${facility.start_date}');
		$('#end_date').val('${facility.end_date}');
		$('#start_time').val('${facility.start_time}');
		$('#end_time').val('${facility.end_time}');
		
		$('input#start_date').datepicker("option", "minDate", $("#start_date").val());
		$('input#start_date').datepicker("option", "maxDate", $("#end_date").val());
		$("input#end_date").datepicker( "option", "minDate", $("#start_date").val() );
		$("input#end_date").datepicker( "option", "maxDate", $("#end_date").val() );
		
	} else if($("#facilityReqForm > input[id='editMode']").val() == 'MODIFY') {
		
		$('input#start_date').datepicker("option", "minDate", '${facility.start_date}');
		$('input#start_date').datepicker("option", "maxDate", '${facility.end_date}');
		$("input#end_date").datepicker( "option", "minDate", '${facility.start_date}');
		$("input#end_date").datepicker( "option", "maxDate", '${facility.end_date}');
	}
	
	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});

</script>
<form:form id="facilityReqForm" modelAttribute="facilityReq" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>									
	<form:hidden path="req_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="facility_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>       		
       		<tr>
	         	<th>시설물명</th>
	         	<td>        		
	         		<c:if test="${facilityReq.editMode eq 'ADD'}">		
	         		<form:select class="selectmenu-search" style="width:200px" id="facility_idx_1" path="facility_idx">
						<option value="">시설물을 선택하세요.</option>
						<c:forEach var="i" varStatus="status" items="${facilityList}">
							<option value="${i.facility_idx}" <c:if test="${i.facility_idx eq facilityReq.facility_idx }">selected="selected"</c:if>>${i.facility_name}</option>
						</c:forEach>
					</form:select>
					</c:if>
					<c:if test="${facilityReq.editMode eq 'MODIFY'}">
			        	${facilityReq.facility_name}
			        </c:if>
	         	</td>
	        </tr>       		
	        <tr>
	         	<th>신청자ID</th>			
	         	<td>
	         		<c:choose>
	         			<c:when test="${facilityReq.editMode eq 'ADD' }">
	         				<form:input path="apply_id" class="text" /> <form:radiobutton path="search_api_type" value="WEBID" label="웹ID"/> <form:radiobutton path="search_api_type" value="USERID" label="대출번호"/> <a class="btn btn1 idCheck">ID 확인</a>	
	         			</c:when>
	         			<c:otherwise>
	         				${facilityReq.apply_id}
	         			</c:otherwise>
	         		</c:choose>
        		</td>
	       	</tr>
	        <tr>
	         	<th>신청자명</th>
	         	<td><form:input path="req_name" class="text" readonly="true"/></td>
	        </tr>
	        <tr>
	         	<th>전화번호</th>
	         	<td>
	         		<form:hidden path="phone"/>
					<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberonly="true"/>
				 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>	
				</td>
	        </tr>
	        <tr>
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="cell_phone"/>
					<form:input path="cell_phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberonly="true"/>
				 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				</td>
			</tr>
			<tr>
				<th>사용목적</th>
				<td>
					<form:textarea path="purpose" class="text" cssStyle="width:100%; height:100px;"/>
				</td>
			</tr>
			<tr>
				<th>방문자 수</th>
				<td>
					<form:input path="visits" class="text" cssStyle="width:60px;" maxlength="2" numberonly="true"/>
				</td>
			</tr>			
			<tr>
				<th>이용일</th>
				<td>
					<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
				</td>
			</tr>
			<tr>
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
