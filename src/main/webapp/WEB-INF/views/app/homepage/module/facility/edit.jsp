<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function() {
		
		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

		if($('#apply_phone1').val() != "") {
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

		doAjaxPost($('#facilityReqForm'));
	});

	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/facility/index.do';
		var formData = serializeParameter(['menu_idx']);
		doGetLoad(url, formData);
	});

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



<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="terms${status.count}" name="agree_codes" type="checkbox" keyValue="${terms.title}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의</label><br>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>

<form:form id="facilityReqForm" modelAttribute="facilityReq" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="facility_req_idx"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="apply_id" value="${facilityReq.apply_id}"/>
	<form:hidden path="member_key"/>
	<form:hidden path="equipment"/>

	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<table class="type1">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>시설물명</th>
	         	<td>${facility.facility_name}</td>
	        </tr>
	        <tr>
	         	<th>이용일</th>
	         	<td>${facility.use_date} ${facility.start_time}~${facility.end_time}</td>
	        </tr>
	        <tr>
	         	<th>신청자명 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
        			<form:input path="apply_name" class="text" readonly="true" value="${member.member_name }"/>
         		</td>
	        </tr>
	        <tr>
				<th>휴대전화번호 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="apply_phone"/>
					<form:input path="apply_phone1" class="text" cssStyle="width:40px;" maxlength="3" numberonly="true" value="${member.cell_phone1}"/>
				 	- <form:input path="apply_phone2" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true" value="${member.cell_phone2}"/>
				 	- <form:input path="apply_phone3" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true" value="${member.cell_phone3}"/>
				</td>
			</tr>
			<tr>
				<th>사용목적 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:textarea path="apply_desc" class="text" cssStyle="width:100%; height:100px;"/>
				</td>
			</tr>
			<c:if test="${facility.date_type eq '0002'}">
			<tr>
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
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
