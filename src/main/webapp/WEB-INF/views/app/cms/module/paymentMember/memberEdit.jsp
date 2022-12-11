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

function paymentMemberSave(editMode) {
	var familyList = new Array();

	$('#editMode').val(editMode);

	$('tr[id^="family_tr_"]').each(function(index, item){
		var family_name = $(this).find('td .family_name').val();
		var family_sex = $(this).find('td .family_sex:checked').val();
		var family_phone = $(this).find('td .family_phone').val();
		var family_birth = $(this).find('td .family_birth').val();
		var family_etc = $(this).find('td .family_etc').val();

		if (!isEmpty(family_name) || !isEmpty(family_sex)  || !isEmpty(family_phone) || !isEmpty(family_birth)) {
			var familyData = new Object() ;
			familyData.family_name = family_name;
			familyData.family_sex = isEmpty(family_sex)  ? '' : family_sex;
			familyData.family_phone = family_phone;
			familyData.family_birth = family_birth;
			familyData.family_etc = family_etc;

			familyList.push(familyData);
		}
	});

	$('#familyData').val(JSON.stringify(familyList));

	if(doAjaxPost($('#paymentMemberEdit'))) {
		location.reload();
	} else {
		console.log('test');
	}
}

function isEmpty(value){
	if(typeof value == "undefined" || value == null || value == "") {
		return true;
	} else {
		return false ;
	}
};
</script>

<form:form id="paymentMemberEdit" modelAttribute="paymentMember" method="POST" action="save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="familyData"/>
<form:hidden path="pay_member_idx"/>
<form:hidden path="editMode"/>


<table class="type3">
	<thead>
	<tr>
		<th colspan="2">신청인</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<th style="width:15%;">이름 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="pay_member_name" class="text"/></td>
	</tr>
	<tr>
		<th>대출번호</th>
		<td><form:input path="loan_number" class="text"/></td>
	</tr>
	<tr>
		<th>본인 연락처 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:input path="phone" placeholder="ex) 010-1234-5678" cssClass="text"/>
			<div class="ui-state-highlight">
				<em>* ex) 010-1234-5678</em>
			</div>
		</td>
	</tr>
	<tr>
		<th>집 전화</th>
		<td>
			<form:input path="tel" placeholder="ex) 054-1234-5678" cssClass="text"/>
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
		<td><form:input path="birth" class="text ui-calendar"/></td>
	</tr>
	<tr>
		<th>기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="join_start_date" class="text ui-calendar" readonly="true"/> ~ <form:input path="join_end_date" class="text ui-calendar" readonly="true"/></td>
	</tr>
	<tr>
		<th>성별 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:radiobutton path="sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
       		<form:radiobutton path="sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
		</td>
	</tr>
	<tr>
		<th>이용구분 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td>
			<form:select path="use_type" cssClass="selectmenu">
				<form:option value="대출">대출</form:option>
				<form:option value="후원">후원</form:option>
			</form:select>
		</td>
	</tr>
	<tr>
		<th>금액 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<td><form:input path="sponsorship_amount" class="text" numberonly="true"/>원</td>
	</tr>
	<tr>
		<th>비고</th>
		<td><form:textarea path="etc" class="text" cssStyle="width:100%;border:1px solid #ccd2dc;" rows="3"/></td>
	</tr>
	</tbody>
</table>
<!-- 유료회원 가족 정보 등록 폼 -->
<br/>
<table class="type3 familyForm">
	<thead>
	<tr>
		<th colspan="6">가족</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<th style="text-align:center;width:15%;">이름 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th style="text-align:center;width:15%;">성별 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th style="text-align:center;width:15%;">연락처 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th style="text-align:center;width:15%;">생년월일 (<span style="color: red; font-weight: bold;">*</span>)</th>
		<th style="text-align:center;width:40%;">기타</th>
	</tr>
	<c:choose>
		<c:when test="${fn:length(familyMemberList) > 0}">
			<c:set value="${fn:length(familyMemberList)}" var="count"></c:set>
			<c:set var="familyCount" value="${5 - count}"></c:set>

			<c:forEach var="i" items="${familyMemberList}" varStatus="satstus">
				<tr id="family_tr_${satstus.count}">
					<td style="text-align:center;">
						<input type="text" class="text family_name" value="${i.family_name}">
					</td>
					<td style="text-align:center;">
						<label><input type="radio" class="family_sex" value="M" label="남" cssClass="M" ${i.family_sex eq 'M' ? 'checked' : ''}/>남</label>
						<label><input type="radio" class="family_sex" value="F" label="여" cssClass="F" ${i.family_sex eq 'F' ? 'checked' : ''}/>여</label>
					</td>
					<td style="text-align:center;">
						<input type="text" class="family_phone text" value="${i.family_phone}">
					</td>
					<td style="text-align:center;">
						<input type="text" class="text ui-calendar family_birth" readonly="true" value="${i.family_birth}">
					</td>
					<td style="text-align:center;">
						<textarea class="family_etc text" style="width:100%;border:1px solid #ccd2dc;">${i.family_etc}</textarea>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${familyCount > 0}">
				<c:forEach var="i" begin="0" end="${familyCount-1}" varStatus="satstus">
					<tr id="family_tr_${count+satstus.count}">
						<td style="text-align:center;">
							<input type="text" class="text family_name">
						</td>
						<td style="text-align:center;">
							<label><input type="radio" class="family_sex" value="M" label="남" cssClass="M"/>남</label>
							<label><input type="radio" class="family_sex" value="F" label="여" cssClass="F"/>여</label>
						</td>
						<td style="text-align:center;">
							<input type="text" class="family_phone text">
						</td>
						<td style="text-align:center;">
							<input type="text" class="text ui-calendar family_birth" readonly="true">
						</td>
						<td style="text-align:center;">
							<textarea class="family_etc text" style="width:100%;border:1px solid #ccd2dc;"></textarea>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:forEach var="i" begin="0" end="4" varStatus="satstus">
				<tr id="family_tr_${satstus.count}">
					<td style="text-align:center;">
						<input type="text" class="text family_name">
					</td>
					<td style="text-align:center;">
						<label><input type="radio" class="family_sex" value="M" label="남" cssClass="M"/>남</label>
						<label><input type="radio" class="family_sex" value="F" label="여" cssClass="F"/>여</label>
					</td>
					<td style="text-align:center;">
						<input type="text" class="family_phone text">
					</td>
					<td style="text-align:center;">
						<input type="text" class="text ui-calendar family_birth" readonly="true">
					</td>
					<td style="text-align:center;">
						<textarea class="family_etc text" style="width:100%;border:1px solid #ccd2dc;"></textarea>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>

<c:if test="${paymentMember.editMode ne 'MODIFY'}">
<br/>
<div class="infodesk">
	<div class="button">
		<a href="javascript:void(0);" class="btn btn5 right" onclick="paymentMemberSave('ADD');"><i class="fa fa-plus"></i><span>저장</span></a>
	</div>
</div>
</c:if>

</form:form>