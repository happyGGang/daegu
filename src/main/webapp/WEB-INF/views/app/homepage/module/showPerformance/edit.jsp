<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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

	$('#save-btn').on('click', function() {
		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}
		
		$('#applicant_tel').val($('#applicant_tel_1').val()+'-'+$('#applicant_tel_2').val()+'-'+$('#applicant_tel_3').val());
		$('#agency_tel').val($('#agency_tel_1').val()+'-'+$('#agency_tel_2').val()+'-'+$('#agency_tel_3').val());
		$.ajax({
			url : '/${homepage.context_path}/module/showPerformance/save.do',
			async : false,
			data : serializeObject($('#showPerformanceEdit')),
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
						$('#tabCon2').load('module/showPerformance/index.do?pageType=ajax');
					} else {
						doGetLoad('/${homepage.context_path}/module/showPerformance/index.do', '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val());
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
	
	$(function(){
		
		$('input.num_only').on('keyup',function(){
		          var cnt = $("input.num_sum").length;     
		          console.log(cnt);
		          
		  for( var i=1; i< cnt; i++){
		     var sum = parseInt($(this).val() || 0 );
		     sum++
		    console.log(sum);
		  }
		            var sum1 = parseInt($("#zero").val() || 0 ); // input 값을 가져오며 계산하지만 값이 없을경우 0이 대입된다  뒷부분에 ( || 0 ) 없을경우 합계에 오류가 생겨 NaN 값이 떨어진다
		            var sum2 = parseInt($("#one").val() || 0);
		            var sum3 = parseInt($("#two").val() || 0);
		            var sum4 = parseInt($("#three").val() || 0);
		            var sum5 = parseInt($("#four").val() || 0);
		            var sum6 = parseInt($("#five").val() || 0);
		            var sum7 = parseInt($("#six").val() || 0);
		            var sum8 = parseInt($("#seven").val() || 0);
		
		            var sum = sum1 + sum2 + sum3 + sum4 + sum5 + sum6 + sum7 + sum8;
		            console.log(sum);
		            $("#total").val(sum);
		        });
		});
	

	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/showPerformance/index.do';
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

<form:form modelAttribute="showApply" id="showPerformanceEdit" action="/${homepage.context_path}/module/showPerformance/save.do" method="post" onsubmit="return false;">
<div style="text-align: right"><b>이용약관 및 개인정보의 수집·이용 동의 여부</b>(<span style="color: red; font-weight: bold;">*</span>)
	<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 70px">
		<form:option value="Y" label="동의"/>
		<form:option value="N" label="미동의"/>
	</form:select>
</div>
<br/>
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="apply_idx"/>
<form:hidden path="showPerformance_idx" value="${showApply.showPerformance_idx }"/>
<form:hidden path="start_date" value="${showApply.start_date}"/>
<form:hidden path="menu_idx"/>
<form:hidden path="apply_id"/>
<form:hidden path="add_id"/>
<form:hidden path="pageType"/>
<form:hidden path="date_type"/>
<form:hidden path="member_check"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div style="text-align: right">
	(<span style="color: red; font-weight: bold;">*</span>) 필수 항목 입니다.
</div>

<table class="type1">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>공연 목록(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<c:choose>
					<c:when test="${showPerformance.editMode eq 'ADD'}">
						<form:select path="code_name" class="selectmenu">
							<form:options items="${dateTypeList}" itemValue="code_name" itemLabel="code_name"/>
						</form:select>	
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${dateTypeList}">
							<c:if test="${i.code_id eq showPerformance.date_type}">${i.code_name}</c:if>
						</c:forEach>
						<form:hidden path="code_name"/>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:choose>
		<c:when test="${showApply.member_check eq 'y' }">
		<tr>
			<th>신청자 성명</th>
			<td>
				<form:hidden path="applicant_name" value="${member.member_name}"/>
				${member.member_name}
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<tr>
			<th>신청자 성명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="applicant_name"/>
			</td>
		</tr>
		<tr>
			<th>비밀번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:password path="password"/>
				<div class="ui-state-highlight">
							* 비회원으로 공연신청 시 [수강신청]화면-'비회원 신청 확인'에서 공연신청 내역 확인가능
				</div>
			</td>
		</tr>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${showApply.member_check eq 'y' }">
		<tr>
			<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:hidden path="applicant_tel"/>
				<form:input path="applicant_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="3" readonly="true" numberonly="true" value="${member.cell_phone1}"/> -
				<form:input path="applicant_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" readonly="true" numberonly="true" value="${member.cell_phone2}"/> -
				<form:input path="applicant_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" readonly="true" numberonly="true" value="${member.cell_phone3}"/>
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<tr>
			<th>신청자 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="applicant_tel_1" cssClass="width:40px;">
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
		</c:otherwise>
		</c:choose>
		<tr>
			<th>신청자 이메일</th>
			<td>
				<form:input path="applicant_email" class="text" cssStyle="width:200px"/>
			</td>
		</tr>
		<tr>
			<th>신청 기관명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="agency_name" class="text" cssStyle="width:250px" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>신청기관 전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:hidden path="agency_tel"/>
				<form:input path="agency_tel_1" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
				<form:input path="agency_tel_2" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/> -
				<form:input path="agency_tel_3" cssStyle="width:40px;" cssClass="text" maxlength="4" numberonly="true"/>
			</td>
		</tr>
		<tr>
			<th>신청기관 주소(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="agency_address" class="text" cssStyle="width:250px"/><button class="btn btn2 findPostCode" keyValue1="#applicant_zipcode" keyValue2="#agency_address" keyValue3="#age">주소 찾기</button>
			</td>
		</tr>
		<tr>
			<th>관람인원(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>총인원<form:input path="total_peple" type="text"  class="form-control num_only num_comma num_sum" id="total" name="total" cssStyle="width:50px" readonly="true"/>명<br>
				(0세<form:input path="age_zero" type="text" 	class="form-control num_only num_comma num_sum"	id="zero" name="zero" cssStyle="width:25px" maxlength="2"/>명/
				1세<form:input path="age_one" type="text" 	class="form-control num_only num_comma num_sum"	id="one" name="one" cssStyle="width:25px" maxlength="2"/>명/
				2세<form:input path="age_two" type="text" 	class="form-control num_only num_comma num_sum"	id="two" name="two" cssStyle="width:25px" maxlength="2"/>명/
				3세<form:input path="age_three" type="text" 	class="form-control num_only num_comma num_sum"	id="three" name="three" cssStyle="width:25px" maxlength="2"/>명/
				4세<form:input path="age_four" type="text" 	class="form-control num_only num_comma num_sum"	id="four" name="four" cssStyle="width:25px" maxlength="2"/>명/
				5세<form:input path="age_five" type="text" 	class="form-control num_only num_comma num_sum"	id="five" name="five" cssStyle="width:25px" maxlength="2"/>명/
				6세<form:input path="age_six" type="text" 	class="form-control num_only num_comma num_sum"	id="six" name="six" cssStyle="width:25px" maxlength="2"/>명/
				7세<form:input path="age_seven" type="text"	class="form-control num_only num_comma num_sum"	id="seven" name="seven" cssStyle="width:25px" maxlength="2"/>명)
			 </td>
		</tr>
		<tr>
			<th>비고</th>
			<td>
				<form:input path="remarks" class="text" cssStyle="width:80%"/><br />
			</td>
		</tr>
	</tbody>
</table>

</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
