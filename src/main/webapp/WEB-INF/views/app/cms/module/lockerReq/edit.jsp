<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
	        $(this).dialog('destroy');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					$('#lockerReqEdit #phone').val($('#lockerReqEdit #phone_1').val()+''+$('#lockerReqEdit #phone_2').val()+''+$('#lockerReqEdit #phone_3').val());
					$('#lockerReqEdit #cell_phone').val($('#lockerReqEdit #cell_phone_1').val()+''+$('#lockerReqEdit #cell_phone_2').val()+''+$('#lockerReqEdit #cell_phone_3').val());
					if ( doAjaxPost($('#lockerReqEdit')) ) {
						$('#dialog-2').load('indexApply.do?homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $('#locker_pre_idx').val(), function( response, status, xhr ) {
							$('#dialog-2').dialog('open');
						});
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
		height: 300
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
	
	$('a.idCheck').on('click', function(e) {
		$('#lockerReqEdit #req_name').val("");
		
		$.get('/cms/module/lockerReq/checkId.do?homepage_id=' + $('#homepage_id').val() + '&apply_id='+ $('#lockerReqEdit #apply_id').val() + '&search_api_type=' + $('[name="search_api_type"]:checked').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);	
			}
			else {
				$('#lockerReqEdit #member_key').val(response.memberInfo.SEQ_NO);
				$('#lockerReqEdit #req_name').val(response.memberInfo.USER_NAME);
			}
		});
		e.preventDefault();
	});
	
});

</script>
<form:form id="lockerReqEdit" modelAttribute="lockerReq" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="req_idx"/>
	<form:hidden path="locker_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="editMode"/>	
	<form:hidden path="locker_pre_idx"/>								
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>	 
	        <tr>
	         	<th>신청자ID</th>			
	         	<td>
	         		<c:choose>
	         			<c:when test="${lockerReq.editMode eq 'ADD' }">
	         				<form:input path="apply_id" class="text" /> <form:radiobutton path="search_api_type" value="WEBID" label="웹ID"/> <form:radiobutton path="search_api_type" value="USERID" label="대출번호"/> <a class="btn btn1 idCheck">ID 확인</a>	
	         			</c:when>
	         			<c:otherwise>
	         				<form:hidden path="apply_id" class="text" />	         				
	         				${lockerReq.apply_id}
	         			</c:otherwise>
	         		</c:choose>
        		</td>
	       	</tr>
	        <tr>
	         	<th>신청자명</th>
	         	<td><form:input path="req_name" class="text" cssStyle="width:30%" readonly="true"/></td>
	        </tr>	        
	        <tr>
	         	<th>전화번호</th>
	         	<td>
	         		<form:hidden path="phone"/>
					<input id="phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
					<input id="phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
					<input id="phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
	         	</td>
	         	
	        </tr>
	        <tr>
	         	<th>휴대전화번호</th>
	         	<td>
	         		<form:hidden path="cell_phone"/>
					<input id="cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
					<input id="cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
					<input id="cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
	         	</td>
	        </tr>	         
		</tbody>
	</table>
</form:form>
