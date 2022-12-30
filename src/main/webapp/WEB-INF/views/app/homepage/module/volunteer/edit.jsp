<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	$('.findPostCode').on('click', function(e){
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

	if('${apply.applicant_tel}' == '') {
	} else {
		var applicant_tel = '${apply.applicant_tel}'.split('-');
		$('#applicant_tel_1').val(applicant_tel[0]);
		$('#applicant_tel_2').val(applicant_tel[1]);
		$('#applicant_tel_3').val(applicant_tel[2]);
	}

	if('${apply.protector_tel}' == '') {
	} else {
		var protector_tel = '${apply.protector_tel}'.split('-');
		$('#protector_tel_1').val(protector_tel[0]);
		$('#protector_tel_2').val(protector_tel[1]);
		$('#protector_tel_3').val(protector_tel[2]);
	}

	$('#save-btn').on('click', function() {
		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

		$('#wr_2').on('keyup', function() {
		
		    this.value = this.value.replace(/\D/g, '');
		
		    if (this.value > 4) this.value = 150;
		
		});
		
		
		$('#applicant_tel').val($('#applicant_tel_1').val()+'-'+$('#applicant_tel_2').val()+'-'+$('#applicant_tel_3').val());
		$('#agency_tel').val($('#agency_tel_1').val()+'-'+$('#agency_tel_2').val()+'-'+$('#agency_tel_3').val());
		$('input[type=number]').val;
		$.ajax({
			url : '/${homepage.context_path}/module/volunteer/save.do',
			async : false,
			data : serializeObject($('#volunteerEdit')),
			method : 'POST',
			dataType : 'json',
			success : function(data) {
				if(data.valid) {
	                 if(data.message != null && data.message.replace(/\s/g,'').length!=0) {
	                	 alert(data.message);
	                 }
    				if(data.targetOpener) {
    					window.open(data.url, '', 'width=500,height=510');
    					return false;
    				}
					if($('#pageType').val() == 'ajax') {
						$('#tabCon2').load('module/volunteer/index.do?pageType=ajax');
					} else {
						doGetLoad('/${homepage.context_path}/module/volunteer/index.do', '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val());
					}
				} else {
	   				if(data.targetOpener) {
						window.open(data.url, '', 'width=500,height=510');
						return false;
					}

					if (data.message != null && data.message.replace(/\s/g, '').length != 0) {
						alert(data.message);
					} else {
						for (var i = 0; i < data.result.length; i++) {
							alert(data.result[i].code);
							$('#' + data.result[i].field).focus();
							break;
						}
					}
				}
			}
		});
	});

	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/volunteer/index.do';
		var formData = serializeParameter(['menu_idx', 'date_type']);
		doGetLoad(url, formData);
	});

	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

});
</script>

<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="terms${status.count}" name="agree_codes" type="checkbox" keyValue="${terms.title}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의</label><br>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>

<form:form modelAttribute="apply" id="volunteerEdit" action="/${homepage.context_path}/module/volunteer/save.do" method="post" onsubmit="return false;">
<div style="text-align: right"><b>이용약관 및 개인정보의 수집·이용 동의 여부</b>(<span style="color: red; font-weight: bold;">*</span>)
	<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 75px">
		<form:option value="Y" label="동의"/>
		<form:option value="N" label="미동의"/>
	</form:select>
</div>
<br/>
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="apply_idx"/>
<form:hidden path="volunteer_idx" value="${apply.volunteer_idx }"/>
<form:hidden path="start_date" value="${apply.start_date}"/>
<form:hidden path="menu_idx"/>
<form:hidden path="apply_id"/>
<form:hidden path="pageType"/>
<form:hidden path="date_type"/>
<form:hidden path="start_time"/>
<form:hidden path="end_time"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div style="text-align: right">
	(<span style="color: red; font-weight: bold;">*</span>) 필수 항목 입니다.
</div>

<c:choose>
<c:when test="${homepage.context_path eq 'seobu'}">
<table class="type1">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청자 성명</th>
			<td>
				<form:hidden path="applicant_name" value="${member.member_name}"/>
				${member.member_name}

			</td>
		</tr>
		<tr>
			<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:hidden path="applicant_tel"/>
				<form:input path="applicant_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="3" numberonly="true" value="${fn:substring(member.mobile_no, 0, 3)}"/> -
				<form:input path="applicant_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 3, 7)}"/> -
				<form:input path="applicant_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 7, 11)}"/>
			</td>
		</tr>
		<tr>
			<th>기관명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<input id="agency_name" name="agency_name" style="width:250px" class="text" value="서부도서관" type="text" maxlength="20" readonly/>
			</td>
		</tr>
		<tr>
			<th>기관 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<input id="agency_tel" name="agency_tel" type="hidden" value=""/>
				<input id="agency_tel_1" name="agency_tel_1" class="text" style="width:40px;" numberonly="true" type="text" value="053" maxlength="4" readonly/> -
				<input id="agency_tel_2" name="agency_tel_2" class="text" style="width:40px;" numberonly="true" type="text" value="231" maxlength="4" readonly/> -
				<input id="agency_tel_3" name="agency_tel_3" class="text" style="width:40px;" numberonly="true" type="text" value="2400" maxlength="4" readonly/>
			</td>
		</tr>
		<form:hidden path="age" class="text" cssStyle="width:50px" value="0"/>
		<tr>
			<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td><form:input path="personnel" class="text" cssStyle="width:50px" maxlength="3" numberOnly="true" value='1'/> *숫자만 입력가능하며 신청자  본인만  방문가능합니다.</td>
		</tr>
	</tbody>
