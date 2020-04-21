<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('input#self_yn1').on('click', function() {
		var value = $(this).is(':checked') ? 'Y' : 'N';
		if ( value === 'Y' ) {
			$('#student_name').val($('#applicant_name').val());
//			$('#student_name').prop('readonly', true);
			$('#student_birth').val($('#applicant_birth').val());
//			$("#student_birth").datepicker('disable');
			if($('#applicant_sex1').length == 0) {
				if ($('#applicant_sex').val() == 'M') {
					$('input[name=student_sex].M').prop('checked', true);
				} else {
					$('input[name=student_sex].F').prop('checked', true);
				}
			} else {
				if ($('#applicant_sex1').is(':checked')) {
					$('input[name=student_sex].M').prop('checked', true);
				} else {
					$('input[name=student_sex].F').prop('checked', true);
				}
			}
			/* $('#student_sex').val($('#applicant_sex').val()); */
			$('#student_zipcode').val($('#applicant_zipcode').val());
 			$('#student_zipcode').prop('readonly', true);
			$('#student_address').val($('#applicant_address').val());
 			$('#student_address').prop('readonly', true);
			$('#student_address_detail').val($('#applicant_address_detail').val());
 			$('#student_address_detail').prop('readonly', true);
			try {
				var applicant_cell_phone = $('#applicant_cell_phone').val();
				var numbers = applicant_cell_phone.split('-');
				$('#student_cell_phone_1').val(numbers[0]);
				$('#student_cell_phone_2').val(numbers[1]);
				$('#student_cell_phone_3').val(numbers[2]);
			} catch(e) { }
		}
		else {
			$('#student_name').val('');
			$('#student_name').prop('readonly', false);
			$('#student_birth').val('');
			$("#student_birth").datepicker('enable');
			$('input[name=student_sex]').prop('disabled', false);
			$('input[name=student_sex]').prop('readonly', false);
			$('#student_zipcode').val('');
			$('#student_zipcode').prop('readonly', false);
			$('#student_address').val('');
			$('#student_address').prop('readonly', false);
			$('#student_address_detail').val('');
			$('#student_address_detail').prop('readonly', false);
			$('#student_cell_phone_1').val('');
			$('#student_cell_phone_2').val('');
			$('#student_cell_phone_3').val('');
			$('#student_cell_phone_1').prop('readonly', false);
			$('#student_cell_phone_2').prop('readonly', false);
			$('#student_cell_phone_3').prop('readonly', false);
		}
	});

	$('input[name=sex1]').on('change', function() {
		$('#applicant_sex').val($(this).val());
	});

	$('#save-btn').on('click', function() {
		var agreeLength = $('div.agree_codes input.agree_check').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked') && $('#terms'+i).attr('keyValue2') == 'Y') {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

		var $form = {};
		$form = $.extend(true, $form, $('#studentForm'));
		$form.find('input[name=applicant_sex]').prop('disabled', false);
		$form.find('input[name=student_sex]').prop('disabled', false);
		$form.find ("#applicant_birth").prop('disabled', false);
		$form.find ("#student_birth").prop('disabled', false);

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

		<c:if test="${teach.birth_yn eq 'Y'}">
		if ( $form.find ("#applicant_birth").val() == '--' ) {
			alert('신청자 생년월일이 입력되지 않았습니다. 회원정보 수정후 신청 해주세요.');
			return false;
		}
		</c:if>

		if ( $form.find ("#applicant_name").val() == '' ) {
			alert('성명이 입력되지 않았습니다.');
			$("#applicant_name").focus();
			return false;
		}

		<c:if test="${teach.birth_yn eq 'Y'}">
		if ( $form.find ("#applicant_birth").val() == '' ) {
			alert('생년월일이 입력되지 않았습니다.');
			$("#applicant_birth").focus();
			return false;
		}
		</c:if>

		<c:if test="${teach.sex_yn eq 'Y'}">
		if ( $("[name=applicant_sex]").val() == '' ) {
			alert('성별이 입력되지 않았습니다.');
			return false;
		}
		</c:if>

		<c:if test="${teach.birth_yn eq 'Y'}">
		if ( $form.find ("#student_birth").val() == '' ) {
			alert('수강생 생년월일이 입력되지 않았습니다.');
			return false;
		}
		</c:if>

// 		if ( $form.find('#self_info_yn').val() != 'Y' ) {
// 			alert('이용약관 및 개인정보의 수집·이용 동의 하여야 신청이 가능합니다.');
// 			return false;
// 		}

		var cellPhone1 = $form.find('#applicant_cell_phone_1').val();
		if ( cellPhone1 == '' ) {
			$form.find('#applicant_cell_phone_1').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}
		var cellPhone2 = $form.find('#applicant_cell_phone_2').val();
		if ( cellPhone2 == '' ) {
			$form.find('#applicant_cell_phone_2').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}
		var cellPhone3 = $form.find('#applicant_cell_phone_3').val();
		if ( cellPhone3 == '' ) {
			$form.find('#applicant_cell_phone_3').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}

		var applyFile = $('#apply_file');
		if ($('#apply_file').val() == '') {
			$('#apply_file').remove();
		}

		<c:if test="${teach.agent_yn eq 'Y'}">
		var cellPhone1_s = $form.find('#student_cell_phone_1').val();
		if ( cellPhone1_s == '' ) {
			$form.find('#student_cell_phone_1').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}
		var cellPhone2_s = $form.find('#student_cell_phone_2').val();
		if ( cellPhone2_s == '' ) {
			$form.find('#student_cell_phone_2').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}
		var cellPhone3_s = $form.find('#student_cell_phone_3').val();
		if ( cellPhone3_s == '' ) {
			$form.find('#student_cell_phone_3').focus();
			alert('휴대전화번호를 입력해주세요.');
			return false;
		}

		$form.find('#student_cell_phone').val(cellPhone1_s+'-'+cellPhone2_s+'-'+cellPhone3_s);
		</c:if>

		<c:if test="${teach.school_info_yn eq 'Y'}">
		var schoolName = $form.find('#student_school').val();
		if ( schoolName == '' ) {
			$form.find('#student_school').focus();
			alert('학교명을 입력해주세요.');
			return false;
		}
		</c:if>
		<c:if test="${teach.school_grade_yn eq 'Y'}">
		var schoolHak = $form.find('#student_hack option:selected').val();
		if ( schoolHak == '0' ) {
			$form.find('#student_hack option:selected').focus();
			alert('학년을 선택해주세요.');
			return false;
		}
		</c:if>

		$form.find('#applicant_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);

		<c:if test="${teach.family_yn eq 'Y'}">
		cellPhone1 = $form.find('#family_cell_phone_1').val();
		if ( cellPhone1 == '' ) {
			alert('보호자 연락처를 입력해주세요.');
			return false;
		}
		cellPhone2 = $form.find('#family_cell_phone_2').val();
		if ( cellPhone2 == '' ) {
			alert('보호자 연락처를 입력해주세요.');
			return false;
		}
		cellPhone3 = $form.find('#family_cell_phone_3').val();
		if ( cellPhone3 == '' ) {
			alert('보호자 연락처를 입력해주세요.');
			return false;
		}

		$form.find('#family_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);
		</c:if>

		var agree_codes = [];
		$('input.agree_check:checked').each(function() {
			agree_codes.push($(this).attr('keyValue3'));
		});
		$form.find('#agree_codes').val(agree_codes.join(','));


		var option = {
			url : 'save.do',
			type : 'POST',
			success: function(response) {
				if(response.valid) {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					}

// 					doGetLoad('/${homepage.context_path}/module/teach/index.do', 'group_idx='+$('input#group_idx').val()+'&menu_idx='+$('input#menu_idx').val());
					try {
						if (document.referrer.startsWith(location.origin)) {
							history.back();
						} else {
							doGetLoad('/${homepage.context_path}/module/teach/index.do', 'menu_idx='+$('input#menu_idx').val());
						}
					} catch (e) {
						doGetLoad('/${homepage.context_path}/module/teach/index.do', 'menu_idx='+$('input#menu_idx').val());
					}
				} else {
					$('td.applyFile').append(applyFile);
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					} else {
						if (response.result != null && response.result.length > 0) {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								$('#'+response.result[i].field, $form).css('border-color', 'red');
								$('#'+response.result[i].field, $form).on('change', function() {
									$(this).css('border-color', '');
								});
								break;
							}
						}
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$('td.applyFile').append(applyFile);
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
			}
		};
		$form.ajaxSubmit(option);

// 		if (doAjaxPost($form)) {
// 			doGetLoad('/${homepage.context_path}/module/teach/index.do', 'group_idx='+$('input#group_idx').val()+'&menu_idx='+$('input#menu_idx').val());
// 		}
	});

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

	$('button#back-btn').on('click', function() {
		history.back();
	});

	$('input#applicant_birth').datepicker({
		yearRange: 'c-120:c',
		maxDate:0,
		onClose: function(selectedDate){
			var tmp =  selectedDate.replace(/[^0-9]/g,'');
			var tmp2 = '';
			if(tmp.length < 8 ||  tmp.length > 8){
				alert('YYYY-MM-DD 형식으로 입력해주세요');
			}else{
				tmp2 += tmp.substr(0,4);
				tmp2 += '-';
				tmp2 += tmp.substr(4,2);
				tmp2 += '-';
				tmp2 += tmp.substr(6,2);
 				$('input#applicant_birth').val(tmp2);
 				$('input#student_zipcode').focus();
			}
				$('input#student_zipcode').focus();
		}
	});
	$('input#student_birth').datepicker({
		yearRange: 'c-120:c',
		maxDate:0,
		onClose: function(selectedDate){
			var tmp =  selectedDate.replace(/[^0-9]/g,'');
			var tmp2 = '';
			if(tmp.length < 8 ||  tmp.length > 8){
				alert('YYYY-MM-DD 형식으로 입력해주세요');
			}else{
				tmp2 += tmp.substr(0,4);
				tmp2 += '-';
				tmp2 += tmp.substr(4,2);
				tmp2 += '-';
				tmp2 += tmp.substr(6,2);
//  				$('input#applicant_birth').val(tmp2);
 				$('input#student_zipcode').focus();
			}
				$('input#student_zipcode').focus();
		}
	});

	<c:if test="${sessionScope.member.login}">
	$("#applicant_birth").datepicker('disable');
	</c:if>
});
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script>
<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="terms${status.count}" class="agree_check" type="checkbox" keyValue="${terms.title}" keyValue2="${terms.required_yn}" keyValue3="${terms.terms_idx}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의 ${terms.required_yn eq 'Y' ? '[필수]' : '[선택]'}</label>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>

