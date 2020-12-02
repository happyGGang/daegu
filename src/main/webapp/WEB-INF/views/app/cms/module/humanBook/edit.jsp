<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
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
		},
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
// 					jQuery.ajaxSettings.traditional = true;
					
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
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
								$('.dialog-common').remove();
								location.reload();
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
					
					$('form#humanBookEdit').ajaxSubmit(option);
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
		width: 700,
		height: 700
	});
	
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
	
	
	
	if($('select#apply_status').val() != '1') {
		$('input#unapproved_reasons').closest('tr').hide();
	}
	$('select#apply_status').on('change', function(e) {
		if($(this).val() == '1') {
			$('input#unapproved_reasons').closest('tr').show();
		} else {
			$('input#unapproved_reasons').closest('tr').hide();
			$('input#unapproved_reasons').val('');
		}
	});
	
});
</script>

<form:form modelAttribute="humanBook" id="humanBookEdit" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="human_book_idx"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>신청상태</th>
				<td>
					<form:select path="apply_status" cssClass="selectmenu">
						<form:option value="0">신청</form:option>
						<form:option value="1">미승인</form:option>
						<form:option value="2">승인</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td><form:input path="teacher_name" class="text" cssStyle="width: 30%" /></td>
			</tr>
			<tr>
				<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td><form:input path="teacher_birth" class="text ui-calendar" cssStyle="width: 105px;" readonly="true"/></td>
			</tr>
			<tr>
				<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="teacher_gender" value="Y" label="남" checked="true"/>&nbsp;
					<form:radiobutton path="teacher_gender" value="N" label="여"/>
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
					<form:select path="activity_category">
						<form:options items="${activityCateList}" itemLabel="code_name" itemValue="code_id"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>활동가능요일(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:checkbox path="activity_day" label="일" value="1" checked="${fn:contains(humanBook.activity_day, '1') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="월" value="2" checked="${fn:contains(humanBook.activity_day, '2') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="화" value="3" checked="${fn:contains(humanBook.activity_day, '3') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="수" value="4" checked="${fn:contains(humanBook.activity_day, '4') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="목" value="5" checked="${fn:contains(humanBook.activity_day, '5') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="금" value="6" checked="${fn:contains(humanBook.activity_day, '6') ? 'checked' : ''}" />
					<form:checkbox path="activity_day" label="토" value="7" checked="${fn:contains(humanBook.activity_day, '7') ? 'checked' : ''}" />
				</td>
			</tr>
			<tr>
				<th>활동가능시간(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:checkbox path="activity_time" label="오전(10:00~12:00)" value="1" checked="${fn:contains(humanBook.activity_time, '1') ? 'checked' : ''}" />
					<form:checkbox path="activity_time" label="오후(13:00~17:00)" value="2" checked="${fn:contains(humanBook.activity_time, '2') ? 'checked' : ''}" />
					<form:checkbox path="activity_time" label="상시" value="3" checked="${fn:contains(humanBook.activity_time, '3') ? 'checked' : ''}" />
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
					<form:textarea path="teacher_content" class="text" cssStyle="width: 100%;height:80px;" />
				</td>
			</tr>
			<tr>
				<th>휴먼북 내용</th>
				<td>
					<form:textarea path="human_book_content" class="text" cssStyle="width: 100%;height:80px;" />
				</td>
			</tr>
			<tr>
				<th>사진등록</th>
				<td class="realFile">
					<input type="file" id="mFile" name="mFile" />
				</td>
			</tr>

			<tr>
				<th>미승인사유</th>
				<td><form:input path="unapproved_reasons" class="text" cssStyle="width: 100%;"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
