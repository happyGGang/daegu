<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					var agreeLength = $('input.agree_check').length;
					for(var i = 1; i <= agreeLength; i++) {
						if(!$('#terms'+i).prop('checked') && $('#terms'+i).attr('keyValue2') == 'Y') {
							alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
							return false;
						}
					}
					
					var $form = {};
					$form = $.extend(true, $form, $('#studentForm'));

					var studendHack = $form.find('#student_hack').val() > 0 ? $form.find('#student_hack').val() : 0;
					$form.find('#student_hack').val(studendHack);

					$form.find('input#student_old').val('0');
					<c:if test="${teach.birth_yn eq 'Y'}">
					if ($("#student_birth").length > 0) {
						var selectedYear = $form.find ("#student_birth").val().split('-')[0];
						var currentYear = new Date().getUTCFullYear();
						$form.find('input#student_old').val((currentYear - selectedYear) + 1);
					} else {
						var selectedYear = $form.find ("#applicant_birth").val().split('-')[0];
						var currentYear = new Date().getUTCFullYear();
						$form.find('input#student_old').val((currentYear - selectedYear) + 1);
					}
					</c:if>

					var cellPhone1 = $form.find('#applicant_cell_phone_1').val();
					if ( cellPhone1 == '' ) {
						$form.find('#applicant_cell_phone_1').focus();
						alert('신청자 휴대전화번호를 입력해 주세요.');
						return false;
					}
					var cellPhone2 = $form.find('#applicant_cell_phone_2').val();
					if ( cellPhone2 == '' ) {
						$form.find('#applicant_cell_phone_2').focus();
						alert('신청자 휴대전화번호를 입력해 주세요.');
						return false;
					}
					var cellPhone3 = $form.find('#applicant_cell_phone_3').val();
					if ( cellPhone3 == '' ) {
						$form.find('#applicant_cell_phone_3').focus();
						alert('신청자 휴대전화번호를 입력해 주세요.');
						return false;
					}

					$form.find('#applicant_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);
					if ($form.find('#student_name').val() == ''){
						$form.find('#student_name').focus();
						alert('수강생명을 입력해 주세요.');
						return false;
					}
					<c:if test="${teach.birth_yn eq 'Y'}">
					if ( $form.find ("#student_birth").val() == '' ) {
						$form.find('#student_birth').focus();
						alert('수강생 생년월일을 입력해 주세요.');
						return false;
					}
					</c:if>
					<c:if test="${teach.sex_yn eq 'Y'}">
					if ( $form.find ('input:radio[name = student_sex]:checked').length < 1){
						$form.find ('input:radio[name = student_sex]').focus();
						alert('수강생 성별을 입력해 주세요.');
						return false;
					}
					</c:if>
					
					<c:if test="${teach.address_yn eq 'Y'}">
						if($form.find('#student_address').val() == ''){
							$form.find('#student_address').focus();
							alert('수강생 주소를 입력해 주세요.');
							return false;
						}
					</c:if>
					
					if($('#self_yn1').is(':checked')){
						if($('#applicant_name').val() != $('#student_name').val()){
							alert('신청자 성명과 수강생 성명이 동일하지 않습니다.');
							return false;
						}else if($('#applicant_birth').val() != $('#student_birth').val()){
							alert('신청자 생년월일과 수강생 생년월일이 동일하지 않습니다.');
							return false;
						}else if($('input:radio[name = applicant_sex]:checked').val() != $('input:radio[name = student_sex]:checked').val()){
							alert('신청자 성별과 수강생 성별이 동일하지 않습니다.');
							return false;
						}
					}
					$('#applicant_zipcode').val($('#student_zipcode').val());
					$('#applicant_address').val($('#student_address').val());

					<c:if test="${teach.family_yn eq 'Y'}">
					if ( $form.find('#family_relation').val() == '') {
						$form.find('#family_relation').focus();
						alert('보호자 관계를 입력해 주세요.');
						return false;
					}
					if ( $form.find('#family_name').val() == ''){
						$form.find('#family_name').focus();
						alert('보호자 이름을 입력해 주세요.');
						return false;
					}
					cellPhone1 = $form.find('#family_cell_phone_1').val();
					if ( cellPhone1 == '' ) {
						$form.find('#family_cell_phone_1').focus();
						alert('보호자 휴대전화번호를 입력해 주세요.');
						return false;
					}
					cellPhone2 = $form.find('#family_cell_phone_2').val();
					if ( cellPhone2 == '' ) {
						$form.find('#family_cell_phone_2').focus();
						alert('보호자 휴대전화번호를 입력해 주세요.');
						return false;
					}
					cellPhone3 = $form.find('#family_cell_phone_3').val();
					if ( cellPhone3 == '' ) {
						$form.find('#family_cell_phone_3').focus();
						alert('보호자 휴대전화번호를 입력해 주세요.');
						return false;
					}
					if ( $form.find('#family_name').val() == ''){
						$form.find('#family_name').focus();
						alert('보호자 이름을 입력해 주세요.');
						return false;
					}
					if ( $form.find('input:radio[name = family_confirm_yn]:checked').length < 1){
						$form.find('input:radio[name = family_confirm_yn]').focus();
						alert('보호자 동의여부를 입력해 주세요.');
						return false;
					}
					if ( $form.find('input:radio[name = family_confirm_yn]:checked').val() == 'N'){
						$form.find('input:radio[name = family_confirm_yn]').focus();
						alert('해당 강좌는 보호자 동의를 받아야 합니다.');
						return false;
					}

					$form.find('#family_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);
					if($('#self_parent_yn1').is(':checked')){
						if($('#applicant_name').val() != $('#family_name').val()){
							alert('신청자 성명과 보호자 이름이 동일하지 않습니다.');
							return false;
						}else if($('#applicant_cell_phone').val() != $('#family_cell_phone').val()){
							alert('신청자 휴대전화번호와 보호자 휴대전화번호가 동일하지 않습니다.');
							return false;
						}
					}
					</c:if>

					<c:if test="${teach.sms_service_yn eq 'Y'}">
					if ( $form.find("input:radio[name = sms_service_yn]:checked").length < 1 ) {
						$form.find('input:radio[name = sms_service_yn]').focus();
						alert('sms 수신동의여부가 입력되지 않았습니다.');
						return false;
					}
					</c:if>

					<c:if test="${teach.picture_use_yn eq 'Y'}">
					if ( $form.find("input:radio[name = picture_use_yn]:checked").length < 1 ) {
						$form.find('input:radio[name = picture_use_yn]').focus();
						alert('사진촬영동의여부가 입력되지 않았습니다.');
						return false;
					}
					</c:if>
					$form.find('#student_name').prop('disabled', false);
					$form.find('input[name="student_sex"]').prop('disabled', false);
					$form.find("#student_birth").prop('disabled', false);
					$form.find('#family_name').prop('disabled', false);
					if(doAjaxPost($form)) {
						$(this).dialog('destroy');
						$('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
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
		width: 600,
		height: 600
	});

	$('input#self_yn1').on('click', function() {
		if ( $(this).is(':checked') ) {
			$('#student_name').val($('#applicant_name').val());
			$('#student_name').prop('disabled', true);
			$('#student_birth').val($('#applicant_birth').val());
			$("#student_birth").datepicker('disable');
			$('input[name="student_sex"].'+$('[name="applicant_sex"]:checked').val()).prop('checked', true);
			$('input[name="student_sex"]').prop('disabled', true);
			$('#student_cell_phone_1').val($('#applicant_cell_phone_1').val());
			$('#student_cell_phone_2').val($('#applicant_cell_phone_2').val());
			$('#student_cell_phone_3').val($('#applicant_cell_phone_3').val());
			$('#student_cell_phone_1').prop('disabled', true);
			$('#student_cell_phone_2').prop('disabled', true);
			$('#student_cell_phone_3').prop('disabled', true);
		}
		else {
			$('#student_name').prop('disabled', false);
			$('#student_name').val('');
			$("#student_birth").datepicker('enable');
			$('#student_birth').val('');
			$('input[name="student_sex"]').prop('disabled', false);
			$('input[name="student_sex"]').prop('checked', false);
			$('#student_cell_phone_1').prop('disabled', false);
			$('#student_cell_phone_2').prop('disabled', false);
			$('#student_cell_phone_3').prop('disabled', false);
			$('#student_cell_phone_1').val('');
			$('#student_cell_phone_2').val('');
			$('#student_cell_phone_3').val('');
		}
	});
	
	$('input#self_parent_yn1').on('click', function() {
		if ( $(this).is(':checked') ) {
			$('#family_name').val($('#applicant_name').val());
			$('#family_name').prop('disabled', true);
			$('#family_cell_phone_1').val($('#applicant_cell_phone_1').val());
			$('#family_cell_phone_2').val($('#applicant_cell_phone_2').val());
			$('#family_cell_phone_3').val($('#applicant_cell_phone_3').val());
			$('#family_cell_phone_1').prop('disabled', true);
			$('#family_cell_phone_2').prop('disabled', true);
			$('#family_cell_phone_3').prop('disabled', true);
		}
		else {
			$('#family_name').prop('disabled', false);
			$('#family_cell_phone_1').prop('disabled', false);
			$('#family_cell_phone_2').prop('disabled', false);
			$('#family_cell_phone_3').prop('disabled', false);
			$('#family_name').val('');
			$('#family_cell_phone_1').val('');
			$('#family_cell_phone_2').val('');
			$('#family_cell_phone_3').val('');
		}
	});

	if($('#self_yn1').is(':checked')){
		$('#student_name').prop('disabled', true);
		$("#student_birth").prop('disabled', true);
		$('input[name="student_sex"]').prop('disabled', true);
		$('#student_cell_phone_1').prop('disabled', true);
		$('#student_cell_phone_2').prop('disabled', true);
		$('#student_cell_phone_3').prop('disabled', true);
	}

	if($('#self_parent_yn1').is(':checked')){
		$('#family_name').prop('disabled', true);
		$('#family_cell_phone_1').prop('disabled', true);
		$('#family_cell_phone_2').prop('disabled', true);
		$('#family_cell_phone_3').prop('disabled', true);
	}

	$('.findPostCode').on('click', function(e){
		e.preventDefault();
		var zipcodeInput 	= $(this).attr('keyValue1');
		var addressInput 	= $(this).attr('keyValue2');
		var focusInput 		= $(this).attr('keyValue3');
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                $(zipcodeInput).val(data.zonecode);
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(addressInput).val(fullAddr);
                // 커서를 상세주소 필드로 이동한다.
                $(focusInput).focus();
            }
        }).open();
		
	});

	$('a.idCheck').on('click', function(e) {
		$('#studentForm #member_key').val('');
		$('#studentForm #applicant_name').val('');
		if($('#studentForm #member_id').val() == ''){
			alert('아이디를 입력해 주세요.');
			return false;
		}
		$.get('checkId.do?homepage_id=' + $('#studentForm #homepage_id').val() + '&member_id='+ $('#studentForm #member_id').val(), function(response) {
			if( response.data.length > 0){


				$('#studentForm #member_key').val(response.data[0]["REC_KEY"]);
				$('#studentForm #applicant_name').val(response.data[0]["NAME"]);
				$('#studentForm #api_user_id').val(response.data[0]["USER_ID"]);

				$('#teacherForm #member_key').val(response.data[0]["REC_KEY"]);
				$('#teacherForm #teacher_name').val(response.data[0]["NAME"]);

				if(response.data[0]["BIRTHDAY"] != null){
					var birthday = response.data[0]["BIRTHDAY"].split("\/");
					$('#studentForm #applicant_birth').val(birthday[0]+'-'+birthday[1]+'-'+birthday[2]);
				}

				$('#studentForm #applicant_address').val(response.data[0]["H_ADDR1"]);
				$('#studentForm #applicant_zipcode').val(response.data[0]["H_ZIPCODE"]);

				if (response.data[0]["HANDPHONE"] == '0') {
					$('input#as1').prop('checked', true);
				} else {
					$('input#as2').prop('checked', true);
				}

				if(response.data[0]["HANDPHONE"] != null){
					var phone = response.data[0]["HANDPHONE"].split("\-");
					$('#studentForm #applicant_cell_phone_1').val(phone[0]);
					$('#studentForm #applicant_cell_phone_2').val(phone[1]);
					$('#studentForm #applicant_cell_phone_3').val(phone[2]);
				}

			} else {
				alert('검색한 사용자 없습니다.');
			}

		});
		e.preventDefault();
	});

	$('input#applicant_birth').datepicker({
		yearRange: 'c-70:c',
		maxDate:0,
		onSelect : function() {
			$(this).parent().focus();
		}
	});

	$('input#student_birth').datepicker({
		yearRange: 'c-70:c',
		maxDate:0,
		onSelect : function() {
			$(this).parent().focus();
		}
	});

	try {

	var applicant_cell_phone_temp = '${student.applicant_cell_phone}'.split('-');
	$('input#applicant_cell_phone_1').val(applicant_cell_phone_temp[0]);
	$('input#applicant_cell_phone_2').val(applicant_cell_phone_temp[1]);
	$('input#applicant_cell_phone_3').val(applicant_cell_phone_temp[2]);
	
	var student_cell_phone_temp = '${student.student_cell_phone}'.split('-');
	$('input#student_cell_phone_1').val(student_cell_phone_temp[0]);
	$('input#student_cell_phone_2').val(student_cell_phone_temp[1]);
	$('input#student_cell_phone_3').val(student_cell_phone_temp[2]);

	var family_cell_phone_temp = '${student.family_cell_phone}'.split('-');
	$('input#family_cell_phone_1').val(family_cell_phone_temp[0]);
	$('input#family_cell_phone_2').val(family_cell_phone_temp[1]);
	$('input#family_cell_phone_3').val(family_cell_phone_temp[2]);

	var organization_tel_arr = '${student.student_organization_tel}'.split('-');
	$('input#student_organization_tel1').val(organization_tel_arr[0]);
	$('input#student_organization_tel2').val(organization_tel_arr[1]);
	$('input#student_organization_tel3').val(organization_tel_arr[2]);
	
	} catch (e) {

	}
	
	$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val($(this).val().replace(/[^0-9]/gi, ""));
	});
});
</script>
<form:form id="studentForm" modelAttribute="student" method="post" action="save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="member_key"/>
	<form:hidden path="api_user_id"/>
	<input type="hidden" name="self_info_yn" value="Y"/>

	<div style="text-align: right; margin-bottom: 5px;">
		<code style="float:left">신청자 정보</code>(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
	</div>
	<table class="type2">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>ID</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${student.editMode eq 'ADD' }">
	         				<form:input path="member_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>
	         			</c:when>
	         			<c:otherwise>
	         				${empty student.web_id ? student.member_id : student.web_id}
	         			</c:otherwise>
	         		</c:choose>
         		</td>
        	</tr>
			<tr>
	         	<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="applicant_name" class="text" /></td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="applicant_birth" class="text ui-calendar"/></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="as1" path="applicant_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
	         		<form:radiobutton id="as2" path="applicant_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
         		</td>
	        </tr>
	        </c:if>
			<tr>
				<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="applicant_cell_phone" cssClass="text"/>
					<input id="applicant_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
					<input id="applicant_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
					<input id="applicant_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
					<div class="ui-state-highlight">
						<em>* ex) 010-1234-5678</em>
					</div>
				</td>
			</tr>
			<c:if test="${teach.member_yn eq 'Y' and not empty student.student_password}">
				<tr>
					<th>비밀번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:password path="student_password" cssClass="text" style="width:20%" maxlength="20" title="비밀번호"/>
						<div class="ui-state-highlight">
							<em>* 입력하는 경우에만 변경됩니다.</em>
						</div>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>약관</th>
				<td>
					<ul>
						<c:forEach items="${termsList}" var="terms" varStatus="status">
						<li>
							<input type="checkbox" name=agree_codes id="terms${status.count}" class="agree_check" value="${terms.terms_idx}" keyValue="${terms.title}" keyValue2="${terms.required_yn}" ${fn:contains(student.agree_codes, terms.terms_idx) ? 'checked' : ''}>
							<label for="terms${status.count}">${terms.required_yn eq 'Y' ? '[필수]' : '[선택]'} ${terms.title}</label>
						</li>
						</c:forEach>
					</ul>
				</td>
			</tr>
		</table>
		<br/>
		<div style="text-align: right; margin-bottom: 5px;">
			<code style="float:left">수강생 정보</code>(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table class="type2">
			<colgroup>
		       <col width="160" />
		       <col width="*"/>
	       	</colgroup>
			<tr>
				<th>동일여부</th>
	        	<td>
	        		<form:checkbox path="self_yn" value="Y" label="신청자 정보와 동일" cssStyle="vertical-align: middle;"/>
	      		</td>
			</tr>
			<tr>
	         	<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_name" class="text" /></td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_birth" class="text ui-calendar" /></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="ss1" path="student_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
	         		<form:radiobutton id="ss2" path="student_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
         		</td>
	        </tr>
	        </c:if>
	        <tr>
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="student_cell_phone" cssClass="text"/>
					<input id="student_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
					<input id="student_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
					<input id="student_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
					<div class="ui-state-highlight">
						<em>* ex) 010-1234-5678</em>
					</div>
				</td>
			</tr>
        	<tr style="display: none">
	         	<th >나이(<span style="font-weight: bold;">*</span>)</th>
	         	<td><input id="student_old" name="student_old" class="text" style="width:30px" maxlength="3" /></td>
        	</tr>
        	<c:if test="${teach.address_yn eq 'Y' }">
	        <tr>
	         	<th>우편번호</th>
	         	<td><form:input path="student_zipcode" class="text" readonly="true" cssStyle="width: 15%;"/><button class="btn btn2 findPostCode student_zipcode" keyValue1="#student_zipcode" keyValue2="#student_address" keyValue3="#student_address">우편번호 찾기</button></td>
        	</tr>
	        <tr>
	         	<th>주소(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:hidden path="applicant_address"/>
	         		<form:input path="student_address" class="text" style="width:100%;" maxlength="60"/><br/>
	         	</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.family_yn eq 'N'}">
        	<tr>
        		<th>SMS 수신동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
        		<td>
        			<form:radiobutton path="sms_service_yn" value="Y" label="동의" cssStyle="vertical-align: middle;"/>
					<form:radiobutton path="sms_service_yn" value="N" label="미동의" cssStyle="vertical-align: middle;"/> 
        		</td>
        	</tr>
        	</c:if>
        	<tr>
        		<th>사진촬영동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
        		<td>
        			<form:radiobutton path="picture_use_yn" value="Y" label="동의" cssStyle="vertical-align: middle;"/>
					<form:radiobutton path="picture_use_yn" value="N" label="미동의" cssStyle="vertical-align: middle;"/>
        		</td>
        	</tr>
			<tr>
				<th>상태</th>
				<td>
					<form:select path="apply_status" class="selectmenu">
						<form:options items="${statusCode}" itemValue="code_id" itemLabel="code_name"/>
					</form:select>
				</td>
			</tr>
        	<c:if test="${teach.school_info_yn eq 'Y'}">
        	<tr>
	         	<th>학교</th>
	         	<td><form:input path="student_school" class="text" cssStyle="width:250px;" /></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.school_grade_yn eq 'Y'}">
        	<tr>
	         	<th>학년</th>
	         	<td>
	         		<form:select path="student_hack" cssClass="selectmenu" cssStyle="width:120px;" items="${hakList}" itemValue="code_id" itemLabel="code_name">
	         		</form:select>
	         	</td>
        	</tr>
        	</c:if>
			<c:if test="${teach.age_info_yn eq 'Y'}">
			<tr>
				<th>나이(<span style="color: red;font-wight: bold;">*</span>)</th>
				<td><form:input path="student_age" cssClass="text" cssStyle="width: 80px;" title="나이 입력" numberOnly="true"/></td>
			</tr>
			</c:if>
        	<c:if test="${teach.remark_yn eq 'Y'}">
				<tr>
					<th>비고</th>
					<td><form:input path="student_remark" cssClass="text" style="width:100%"/></td>
				</tr>
			</c:if>
			<c:if test="${teach.neis_location_yn eq 'Y'}">
				<tr>
					<th>지역(나이스)</th>
					<td>
						<form:select path="student_location_code" cssClass="selectmenu" cssStyle="width:120px;" >
	         			<form:options items="${traingLocationList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
					</td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_cd_yn eq 'Y'}">
				<tr>
					<th>개인번호(나이스)</th>
					<td><form:input path="student_neis_cd" cssClass="text" style="width:100%" maxlength="10"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_training_num_yn eq 'Y'}">
				<tr>
					<th>연수지명번호(나이스)</th>
					<td><form:input path="student_training_num" cssClass="text" style="width:100%" maxlength="60"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.organization_yn eq 'Y'}">
				<tr>
					<th>기관</th>
					<td><form:input path="student_organization" cssClass="text" style="width:100%" maxlength="40"/></td>
				</tr>
				<tr>
					<th>기관 연락처</th>
					<td>
						<form:hidden path="student_organization_tel" />
						<input type="text" id="student_organization_tel1" style="width:40px;" class="text" maxlength="3" numberonly="true"/> -
						<input type="text" id="student_organization_tel2" style="width:50px;" class="text" maxlength="4" numberonly="true"/> -
						<input type="text" id="student_organization_tel3" style="width:50px;" class="text" maxlength="4" numberonly="true"/>
					</td>
				</tr>
			</c:if>
        	<c:if test="${teach.rank_yn eq 'Y'}">
				<tr>
					<th>직급</th>
					<td><form:input path="student_rank" cssClass="text" style="width:100%" maxlength="20"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.course_taken_yn eq 'Y'}">
				<tr>
					<th>연수수강여부</th>
					<td>
						<form:radiobutton path="student_course_taken_yn" value="Y" label="이수" cssStyle="vertical-align: middle;"/>
	         			<form:radiobutton path="student_course_taken_yn" value="N" label="미이수" cssStyle="vertical-align: middle;"/>
					</td>
				</tr>
			</c:if>
			<c:if test="${teach.family_count_yn eq 'Y'}">
				<tr>
					<th>가족 인원 수</th>
					<td><form:input path="student_family_count" cssClass="text" numberOnly="true"/></td>
				</tr>
			</c:if>
		</table>
		<c:if test="${teach.family_yn eq 'Y'}">
		</br>
		<div style="text-align: right; margin-bottom: 5px;">
				<code style="float:left">보호자 정보</code>(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table class="type2">
			<colgroup>
				<col width="160" />
				<col width="*"/>
			</colgroup>
				<tr>
					<th>동일여부</th>
					<td><form:checkbox path="self_parent_yn" value="Y" label="신청자 정보와 동일" cssStyle="vertical-align: middle;"/></td>
				</tr>
				<tr>
					<th>관계(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_relation" cssClass="text"/></td>
				</tr>
				<tr>
					<th>이름(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_name" cssClass="text"/></td>
				</tr>
				<tr>
					<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="family_cell_phone" cssClass="text"/>
						<input id="family_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
						<input id="family_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
						<input id="family_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
						<div class="ui-state-highlight">
							<em>* ex) 010-1234-5678</em>
						</div>
					</td>
				</tr>
				<c:if test="${teach.sms_service_yn eq 'Y'}">
				<tr>
					<th>SMS 수신동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="sms_service_yn" value="Y" label="동의" cssStyle="vertical-align: middle;"/>
						<form:radiobutton path="sms_service_yn" value="N" label="미동의" cssStyle="vertical-align: middle;"/> 
					</td>
				</tr>
				</c:if>
				<c:if test="${teach.vaccines_yn eq 'Y'}">
				<tr>
					<th>백신여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="vaccines_counter" value="0" label="미접종" cssStyle="vertical-align: middle;" title="미접종"/>
	         			<form:radiobutton path="vaccines_counter" value="1" label="1회접종" cssStyle="vertical-align: middle;" title="1회접종"/>
	         			<form:radiobutton path="vaccines_counter" value="2" label="2회접종" cssStyle="vertical-align: middle;" title="2회접종"/>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>14세 미만 어린이/아동보호자(법정대리인)동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="family_confirm_yn" value="Y" label="동의" cssStyle="vertical-align: middle;"/>
	         			<form:radiobutton path="family_confirm_yn" value="N" label="미동의" cssStyle="vertical-align: middle;"/>
	        		</td>
				</tr>
				<tr>
					<th>비고</th>
					<td>
						<form:input path="family_desc" cssClass="text"/>
					</td>
				</tr>
       		</tbody>
		</table>
	</c:if>
	
</form:form>