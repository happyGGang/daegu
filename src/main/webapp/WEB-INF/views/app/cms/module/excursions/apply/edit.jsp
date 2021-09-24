<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#apply_edit'))) {
						$(this).dialog('destroy');
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
		height: 550
	});

	if('${apply.applicant_tel}' == '') {
		$('#applicant_tel_1').val("010");
	} else {
		var applicant_tel = '${apply.applicant_tel}'.split('-');
		$('#applicant_tel_1').val(applicant_tel[0]);
		$('#applicant_tel_2').val(applicant_tel[1]);
		$('#applicant_tel_3').val(applicant_tel[2]);
	}

	if('${apply.guide_tel}' == '') {
		$('#guide_tel_1').val("010");
	} else {
		var guide_tel = '${apply.guide_tel}'.split('-');
		$('#guide_tel_1').val(guide_tel[0]);
		$('#guide_tel_2').val(guide_tel[1]);
		$('#guide_tel_3').val(guide_tel[2]);
	}

	$('a.idCheck').on('click', function(e) {
		if($('#apply_edit #applicant_member_id').val() == '') {
			alert('신청자ID를 입력하세요.');
			$('#apply_edit #applicant_member_id').focus();
			return false;
		}
		
		$('#apply_edit #applicant_name').val("");
		$.get('/cms/module/excursions/apply/checkId.do?homepage_id=' + $('#homepage_id').val() + '&applicant_member_id='+ $('#applicant_member_id').val() + '&search_api_type=' + $('#search_api_type').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);
			} else {
				$('#apply_edit #applicant_name').val(response.memberInfo[0].NAME);
				var phone = response.memberInfo[0].HANDPHONE.split('-');
				$('#apply_edit #applicant_tel_1').val(phone[0]);
				$('#apply_edit #applicant_tel_2').val(phone[1]);
				$('#apply_edit #applicant_tel_3').val(phone[2]);
			}
		});
		e.preventDefault();
	});

	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

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

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(addressInput).val(fullAddr);
                // 커서를 상세주소 필드로 이동한다.
                $(focusInput).focus();
            }
        }).open();
	});
});
</script>
<form:form modelAttribute="apply" id="apply_edit" action="/cms/module/excursions/apply/save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="apply_idx"/>
<%-- <form:hidden path="member_key"/> --%>
<form:hidden path="excursions_idx" value="${apply.excursions_idx }"/>
<form:hidden path="start_date" value="${apply.start_date }"/>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
         	<th>신청자ID(<span style="color: red; font-weight: bold;">*</span>)</th>
         	<td>
         		<c:choose>
         			<c:when test="${apply.editMode eq 'ADD' }">
         				<form:hidden path="search_api_type" value="WEBID"/>
         				<form:input path="applicant_member_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>
         			</c:when>
         			<c:otherwise>
         				${apply.applicant_member_id}
         				<form:hidden path="applicant_member_id"/>
         			</c:otherwise>
         		</c:choose>
       		</td>
       	</tr>
		<tr>
			<th>신청자 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="applicant_name" class="text" cssStyle="width:100px" readonly="true"/>
			</td>
		</tr>
		<tr>
			<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="applicant_tel_1" cssClass="selectmenu">
					<form:option value="010">010</form:option>
					<form:option value="011">011</form:option>
					<form:option value="016">016</form:option>
					<form:option value="017">017</form:option>
					<form:option value="018">018</form:option>
					<form:option value="019">019</form:option>
				</form:select> -
				<form:input path="applicant_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
				<form:input path="applicant_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
			</td>
		</tr>
		<tr>
			<th>신청자 이메일</th>
			<td>
				<form:input path="applicant_email" class="text" cssStyle="width:200px"/>
			</td>
		</tr>
		<tr>
			<th>기관명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="agency_name" class="text" cssStyle="width:250px" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>기관 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="agency_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
				<form:input path="agency_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
				<form:input path="agency_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
			</td>
		</tr>
		<tr>
			<th>기관 주소</th>
			<td>
				<form:input path="agency_address" class="text" cssStyle="width:60%"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#agency_address" keyValue3="#age">주소 찾기</button>
			</td>
		</tr>
		<tr>
			<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="age" class="text" cssStyle="width:50px"/>
			</td>
		</tr>
		<tr>
			<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td><form:input path="personnel" class="text" cssStyle="width:50px" maxlength="3"/></td>
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
		<tr>
			<th>비고</th>
			<td>
				<form:input path="remarks" class="text" cssStyle="width:90%"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>