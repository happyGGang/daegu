<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/resources/common/css/hb_common.css"/>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {

	$('input#teacher_birth').datepicker({
		yearRange: 'c-90:c',
		maxDate:0,
		onClose: function(selectedDate){
// 			$('input#human_book_title').focus();
		}
	});

	$('.findPostCode').on('click', function(e){
		e.preventDefault();
		var zipcodeInput 	= $(this).attr('keyValue1');
		var addressInput 	= $(this).attr('keyValue2');
		var focusInput 		= $(this).attr('keyValue2');
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

	// 휴먼북 등록
	$('a#board_save_btn').on('click', function(e) {
		e.preventDefault();

		if ($('input#reqHumanBookPrivacy:checked').val() != '1') {
			alert('개인정보 수집 이용에 동의 후 신청 가능합니다.');
			$('input#reqHumanBookPrivacy').focus();
			return false;
		}

		jQuery.ajaxSettings.traditional = true;
		var file = $('input#mFile');
		if(file.val() == '') {
			$('input#mFile').remove();
		}

		var teacher_phone = $('input#cell_phone1').val() + '-' + $('input#cell_phone2').val() + '-' + $('input#cell_phone3').val();
		$('input#teacher_phone').val(teacher_phone);

		var option = {
			url : 'save.do',
			type : 'POST',
			success : function(response) {
				if(response.valid) {
					alert(response.message);
					doGetLoad(response.url, response.data);
				} else {
					$('td.realFile').append(file);
					if ( response.message != null ) {
						alert(response.message);
					} else {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				$('td.realFile').append(file);
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
			}
		}

		$('form#humanBook').ajaxSubmit(option);
	});

	$('a#humanbook-req-cancel').on('click', function(e) {
		e.preventDefault();
		history.go(-1);
	});

});
</script>
<style>
	.Gnb .mask{margin-top:-10px;}
</style>

<form:form modelAttribute="humanBook" action="save.do" method="post" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>


	<h4>개인정보 수집 및 이용 동의</h4>
	<div class="Box">
		<ul class="con2">
			<li>「개인정보보호법」제15조(개인정보의 수집·이용)에 의거하여 본인의 개인정보 및 사진의 온라인 공개 등에 활용되는 것에 동의합니다.</li>
			<li> 개인정보는 귀하가 휴먼북 활동을 포기하거나 본 사업이 종료된 후에는 파기됩니다.</li>
			<li> 귀하께서는 개인정보 수집·이용에 대해서 동의를 거부하실 권리가 있습니다. 다만 거부하실 경우 휴먼북 선정에 불이익이 발생할 수 있음을 알려드립니다.</li>
			<li> 위 사항을 충분히 숙지하였으며, 개인정보를 수집·이용하는 것에 동의하시겠습니까?</li>
		</ul>
	</div>

	<div class="agree_codes">
		<input id="reqHumanBookPrivacy" name="reqHumanBookPrivacy" type="checkbox" value="1"/>
		<label for="reqHumanBookPrivacy">개인정보 수집 및 이용에 동의 합니다.</label>
	</div>

	<table class="edit" style="margin-top:23px;">
		<tbody>

			<tr>
					<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="teacher_name" value="${member.member_name}"/>
						${member.member_name}
					</td>
				</tr>
				<tr>
					<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="teacher_birth" class="text ui-calendar" cssStyle="width: 105px;" readonly="true"/></td>
				</tr>
				<tr>
					<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:radiobutton path="teacher_gender" value="Y" label="남" checked="true" class="new_input_btn01"/>&nbsp;
						<form:radiobutton path="teacher_gender" value="N" label="여" class="new_input_btn01"/>
					</td>
				</tr>
				<tr>
					<th>메일</th>
					<td><form:input path="teacher_email" class="text" cssStyle="width:50%" /></td>
				</tr>
				<tr>
					<th>휴대폰번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:hidden path="teacher_phone" class="text" maxlength="13"/>
						<c:set var="phone_arr" value="${fn:split(humanBook.teacher_phone, '-')}"/>
						<input id="cell_phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${phone_arr[0]}"/> -
						<input id="cell_phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phone_arr[1]}"/> -
						<input id="cell_phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phone_arr[2]}"/>
						<div class="ui-state-highlight">
							<em>* ex) 010-1234-5678</em>
						</div>
					</td>
				</tr>
				<tr>
					<th>소속(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:input path="teacher_agency" class="text"/>
					</td>
				</tr>
				<tr>
					<th>우편번호(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="teacher_zipcode" class="text" maxlength="15"/> <button class="btn btn2 findPostCode" keyValue1="#teacher_zipcode" keyValue2="#teacher_address">우편번호 찾기</button></td>
				</tr>
				<tr>
					<th>주소(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="teacher_address" class="text" cssStyle="width: 100%;" /></td>
				</tr>
				<tr>
					<th>활동분야(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:select path="activity_category" cssClass="new_select_box">
							<form:options items="${activityCateList}" itemLabel="code_name" itemValue="code_id"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th>활동가능요일(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:checkbox path="activity_day" label="일" value="1" checked="${fn:contains(humanBook.activity_day, '1') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="월" value="2" checked="${fn:contains(humanBook.activity_day, '2') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="화" value="3" checked="${fn:contains(humanBook.activity_day, '3') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="수" value="4" checked="${fn:contains(humanBook.activity_day, '4') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="목" value="5" checked="${fn:contains(humanBook.activity_day, '5') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="금" value="6" checked="${fn:contains(humanBook.activity_day, '6') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_day" label="토" value="7" checked="${fn:contains(humanBook.activity_day, '7') ? 'checked' : ''}" class="new_input_btn01" />
					</td>
				</tr>
				<tr>
					<th>활동가능시간(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:checkbox path="activity_time" label="오전(10:00~12:00)" value="1" checked="${fn:contains(humanBook.activity_time, '1') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_time" label="오후(13:00~17:00)" value="2" checked="${fn:contains(humanBook.activity_time, '2') ? 'checked' : ''}" class="new_input_btn01" />
						<form:checkbox path="activity_time" label="상시" value="3" checked="${fn:contains(humanBook.activity_time, '3') ? 'checked' : ''}" class="new_input_btn01" />
						<form:input path="activity_time_txt" cssClass="text" cssStyle="width: 130px;" />
					</td>
				</tr>
				<tr>
					<th>휴먼북 제목(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td><form:input path="human_book_title" class="text" cssStyle="width: 100%;"/></td>
				</tr>
				<tr>
					<th>본인소개(주요경력 및 활동내역)(<span style="color: red; font-weight: bold;">*</span>)</th>
					<td>
						<form:textarea path="teacher_content" class="text" cssClass="new_textarea01" />
					</td>
				</tr>
				<tr>
					<th>휴먼북 내용</th>
					<td>
						<form:textarea path="human_book_content" class="text" cssClass="new_textarea01" />
					</td>
				</tr>
				<tr>
					<th>사진등록</th>
					<td class="realFile">
						<input type="file" id="mFile" name="mFile" />
					</td>
				</tr>

		</tbody>
	</table>


	<div class="" style="text-align:center;padding-top:10px;">
		<a href="#" id="board_save_btn" class="btn btn1">신청</a>
		<a href="#" id="humanbook-req-cancel" class="btn">취소</a>
	</div>

</form:form>