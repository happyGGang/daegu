<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					var $form = {};
					$form = $.extend(true, $form, $('#studentForm'));
					$form.find('input[name="student_sex"]').prop('disabled', false);
					$form.find("#student_birth").prop('disabled', false);

					var studendHack = $form.find('#student_hack').val() > 0 ? $form.find('#student_hack').val() : 0;
					$form.find('#student_hack').val(studendHack);

					var selectedYear = $form.find('#student_birth').val().split('-')[0];
					var currentYear = new Date().getUTCFullYear();
					$form.find('#student_old').val((currentYear - selectedYear) + 1);

					var cellPhone1 = $form.find('#applicant_cell_phone_1').val();
					if ( cellPhone1 == '' ) {
						alert('휴대전화번호를 입력해주세요.');
						return false;
					}
					var cellPhone2 = $form.find('#applicant_cell_phone_2').val();
					if ( cellPhone2 == '' ) {
						alert('휴대전화번호를 입력해주세요.');
						return false;
					}
					var cellPhone3 = $form.find('#applicant_cell_phone_3').val();
					if ( cellPhone3 == '' ) {
						alert('휴대전화번호를 입력해주세요.');
						return false;
					}

					$form.find('#applicant_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);

					<c:if test="${teach.family_yn eq 'Y'}">
					cellPhone1 = $form.find('#family_cell_phone_1').val();
					cellPhone2 = $form.find('#family_cell_phone_2').val();
					cellPhone3 = $form.find('#family_cell_phone_3').val();
					$form.find('#family_cell_phone').val(cellPhone1+'-'+cellPhone2+'-'+cellPhone3);
					</c:if>

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

	$('[name="self_yn"]').change(function() {
		if ( $(this).is(':checked') ) {
			$('#student_name').val($('#applicant_name').val());
			$('#student_name').prop('readonly', true);
			$('#student_birth').val($('#applicant_birth').val());
			$("#student_birth").datepicker('disable');
			$('[name="student_sex"].'+$('[name="applicant_sex"]:checked').val()).prop('checked', true);
			$('[name="student_sex"]').prop('disabled', true);
			$('#student_zipcode').val($('#applicant_zipcode').val());
			$('#student_zipcode').prop('readonly', true);
			$('#student_address').val($('#applicant_address').val());
			$('#student_address').prop('readonly', true);
			$('#student_address_detail').val($('#applicant_address_detail').val());
			$('#student_address_detail').prop('readonly', true);
			$('button.student_zipcode').hide();
		}
		else {
			$('#student_name').prop('readonly', false);
			$('#student_name').val('');
			$("#student_birth").datepicker('enable');
			$('#student_birth').val('');
			$('[name="student_sex"]').prop('disabled', false);
			$('#student_zipcode').prop('readonly', false);
			$('#student_zipcode').val('');
			$('#student_address').prop('readonly', false);
			$('#student_address').val('');
			$('#student_address_detail').prop('readonly', false);
			$('#student_address_detail').val('');
			$('button.student_zipcode').show();
		}
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

	$('a.idCheck').on('click', function(e) {
		$('#studentForm #member_key').val('');
		$('#studentForm #applicant_name').val('');
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
		onClose: function(selectedDate){
			$('input#applicant_zipcode').focus();
		}
	});

	$('input#student_birth').datepicker({
		yearRange: 'c-70:c',
		maxDate:0,
		onClose: function(selectedDate){
			$('input#student_zipcode').focus();
		}
	});

	try {

	var applicant_cell_phone_temp = '${student.applicant_cell_phone}'.split('-');
	$('input#applicant_cell_phone_1').val(applicant_cell_phone_temp[0]);
	$('input#applicant_cell_phone_2').val(applicant_cell_phone_temp[1]);
	$('input#applicant_cell_phone_3').val(applicant_cell_phone_temp[2]);

	var family_cell_phone_temp = '${student.family_cell_phone}'.split('-');
	$('input#family_cell_phone_1').val(family_cell_phone_temp[0]);
	$('input#family_cell_phone_2').val(family_cell_phone_temp[1]);
	$('input#family_cell_phone_3').val(family_cell_phone_temp[2]);

	} catch (e) {

	}

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
	         	<th>신청자 - ID(<span style="color: red; font-weight: bold;">*</span>)</th>
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
	         	<th>신청자 - 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="applicant_name" class="text" /></td>
        	</tr>
        	<tr>
	         	<th>신청자 - 생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="applicant_birth" class="text ui-calendar"/></td>
        	</tr>
        	<tr>
	         	<th>신청자 - 성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="as1" path="applicant_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
	         		<form:radiobutton id="as2" path="applicant_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
         		</td>
	        </tr>
	        <tr>
	         	<th>신청자 - 우편번호</th>
	         	<td><form:input path="applicant_zipcode" class="text" readonly="true" cssStyle="width: 15%;"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#applicant_address" keyValue3="#applicant_address">우편번호 찾기</button></td>
        	</tr>
	        <tr>
	         	<th>신청자 - 주소</th>
	         	<td>
	         		<form:input path="applicant_address" class="text" style="width:100%;" maxlength="60"/><br/>
         		</td>
        	</tr>
			<tr>
				<th>신청자 - 휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
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
				<th>수강생 동일여부</th>
	        	<td>
	        		<form:checkbox path="self_yn" value="Y" label="신청자 정보와 동일" cssStyle="vertical-align: middle;"/>
	      		</td>
			</tr>
			<tr>
	         	<th>수강생 - 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_name" class="text" /></td>
        	</tr>
        	<tr>
	         	<th>수강생 - 생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="student_birth" class="text ui-calendar" /></td>
        	</tr>
        	<tr>
	         	<th>수강생 - 성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="ss1" path="student_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;"/>
	         		<form:radiobutton id="ss2" path="student_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;"/>
         		</td>
	        </tr>
        	<tr style="display: none">
	         	<th >수강생 - 나이(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><input id="student_old" name="student_old" class="text" style="width:30px" maxlength="3" /></td>
        	</tr>
	        <tr>
	         	<th>수강생 - 우편번호</th>
	         	<td><form:input path="student_zipcode" class="text" readonly="true" cssStyle="width: 15%;"/><button class="btn btn2 findPostCode student_zipcode" keyValue1="#student_zipcode" keyValue2="#student_address" keyValue3="#student_address">우편번호 찾기</button></td>
        	</tr>
	        <tr>
	         	<th>수강생 - 주소</th>
	         	<td>
	         		<form:input path="student_address" class="text" style="width:100%;" maxlength="60"/><br/>
	         	</td>
        	</tr>
			<tr>
	         	<th>개인정보 동의 여부(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${student.editMode eq 'ADD' }">
			         		<form:select path="self_info_yn" class="selectmenu">
								<form:option value="Y" label="동의"/>
								<form:option value="N" label="미동의"/>
							</form:select>
	         			</c:when>
	         			<c:otherwise>
	         				${student.self_info_yn eq 'Y' ? '동의' : '미동의'}
	         			</c:otherwise>
	         		</c:choose>

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
			<c:if test="${teach.family_yn eq 'Y'}">
				<tr>
					<th>보호자 관계</th>
					<td><form:input path="family_relation" cssClass="text"/></td>
				</tr>
				<tr>
					<th>보호자 이름</th>
					<td><form:input path="family_name" cssClass="text"/></td>
				</tr>
				<tr>
					<th>보호자연락처</th>
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
				<tr>
					<th>보호자 동의여부</th>
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
			</c:if>
			<c:if test="${teach.family_count_yn eq 'Y'}">
				<tr>
					<th>가족 인원 수</th>
					<td><form:input path="student_family_count" cssClass="text" numberOnly="true"/></td>
				</tr>
			</c:if>
        	<c:if test="${teach.school_info_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 학교</th>
	         	<td><form:input path="student_school" class="text" cssStyle="width:250px;" /></td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.school_grade_yn eq 'Y'}">
        	<tr>
	         	<th>수강생 - 학년</th>
	         	<td>
	         		<form:select path="student_hack" cssClass="selectmenu" cssStyle="width:120px;" items="${hakList}" itemValue="code_id" itemLabel="code_name">
	         		</form:select>
	         	</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.remark_yn eq 'Y'}">
				<tr>
					<th>수강생 - 비고</th>
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
		</tbody>
	</table>
</form:form>