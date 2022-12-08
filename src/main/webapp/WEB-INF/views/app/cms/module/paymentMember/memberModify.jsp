<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});

$(function(){
	$('input#birth').datepicker({
		dateFormat:'yy-mm-dd',
		yearRange: 'c-70:c',
		maxDate:0
	});
	
	$('input#join_start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#join_end_date').val(), 
		onClose: function(selectedDate){
			$('input#join_end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${paymentMember.join_start_date}');
	$('input#join_end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#join_start_date').val(), 
		onClose: function(selectedDate){
			$('input#join_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${paymentMember.join_end_date}');
	
	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
	});
	
	$('.ui-calendar').each(function(){
		$(this).datepicker({
			dateFormat:'yy-mm-dd',
			yearRange: 'c-70:c',
			maxDate:0
		});
	});
});

function loadFamilyForm() {
	var familyCount = $('#family_count').val();
	
	if(familyCount == '0'){
		alert('가족구성원수를 입력하지 않으셨습니다.');
	} else {
		var ajaxData = {
			'family_count' : familyCount
		};
		
		$.ajax({
			type: "POST",
			url: 'modify.do?family_count='+familyCount+'&pay_member_idx=1',
			data: ajaxData,
			success: function(response) {
 				doGetLoad('modify.do?pay_member_idx=1', $('form#paymentMemberModify').serialize());
			},
			error : function() {
				alert('회원정보 삭제에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
}

function savePaymentMember() {
	const count = $('#family_count').val();
	const countNum = Number(count);
	const formData = {};
	formData.pay_member_idx = $("#pay_member_idx").val();
	formData.pay_family_member_idx = $("#pay_family_member_idx").val();
	formData.pay_member_name = $("#pay_member_name").val();
	formData.phone1 = $("#phone1").val();
	formData.phone2 = $("#phone2").val();
	formData.phone3 = $("#phone3").val();
	formData.tel1 = $("#tel1").val();
	formData.tel2 = $("#tel2").val();
	formData.tel3 = $("#tel3").val();
	formData.loan_number = $("#loan_number").val();
	formData.birth = $("#birth").val();
	formData.join_start_date = $("#join_start_date").val();
	formData.join_end_date = $("#join_end_date").val();
	formData.use_type = $("#use_type").val();
	formData.sex = $("input[name=sex]:checked").val();
	formData.sponsorship_amount = $("#sponsorship_amount").val();
	formData.etc = $("#etc").val();
	formData.email1 = $("#email1").val();
	formData.email2 = $("#email2").val();
	formData.family_count = $("#family_count").val();
	if(countNum > 0){
		
		var aJsonArray = new Array();
		
		for (let i = 1; i < countNum+1; i++) {
			var obj = {};
	        obj.family_name = $("#family_name_"+i).val();
	        obj.family_sex = $("#family_sex_"+i).val();
	        obj.family_phone1 = $("#family_phone1_"+i).val();
	        obj.family_phone2 = $("#family_phone2_"+i).val();
	        obj.family_phone3 = $("#family_phone3_"+i).val();
 	        obj.family_birth = $("#family_birth_"+i).val();
 	        obj.family_etc = $("#family_etc_"+i).val();
	        
	        aJsonArray.push(obj);
	    }
		
		formData.paymentFamilyMemberList = aJsonArray;
		var sJson = JSON.stringify(formData);
		
		$.ajax({
    		type: "POST",
			url: 'memberModifySave.do',
            dataType: "json",
            data: sJson,
            contentType:'application/json; charset=UTF-8',
            success: function(response) {
            	alert('수정되었습니다.');
            	location.reload();
			},
			error : function() {
				alert('실패했습니다.\n관리자에게 문의해 주세요.');
			}
        });
	} else {
		if(confirm('가족구성원 정보가 등록되지 않았습니다. 계속 진행하시겠습니까?')) {
			var aJsonArray = new Array();
			formData.paymentFamilyMemberList = aJsonArray;
			var sJson = JSON.stringify(formData);
			$.ajax({
				type: "POST",
				url: 'memberModifySave.do',
	            dataType: "json",
	            data: sJson,
	            contentType:'application/json; charset=UTF-8',
				success: function(response) {
					alert('수정되었습니다.');
					location.reload();
				},
				error : function() {
					alert('실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		}
	}
}
</script>

<form:form id="paymentMemberModify" modelAttribute="paymentMember" method="POST">
<form:hidden id="homepage_id" path="homepage_id"/>
<form:hidden id="pay_member_idx" path="pay_member_idx"/>

<table class="type3">
	<colgroup>
		<col width="160" />
		<col width="*"/>
	</colgroup>
	<thead>
	<tr>
		<th colspan="2">신청인</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<th>이름 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="pay_member_name" class="text" disabled="true"/></td>
	</tr>
	<tr>
		<th>대출번호</th>
		<td><form:input path="loan_number" class="text" numberonly="true"/></td>
	</tr>
	<tr>
		<th>본인 연락처 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:input path="phone1" cssStyle="width:40px;" cssClass="text" maxlength="3" numberonly="true"/> -
            <form:input path="phone2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
            <form:input path="phone3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
			<div class="ui-state-highlight">
				<em>* ex) 010-1234-5678</em>
			</div>
		</td>
	</tr>
	<tr>
		<th>집 전화</th>
		<td>
			<form:input path="tel1" cssStyle="width:40px;" cssClass="text" maxlength="3" numberonly="true"/> -
            <form:input path="tel2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
            <form:input path="tel3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
		</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>
			<form:input path="email1" class="text new_text01" title="이메일 아이디 입력" /> @
			<form:input path="email2" class="text new_text01" title="이메일주소 입력" />
			<select id="email2_temp" name="email2_temp" class="selectmenu new_select_box" title="이메일 주소 선택">
				<option value="" >--직접입력--</option>
				<option value="naver.com" >naver.com</option>
				<option value="daum.net" >daum.net</option>
				<option value="gmail.com" >gmail.com</option>
				<option value="korea.kr" >korea.kr</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>출생연도 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="birth" class="text ui-calendar" disabled="true"/></td>
	</tr>
	<tr>
		<th>기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="join_start_date" class="text ui-calendar" readonly="true"/> ~ <form:input path="join_end_date" class="text ui-calendar" readonly="true"/></td>
	</tr>
	<tr>
		<th>성별 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:radiobutton path="sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;" disabled="true"/>
       		<form:radiobutton path="sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;" disabled="true"/>
		</td>
	</tr>
	<tr>
		<th>이용구분 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:input path="use_type" class="text"/>
			<div class="ui-state-highlight">
				<em>* ex) 열람, 대출, 후원</em>
			</div>
		</td>
	</tr>
	<tr>
		<th>금액 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="sponsorship_amount" class="text" numberonly="true"/>원</td>
	</tr>
	<tr>
		<th>비고</th>
		<td><form:textarea path="etc" class="text" cssStyle="width:100%;" rows="3"/></td>
	</tr>
	<tr>
		<th>가족구성원수</th>
		<td>
			<form:input path="family_count" disabled="true" cssStyle="width:20px;" cssClass="text" numberonly="true"/>명
		</td>
	</tr>
	</tbody>
</table>
<!-- 유료회원 가족 정보 수정 폼 -->
<br/>
<table class="type3 familyForm">
	<colgroup>
		<col width="160" />
		<col width="100"/>
		<col width="250"/>
		<col width="100"/>
		<col width="*"/>
	</colgroup>
	<thead>
	<tr>
		<th colspan="6">가족</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<th>이름 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th>성별 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th>연락처 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th>생년월일 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th>기타</th>
	</tr>
	<c:forEach var="i" items="${familyMemberList}" varStatus="status">
		<form:hidden id="pay_family_member_idx_${status.count}" path="pay_family_member_idx" value="${i.pay_family_member_idx}"/>
		<tr>
			<td><form:input path="family_name" disabled="true" id="family_name_${status.count}" class="text" value="${i.family_name}"/></td>
			<td>
				<input type="radio" disabled="disabled" id="family_sex_${status.count}" name="family_sex_${status.count}" value="M" label="남" cssClass="M"<c:if test="${i.family_sex eq 'M'}">checked</c:if>/>남
				<input type="radio" disabled="disabled" id="family_sex_${status.count}" name="family_sex_${status.count}" value="F" label="여" cssClass="F"<c:if test="${i.family_sex eq 'F'}">checked</c:if>/>여
	       	</td>
			<td>
				<form:input path="family_phone1" id="family_phone1_${status.count}" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${i.family_phone1}"/> -
				<form:input path="family_phone2" id="family_phone2_${status.count}" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${i.family_phone2}"/> -
				<form:input path="family_phone3" id="family_phone3_${status.count}" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${i.family_phone3}"/>
			</td>
			<td><form:input path="family_birth" disabled="true" id="family_birth_${status.count}" class="text ui-calendar" readonly="true" value="${i.family_birth}"/></td>
			<td><form:textarea path="family_etc" id="family_etc_${status.count}" class="text" cssStyle="width:100%;"/></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</form:form>