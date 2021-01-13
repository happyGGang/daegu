<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({
		autoOpen: false,
		resizable: true,
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
				click: function(){
					if($('input#member_id').val() == ''){
						alert('아이디를 입력해 주세요.');
						$('input#member_id').focus();
						return false;
					}
					if($('input#member_name').val() == ''){
						alert('이름을 입력해 주세요.');
						$('input#member_name').focus();
						return false;
					}
					if($('input:radio[name = age_type]:checked').length < 1){
						alert('분류를 선택해 주세요.');
						return false;
					}
					if($('input:radio[name = age_type]:checked').val() != 'adult'){
						if($('input#school_name').val() == ''){
							alert('학교를 입력해 주세요.');
							$('input#school_name').focus();
							return false;
						}
						if($('input#school_class_one').val() == ''){
							alert('학년을 입력해 주세요.');
							$('input#school_class_one').focus();
							return false;
						}
						if($('input#school_class_two').val() == ''){
							alert('반을 입력해 주세요.');
							$('input#school_class_two').focus();
							return false;
						}
					}
					if($('select#address_dong').val() == '' || $('input#address_writeDong').val() == ''){
						alert('동명을 입력해 주세요.');
						$('select#address_dong').focus();
						return false;
					}
					if($('input#zipcode').val() == ''){
						alert('우편번호를 입력해 주세요.');
						$('input#zipcode').focus();
						return false;
					}
					if($('input#address_one').val() == ''){
						alert('주소를 입력해 주세요.');
						$('input#address_one').focus();
						return false;
					}
					if($('input#address_one').val().length > 50) {
						alert('주소는 50자리 이내로 입력해 주세요.');
						$('input#address_one').focus();
						return false;
					}
					if($('input#address_two').val() == ''){
						alert('주소를 입력해 주세요.');
						$('input#address_two').focus();
						return false;
					}
					if($('input#address_two').val().length > 50) {
						alert('주소는 50자리 이내로 입력해 주세요.');
						$('input#address_two').focus();
						return false;
					}
					if($('input#telephone_one').val() == ''){
						alert('전화번호 앞자리를 입력해 주세요.');
						$('input#telephone_one').focus();
						return false;
					}
					if($('input#telephone_one').val().length > 3) {
						alert('전화번호 앞자리는 4자리 미만을 입력해 주세요.');
						$('input#telephone_one').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#telephone_one').val())){
						alert('전화번호에는 숫자만 입력해 주세요.');
						$('input#telephone_one').focus();
						return false;
					}
					if($('input#telephone_two').val() == ''){
						alert('전화번호 중간자리를 입력해 주세요.');
						$('input#telephone_two').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#telephone_two').val())){
						alert('전화번호에는 숫자만 입력해 주세요.');
						$('input#telephone_two').focus();
						return false;
					}
					if($('input#telephone_three').val() == ''){
						alert('전화번호 끝자리를 입력해 주세요.');
						$('input#telephone_three').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#telephone_three').val())){
						alert('전화번호에는 숫자만 입력해 주세요.');
						$('input#telephone_three').focus();
						return false;
					}
					if($('input#cellphone_one').val() == ''){
						alert("휴대전화번호 앞자리를 입력해 주세요.");
						$('input#cellphone_one').focus();
						return false;
					}
					if($('input#cellphone_one').val().length > 3) {
						alert('휴대전화번호 앞자리는 4자리 미만을 입력해 주세요.');
						$('input#cellphone_one').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#cellphone_one').val())){
						alert('휴대전화번호에는 숫자만 입력해 주세요.');
						$('input#cellphone_one').focus();
						return false;
					}
					if($('input#cellphone_two').val() == ''){
						alert('휴대전화번호 중간자리를 입력해 주세요.');
						$('input#cellphone_two').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#cellphone_two').val())){
						alert('휴대전화번호에는 숫자만 입력해 주세요.');
						$('input#cellphone_two').focus();
						return false;
					}
					if($('input#cellphone_three').val() == ''){
						alert('휴대전화번호 끝자리를 입력해 주세요.');
						$('input#cellphone_three').focus();
						return false;
					}
					var regexp = /^[0-9]/g;
					if(!regexp.test($('input#cellphone_three').val())){
						alert('휴대전화번호에는 숫자만 입력해 주세요.');
						$('input#cellphone_three').focus();
						return false;
					}
					if($('input:radio[name = gender]:checked').length < 1){
						alert('성별을 선택해 주세요.');
						$('input:radio[name = gender]').focus();
						return false;
					}
					if($('select#birthday_year').val() == ''){
						alert('생년월일 연도를 선택해 주세요.');
						$('select#birthday_year').focus();
						return false;
					}
					if($('select#birthday_month').val() == ''){
						alert('생년월일 월을 선택해 주세요.');
						$('select#birthday_month').focus();
						return false;
					}
					if($('select#birthday_date').val() == ''){
						alert('생년월일 일을 선택해 주세요.');
						$('select#birthday_date').focus();
						return false;
					}
					if($('select#contest_type_idx_edit').val() == ''){
						alert('참가종목을 선택해 주세요.');
						$('select#contest_type_idx_edit').focus();
						return false;
					}
					if($('select#contest_type_idx_edit option:selected').prop('disabled')){
						alert('선택한 분류는 해당 참가종목에 참여할 수 없습니다.');
						$('select#contest_type_idx_edit').focus();
						return false;
					}
					if($('input:radio[name = finish_memorial]:checked').length < 1){
						alert('완주기념풍을 선택해 주세요.');
						$('input:radio[name = finish_memorial]').focus();
						return false;
					}
					if($('select#address_dong').val() == 'write' && $('input#address_writeDong').val() != ''){
						$('select#address_dong').append('<option value=' + $('input#address_writeDong').val() + ' selected="selected"></option>');
						$('select#address_dong option[value = "write"]').remove();
					}
					if(doAjaxPost($('form#marathonApplicant'))){
						location.reload();
					}
				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function(){
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$('#dialog-1').dialog({
		width: 800,
		height: 800
	});
	
	$('a#findPostCode').on('click', function(e) {
		e.preventDefault();
		new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
				fullAddr = data.roadAddress;
				if(data.bname !== ''){
				    extraAddr += data.bname;
				}
				if(data.buildingName !== ''){
				    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				extraAddr = '(' + extraAddr + ')';
                $('input#zipcode').val(data.zonecode);//5자리 새우편번호 사용
                $('input#address_one').val(fullAddr);
                $('input#address_two').val(extraAddr);
            }
        }).open();
	});
	
	if($('input:radio[name = age_type]:checked').val() == 'ele_low'){
		$('select#contest_type_idx_edit option').each(function(i) {
			var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
			if (optionValue.indexOf('ele_low') > -1 || optionValue == 'all') {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
			} else {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
			}
		});
	}else if($('input:radio[name = age_type]:checked').val() == 'ele_high'){
		$('select#contest_type_idx_edit option').each(function(i) {
			var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
			if(optionValue.indexOf('ele_high') > -1 || optionValue == 'all') {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
			} else {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
			}
		});
	}else if($('input:radio[name = age_type]:checked').val() == 'middle' || $('input:radio[name = age_type]:checked').val() == 'high' || $('input:radio[name = age_type]:checked').val() =='adult'){
		var selectedValue = $('input:radio[name = age_type]:checked').val();
		$('select#contest_type_idx_edit option').each(function(i) {
			var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
			var optionArray = optionValue.split(',');
			
			Array.prototype.contains = function(element) {
				for (var i = 0; i < this.length; i++){
					if (this[i] == element) {
						return true;
					}
				}
				return false;
			}
			
			if (optionArray.contains(selectedValue) || optionValue == 'all') {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
			} else {
				$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
			}
		});
	}
	if($('input:radio[name = age_type]:checked').val() == 'adult'){
		$('input#school_class_one').prop('disabled', true);
		$('input#school_class_two').prop('disabled', true);
		$('input#school_name').prop('disabled', true);
	}
	
	$('input:radio[name = age_type]').on('click', function(e) {
		$('select#contest_type_idx_edit option').eq(0).prop('selected', true);
		if($(this).val() == 'ele_low'){
			$('select#contest_type_idx option').each(function(i) {
				var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
				if (optionValue.indexOf('ele_low') > -1 || optionValue == 'all') {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
				}
			});
			$('input#school_class_one').prop('disabled', false);
			$('input#school_class_two').prop('disabled', false);
			$('input#school_name').prop('disabled', false);
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
		}else if($(this).val() == 'ele_high'){
			$('select#contest_type_idx_edit option').each(function(i) {
				var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
				if (optionValue.indexOf('ele_high') > -1 || optionValue == 'all') {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
				}
			});
			$('input#school_class_one').prop('disabled', false);
			$('input#school_class_two').prop('disabled', false);
			$('input#school_name').prop('disabled', false);
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
		}else if($(this).val() == 'middle' || $(this).val() == 'high' || $(this).val() == 'adult'){
			var selectedValue = $(this).val();
			$('select#contest_type_idx_edit option').each(function(i) {
				var optionValue = $('select#contest_type_idx_edit option').eq(i).data('subject');
				var optionArray = optionValue.split(',');
				
				Array.prototype.contains = function(element) {
					for (var i = 0; i < this.length; i++){
						if (this[i] == element) {
							return true;
						}
					}
					return false;
				}
				
				if (optionArray.contains(selectedValue) || optionValue == 'all') {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx_edit option').eq(i).prop('disabled', true);
				}
			});
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
		}
		if($(this).val() == 'middle' || $(this).val() == 'high') {
			$('input#school_class_one').prop('disabled', false);
			$('input#school_class_two').prop('disabled', false);
			$('input#school_name').prop('disabled', false);
		}
		if($(this).val() == 'adult'){
			$('input#school_class_one').val('');
			$('input#school_class_two').val('');
			$('input#school_name').val('');
			$('input#school_class_one').prop('disabled', true);
			$('input#school_class_two').prop('disabled', true);
			$('input#school_name').prop('disabled', true);
			$('input#school_class_one').css('background', "rgb(238, 238, 238)");
			$('input#school_class_two').css('background', "rgb(238, 238, 238)");
			$('input#school_name').css('background', "rgb(238, 238, 238)");
		}
	});
	<c:choose>
		<c:when test="${marathonApplicant.address_dong != '10' && marathonApplicant.address_dong != '20' && marathonApplicant.address_dong != '30'
			&& marathonApplicant.address_dong != '40' && marathonApplicant.address_dong != '50' && marathonApplicant.address_dong != '60'
			&& marathonApplicant.address_dong != '70' && marathonApplicant.address_dong != '80' && marathonApplicant.address_dong != '90'
			&& marathonApplicant.address_dong != '100' && marathonApplicant.address_dong != '110' && marathonApplicant.address_dong != '120'
			&& marathonApplicant.address_dong != '130' && marathonApplicant.address_dong != '140' && marathonApplicant.address_dong != '150'
			&& marathonApplicant.address_dong != '160' && marathonApplicant.address_dong != '170' && marathonApplicant.address_dong != '180'
			&& marathonApplicant.address_dong != '190' && marathonApplicant.address_dong != '200' && marathonApplicant.address_dong != '210'
			&& marathonApplicant.address_dong != '220' && marathonApplicant.address_dong != '230' && marathonApplicant.address_dong != '240'
			&& marathonApplicant.address_dong != '250' && marathonApplicant.address_dong != '260' && marathonApplicant.address_dong != '270'
			&& marathonApplicant.address_dong != '280' && marathonApplicant.address_dong != '290' && marathonApplicant.address_dong != '300'
			&& marathonApplicant.address_dong != '310' && marathonApplicant.address_dong != '320' && marathonApplicant.address_dong != '330'
			&& marathonApplicant.address_dong != '340' && marathonApplicant.address_dong != '350' && marathonApplicant.address_dong != '' && marathonApplicant.address_dong != null}">
			$('select#address_dong option[value="write"]').prop('selected', 'true');
			$('input#address_writeDong').prop('readonly', false);
			$('input#address_writeDong').val('${marathonApplicant.address_dong}');
		</c:when>
		<c:when test="${marathonApplicant.address_dong == '' || marathonApplicant.address_dong == null}">
			$('input#address_writeDong').val('');
		</c:when>
		<c:otherwise>
			$('input#address_writeDong').val($('select#address_dong option[value = "${marathonApplicant.address_dong}"]').text());
		</c:otherwise>
	</c:choose>
	
	$('select#address_dong').on('change', function(e) {
		if($(this).val() == 'write') {
			$('input#address_writeDong').prop('readonly', false);
			$('input#address_writeDong').val('');
		}else if($(this).val() == ''){
			$('input#address_writeDong').val('');
			$('input#address_writeDong').prop('readonly', true);
		}else{
			$('input#address_writeDong').val($('select#address_dong option:checked').text());
			$('input#address_writeDong').prop('readonly', true);
		}
	});
	
	function setDate(){
		var year = new Array();
		var month = new Array();
		var date = new Array();
		
		var sysDate = new Date();
		var now_year = sysDate.getFullYear();
		var now_year2 = sysDate.getFullYear();
		
		var birth_year = '${marathonApplicant.birthday_year}';
		var birth_month = '${marathonApplicant.birthday_month}';
		var birth_date = '${marathonApplicant.birthday_date}';

		for(var i = now_year2; i > now_year2 - 100; i--){
			year.push(now_year);
			now_year = now_year - 1;
		}
		for(var i = 1; i < 13; i++){
			if(i < 10){
				i = "0" + i;
			}
			month.push(i);
		}
		for(var i = 1; i < 32; i++){
			if(i < 10){
				i = "0" + i;
			}
			date.push(i);
		}
		for(var count = 0; count < year.length; count++){
			if(year[count] == birth_year){
				$('select#birthday_year').append("<option value='" + year[count] + "' + selected = 'selected'>" + year[count] + "</option>");
			}else{
				$('select#birthday_year').append("<option value='" + year[count] + "'>" + year[count] + "</option>");
			}
		}
		for(var count = 0; count < month.length; count++){
			if(month[count] == birth_month){
				$('select#birthday_month').append("<option value='" + month[count] + "' + selected = 'selected'>" + month[count] + "</option>");
			}else{
				$('select#birthday_month').append("<option value='" + month[count] + "'>" + month[count] + "</option>");
			}
		}
		for(var count = 0; count < date.length; count++){
			if(date[count] == birth_date){
				$('select#birthday_date').append("<option value='" + date[count] + "' + selected = 'selected'>" + date[count] + "</option>");
			}else{
				$('select#birthday_date').append("<option value='" + date[count] + "'>" + date[count] + "</option>");
			}
		}
	}
	setDate();
});
</script>
<form:form modelAttribute="marathonApplicant" method="POST" action="save.do" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<c:if test="${marathonApplicant.editMode eq 'MODIFY'}">
		<form:hidden path="contest_idx"/>
	</c:if>
	<form:hidden path="contest_type_idx"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="member_id" value="${marathonApplicant.member_id}"/>
	<table class="type2">
		<colgroup>
			<col width="160"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>대회명</th>
				<td>
					<c:choose>
						<c:when test="${marathonApplicant.editMode eq 'ADD'}">
							<form:select path="contest_idx" cssClass="selectmenu">
								<form:options itemValue="contest_idx" itemLabel="contest_name" items="${marathonList}"/>					
							</form:select>
						</c:when>
						<c:when test="${marathonApplicant.editMode eq 'MODIFY'}">
							${marathonApplicant.contest_name}
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>신청일</th>
				<td><fmt:formatDate value="${marathonApplicant.add_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<th>아이디*</th>
				<td>
					${marathonApplicant.member_id}
				</td>
			</tr>
			<tr>
				<th>이름*</th>
				<td>
					<form:input path="member_name" cssClass="text"/>
					<em>* 30자 이내로 입력해주세요.</em>
				</td>
			</tr>
			<tr>
				<th>분류*</th>
				<td>
					<form:radiobutton path="age_type" id="age_type_ele_low" value="ele_low"/>
					<label for="age_type_ele_low">초등(1~3)저학년</label>
					<form:radiobutton path="age_type" id="age_type_ele_high" value="ele_high"/>
					<label for="age_type_ele_high">초등(4~6)고학년</label>
					<form:radiobutton path="age_type" id="age_type_middle" value="middle"/>
					<label for="age_type_middle">중학생</label>
					<form:radiobutton path="age_type" id="age_type_high" value="high"/>
					<label for="age_type_high">고등학생</label>
					<form:radiobutton path="age_type" id="age_type_adult" value="adult"/>
					<label for="age_type_adult">일반인</label><br/>
				</td>
			</tr>
			<tr>
				<th>학교</th>
				<td>
					<form:input path="school_name" cssClass="text"/>
					<em>* 일반인의 경우 학교 학년 기입하지 않으셔도 됩니다.</em>
				</td>
			</tr>
			<tr>
				<th>학년</th>
				<td>
					<form:input path="school_class_one" cssClass="text" size="4" value=""/>학년<form:input path="school_class_two" cssClass="text" size="4" value=""/>반
				</td>
			</tr>
			<tr>
				<th>주소*</th>
				<td>
					<div style="margin-bottom:1%;">
						<form:select path="address_dong">
							<form:option value="">동 선택</form:option>
							<form:options items="${dongList}" itemLabel="code_name" itemValue="code_id"/>
							<form:option value="write">기타 직접 입력</form:option>
						</form:select>
						<input type="text" id="address_writeDong" class="text" size="6" readonly="true"/><em> *동명을 입력해 주세요.</em><br/>
					</div>
					<a href="" id="findPostCode" class="btn" style="background:#fff">우편번호찾기</a><form:input path="zipcode" cssClass="text" readonly="true" cssStyle="width:80px;" maxLength="5"/><em>* 우편번호(숫자5자리)</em><br/>
					<form:input path="address_one" cssClass="text" style="width:60%;margin-top:1%;" readonly="true"/><br/><em> *시도 + 시군구 + 읍면 + 도로명(50자리 이내로 입력해 주세요.)</em>
					<form:input path="address_two" cssClass="text" style="width:60%;margin-top:1%;"/><br/><em> *건물번호 + 동·층·호 + (법정동,공동주택명)(50자리 이내로 입력해 주세요.)</em>
				</td>
			</tr>
			<tr>
				<th>전화번호*</th>
				<td>
					<form:input path="telephone_one" cssClass="text" size="4" maxLength="4"/>-<form:input path="telephone_two" cssClass="text" size="4" maxLength="4"/>-<form:input path="telephone_three" cssClass="text" size="4" maxLength="4"/>
					<em>* 숫자만 입력해 주세요.</em>
				</td>
			</tr>
			<tr>
				<th>휴대전화번호*</th>
				<td>
					<form:input path="cellphone_one" cssClass="text" size="4" maxLength="4"/>-<form:input path="cellphone_two" cssClass="text" size="4" maxLength="4"/>-<form:input path="cellphone_three" cssClass="text" size="4" maxLength="4"/>
					<em>* 숫자만 입력해 주세요.</em>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<form:input path="email" cssClass="text" size="30"/>
					<em>* 100자 이내로 @포함한 이메일주소를 입력해 주세요.</em>
				</td>
			</tr>
			<tr>
				<th>성별*</th>
				<td>
					<form:radiobutton path="gender" id="gender_man" value="M"/>
					<label for="gender_man">남</label>
					<form:radiobutton path="gender" id="gender_woman" value="F"/>
					<label for="gender_woman">여</label>
				</td>
			</tr>
			<tr>
				<th>생년월일*</th>
				<td>
					<form:select path="birthday_year" cssClass="selectmenu">
						<form:option value="">년도</form:option>
					</form:select>
					년
					<form:select path="birthday_month" cssClass="selectmenu">
						<form:option value="">월</form:option>
					</form:select>
					월
					<form:select path="birthday_date" cssClass="selectmenu">
						<form:option value="">일</form:option>
					</form:select>
					일
				</td>
			</tr>
			<tr>
				<th>참가종목*</th>
				<td>
					<form:select path="contest_type_idx_edit" cssClass="selectmenu">
						<form:option value="0" data-subject="DONOTSELECT">참가종목</form:option>
						<c:forEach items="${marathonTypeList}" var="i">
							<form:option value="${i.contest_type_idx}" data-subject="${i.application_subject}">${i.contest_type}</form:option>
						</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>완주기념품*</th>
				<td>
					<form:radiobutton path="finish_memorial" id="finish_memorial_document" value="document"/>
					<label for="finish_memorial_document">완주증서</label>
					<form:radiobutton path="finish_memorial" id="finish_memorial_medal" value="medal"/>
					<label for="finish_memorial_medal">완주메달</label>
				</td>
			</tr>
			<tr>
				<th>각오한마디</th>
				<td>
					<form:textarea path="determination_talk" cssClass="text" cols="50" rows="4" style="padding:10px;"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>