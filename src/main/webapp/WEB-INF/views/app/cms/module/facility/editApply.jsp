<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					if($('#apply_phone1').val() != "" && $('#apply_phone2').val() != "" && $('#apply_phone3').val() != "") {
						$('#apply_phone').val($('#apply_phone1').val()+'-'+$('#apply_phone2').val()+'-'+$('#apply_phone3').val());	
					}
					var equipmentList='';
					$('input:checkbox[name=checkList]').each(function (index) {
						if($(this).is(":checked")==true){
							equipmentList += $(this).attr('id')+":"+$(this).next().next().val()+","
						}

					});

					if (equipmentList.length > 0){
						$('#equipment').val(equipmentList.slice(0,-1));
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 550,
		height: 450
	});
 
	$('a.idCheck').on('click', function(e) {
		if($('#facilityReqForm #apply_id').val() == '') {
			alert('신청자ID를 입력하세요');
			$('#facilityReqForm #apply_id').focus();
			return false;
		}
		
		$('#facilityReqForm #apply_name').val("");
		$.get('checkId.do?homepage_id=' + $('#homepage_id').val() + '&apply_id='+ $('#apply_id').val() + '&search_api_type=' + $('#search_api_type').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);	
			} else {
				$('#facilityReqForm #apply_name').val(response.memberInfo[0].NAME);
				var phone = response.memberInfo[0].HANDPHONE.split('-');
				$('#facilityReqForm #apply_phone1').val(phone[0]);
				$('#facilityReqForm #apply_phone2').val(phone[1]);
				$('#facilityReqForm #apply_phone3').val(phone[2]);
			}
		});
		e.preventDefault();
	});
	
	
	//휴관일 disable	
// 	var closed_date = '${closed_date}';
	
// 	var arrDisabledDates = {};
//     arrDisabledDates[new Date('[2016/12/30, 2016/12/30]')] = new Date('[2016/12/30, 2016/12/30]');
	
	
	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

	$('input:checkbox[name=checkList]').on('click',function(){
		if ($(this).is(':checked')){
			$(this).next().next().removeAttr('disabled');
		} else {
			$(this).next().next().attr('disabled','disabled');
			$(this).next().next().val('');
		}
	});
	$('.numberText').change(function(){
		if (parseInt($(this).val()) > parseInt($(this).next().text())) {
			alert("개수가 초과되었습니다.");
			$(this).val('');
			return false;
		}
	});

	if ($('#equipment').val()){
		let value = $('#equipment').val();
		let valueArray = value.split(",");
		for (var i=0;i<valueArray.length;i++){
			let imsi = valueArray[i].split(":");
			$('input:checkbox[name=checkList]').each(function (index) {
				if ($(this).attr('id') == imsi[0]){
					$(this).prop('checked',true);
					$(this).next().next().val(imsi[1]);
				}
			});
		}
	}

});

</script>
<form:form id="facilityReqForm" modelAttribute="facilityReq" method="post" action="saveApply.do" >
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="facility_req_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="equipment"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>       		
       		<tr>
	         	<th>시설물명</th>
	         	<td>${facility.facility_name}</td>
	        </tr>   
	        <tr>
	         	<th>이용일</th>
	         	<td>${facility.use_date}</td>
	        </tr>       		
	        <tr>
	         	<th>신청자ID (<span style="color: red; font-weight: bold;">*</span>)</th>			
	         	<td>
	         		<c:choose>
	         			<c:when test="${facilityReq.editMode eq 'ADD' }">
	         				<form:hidden path="search_api_type" value="WEBID"/>
	         				<form:input path="apply_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>
	         			</c:when>
	         			<c:otherwise>
	         				${facilityReq.apply_id}
	         			</c:otherwise>
	         		</c:choose>
        		</td>
	       	</tr>
	        <tr>
	         	<th>신청자명 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${facilityReq.editMode eq 'ADD'}">
	         				<form:input path="apply_name" class="text" readonly="true"/>	
	         			</c:when>
	         			<c:otherwise>
	         				${facilityReq.apply_name}
	         			</c:otherwise>
	         		</c:choose>
	         		
         		</td>
	        </tr>
	        <tr>
				<th>휴대전화번호 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="apply_phone"/>
					<form:input path="apply_phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberonly="true"/>
				 	- <form:input path="apply_phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				 	- <form:input path="apply_phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberonly="true"/>
				</td>
			</tr>
			<tr>
				<th>사용목적 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:textarea path="apply_desc" class="text" cssStyle="width:100%; height:100px;"/>
				</td>
			</tr>
			<tr>
				<th>개인정보 동의 여부</th>
				<td>
					<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 100px">
						<form:option value="Y" label="동의"/>
						<form:option value="N" label="미동의"/>
					</form:select>
				</td>
			</tr>
			<c:if test="${facility.date_type eq '0001'}">
			<tr class="equipment">
				<th>장비 대여</th>
				<td>
					<c:forEach var="i" items="${facilityEquipmentList}" varStatus="status">
						<input name="checkList" type="checkbox" id="${i.equipment_idx}"/><label for="${i.equipment_idx}">${i.equipment_name}</label> 수량 : <input type="text" class="text numberText" style="width:40px;" maxlength="3" numberonly="true" disabled> / <span>${i.equipment_cnt}</span><br/>
					</c:forEach>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>
</form:form>
