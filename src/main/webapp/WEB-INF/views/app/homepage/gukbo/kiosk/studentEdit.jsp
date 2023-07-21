<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<tiles:insertAttribute name="header" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('input#self_yn1').on('click', function() {
		var value = $(this).is(':checked') ? 'Y' : 'N';
		if ( value === 'Y' ) {
			$('#student_name').val($('#applicant_name').val());
			$('#student_name').prop('disabled', true);
			$('#student_birth').val($('#applicant_birth').val());
			$('#student_birth').prop('disabled', true);
			$("#student_birth").datepicker('disable');

			$('#student_cell_phone_1').val($('#applicant_cell_phone_1').val());
			$('#student_cell_phone_2').val($('#applicant_cell_phone_2').val());
			$('#student_cell_phone_3').val($('#applicant_cell_phone_3').val());
			$('#student_cell_phone_1').prop('disabled', true);
			$('#student_cell_phone_2').prop('disabled', true);
			$('#student_cell_phone_3').prop('disabled', true);
			
			if($('#applicant_sex1').length == 0) { //로그인 했을 때
				if ($('#applicant_sex').val() == 'M') {
					$('input[name=student_sex].M').prop('checked', true);
					$('input[name=student_sex]').prop('disabled', true);
				} else {
					$('input[name=student_sex].F').prop('checked', true);
					$('input[name=student_sex]').prop('disabled', true);
				}
			} else { //로그인 하지 않았을 때
				if ($('#applicant_sex1').is(':checked')) {
					$('input[name=student_sex].M').prop('checked', true);
					$('input[name=student_sex]').prop('disabled', true);
				} else {
					$('input[name=student_sex].F').prop('checked', true);
					$('input[name=student_sex]').prop('disabled', true);
				}
			}
			<c:if test="${!sessionScope.member.login}">
			if(!($('#applicant_sex1').is(':checked') || $('#applicant_sex2').is(':checked'))) {
				$('input[name = student_sex].M').prop('checked', false);
				$('input[name = student_sex].F').prop('checked', false);
			}
			</c:if>
		}
		else {
			$('#student_name').val('');
			$('#student_name').prop('disabled', false);
			$('#student_birth').val('');
			$('#student_birth').prop('disabled', false);
			$("#student_birth").datepicker('enable');
			$('#student_cell_phone_1').val('');
			$('#student_cell_phone_2').val('');
			$('#student_cell_phone_3').val('');
			$('#student_cell_phone_1').prop('disabled', false);
			$('#student_cell_phone_2').prop('disabled', false);
			$('#student_cell_phone_3').prop('disabled', false);
			$('input[name=student_sex]').prop('disabled', false);
			$('input[name = student_sex].M').prop('checked', false);
			$('input[name = student_sex].F').prop('checked', false);
		}
	});
	
	$('input#self_parent_yn1').on('click', function() {
		var value = $(this).is(':checked') ? 'Y' : 'N';
		if( value == 'Y') {
			$('#family_name').val($('#applicant_name').val());
			$('#family_name').prop('disabled', true);
			$('#family_cell_phone_1').val($('#applicant_cell_phone_1').val());
			$('#family_cell_phone_2').val($('#applicant_cell_phone_2').val());
			$('#family_cell_phone_3').val($('#applicant_cell_phone_3').val());
			$('#family_cell_phone_1').prop('disabled', true);
			$('#family_cell_phone_2').prop('disabled', true);
			$('#family_cell_phone_3').prop('disabled', true);
			
		}else {
			$('#family_name').val('');
			$('#family_name').prop('disabled', false);
			$('#family_cell_phone_1').val('');
			$('#family_cell_phone_2').val('');
			$('#family_cell_phone_3').val('');
			$('#family_cell_phone_1').prop('disabled', false);
			$('#family_cell_phone_2').prop('disabled', false);
			$('#family_cell_phone_3').prop('disabled', false);
		}
	});

	$('input[name=sex1]').on('change', function() {
		$('#applicant_sex').val($(this).val());
	});

	var doubleSubmit = false;

	$('#save-btn').on('click', function() {

		if(doubleSubmit) {
			return false;
		}else{
			doubleSubmit = true;

			var agent_yn = $('#agent_yn').val();
			var vaccines_yn = $('#vaccines_yn').val();
			var vaccines_counter_1 = $('#vaccines_counter_1').val();
			var vaccines_counter_2 = $('#vaccines_counter_2').val();

			if(agent_yn == "N" && vaccines_yn == "Y"){
				$('#vaccines_counter').val($('input[name="vaccines_counter_1"]:checked').val());
			}else if(agent_yn == "Y" && vaccines_yn == "Y"){
				$('#vaccines_counter').val($('input[name="vaccines_counter_2"]:checked').val());
			}

			var $form = {};
			$form = $.extend(true, $form, $('#studentForm'));


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
				doubleSubmit = false;
				return false;
			}
			</c:if>

			if ( $form.find ("#applicant_name").val() == '' ) {
				$form.find("#applicant_name").focus();
				alert('신청자 성명을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}

			let regExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;

			<c:if test="${teach.sex_yn eq 'Y'}">
			if ( $("input:radio[name = applicant_sex]").length > 0 && $("input:radio[name = applicant_sex]:checked").length < 1 ) {
				$form.find('input:radio[name = applicant_sex]').focus();
				alert('신청자 성별을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.vaccines_yn eq 'Y'}">
			if ($('#vaccines_counter').val() == '') {
				$form.find('input:radio[name = vaccines_counter]').focus();
				alert('백신 접종여부를 선택해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.birth_yn eq 'Y'}">
			if ( $form.find ("#applicant_birth").val() == '' ) {
				$form.find('#applicant_birth').focus();
				alert('신청자 생년월일을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			} else if(!regExp.exec($form.find ("#applicant_birth").val())) {
				alert('잘못된 생년월일 입니다. 다시 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			var cellPhone1 = $form.find('#applicant_cell_phone_1').val();
			if ( cellPhone1 == '' ) {
				$form.find('#applicant_cell_phone_1').focus();
				alert('신청자 휴대전화번호를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			var cellPhone2 = $form.find('#applicant_cell_phone_2').val();
			if ( cellPhone2 == '' ) {
				$form.find('#applicant_cell_phone_2').focus();
				alert('신청자 휴대전화번호를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			var cellPhone3 = $form.find('#applicant_cell_phone_3').val();
			if ( cellPhone3 == '' ) {
				$form.find('#applicant_cell_phone_3').focus();
				alert('신청자 휴대전화번호를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}

			var applicant_birth = $form.find('#applicant_birth').val();
				if(applicant_birth)

			<c:if test="${teach.sms_service_yn eq 'Y'}">
			if ( $("input:radio[name = sms_service_yn]").length > 0 && $("input:radio[name=sms_service_yn]:checked").length < 1 ) {
				$form.find ("input:radio[name = sms_service_yn]").focus();
				alert('sms 수신동의여부를 선택해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.picture_use_yn eq 'Y'}">
			if ( $("input:radio[name = picture_use_yn]").length > 0 && $("input:radio[name = picture_use_yn]:checked").length < 1 ) {
				$form.find ('input:radio[name = picture_use_yn]').focus();
				alert('사진 촬영 동의 여부를 선택해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			var applyFile = $('#apply_file');
			if ($('#apply_file').val() == '') {
				$('#apply_file').remove();
			}

			<c:if test="${teach.agent_yn eq 'Y'}">

			if ( $form.find ('#student_name').val() == ''){
				$form.find('#student_name').focus();
				alert('수강생 이름을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}

			// 수강생 연락처 처리
			if($('#student_cell_phone_1').val() != '' && $('#student_cell_phone_3').val() != '' && $('#student_cell_phone_3').val() != '') {
				$('#student_cell_phone').val($('#student_cell_phone_1').val() + '-' + $('#student_cell_phone_2').val() + '-' + $('#student_cell_phone_3').val());
			}

			<c:if test="${teach.birth_yn eq 'Y'}">
			if ( $form.find ("#student_birth").val() == '' ) {
				$form.find('#student_birth').focus();
				alert('수강생 생년월일을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			} else if(!regExp.exec($form.find ('#student_birth').val())) {
				alert('잘못된 생년월일 입니다. 다시 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.sex_yn eq 'Y'}">
			if ( $form.find ('input:radio[name = student_sex]:checked').length < 1){
				$form.find ('input:radio[name = student_sex]').focus();
				alert('수강생 성별을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.address_yn eq 'Y'}">
			if ( $form.find ("#student_address").val() == ''){
				$form.find('#student_address').focus();
				alert('수강생 주소를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			if($('#self_yn1').is(':checked')){
				if($('#applicant_name').val() != $('#student_name').val()){
					alert('신청자 성명과 수강생 성명이 동일하지 않습니다.');
					doubleSubmit = false;
					return false;
				}
				<c:choose>
					<c:when test="${!sessionScope.member.login}">
					else if($('input:radio[name = applicant_sex]:checked').val() != $('input:radio[name = student_sex]:checked').val()){
						alert('신청자 성별과 수강생 성별이 동일하지 않습니다.');
						doubleSubmit = false;
						return false;
					</c:when>
					<c:otherwise>
					else if($('input#applicant_sex').val() != $('input:radio[name = student_sex]:checked').val()){
						alert('신청자 성별과 수강생 성별이 동일하지 않습니다.');
						doubleSubmit = false;
						return false;
					</c:otherwise>
				</c:choose>
				}else if($('#applicant_birth').val() != $('#student_birth').val()){
					alert('신청자 생년월일과 수강생 생년월일이 동일하지 않습니다.');
					doubleSubmit = false;
					return false;
				}
			}
			$('#applicant_zipcode').val($('#student_zipcode').val());
			$('#applicant_address').val($('#student_address').val());

			</c:if>

			<c:if test="${teach.school_info_yn eq 'Y'}">
			var schoolName = $form.find('#student_school').val();
			if ( schoolName == '' ) {
				$form.find('#student_school').focus();
				alert('학교명을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			<c:if test="${teach.school_grade_yn eq 'Y'}">
			var schoolHak = $form.find('#student_hack option:selected').val();
			if ( schoolHak == '0' ) {
				$form.find('#student_hack option:selected').focus();
				alert('학년을 선택해 주세요.');
				doubleSubmit = false;
				return false;
			}
			var schoolHak = $form.find('#student_ban').val();
			if ( schoolHak == '' ) {
				$form.find('#student_ban').focus();
				alert('반을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			</c:if>

			$form.find('#applicant_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);

			<c:if test="${teach.family_yn eq 'Y'}">
			if ( $form.find ('#family_relation').val() == ''){
				$form.find('#family_relation').focus();
				alert('보호자 관계를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			if ( $form.find ('#family_name').val() == ''){
				$form.find('#family_name').focus();
				alert('보호자 이름을 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			cellPhone1 = $form.find('#family_cell_phone_1').val();
			if ( cellPhone1 == '' ) {
				$form.find('#family_cell_phone_1').focus();
				alert('보호자 연락처를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			cellPhone2 = $form.find('#family_cell_phone_2').val();
			if ( cellPhone2 == '' ) {
				$form.find('#family_cell_phone_2').focus();
				alert('보호자 연락처를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}
			cellPhone3 = $form.find('#family_cell_phone_3').val();
			if ( cellPhone3 == '' ) {
				$form.find('#family_cell_phone_3').focus();
				alert('보호자 연락처를 입력해 주세요.');
				doubleSubmit = false;
				return false;
			}

			$form.find('#family_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);

			if ($form.find ('input:radio[name = family_confirm_yn]:checked').length < 1){
				$form.find('input:radio[name = family_confirm_yn]').focus();
				alert('해당 강좌는 보호자 동의를 받아야 합니다.');
				doubleSubmit = false;
				return false;
			}
			if($('#self_parent_yn1').is(':checked')){
				if($('#applicant_name').val() != $('#family_name').val()){
					alert('신청자 성명과 보호자 이름이 동일하지 않습니다.');
					doubleSubmit = false;
					return false;
				}else if($('#applicant_cell_phone').val() != $('#family_cell_phone').val()){
					alert('신청자 휴대전화번호와 보호자 휴대전화번호가 동일하지 않습니다.');
					doubleSubmit = false;
					return false;
				}
			}
			</c:if>

			// 기관 연락처 처리
			if($('#student_organization_tel1').val() != '' && $('#student_organization_tel2').val() != '' && $('#student_organization_tel3').val() != '') {
				$('#student_organization_tel').val($('#student_organization_tel1').val() + '-' + $('#student_organization_tel2').val() + '-' + $('#student_organization_tel3').val());
			}

			var agree_codes = [];
			$('input.agree_check:checked').each(function() {
				agree_codes.push($(this).attr('keyValue3'));
			});
			$form.find('#agree_codes').val(agree_codes.join(','));

			$form.find('#student_name').prop('disabled', false);
			$form.find('input[name = student_sex]').prop('disabled', false);
			$form.find("#student_birth").prop('disabled', false);
			$form.find('#family_name').prop('disabled', false);

			var option = {
				url : 'save.do',
				type : 'POST',
				success: function(response) {
					if(response.valid) {
						if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							alert(response.message);
						}

						try {
							if (document.referrer.startsWith(location.origin)) {
								history.back();
							} else {
								doGetLoad('/${homepage.context_path}/kiosk/teachIndex.do', 'menu_idx='+$('input#menu_idx').val(), 'searchCate1='+$('input#category_idx').val());
							}
						} catch (e) {
							doGetLoad('/${homepage.context_path}/kiosk/teachIndex.do', 'menu_idx='+$('input#menu_idx').val(), 'searchCate1='+$('input#category_idx').val());
						}
					} else {
						$('div.applyFile').append(applyFile);
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
					$('div.applyFile').append(applyFile);
					alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
					doubleSubmit = false;
				}
			};
			$form.ajaxSubmit(option);
			}
	});

	$('.findPostCode').on('click', function(e){
		e.preventDefault();
		var zipcodeInput 	= $(this).attr('keyValue1');
		var addressInput 	= $(this).attr('keyValue2');
		var focusInput 		= $(this).attr('keyValue3');
		new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
                
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
                $(addressInput).val(fullAddr);
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
				alert('YYYY-MM-DD 형식으로 입력해 주세요');
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
				alert('YYYY-MM-DD 형식으로 입력해 주세요');
			}else{
				tmp2 += tmp.substr(0,4);
				tmp2 += '-';
				tmp2 += tmp.substr(4,2);
				tmp2 += '-';
				tmp2 += tmp.substr(6,2);
 				$('input#student_birth').val(tmp2);
 				$('input#student_zipcode').focus();
			}
				$('input#student_zipcode').focus();
		}
	});

	<c:if test="${sessionScope.member.login}">
	
	</c:if>
	
	$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val($(this).val().replace(/[^0-9]/gi, ""));
	});


	let userAge = document.getElementById('applicant_birth').value;
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

</script>
	<div class="culturerequest-wrap">
		<div class="header">
			<h1>문화강좌</h1>
			<p>Cultural Lecture</p>
		</div>
		<div class="contents">

			<div class="culture-request-box">
				<div class="culture-request-title">
					<h2>문화강좌신청</h2>
				</div>
				<div class="culture-request-input">
					<div class="outer">
						<div class="inner">

							<div class="overflow-y input-contents">
								<form:form id="studentForm" modelAttribute="student" method="post" action="/${homepage.context_path}/kiosk/save.do" onsubmit="return false;" enctype="multipart/form-data">
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
									<form:hidden path="vaccines_counter" id="vaccines_counter"/>
									<input type="hidden" id="agent_yn" value="${teach.agent_yn }"/>
									<input type="hidden" id="vaccines_yn" value="${teach.vaccines_yn }"/>
									<form:hidden path="searchCate1"/>
									
									<c:choose>
										<c:when test="${teach.detail_address_yn eq 'Y'}">
										<c:set var="placeholder" value="* 상세주소까지 입력하시기 바랍니다." />
										</c:when>
										<c:otherwise>
										<c:set var="placeholder" value="* 개인정보보호를 위해 시/군/구(또는 읍/면/동)까지 입력하시기 바랍니다." />
										</c:otherwise>
									</c:choose>
											
									<input type="hidden" name="self_info_yn" value="Y"/>

									<h2 class="FS38">※ 신청자정보</h2>
									<div style="font-size:23px;text-align:right; ${param.ageType eq 'under' ? 'display:none;':''}">
										(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
									</div>
									<div class="PT20" style="display: none;">
										<h3>회원ID<span style="color: red; font-weight: bold;">*</span></h3>
										<form:input path="member_id" value="${memberInfo.member_id}" cssClass="inputText1" readonly="true" title="회원 아이디 입력"/>
									</div>
									<div class="PT20">
										<h3>성명<span style="color: red; font-weight: bold;">*</span></h3>
										<c:choose>
										<c:when test="${sessionScope.member.login}">
										${memberInfo.member_name}
										<form:hidden path="applicant_name" value="${memberInfo.member_name}" cssClass="inputText1" />
										</c:when>
										<c:otherwise>
										<form:input path="applicant_name" value="${memberInfo.member_name}" cssClass="inputText1" />
										</c:otherwise>
										</c:choose>
									</div>
									<c:if test="${teach.sex_yn eq 'Y'}">
									<div class="PT20">
										<h3>성별<span style="color: red; font-weight: bold;">*</span></h3>
										<c:choose>
										<c:when test="${sessionScope.member.login}">
											<form:hidden path="applicant_sex" value="${memberInfo.sex eq '0' ? 'M' : 'F'}" cssClass="inputText1" />
											<c:if test="${memberInfo.sex eq '0'}">
												남자
											</c:if>
											<c:if test="${memberInfo.sex eq '1'}">
												여자
											</c:if>
										</c:when>
										<c:otherwise>
										<input type="radio" name="applicant_sex" id="applicant_sex1" value="M" checked="checked"> <label class="agree-label">남자</label>
										<input type="radio" name="applicant_sex" id="applicant_sex2" value="F"> <label class="agree-label">여자</label>
										</c:otherwise>
										</c:choose>
									</div>
									</c:if>
									<c:if test="${teach.birth_yn eq 'Y'}">
									<div class="PT20">
										<h3>생년월일<span style="color: red; font-weight: bold;">*</span></h3>
										<c:choose>
											<c:when test="${sessionScope.member.login}">
												<form:hidden path="applicant_birth" value="${memberInfo.birth_day}"/>
												${sessionScope.member.birth_day}
											</c:when>
											<c:otherwise>
												<form:input path="applicant_birth" value="${memberInfo.birth_day}" maxlength="10" cssClass="inputText1 ui-calendar"/>
												<c:set var="birth" value="${memberInfo.birth_day}"/>
											</c:otherwise>
										</c:choose>
									</div>
									</c:if>
									<c:if test="${teach.address_yn eq 'Y' && teach.agent_yn eq 'N'}">
									<div class="PT20">
										<h3>주소<span style="color: red; font-weight: bold;">*</span></h3>
										<c:choose>
											<c:when test="${empty memberInfo.zipcode}">
												<form:input path="applicant_address"  cssClass="inputText1" style="width:82%;" maxlength="100" placeholder="${placeholder}"/>
												<form:hidden path="applicant_zipcode" cssClass="inputText1" cssStyle="width:8%;" readonly="true"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#applicant_address" keyValue3="#applicant_address" style="font-size:23px;padding:18px;">주소 찾기</button>	
											</c:when>
											<c:otherwise>
												${memberInfo.address}
												<form:hidden path="" value="${memberInfo.zipcode}" cssClass="inputText1" cssStyle="width: 8%;" readonly="true"/>
												<form:hidden path="applicant_address" value="${memberInfo.address}" cssClass="inputText1" style="width:95%;" maxlength="60" readonly="true"/><br/>
											</c:otherwise>
										</c:choose>
									</div>
									</c:if>
									<div class="PT20">
										<h3>휴대전화번호<span style="color: red; font-weight: bold;">*</span></h3>
										<c:choose>
											<c:when test="${empty member.cell_phone1}">
												<form:hidden path="applicant_cell_phone" />
												<input type="text" id="applicant_cell_phone_1" name="applicant_cell_phone_1" class="inputText2" maxlength="3" numberonly="true"/> -
												<input type="text" id="applicant_cell_phone_2" name="applicant_cell_phone_2" class="inputText2" maxlength="4" numberonly="true"/> -
												<input type="text" id="applicant_cell_phone_3" name="applicant_cell_phone_3" class="inputText2" maxlength="4" numberonly="true"/>
											</c:when>
											<c:when test="${teach.teach_age_type eq 'child' and teach.agent_yn eq 'N'}">
												<form:hidden path="applicant_cell_phone" />
												<input type="text" id="applicant_cell_phone_1" class="inputText2" maxlength="3" numberonly="true" value="${member.cell_phone1}"/>
												<input type="text" id="applicant_cell_phone_2" class="inputText2" maxlength="4" numberonly="true" value="${member.cell_phone2}"/>
												<input type="text" id="applicant_cell_phone_3" class="inputText2" maxlength="4" numberonly="true" value="${member.cell_phone3}"/>
											</c:when>
											<c:otherwise>
												${member.cell_phone1}-${member.cell_phone2}-${member.cell_phone3}
												<form:hidden path="applicant_cell_phone" />
												<input type="hidden" id="applicant_cell_phone_1" class="inputText2" maxlength="3" numberonly="true" value="${member.cell_phone1}"/>
												<input type="hidden" id="applicant_cell_phone_2" class="inputText2" maxlength="4" numberonly="true" value="${member.cell_phone2}"/>
												<input type="hidden" id="applicant_cell_phone_3" class="inputText2" maxlength="4" numberonly="true" value="${member.cell_phone3}"/>
											</c:otherwise>
										</c:choose>
									</div>

									<c:if test="${teach.agent_yn eq 'N'}">
										<c:if test="${teach.sms_service_yn eq 'Y'}">
										<div class="PT20">
											<h3 class="inline-block">SMS 수신동의여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<td>
												<form:radiobutton path="sms_service_yn" value="Y" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="sms_service_yn1">동의</label>
												<form:radiobutton path="sms_service_yn" value="N" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="sms_service_yn2">미동의</label>
												<div class="boxes">
													* 활용목적: 도서관 강좌 및 각종행사 안내<br>
													* 미동의하여도 수강신청에 제한이 없음(단, 미동의할 경우 해당강좌에 대한 안내를 받을 수 없음)
												</div>
											</td>
										</div>
										</c:if>
										<c:if test="${teach.picture_use_yn eq 'Y'}">
										<div class="PT20">
											<h3 class="inline-block">사진 촬영 동의 여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<td>
												<form:radiobutton path="picture_use_yn" value="Y" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="picture_use_yn1">동의</label>
												<form:radiobutton path="picture_use_yn" value="N" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="picture_use_yn2">미동의</label>
												<div class="boxes">
													* 활용목적: 도서관 프로그램 홍보<br>
													* 참고사항<br>
													 &nbsp;&nbsp;- 프로그램 진행 시간 동안 참여자 대상 사진 및 사진 촬영, 인터뷰 요청 등<br>
													 &nbsp;&nbsp;- 모든 촬영은 프로그램 진행이나 활동에 전혀 영향을 주지 않는 선에서 진행<br>
													 &nbsp;&nbsp;- 촬영된 사진, 영상물은 비상업적 용도로만 사용됨<br>
													 &nbsp;&nbsp;- 미동의하여도 수강신청에 제한이 없음
												</div>
											</td>
										</div>
										</c:if>
									</c:if>

									<c:if test="${teach.family_member_yn eq 'Y'}">
									<div class="PT20">
										<h3>가족참여 구성원(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="family_member" cssClass="inputText1" title="가족참여 구성원"/>
									</div>
									</c:if>
									<c:if test="${teach.apply_file_yn eq 'Y'}">
									<div class="PT20">
										<h3>첨부파일</h3>
										<div class="applyFile"><input type="file" id="apply_file" name="apply_file" class="inputText1" accept=".hwp"></div>
									</div>
									</c:if>

								<c:if test="${teach.agent_yn ne 'Y'}">

									<c:if test="${teach.family_count_yn eq 'Y'}">
									<div class="PT20">
										<h3>참여가족 인원 수(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_family_count" cssClass="inputText1" numberOnly="true" title="참여가족인원수"/>
									</div>
									<div class="PT20">
										<h3>참여가족 팀명</h3>
										<form:input path="student_family_team" cssClass="inputText1"/>
									</div>
									</c:if>

									<c:if test="${teach.school_info_yn eq 'Y'}">
									<div class="PT20">
										<h3>학교(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_school" cssClass="inputText1" title="학교 입력"/>
									</div>
									</c:if>

									<c:if test="${teach.school_grade_yn eq 'Y'}">
									<div class="PT20">
										<h3>학년(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<div>
										<form:select path="student_hack" cssClass="inputSelect1" title="학년 선택">
										<form:option value="0" label="--선택--"></form:option>
										<form:options items="${hakList}" itemValue="code_id" itemLabel="code_name"/>
										</form:select>
										</div>

										<c:if test="${homepage.homepage_id eq 'h7' and menuOne.menu_idx eq '30' }">
										<div>
											<div>반(<span style="color: red; font-weight: bold;">*</span>)</div>
											<div><form:input path="student_ban" cssClass="inputText1" title="반 입력" numberOnly="true"/></div>
										</div>
										</c:if>
									</div>
									</c:if>

									<%--<c:if test="${teach.age_info_yn eq 'Y'}">--%>
									<%--	<div class="PT20">--%>
									<%--		<h3>생년(<span style="color: red; font-wight: bold;">*</span>)</h3>--%>
									<%--			<form:select path="student_age" cssClass="selectmenu" id="studentAgeSelect">--%>
									<%--				<form:option value="0" label="--선택--"></form:option>--%>
									<%--			</form:select>--%>
									<%--		생--%>
									<%--	</div>--%>
									<%--</c:if>--%>

									<c:if test="${teach.remark_yn eq 'Y'}">
										<div class="PT20">
											<h3>비고</h3>
											<form:input path="student_remark" cssClass="inputText1" style="width:100%" title="비고 창"/>
											<c:if test="${teach.remark_comment ne null}">
											<div class="boxes">
												${teach.remark_comment}
											</div>
											</c:if>
										</div>
									</c:if>

									<c:if test="${teach.member_yn eq 'Y' && !sessionScope.member.login}">
										<div class="PT20">
											<h3>비밀번호(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:password path="student_password" cssClass="inputText1"  maxlength="20" title="비밀번호"/><br>
										</div>
										<div class="PT20">
											<span class="comment">* 비회원으로 수강신청 시 홈페이지의 수강신청 화면-'비회원 신청 확인'에서 수강신청 내역 확인가능</span>
										</div>
									</c:if>
									<c:if test="${teach.vaccines_yn eq 'Y' and teach.agent_yn eq 'N'}">			
										<div class="PT20">
											<h3>백신여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:radiobutton path="vaccines_counter_1" value="0" cssStyle="vertical-align: middle;" title="미접종"/> <label class="agree-label" for="vaccines_counter_21">미접종</label>
											<form:radiobutton path="vaccines_counter_1" value="1" cssStyle="vertical-align: middle;" title="1회접종"/> <label class="agree-label" for="vaccines_counter_22">1회접종</label>
											<form:radiobutton path="vaccines_counter_1" value="2" cssStyle="vertical-align: middle;" title="2회접종"/> <label class="agree-label" for="vaccines_counter_23">2회접종</label>
											<form:radiobutton path="vaccines_counter_1" value="3" cssStyle="vertical-align: middle;" title="3회접종"/> <label class="agree-label" for="vaccines_counter_23">3회접종</label>
										</div>
									</c:if>
									<div class="PT20" style="display: none">
										<h3>수강생 - 나이(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<input type="text" id="student_old" name="student_old" class="inputText2" maxlength="3" numberOnly="true" title="수강생 나이"/>
									</div>
								</c:if>

								<c:if test="${teach.agent_yn eq 'Y'}">
									<div class="PT30">&nbsp;</div>
									<h2 class="FS38">※ 수강생정보</h2>
									<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
										(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
									</div>

									<div class="PT20">
										<h3 class="inline-block;">동일여부</h3>
										<form:checkbox path="self_yn" value="Y" cssStyle="vertical-align: middle;" title="수강생 동일여부 체크"/> <label class="agree-label" for="self_yn1">신청자 정보와 동일</label>
									</div>
									<div class="PT20">
										<h3>성명(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_name" cssClass="inputText2" title="수강생 수"/>
									</div>
									<div class="PT20">
										<h3>휴대전화번호</h3>
										<form:hidden path="student_cell_phone" cssClass="text"/>
										<input id="student_cell_phone_1" class="inputText2" maxlength="3" numberonly="true" title="연락처 앞자리"/> -
										<input id="student_cell_phone_2" class="inputText2" maxlength="4" numberonly="true" title="연락처 뒤자리"/> -
										<input id="student_cell_phone_3" class="inputText2" maxlength="4" numberonly="true" title="연락처 끝자리"/>
										
									</div>
									<c:if test="${teach.birth_yn eq 'Y'}">
									<div class="PT20">
										<h3>생년월일(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_birth" cssClass="inputText1 ui-calendar" maxlength="10" title="생년월일 입력"/>
										
									</div>
									</c:if>
									<c:if test="${teach.sex_yn eq 'Y'}">
									<div class="PT20">
										<h3>성별(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:radiobutton id="student_sex1" path="student_sex" cssClass="M" value="M" cssStyle="vertical-align: middle;" title="성별 남자"/> <label class="agree-label" for="student_sex1">남자</label>
										<form:radiobutton id="student_sex2" path="student_sex" cssClass="F" value="F" cssStyle="vertical-align: middle;" title="성별 여자"/> <label class="agree-label" for="student_sex2">여자</label>
										
									</div>
									</c:if>
									<c:if test="${teach.address_yn eq 'Y'}">
									<div class="PT20">
										<h3>주소(<span style="color: red; font-weight: bold;">*</span>)</h3>
										
										<form:input path="student_address" cssClass="inputText1" style="width:82%;" maxlength="60" title="주소입력" placeholder="${placeholder}"/>
										<form:hidden path="student_zipcode" cssClass="inputText1" cssStyle="width: 8%;" title="우편번호"/><button class="btn btn2 findPostCode" keyValue1="#student_zipcode" keyValue2="#student_address" keyValue3="#student_address" style="font-size:23px;padding:18px;">주소찾기</button>
										<form:hidden path="applicant_zipcode" cssClass="inputText1" cssStyle="width: 8%;" readonly="true"/>
										<form:hidden path="applicant_address" cssClass="inputText1" cssStyle="width: 8%;" readonly="true"/>
										
									</div>
									</c:if>
									<c:if test="${teach.family_yn eq 'N' && teach.sms_service_yn eq 'Y'}">
									<div class="PT20">
										<h3 class="inline-block">SMS 수신동의여부(<span style="color: red; font-weight: bold;">*</span>)</h3>

										<form:radiobutton path="sms_service_yn" value="Y" cssStyle="vertical-align: middle;"/>  <label class="agree-label" for="sms_service_yn1">동의</label>
										<form:radiobutton path="sms_service_yn" value="N" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="sms_service_yn2">미동의</label>
										<div class="boxes">
											* 활용목적: 도서관 강좌 및 각종행사 안내<br>
											* 미동의하여도 수강신청에 제한이 없음(단, 미동의할 경우 해당강좌에 대한 안내를 받을 수 없음)
										</div>
										
									</div>
									</c:if>
									<c:if test="${teach.picture_use_yn eq 'Y'}">
									<div class="PT20">
										<h3 class="inline-block">사진 촬영 동의 여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
										
										<form:radiobutton path="picture_use_yn" value="Y" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="picture_use_yn1">동의</label>
										<form:radiobutton path="picture_use_yn" value="N" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="picture_use_yn2">미동의</label>

										<div class="boxes">
											* 활용목적: 도서관 프로그램 홍보<br>
											* 참고사항<br>
											 &nbsp;&nbsp;- 프로그램 진행 시간 동안 참여자 대상 사진 및 사진 촬영, 인터뷰 요청 등<br>
											 &nbsp;&nbsp;- 모든 촬영은 프로그램 진행이나 활동에 전혀 영향을 주지 않는 선에서 진행<br>
											 &nbsp;&nbsp;- 촬영된 사진, 영상물은 비상업적 용도로만 사용됨<br>
											 &nbsp;&nbsp;- 미동의하여도 수강신청에 제한이 없음
										</div>
										
									</div>
									</c:if>
									<c:if test="${teach.school_info_yn eq 'Y'}">
									<div class="PT20">
										<h3>학교(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_school" cssClass="inputText1" title="학교 입력"/>
									</div>
									</c:if>
									<c:if test="${teach.school_grade_yn eq 'Y'}">
									<div class="PT20">
										<h3>학년(<span style="color: red; font-weight: bold;">*</span>)</h3>
										
										<form:select path="student_hack" cssClass="inputSelect1" title="학년 선택">
										<form:option value="0" label="--선택--"></form:option>
										<form:options items="${hakList}" itemValue="code_id" itemLabel="code_name"/>
										</form:select>
										
										<c:if test="${homepage.homepage_id eq 'h7' and menuOne.menu_idx eq '30' }">
										<div class="PT20">
										<h3>반(<span style="color: red; font-weight: bold;">*</span>)</h3>
										<form:input path="student_ban" cssClass="inputText2"  title="반 입력" numberOnly="true"/>
										</div>
									</c:if>
									</div>
									</c:if>
									<c:if test="${teach.age_info_yn eq 'Y'}">
									<div class="PT20">
										<h3>나이(<span style="color: red;font-wight: bold;">*</span>)</h3>
										<c:choose>
											<c:when test="${teach.teach_age_type eq 'infants' }">
											<form:input path="student_age" cssClass="inputText2" title="나이 입력" numberOnly="true" maxlength="2"/>개월
											</c:when>
											<c:otherwise>
											<form:input path="student_age" cssClass="inputText2" title="나이 입력" numberOnly="true"/>
											</c:otherwise>
										</c:choose>
									</div>
									</c:if>
									<c:if test="${teach.remark_yn eq 'Y'}">
										<div class="PT20">
											<h3>비고</h3>
											<form:input path="student_remark" cssClass="inputText1" title="비고창"/>
											<c:if test="${teach.remark_comment ne null}">
											<div class="boxes">
												<em>${teach.remark_comment}</em>
											</div>
											</c:if>
										</div>
									</c:if>
									<c:if test="${teach.neis_location_yn eq 'Y'}">
										<div class="PT20">
											<h3>지역(나이스)(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
											<form:select path="student_location_code" cssClass="inputSelect1" title="지역 선택">
											<form:options items="${traingLocationList}" itemValue="code_id" itemLabel="code_name"/>
											</form:select>
											
										</div>
									</c:if>
									<c:if test="${teach.neis_cd_yn eq 'Y'}">
										<div class="PT20">
											<h3>개인번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="student_neis_cd" cssClass="inputText1" maxlength="10" title="개인번호"/>
										</div>
									</c:if>
									<c:if test="${teach.neis_training_num_yn eq 'Y'}">
										<div class="PT20">
											<h3>연수지명번호(나이스)(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="student_training_num" cssClass="inputText1" style="width:100%" maxlength="60" title="연수지명번호"/>
										</div>
									</c:if>
									<c:if test="${teach.organization_yn eq 'Y'}">
										<div class="PT20">
											<h3>기관(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="student_organization" cssClass="inputText1" style="width:100%" maxlength="40" title="기관"/>
										</div>
										<div class="PT20">
											<h3>기관 연락처</h3>
											
											<form:hidden path="student_organization_tel" />
											<input type="text" id="student_organization_tel1" class="inputText2" maxlength="3" numberonly="true"/> -
											<input type="text" id="student_organization_tel2" class="inputText2" maxlength="4" numberonly="true"/> -
											<input type="text" id="student_organization_tel3" class="inputText2" maxlength="4" numberonly="true"/>
											
										</div>
									</c:if>
									<c:if test="${teach.rank_yn eq 'Y'}">
										<div class="PT20">
											<h3>직급(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="student_rank" cssClass="inputText1" style="width:100%" maxlength="20" title="직급"/>
										</div>
									</c:if>
									<c:if test="${teach.course_taken_yn eq 'Y'}">
										<div class="PT20">
											<h3>연수수강여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
											<form:radiobutton path="student_course_taken_yn" value="Y" label="이수" cssStyle="vertical-align: middle;" title="연수수강여부 이수"/>
											<form:radiobutton path="student_course_taken_yn" value="N" label="미이수" cssStyle="vertical-align: middle;" title="연수수강여부 미이수"/>
											
										</div>
									</c:if>
									<c:if test="${teach.vaccines_yn eq 'Y'}">
										<div class="PT20">
											<h3>백신여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
											<form:radiobutton path="vaccines_counter_2" value="0" cssStyle="vertical-align: middle;" title="미접종"/> <label class="agree-label" for="vaccines_counter_21">미접종</label>
											<form:radiobutton path="vaccines_counter_2" value="1" cssStyle="vertical-align: middle;" title="1회접종"/> <label class="agree-label" for="vaccines_counter_22">1회접종</label>
											<form:radiobutton path="vaccines_counter_2" value="2" cssStyle="vertical-align: middle;" title="2회접종"/> <label class="agree-label" for="vaccines_counter_23">2회접종</label>
											<form:radiobutton path="vaccines_counter_2" value="3" cssStyle="vertical-align: middle;" title="3회접종"/> <label class="agree-label" for="vaccines_counter_24">3회접종</label>
											
										</div>
									</c:if>
									<c:if test="${teach.family_count_yn eq 'Y'}">
										<div class="PT20">
											<h3>참여가족 인원 수</h3>
											<form:input path="student_family_count" cssClass="inputText2" numberOnly="true" title="참여가족인원수"/>
										</div>
										<div class="PT20">
											<h3>참여가족 팀명</h3>
											<form:input path="student_family_team" cssClass="inputText2"/>
										</div>
									</c:if>
								</c:if>

									<c:if test="${teach.family_yn eq 'Y' }">
									<div class="PT30">&nbsp;</div>
									<h2 class="FS38">※ 보호자정보</h2>
									<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}">
										(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
									</div>

									<c:if test="${teach.family_yn eq 'Y'}">
										<div class="PT20">
											<h3>동일여부</h3>
											
												<form:checkbox path="self_parent_yn" value="Y" cssStyle="vertical-align: middle;" title="보호자 동일여부 체크"/> <label class="agree-label" for="self_parent_yn1">신청자 정보와 동일</label>
											
										</div>
										<div class="PT20">
											<h3>관계(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="family_relation" cssClass="inputText1"/>
										</div>
										<div class="PT20">
											<h3>이름(<span style="color: red; font-weight: bold;">*</span>)</h3>
											<form:input path="family_name" cssClass="inputText1" title="보호자 관계"/>
										</div>
										<div class="PT20">
											<h3>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
												<form:hidden path="family_cell_phone" cssClass="text"/>
												<input id="family_cell_phone_1" class="inputText2" maxlength="3" numberonly="true" title="연락처 앞자리"/> -
												<input id="family_cell_phone_2" class="inputText2" maxlength="4" numberonly="true" title="연락처 뒤자리"/> -
												<input id="family_cell_phone_3" class="inputText2" maxlength="4" numberonly="true" title="연락처 끝자리"/>
											
										</div>
										<c:if test="${teach.sms_service_yn eq 'Y' }">
										<div class="PT20">
											<h3 class="inline-block">SMS 수신동의여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
												<form:radiobutton path="sms_service_yn" value="Y" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="sms_service_yn1">동의</label>
												<form:radiobutton path="sms_service_yn" value="N" cssStyle="vertical-align: middle;"/> <label class="agree-label" for="sms_service_yn2">동의</label>
												<div class="boxes">
													* 활용목적: 도서관 강좌 및 각종행사 안내<br>
													* 미동의하여도 수강신청에 제한이 없음(단, 미동의할 경우 해당강좌에 대한 안내를 받을 수 없음)
												</div>
											
										</div>
										</c:if>
										<div class="PT20">
											<h3 class="inline-block" style="width:500px;">14세 미만 어린이/아동 보호자(법정대리인)동의여부(<span style="color: red; font-weight: bold;">*</span>)</h3>
											
												<form:radiobutton path="family_confirm_yn" value="Y" cssStyle="vertical-align: middle;" title="보호자 동의 "/> <label class="agree-label" for="family_confirm_yn1">동의</label>
												<form:radiobutton path="family_confirm_yn" value="N" cssStyle="vertical-align: middle;" title="보호자 미동의"/> <label class="agree-label" for="family_confirm_yn2">미동의</label>
												<div class="boxes">
													* 활용목적: 도서관 강좌 및 각종행사 안내<br/>
													<span style="color:red">* 미동의 시 수강신청 불가</span>
												</div>
											
										</div>
										<div class="PT20" style="display: none;">
											<h3>비고</h3>
												<form:input path="family_desc" cssClass="inputText1" style="width:100%" title="비고창"/>
										</div>
									</c:if>

									</c:if>

									<c:if test="${sessionScope.member.login}">
										<div class="boxes" style="margin-top:10px;">
										* 신청자정보 변경 시 홈페이지를 방문하여 My Library > 회원정보 수정에서 수정후 신청하시기 바랍니다.
										</div>
									</c:if>

								</form:form>
							</div>

						</div>

					</div>
				</div>
			</div>

			<div class="culturedetail-request-button-box">
				<button id="save-btn" class="btn button2 add" style="display:inline-block;width:45%;">신청하기</button>
				<button id="back-btn" class="btn button2" style="display:inline-block;width:45%;">뒤로가기</button>
			</div>
		</div>
	</div>

<tiles:insertAttribute name="footer" />