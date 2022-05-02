<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#modify_btn').on('click', function() {

		// 기관 연락처 처리
		if($('#student_organization_tel1').val() != '' && $('#student_organization_tel2').val() != '' && $('#student_organization_tel3').val() != '') {
			$('#student_organization_tel').val($('#student_organization_tel1').val() + '-' + $('#student_organization_tel2').val() + '-' + $('#student_organization_tel3').val());
		}
			if (confirm('신청정보를 수정하시겠습니까?')) {
				$('input#editMode').val('MODIFY');
				doAjaxPost($('form#studentForm'));
			}
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
	<form:hidden path="large_category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="member_key"/>
	<form:hidden path="api_user_id"/>
	<form:hidden path="applicant_name"/>
	<form:hidden path="menu_idx" value="${student.menu_idx }"/>
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
	         			<c:when test="${!empty student.web_id }">
	         				${student.member_id }
	         			</c:when>
	         			<c:otherwise>
	         				비회원
	         			</c:otherwise>
	         		</c:choose>	         	
         		</td>
        	</tr>
			<tr>
	         	<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${student.applicant_name }</td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${student.applicant_birth }</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="as1" path="applicant_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;" disabled="true"/>
	         		<form:radiobutton id="as2" path="applicant_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;" disabled="true"/>
         		</td>
	        </tr>
	        </c:if>
			<tr>
				<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="applicant_cell_phone" cssClass="text"/>
					${student.applicant_cell_phone } 
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
	         	<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${student.student_name }</td>
        	</tr>
        	<c:if test="${teach.birth_yn eq 'Y'}">
        	<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${student.student_birth }</td>
        	</tr>
        	</c:if>
        	<c:if test="${teach.sex_yn eq 'Y'}">
        	<tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton id="ss1" path="student_sex" cssClass="M" value="M" label="남" cssStyle="vertical-align: middle;" disabled="true"/>
	         		<form:radiobutton id="ss2" path="student_sex" cssClass="F" value="F" label="여" cssStyle="vertical-align: middle;" disabled="true"/>
         		</td>
	        </tr>
	        </c:if>
	        <tr>
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="student_cell_phone" cssClass="text"/>
					${student.student_cell_phone }
				</td>
			</tr>
        	<c:if test="${teach.address_yn eq 'Y' }">
	        <tr>
	         	<th>우편번호</th>
	         	<td>${student.student_zipcode }</td>
        	</tr>
	        <tr>
	         	<th>주소(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:hidden path="applicant_address"/>
	         		${student.student_address }<br/>
	         	</td>
        	</tr>
        	</c:if>
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
        	<c:if test="${teach.school_grade_yn eq 'Y'}">
        	<tr>
	         	<th>반</th>
	         	<td><form:input path="student_ban" class="text" cssStyle="width:100px;" /></td>
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
					<th>관계(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>${student.family_relation }</td>
				</tr>
				<tr>
					<th>이름(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>${student.family_name }</td>
				</tr>
				<tr>
					<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="family_cell_phone" cssClass="text"/>
						${student.family_cell_phone }
					</td>
				</tr>
				<tr>
					<th>보호자 비고</th>
					<td>
						<form:input path="family_desc" cssClass="text"/>
					</td>
				</tr>
       		</tbody>
		</table>
	</c:if>
		<div class="arrayArea" style="margin: 30px auto; ">
			<div style="margin:0 auto; width:130px;">
				<a class="btn btn4" id="modify_btn"><span>수정</span></a>
	 			<a href="javascript:history.back();" class="btn btn5" id="modify_cancel"><span>취소</span></a>	 			
 			</div>
		</div>	
</form:form>    