<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
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
		
		$('a#back-btn').on('click', function(e) {
			e.preventDefault();
			location.href = '/${homepage.context_path}/module/marathonApplicant/index.do?menu_idx=106';
		});
		
		$('a#printCompleteDocument').on('click', function(e) {
			var url = 'certificate.do?';
			/* $('#studentListForm input#student_idx').val($(this).attr('keyValue'));
			$('#dialog-2').load('certificate.do?'+$('#studentListForm').serialize(), function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			}); */
			
			$('#dialog-2').load('certificate.do?homepage_id=${marathonApplicant.homepage_id}&contest_idx=${marathonApplicant.contest_idx}&contest_type_idx=${marathonApplicant.contest_type_idx}&applicant_idx=${marathonApplicant.applicant_idx}', function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			})

			e.preventDefault();
		});
		
		$('input#address_writeDong').val($('select#address_dong option:checked').text());
		
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
		
		$('a#save-btn').on('click', function(e) {
			e.preventDefault();
			<c:if test="${marathonApplicant.age_type ne 'adult'}">
				if($('input#school_name').val() == '') {
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
			</c:if>
			
			if($('select#address_dong').val() == '' && $('input#address_writeDong').val() == ''){
				alert('동(행정동)을 입력해 주세요.');
				$('select#address_dong').focus();
				return false;
			}
			if($('select#address_dong').val() == 'write' && $('input#address_writeDong').val() == '') {
				alert('동(행정동)을 입력해 주세요.');
				$('input#address_writeDong').focus();
				return false;
			}
			if($('select#address_dong').val() == 'write' && $('input#address_writeDong').val() != ''){
				$('select#address_dong').append('<option value=' + $('input#address_writeDong').val() + ' selected="selected"></option>');
				$('select#address_dong option[value = "write"]').remove();
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
			if($('input#address_two').val() == '') {
				alert('주소를 입력해 주세요.');
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
			if($('input#telephone_two').val().length < 3) {
				alert('전화번호 중간자리는 3자리 이상을 입력해 주세요.');
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
			if($('input#telephone_three').val().length < 4) {
				alert('전화번호 끝자리는 4자리를 입력해 주세요.');
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
			if($('input#cellphone_two').val().length < 3) {
				alert('휴대전화번호 중간자리는 3자리 이상을 입력해 주세요.');
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
			if($('input#cellphone_three').val().length < 4) {
				alert('휴대전화번호 끝자리는 4자리를 입력해 주세요.');
				$('input#cellphone_three').focus();
				return false;
			}
			var regexp = /^[0-9]/g;
			if(!regexp.test($('input#cellphone_three').val())){
				alert('휴대전화번호에는 숫자만 입력해 주세요.');
				$('input#cellphone_three').focus();
				return false;
			}
			
			$('input#editMode').val('MODIFY');
			doAjaxPost($('form#marathonApplicant'));
		});
	});
</script>
<style>
span.text2{font-style: normal;color: #888;font-size: 90%;margin: 0 5px;}
</style>
<form:form modelAttribute="marathonApplicant" method="POST" action="save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="contest_idx"/>
<form:hidden path="contest_type_idx"/>
<form:hidden path="applicant_idx"/>
<form:hidden path="age_type"/>
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청일</th>
			<td><fmt:formatDate value="${marathonApplicant.add_date}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<th>달성율</th>
			<td style="text-align:left;">
				<fmt:formatNumber value="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) * 100}" pattern="##.##"/>%
				<c:if test="${marathonApplicant.process_status eq 1}">
					<a href="#" class="btn btn1" id="printCompleteDocument">완주증서 출력</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${marathonApplicant.member_id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${marathonApplicant.member_name}</td>
		</tr>
		<c:if test="${marathonApplicant.age_type ne 'adult'}">
		<tr>
			<th>학교</th>
			<td>
				<form:input path="school_name" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>학년</th>
			<td>
				<form:input path="school_class_one" cssClass="text" size="4"/>학년
				<form:input path="school_class_two" cssClass="text" size="4"/>반
			</td>
		</tr>
		</c:if>
		<tr>
			<th>주소</th>
			<td>
				<div style="margin-bottom:1%;">
					<form:select path="address_dong" cssClass="selectmenu">
						<form:option value="">동 선택</form:option>
						<form:options items="${dongList}" itemLabel="code_name" itemValue="code_id"/>
						<form:option value="write">기타 직접 입력</form:option>
					</form:select>
					<input type="text" id="address_writeDong" class="text" size="6" readonly="true"/><span class="text2"> *동명을 입력해 주세요.    ※참가자격: 달서구민 및 달서구 소재 학교 재학생</span><br/>
				</div>
				<a href="" id="findPostCode" class="btn" style="background:#fff;font-size:14px;padding:5px 3px;">우편번호찾기</a><form:input path="zipcode" cssClass="text" cssStyle="width:80px;" maxLength="5"/><span class="text2"> *우편번호(숫자5자리)</span><br/>
				<form:input path="address_one" size="40" cssClass="text" style="margin-top:0.5px;"/><span class="text2"> *시도 + 시군구 + 도로명(50자리 이내로 입력해 주세요.)</span><br/>
				<form:input path="address_two" size="40" cssClass="text" style="margin-top:0.5px"/><span class="text2"> *건물번호 + 동·층·호 + (법정동,공동주택명)(50자리 이내로 입력해 주세요.)</span>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<form:input path="telephone_one" cssClass="text" size="4" maxlength="3"/>-<form:input path="telephone_two" cssClass="text" size="4" maxlength="4"/>-<form:input path="telephone_three" cssClass="text" size="4" maxlength="4"/>
				<span class="text2">*숫자만 입력해 주세요.</span>
			</td>
		</tr>
		<tr>
			<th>휴대전화번호</th>
			<td>
				<form:input path="cellphone_one" cssClass="text" size="4" maxlength="3"/>-<form:input path="cellphone_two" cssClass="text" size="4" maxlength="4"/>-<form:input path="cellphone_three" cssClass="text" size="4" maxlength="4"/>
				<span class="text2">*숫자만 입력해 주세요.</span>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				${marathonApplicant.email}
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				${marathonApplicant.gender == 'M' ? '남' : '여'}
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				${marathonApplicant.birthday}
			</td>
		</tr>
		<tr>
			<th>참가부문</th>
			<td>
				${marathonApplicant.contest_type} (${marathonApplicant.page_count}쪽)
			</td>
		</tr>
		<tr>
			<th>완주기념품</th>
			<td>
				${marathonApplicant.finish_memorial == 'document' ? '완주증서' : '완주메달'}
			</td>
		</tr>
		<tr>
			<th>각오한마디</th>
			<td>
				${marathonApplicant.determination_talk}
			</td>
		</tr>
	</tbody>
</table>
<br/>
<div class="button bbs-btn right">
	<a href="#" class="btn btn1 write" id="save-btn"><i class="fa fa-pencil"></i><span>저장하기</span></a>
	<a href="#" class="btn" id="back-btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>
</form:form>

<div id="dialog-2" class="dialog-common" title="완주증서">
</div>