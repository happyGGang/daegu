<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	if($('input:radio[id=minor]').is(':checked')){
		$('#hide1').show();
		$('#hide2').show();
		$('#hide3').show();
		$('#hide4').show();
	} else {
		$('#hide1').hide();
		$('#hide2').hide();
		$('#hide3').hide();
		$('#hide4').hide();
	}
});

function showDisplay(){
    if($('input:radio[id=minor]').is(':checked')){
    	$('#hide1').show();
		$('#hide2').show();
		$('#hide3').show();
		$('#hide4').show();
    }
}

function hideDisplay(){
	$('#hide1').hide();
	$('#hide2').hide();
	$('#hide3').hide();
	$('#hide4').hide();
}

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

	if('${mediaFactoryApply.applicant_tel}' == '') {
		$('#applicant_tel_1').val("010");
	} else {
		var applicant_tel = '${mediaFactoryApply.applicant_tel}'.split('-');
		$('#applicant_tel_1').val(applicant_tel[0]);
		$('#applicant_tel_2').val(applicant_tel[1]);
		$('#applicant_tel_3').val(applicant_tel[2]);
	}

	if('${mediaFactoryApply.guide_tel}' == '') {
		$('#guide_tel_1').val("010");
	} else {
		var guide_tel = '${mediaFactoryApply.guide_tel}'.split('-');
		$('#guide_tel_1').val(guide_tel[0]);
		$('#guide_tel_2').val(guide_tel[1]);
		$('#guide_tel_3').val(guide_tel[2]);
	}

	if('${mediaFactoryApply.protector_tel}' == '') {
		$('#protector_tel_1').val("010");
	} else {
		var protector_tel = '${mediaFactoryApply.protector_tel}'.split('-');
		$('#protector_tel_1').val(protector_tel[0]);
		$('#protector_tel_2').val(protector_tel[1]);
		$('#protector_tel_3').val(protector_tel[2]);
	}

	$('a.idCheck').on('click', function(e) {
		if($('#apply_edit #applicant_member_id').val() == '') {
			alert('신청자ID를 입력하세요.');
			$('#apply_edit #applicant_member_id').focus();
			return false;
		}
		
		$('#apply_edit #applicant_name').val("");
		$.get('/cms/module/mediaFactory/apply/checkId.do?homepage_id=' + $('#homepage_id').val() + '&applicant_member_id='+ $('#applicant_member_id').val() + '&search_api_type=' + $('#search_api_type').val(), function(response) {
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
<form:form modelAttribute="mediaFactoryApply" id="apply_edit" action="/cms/module/mediaFactory/apply/save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="apply_idx"/>
<form:hidden path="use_time"/>
<form:hidden path="start_time" value="${mediaFactoryApply.start_time }"/>
<form:hidden path="end_time" value="${mediaFactoryApply.end_time }"/>
<form:hidden path="mediaFactory_idx" value="${mediaFactoryApply.mediaFactory_idx }"/>
<form:hidden path="start_date" value="${mediaFactoryApply.start_date }"/>
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
         			<c:when test="${mediaFactoryApply.editMode eq 'ADD' }">
         				<form:hidden path="search_api_type" value="WEBID"/>
         				<form:input path="applicant_member_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>
         			</c:when>
         			<c:otherwise>
         				${mediaFactoryApply.applicant_member_id}
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
		<c:choose>
		<c:when test="${mediaFactoryApply.homepage_id ne 'h50'}">
			<tr>
				<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="age" value="성인" id="adult" onchange="hideDisplay()"/>만18세 이상
					<form:radiobutton path="age" value="미성년자" id="minor" onchange="showDisplay()"/>만18 이하
				</td>
			</tr>
			<tr id="hide1">
				<th>보호자 동의서(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					본 법정대리인(또는 보호자)은 다음사항을 확인합니다.<br/>
					① 본인은 「미디어팩토리」 운영지침을 숙지하셨습니다.<br/>
					② 본인은 상기 미성년자 또는 외국인이 「미디어팩토리」의 시설 및 장비를 대여함에 동의합니다.<br/>
					③ 본인은 상기 미성년자 또는 외국인이 「미디어팩토리」의 시설 및 장비를 이용함에 있어서 모든 책임이<br/>
					&nbsp;&nbsp;&nbsp; 본인에게 있음을 확인합니다.<br>
					<p style="color:red;">※ 초등학생 이하는 반드시 보호자가 함께 입실하여야 합니다.</p>
					<div style="text-align: right; margin-bottom: 5px;">
						<c:out value="${today}" /> 보호자 : <form:input path="protector_name" class="text" cssStyle="width:80px"/>
					</div>
				</td>
			</tr>
			<tr id="hide2">
				<th>신청인과의 관계(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="protector_relation">
						<form:option value="1">부모</form:option>
						<form:option value="2">교사</form:option>
					</form:select>
				</td>
			</tr>
			<tr id="hide3">
				<th>보호자 주소(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="protector_address" class="text" cssStyle="width:250px"/>
					<button class="btn btn2 findPostCode" keyValue1="#protector_zipcode" keyValue2="#protector_address" keyValue3="#age">주소 찾기</button>
				</td>
			</tr>
			<tr id="hide4">
				<th>보호자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="protector_tel"/>
					<form:input path="protector_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
					<form:input path="protector_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
					<form:input path="protector_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
				</td>
			</tr>
			<tr>
				<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="personnel">
						<form:option value="1">1</form:option>
						<form:option value="2">2</form:option>
						<form:option value="3">3</form:option>
						<form:option value="4">4</form:option>
					</form:select> *최대 4명까지 가능합니다.
				</td>
			</tr>
			<tr>
				<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="age" class="text" cssStyle="width:50px" />
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td><form:input path="personnel" class="text" cssStyle="width:50px" maxlength="3" numberOnly="true"/> *숫자만 입력가능합니다.</td>
			</tr>
		</c:otherwise>
		</c:choose>
		<tr>
			<th>개인정보 동의 여부</th>
			<td>
				<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 100px">
					<form:option value="Y" label="동의"/>
					<form:option value="N" label="미동의"/>
				</form:select>
			</td>
		</tr>
		<c:choose>
			<c:when test="${mediaFactoryApply.homepage_id ne 'h50'}">
				<tr>
					<th>비고</th>
					<td>
						<form:input path="remarks" class="text" cssStyle="width:90%"/>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th>이용목적</th>
					<td>
						<form:input path="remarks" class="text" cssStyle="width:90%"/>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>

	</tbody>
</table>
</form:form>