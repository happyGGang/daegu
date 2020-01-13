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
					jQuery.ajaxSettings.traditional = true;
					var $file = $('#file');
					if ( $('#file').val() == '' ) {
						$('#file').remove();
					}

					$('#teacher_phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());
					$('#teacher_cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());

					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#teacherForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
				    			location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									$('td.fileTd').append($file);
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				        	 $('td.fileTd').append($file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#teacherForm').ajaxSubmit(option);
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

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 800
	});

	$('a.idCheck').on('click', function(e) {
		$.get('checkId.do?homepage_id=' + $('#homepage_id').val() + '&teacher_id='+ $('#teacher_id').val() + '&search_api_type=' + $('[name="search_api_type"]:checked').val(), function(response) {
			if( response.data.length > 0){

				$('#teacherForm #member_key').val(response.data[0]["REC_KEY"]);
				$('#teacherForm #teacher_name').val(response.data[0]["NAME"]);

				if(response.data[0]["HANDPHONE"] != null){
					var phone = response.data[0]["HANDPHONE"].split("\-");
					$('#teacherForm #cell_phone1').val(phone[0]);
					$('#teacherForm #cell_phone2').val(phone[1]);
					$('#teacherForm #cell_phone3').val(phone[2]);
				}

				if (response.data[0]["HANDPHONE"] == '0') {
					$('input#teacher_sex1').prop('checked', true);
				} else {
					$('input#teacher_sex2').prop('checked', true);
				}

				$('#teacherForm #teacher_address').val(response.data[0]["H_ADDR1"]);
				$('#teacherForm #teacher_zipcode').val(response.data[0]["H_ZIPCODE"]);

				if(response.data[0]["BIRTHDAY"] != null){
					var birthday = response.data[0]["BIRTHDAY"].split("\/");
					$('#teacherForm #teacher_birth').val(birthday[0]+'-'+birthday[1]+'-'+birthday[2]);
				}

			} else {
				alert('검색한 사용자 없습니다.');
			}

		});
		e.preventDefault();
	});

	$('input#teacher_birth').datepicker({
		yearRange: 'c-90:c',
		maxDate:0,
		onClose: function(selectedDate){
			$('input#teacher_subject_name').focus();
		}
	});


});

</script>
<form:form id="teacherForm" modelAttribute="teacher" method="post" action="save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>강사ID</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${teacher.editMode eq 'ADD' }">
	         				<form:input path="teacher_id" class="text" /><a class="btn btn1 idCheck">ID 확인</a>
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_id}
	         			</c:otherwise>
	         		</c:choose>
         		</td>
        	</tr>
			<tr>
	         	<th>강사명 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
		         		<c:when test="${teacher.editMode eq 'ADD' }">
		         			<form:input path="teacher_name" class="text" readonly="true" />
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_name}
	         			</c:otherwise>
         			</c:choose>
         		</td>
        	</tr>
        	<tr>
	         	<th>생년월일</th>
	         	<td>
		         	<c:choose>
		         		<c:when test="${teacher.editMode eq 'ADD' }">
	         				<form:input path="teacher_birth" class="text ui-calendar"/>
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_birth}
	         			</c:otherwise>
         			</c:choose>
     			</td>
        	</tr>
        	<tr>
	         	<th>과목명</th>
	         	<td><form:input path="teacher_subject_name" class="text" style="width:100%" maxlength="30"/></td>
        	</tr>
	        <tr>
	         	<th>성별</th>
	         	<td>
	         		<form:radiobutton path="teacher_sex" value="남"/> <label for="teacher_sex1" style="cursor:pointer;">남</label>&nbsp;
					<form:radiobutton path="teacher_sex" value="여"/> <label for="teacher_sex2" style="cursor:pointer;">여</label>
				</td>
	        </tr>
			<tr>
				<th>전화번호</th>
				<td>
					<form:hidden path="teacher_phone"/>
					<c:set var="phoneArr" value="${fn:split(teacher.teacher_phone, '-')}"/>
					<input id="phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${phoneArr[0]}"/> -
					<input id="phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phoneArr[1]}"/> -
					<input id="phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phoneArr[2]}"/>
					<div class="ui-state-highlight">
						<em>* ex) 053-666-7777</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="teacher_cell_phone" class="text" maxlength="13"/>
					<c:set var="cellPhoneArr" value="${fn:split(teacher.teacher_cell_phone, '-')}"/>
					<input id="cell_phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${cellPhoneArr[0]}"/> -
					<input id="cell_phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${cellPhoneArr[1]}"/> -
					<input id="cell_phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${cellPhoneArr[2]}"/>
					<div class="ui-state-highlight">
						<em>* ex) 010-1234-5678</em>
					</div>
				</td>
			</tr>
			<tr>
	         	<th>E-MAIL</th>
	         	<td>
	         		<form:input path="teacher_email" class="text" style="width:100%"/>
	         	</td>
        	</tr>
			<tr>
	         	<th>국적</th>
	         	<td>
	         		<form:input path="teacher_nationality" class="text" maxlength="10"/>
	         		<div class="ui-state-highlight">
						<em>* ex) 한국, 중국, 일본</em>
					</div>
	         	</td>
        	</tr>
        	<tr>
	         	<th>우편번호</th>
	         	<td><form:input path="teacher_zipcode" class="text" maxlength="15"/> <button class="btn btn2 findPostCode" keyValue1="#teacher_zipcode" keyValue2="#teacher_address">우편번호 찾기</button></td>
        	</tr>
			<tr>
	         	<th>주소</th>
	         	<td><form:input path="teacher_address" class="text" style="width:100%" maxlength="60"/></td>
        	</tr>
        	<tr>
	         	<th>강사이력</th>
	         	<td><form:textarea path="teacher_history" class="text" style="width:100%;height:80px;"/></td>
        	</tr>
        	<c:if test="${teacher.org_file_name != null and teacher.org_file_name != ''}">
	        	<tr>
	        	 	<th>현재 첨부 파일</th>
		         	<td><a href="/cms/module/teacher/download/${teacher.homepage_id}/${teacher.teacher_idx}.do"><i class="fa fa-floppy-o"></i> ${teacher.org_file_name}</a></td>
	        	</tr>
        	</c:if>
        	<tr>
        		<th>첨부파일</th>
        		<td class="fileTd"><input type="file" id="file" name="file" class="text"/></td>
        	</tr>
		</tbody>
	</table>
</form:form>