</table>
</c:when>
<c:otherwise>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<table class="type1">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
	<c:choose>
		<c:when test="${sessionScope.member.login}">
			<tr>
				<th>신청자 성명</th>
				<td>
					<form:hidden path="applicant_name" value="${member.member_name}"/>
						${member.member_name}
				</td>
			</tr>
			<tr>
				<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="applicant_tel"/>
					<form:input path="applicant_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="3" numberonly="true" value="${member.cell_phone1}"/> -
					<form:input path="applicant_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${member.cell_phone2}"/> -
					<form:input path="applicant_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${member.cell_phone3}"/>
				</td>
			</tr>
			<tr>
				<th>신청자 이메일</th>
				<td>
					<form:input path="applicant_email" class="text" cssStyle="width:200px" value="${member.email}"/>
				</td>
			</tr>
			<c:if test="${homepage.context_path ne 'donggu'}">
				<tr>
					<th> 주소</th>
					<td>
						<form:input path="agency_address" class="text" cssStyle="width:250px"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#agency_address" keyValue3="#age">주소 찾기</button>
					</td>
				</tr>
			</c:if>
			<c:choose>
				<c:when test="${homepage.context_path eq 'wasabi'}">
					<tr>
						<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td>
							<form:radiobutton path="age" value="성인" id="adult" onchange="hideDisplay()" />만 18세 이상
							<form:radiobutton path="age" value="미성년자" id="minor" onchange="showDisplay()"/>만 18세 이하
						</td>
					</tr>
					<tr id="hide1">
						<th>보호자 동의서(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td>
							본 법정대리인(또는 보호자)은 다음사항을 확인합니다.<br/>
							① 본인은 자원봉사신청지침을 숙지하셨습니다.<br/>
							② 본인은 상기 미성년자 또는 외국인이 자원봉사신청에 동의합니다.<br/>
							③ 본인은 상기 미성년자 또는 외국인이 자원봉사활동에 있어서 모든 책임이 본인에게 있음을 확인합니다.<br>
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
				</c:when>
				<c:otherwise>
					<tr>
						<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td>
							<form:input path="age" class="text" cssStyle="width:50px" />
						</td>
					</tr>
					<tr>
						<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td><form:input path="personnel" class="text" cssStyle="width:50px" maxlength="3" numberOnly="true"/> *숫자만 입력가능합니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th>비고</th>
				<td><form:input path="remarks" class="text" cssStyle="width:80%"/> </td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<th>신청자 성명</th>
				<td>
					<form:input path="applicant_name" class="text" cssStyle="width:80%"/>
				</td>
			</tr>
			<tr>
				<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="applicant_tel"/>
					<form:input path="applicant_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="3" numberonly="true" value="${fn:substring(member.mobile_no, 0, 3)}"/> -
					<form:input path="applicant_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 3, 7)}"/> -
					<form:input path="applicant_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 7, 11)}"/>
				</td>
			</tr>
			<tr>
				<th>신청자 이메일</th>
				<td>
					<form:input path="applicant_email" class="text" cssStyle="width:200px"/>
				</td>
			</tr>
			<c:if test="${homepage.context_path ne 'donggu'}">
				<tr>
					<th> 주소</th>
					<td>
						<form:input path="agency_address" class="text" cssStyle="width:250px"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#agency_address" keyValue3="#age">주소 찾기</button>
					</td>
				</tr>
			</c:if>
			<c:choose>
				<c:when test="${homepage.context_path eq 'wasabi'}">
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
				</c:when>
				<c:otherwise>
					<tr>
						<th>연령대(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td>
							<form:input path="age" class="text" cssStyle="width:50px" />
						</td>
					</tr>
					<tr>
						<th>방문인원(<span style="color: red; font-weight: bold;">*</span>)</th>
						<td><form:input path="personnel" class="text" cssStyle="width:50px" maxlength="3" numberOnly="true"/> *숫자만 입력가능합니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th>비고</th>
				<td><form:input path="remarks" class="text" cssStyle="width:80%"/> </td>
			</tr>
		</c:otherwise>
	</c:choose>

	</tbody>
</table>
</c:otherwise>
</c:choose>

</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