<form:form id="studentForm" modelAttribute="student" method="post" action="save.do" onsubmit="return false;" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="apply_status"/>
	<form:hidden path="member_key" />
	<form:hidden path="agree_codes"/>
	<input type="hidden" name="self_info_yn" value="Y"/>
	<h3>신청자정보</h3>
	<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
		(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
	</div>
	<table class="type2 nohead">
		<colgroup>
	       <col width="200" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr style="display: none;">
	         	<th>신청자 - 회원ID</th>
	         	<td><form:input path="member_id" value="${memberInfo.member_id}" cssClass="text" readonly="true" title="회원 아이디 입력"/></td>
        	</tr>
			<tr>
	         	<th>신청자 - 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
	         		<c:when test="${sessionScope.member.login}">
	         		${memberInfo.member_name}
	         		<form:hidden path="applicant_name" value="${memberInfo.member_name}" cssClass="text" />
	         		</c:when>
	         		<c:otherwise>
	         		<form:input path="applicant_name" value="${memberInfo.member_name}" cssClass="text" />
	         		</c:otherwise>
	         		</c:choose>
	         	</td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>신청자 - 생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
		         	<c:choose>
	         		<c:when test="${sessionScope.member.login}">
	         		<form:hidden path="applicant_birth" value="${memberInfo.birth_day}" />
	         		${sessionScope.member.birth_day}
	         		</c:when>
	         		<c:otherwise>
	         		<form:input path="applicant_birth" value="${memberInfo.birth_day}" cssClass="text ui-calendar" />
	         		</c:otherwise>
		         	</c:choose>
	         	</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>신청자 - 성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
		         	<c:choose>
	         		<c:when test="${sessionScope.member.login}">
	         		<form:hidden path="applicant_sex" value="${memberInfo.sex eq '0' ? 'M' : 'F'}" cssClass="text" />
	         			<c:if test="${memberInfo.sex eq '0'}">
	         				남자
	         			</c:if>
	         			<c:if test="${memberInfo.sex eq '1'}">
	         				여자
	         			</c:if>
	         		</c:when>
	         		<c:otherwise>
	         		<form:radiobutton path="applicant_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
	         		<form:radiobutton path="applicant_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
    	     		</c:otherwise>
	    	     	</c:choose>
         		</td>
	        </tr>
	        </c:if>
	        <c:if test="${teach.address_yn eq 'Y'}">
	        <tr>
	         	<th>신청자 - 주소찾기(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
						<c:when test="${empty memberInfo.zipcode}">
	         		<form:hidden path="applicant_zipcode" cssClass="text" cssStyle="width: 8%;" readonly="true"/>
	         		<button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#applicant_address" keyValue3="#applicant_address">주소 찾기</button>
						</c:when>
						<c:otherwise>
	         		<form:hidden path="applicant_zipcode" value="${memberInfo.zipcode}" cssClass="text" cssStyle="width: 8%;" readonly="true"/>
						</c:otherwise>
					</c:choose>
	         	</td>
        	</tr>
	        <tr>
	         	<th>신청자 - 주소(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
						<c:when test="${empty memberInfo.zipcode}">
					<form:input path="applicant_address"  cssClass="text" style="width:95%;" maxlength="100"/><br/>
					<div class="ui-state-highlight">
						<em>* 개인정보보호를 위해 동/면/리 단위까지 입력하시기 바랍니다.</em>
					</div>
						</c:when>
						<c:otherwise>
	         		${memberInfo.address}
	         		<form:hidden path="applicant_address" value="${memberInfo.address}" cssClass="text" style="width:95%;" maxlength="60" readonly="true"/><br/>
						</c:otherwise>
					</c:choose>
         		</td>
        	</tr>
        	</c:if>
			<tr>
				<th>신청자 - 휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<c:choose>
						<c:when test="${empty member.cell_phone1}">
							<form:hidden path="applicant_cell_phone" />
							<input type="text" id="applicant_cell_phone_1" name="applicant_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true"/> -
							<input type="text" id="applicant_cell_phone_2" name="applicant_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true"/> -
							<input type="text" id="applicant_cell_phone_3" name="applicant_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true"/>
							<c:if test="${teach.family_yn eq 'Y'}">
							<div class="ui-state-highlight">
								<em>* 연락처가 없는 경우 보호자의 연락처를 입력하시기 바랍니다.</em>
							</div>
							</c:if>
						</c:when>
						<c:otherwise>
							${member.cell_phone1}-${member.cell_phone2}-${member.cell_phone3}
							<form:hidden path="applicant_cell_phone" />
							<input type="hidden" id="applicant_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${member.cell_phone1}"/>
							<input type="hidden" id="applicant_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${member.cell_phone2}"/>
							<input type="hidden" id="applicant_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${member.cell_phone3}"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<c:if test="${teach.apply_file_yn eq 'Y'}">
			<tr>
				<th>첨부파일</th>
				<td class="applyFile"><input type="file" id="apply_file" name="apply_file" class="text" accept=".hwp"></td>
			</tr>
			</c:if>
			<c:if test="${teach.agent_yn ne 'Y'}">
			<c:if test="${teach.family_yn eq 'Y'}">
				<tr>
					<th>보호자 관계(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_relation" cssClass="text" title="보호자 관계"/></td>
				</tr>
				<tr>
					<th>보호자 이름(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_name" cssClass="text" title="보호자 이름"/></td>
				</tr>
				<tr>
					<th>보호자연락처(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="family_cell_phone" cssClass="text"/>
						<input id="family_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" title="보호자 연락처 앞자리"/> -
						<input id="family_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" title="보호자 연락처 중간자리"/> -
						<input id="family_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" title="보호자 연락처 뒷자리" />
						<div class="ui-state-highlight">
							<em>* ex) 010-1234-5678</em>
						</div>
					</td>
				</tr>
				<tr>
					<th>보호자 동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="family_confirm_yn" value="Y" label="동의" cssStyle="vertical-align: middle;" title="동의"/>
	         			<form:radiobutton path="family_confirm_yn" value="N" label="미동의" cssStyle="vertical-align: middle;" title="미동의"/>
         			</td>
				</tr>
				<tr>
					<th>비고</th>
					<td>
						<form:input path="family_desc" cssClass="text" style="width:100%" title="비고 창"/>
					</td>
				</tr>
			</c:if>
	        <c:if test="${teach.family_count_yn eq 'Y'}">
				<tr>
					<th>가족 인원 수(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_family_count" cssClass="text" numberOnly="true" title="가족인원수"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.school_info_yn eq 'Y'}">
        	<tr>
	         	<th>학교(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_school" cssClass="text" cssStyle="width:250px;"  title="학교 입력"/></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.school_grade_yn eq 'Y'}">
        	<tr>
	         	<th>학년(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select path="student_hack" cssClass="selectmenu" cssStyle="width:120px;" title="학년 선택">
	         			<form:option value="0" label="--선택--"></form:option>
	         			<form:options items="${hakList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
	         	</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.remark_yn eq 'Y'}">
				<tr>
					<th>비고</th>
					<td><form:input path="student_remark" cssClass="text" style="width:100%" title="비고 창"/>
					<div class="ui-state-highlight">
						<em>${teach.remark_comment}</em>
					</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${teach.neis_location_yn eq 'Y'}">
				<tr>
					<th>지역(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:select path="student_location_code" cssClass="selectmenu" cssStyle="width:120px;" title="지역선택">
	         			<form:options items="${traingLocationList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
					</td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_cd_yn eq 'Y'}">
				<tr>
					<th>개인번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_neis_cd" cssClass="text" style="width:100%" maxlength="10" title="개인번호입력"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_training_num_yn eq 'Y'}">
				<tr>
					<th>연수지명번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_training_num" cssClass="text" style="width:100%" maxlength="30" title="연수지명번호"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.organization_yn eq 'Y'}">
				<tr>
					<th>기관(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_organization" cssClass="text" style="width:100%" maxlength="40" title="기관"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.rank_yn eq 'Y'}">
				<tr>
					<th>직급(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_rank" cssClass="text" style="width:100%" maxlength="20" title="직급"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.course_taken_yn eq 'Y'}">
				<tr>
					<th>연수수강여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="student_course_taken_yn" value="Y" label="이수" cssStyle="vertical-align: middle;" title="이수"/>
	         			<form:radiobutton path="student_course_taken_yn" value="N" label="미이수" cssStyle="vertical-align: middle;" title="미이수"/>
					</td>
				</tr>
			</c:if>
			</c:if>
        	<c:if test="${teach.member_yn eq 'Y' && !sessionScope.member.login}">
				<tr>
					<th>비밀번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:password path="student_password" cssClass="text" style="width:20%" maxlength="20" title="비밀번호"/>
					</td>
				</tr>
			</c:if>
			<tr style="display: none">
	         	<th>수강생 - 나이(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><input id="student_old" name="student_old" class="text" maxlength="3" numberOnly="true" style="width:30px;" title="수강생 나이"/></td>
        	</tr>
		</tbody>
	</table>
	<div class="ui-state-error" style="margin:5px 0;box-sizing:border-box;padding:5px 10px;">
		<c:if test="${sessionScope.member.login}">
		* 신청자정보 변경 시 My Library > 회원정보 수정에서 수정후 신청하시기 바랍니다.
		</c:if>
		<c:if test="${!sessionScope.member.login}">
		* [수강신청]화면 - '비회원 신청 확인'
		</c:if>
	</div>
	<br/>
	<c:if test="${teach.agent_yn eq 'Y'}">
	<h3>수강생정보</h3>
	<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
		(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
	</div>
	<table class="type2 nohead">
		<colgroup>
	       <col width="200" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
				<th>수강생 동일여부</th>
	        	<td>
	        		<form:checkbox path="self_yn" value="Y" label="신청자 정보와 동일" cssStyle="vertical-align: middle;" title="수강생 동일여부 체크"/>
	      		</td>
			</tr>
			<tr>
	         	<th>수강생 - 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_name" cssClass="text" title="수강생 수"/></td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_birth" cssClass="text ui-calendar" maxlength="6" title="생년월일 입력"/></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="ss1" path="student_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;" title="성별 남자"/>
	         		<form:radiobutton id="ss2" path="student_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;" title="성별 여자"/>
         		</td>
	        </tr>
	        </c:if>
	        <c:if test="${teach.address_yn eq 'Y'}">
	        <tr>
	         	<th>수강생 - 주소찾기(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:hidden path="student_zipcode" cssClass="text" cssStyle="width: 8%;" title="우편번호"/><button class="btn btn2 findPostCode" keyValue1="#student_zipcode" keyValue2="#student_address" keyValue3="#student_address" >주소 찾기</button></td>
        	</tr>
        	</c:if>
	        <tr>
	         	<th>수강생 - 주소(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:input path="student_address" cssClass="text" style="width:95%;" maxlength="60" title="주소입력"/><br/>
	         		<div class="ui-state-highlight">
						<em>* 개인정보보호를 위해 동/면/리 단위까지 입력하시기 바랍니다.</em>
					</div>
	         	</td>
        	</tr>
        	<c:if test="${teach.school_info_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 학교(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_school" cssClass="text" cssStyle="width:250px;" title="학교 입력"/></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.school_grade_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 학년(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select path="student_hack" cssClass="selectmenu" cssStyle="width:120px;" title="학년 선택">
	         			<form:option value="0" label="--선택--"></form:option>
	         			<form:options items="${hakList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
	         	</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.remark_yn eq 'Y'}">
				<tr>
					<th>수강생 - 비고</th>
					<td><form:input path="student_remark" cssClass="text" style="width:100%" title="비고창"/>
					<div class="ui-state-highlight">
						<em>${teach.remark_comment}</em>
					</div>
					</td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_location_yn eq 'Y'}">
				<tr>
					<th>수강생 - 지역(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:select path="student_location_code" cssClass="selectmenu" cssStyle="width:120px;" title="지역 선택">
	         			<form:options items="${traingLocationList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
					</td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_cd_yn eq 'Y'}">
				<tr>
					<th>수강생 - 개인번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_neis_cd" cssClass="text" style="width:100%" maxlength="10" title="개인번호"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.neis_training_num_yn eq 'Y'}">
				<tr>
					<th>수강생 - 연수지명번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_training_num" cssClass="text" style="width:100%" maxlength="60" title="연수지명번호"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.organization_yn eq 'Y'}">
				<tr>
					<th>기관(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_organization" cssClass="text" style="width:100%" maxlength="40" title="기관"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.rank_yn eq 'Y'}">
				<tr>
					<th>직급(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="student_rank" cssClass="text" style="width:100%" maxlength="20" title="직급"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.course_taken_yn eq 'Y'}">
				<tr>
					<th>연수수강여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="student_course_taken_yn" value="Y" label="이수" cssStyle="vertical-align: middle;" title="연수수강여부 이수"/>
	         			<form:radiobutton path="student_course_taken_yn" value="N" label="미이수" cssStyle="vertical-align: middle;" title="연수수강여부 미이수"/>
					</td>
				</tr>
			</c:if>
			 <c:if test="${teach.family_yn eq 'Y'}">
				<tr>
					<th>보호자 관계(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_relation" cssClass="text"/></td>
				</tr>
				<tr>
					<th>보호자 이름(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="family_name" cssClass="text" title="보호자 관계"/></td>
				</tr>
				<tr>
					<th>보호자연락처(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="family_cell_phone" cssClass="text"/>
						<input id="family_cell_phone_1" style="width:40px;" class="text" maxlength="3" numberonly="true" title="연락처 앞자리"/> -
						<input id="family_cell_phone_2" style="width:50px;" class="text" maxlength="4" numberonly="true" title="연락처 뒤자리"/> -
						<input id="family_cell_phone_3" style="width:50px;" class="text" maxlength="4" numberonly="true" title="연락처 끝자리"/>
						<div class="ui-state-highlight">
							<em>* ex) 010-1234-5678</em>
						</div>
					</td>
				</tr>
				<tr>
					<th>보호자 동의여부(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="family_confirm_yn" value="Y" label="동의" cssStyle="vertical-align: middle;" title="보호자 동의 "/>
	         			<form:radiobutton path="family_confirm_yn" value="N" label="미동의" cssStyle="vertical-align: middle;" title="보호자 미동의"/>
         			</td>
				</tr>
				<tr>
					<th>비고</th>
					<td>
						<form:input path="family_desc" cssClass="text" style="width:100%" title="비고창"/>
					</td>
				</tr>
			</c:if>
	        <c:if test="${teach.family_count_yn eq 'Y'}">
				<tr>
					<th>가족 인원 수</th>
					<td><form:input path="student_family_count" cssClass="text" numberOnly="true" title="가족인원수"/></td>
				</tr>
			</c:if>
		</tbody>
	</table>
	</c:if>
</form:form>
<br/>
<div class="button bbs-btn center">
	<button id="save-btn" class="btn btn5" title="신청하기">신청하기</button>
	<button id="back-btn" class="btn"><i class="fa fa-reorder" title="뒤로가기"></i><span>뒤로가기</span></button>
</div>

