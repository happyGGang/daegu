<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('a#searchAddress').on('click', function(e) {
		e.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                
                } else {
                	extraAddr = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("edu_address_1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("edu_address_2").focus();
            }
        }).open();
   	
	});

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
					var option = {
						url : 'save.do',
						type : 'POST',
 						data : $('#lectureInfoEdit').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#lectureInfoEdit').ajaxSubmit(option);
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

	$('#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 950
	});

	$('#dialog-2').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 950
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
		if($(this).val() > 0){
			$(this).val( $(this).val().replace(/(^0+)/,"") );
		}
	});

	// 접수기간 시작일
	$('input#request_start_date').datepicker({
		maxDate: $('input#request_end_date').val(),
		onClose: function(selectedDate){
			$('input#request_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	// 접수기간 종료일
	$('input#request_end_date').datepicker({
		minDate: $('input#request_start_date').val(),
		onClose: function(selectedDate){
			$('input#request_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	// 교육기간 시작일
	$('input#edu_start_date').datepicker({
		maxDate: $('input#edu_end_date').val(),
		onClose: function(selectedDate){
			$('input#edu_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	// 교육기간 종료일
	$('input#edu_end_date').datepicker({
		minDate: $('input#edu_start_date').val(),
		onClose: function(selectedDate){
			$('input#edu_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	//첨부파일 삭제
	$('a.delete-file-btn').on('click', function(e) {
		e.preventDefault();
		var action = $('form#lectureInfoEdit').attr('action');
		$('form#lectureInfoEdit').attr('action', 'deleteFile.do');
		if ( doAjaxPost($('#lectureInfoEdit')) ) {
			$('form#lectureInfoEdit').attr('action', action);
			$('td.file1 a').remove();
			$('a.delete-file-btn').remove();
		}
	});
});
</script>

<style>
	#edit-modal {
		height: 80vh;
		overflow-y: auto;
	}
</style>

<div id="edit-modal">
<form:form modelAttribute="lectureInfo" id="lectureInfoEdit" action="save.do" enctype="multipart/form-data" >
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="lecture_id"/>

	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다..</p>
	<table class="type2">
		<colgroup>
			<col width="18%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>과정선택(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<select name="course_id" class="selectmenu">
						<c:forEach var="i" varStatus="status" items="${courseInfoList}">
							<option value="${i.course_id}" ${i.course_id eq lectureInfo.course_id ? 'selected' : ''}>${i.course_title} ${i.use_yn eq "N" ? '(미사용)' : ''}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>강좌명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="lecture_title" cssStyle="width: 70%;" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th>접수기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="request_start_date" cssClass="text ui-calendar" readonly="true"/>
					 ~
					<form:input path="request_end_date" cssClass="text ui-calendar" readonly="true"/>
				</td>
			</tr>
			<tr>
				<th>접수방식(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="request_type" cssClass="selectmenu">
						<form:option value="선착순">선착순</form:option>
						<form:option value="추첨제">추첨제</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>온라인 모집인원(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="online_person_count" numberOnly="true"/>
					<span>※ 정수의 숫자만 입력</span>
				</td>
			</tr>
			<tr>
				<th>오프라인 모집인원(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="offline_person_count" numberOnly="true"/>
					<span>※ 정수의 숫자만 입력</span>
				</td>
			</tr>
			<tr>
				<th>대기자모집인원(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="wait_person_count" numberOnly="true"/>
					<span>※ 정수의 숫자만 입력(추첨제에서는 추첨대기인원으로 설정됨.)</span>
				</td>
			</tr>
			<tr>
				<th>교육기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="edu_start_date" cssClass="text ui-calendar" readonly="true"/>
					 ~
					<form:input path="edu_end_date" cssClass="text ui-calendar" readonly="true"/>
				</td>
			</tr>
			<tr>
				<th>교육시간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					시작시간 <form:input path="edu_start_time" cssClass="text"/> <span>※ 입력 예) 09:00</span>
					<br>
					종료시간 <form:input path="edu_end_time" cssClass="text"/> <span>※ 입력 예) 18:00</span>
				</td>
			</tr>
			<tr>
				<th>학습요일</th>
				<td>
					<form:checkbox path="day_week" label="일" value="1" checked="${fn:contains(lectureInfo.day_week, '1')?'checked':''}"/>
					<form:checkbox path="day_week" label="월" value="2" checked="${fn:contains(lectureInfo.day_week, '2')?'checked':''}"/>
					<form:checkbox path="day_week" label="화" value="3" checked="${fn:contains(lectureInfo.day_week, '3')?'checked':''}"/>
					<form:checkbox path="day_week" label="수" value="4" checked="${fn:contains(lectureInfo.day_week, '4')?'checked':''}"/>
					<form:checkbox path="day_week" label="목" value="5" checked="${fn:contains(lectureInfo.day_week, '5')?'checked':''}"/>
					<form:checkbox path="day_week" label="금" value="6" checked="${fn:contains(lectureInfo.day_week, '6')?'checked':''}"/>
					<form:checkbox path="day_week" label="토" value="7" checked="${fn:contains(lectureInfo.day_week, '7')?'checked':''}"/>
					<span>&nbsp;&nbsp;&nbsp;&nbsp; ※ 중복체크가능</span>
				</td>
			</tr>
			<tr>
				<th>담당자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="supporter_name" cssClass="text" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th>담당자연락처(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="supporter_tel" cssClass="text"/>
					<span>※ 입력 예) 010-1234-1234</span>
				</td>
			</tr>
			<tr>
				<th>강사명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="teacher_name" cssClass="text" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th>강사연락처</th>
				<td>
					<form:input path="teacher_tel" cssClass="text"/>
					<span>※ 입력 예) 010-1234-1234</span>
				</td>
			</tr>
			<tr>
				<th>교육장(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="edu_school" cssClass="text" maxlength="100"/>
				</td>
			</tr>
			<tr>
				<th>교육장 주소(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="edu_address_1" cssClass="text" cssStyle="width:30%; margin:5px 0;"  readonly="true" />
					<a href="#" id="searchAddress" class="btn">교육장 찾기</a><br/>
				</td>
			</tr><tr>
				<th>교육장 상세주소</th>
				<td>
					<form:input path="edu_address_2" cssClass="text" cssStyle="width:60%;" maxlength="40"/><br/>
				</td>
			</tr>
			<tr>
				<th>교육장 지도링크</th>
				<td>
					<form:input path="edu_school_map" cssClass="text" cssStyle="width:60%;" maxlength="190"/>
				</td>
			</tr>
			<tr>
				<th>과정소개</th>
				<td>
					<form:textarea path="lecture_content" cssClass="textArea" cssStyle="width:100%;" rows="5"/>
					<br><span style="float: right;">※ 마우스로 잡아당겨 입력상자 크기를 조절할 수 있습니다 ↑</span>
				</td>
			</tr>

			<tr>
				<th>첨부파일</th>
				<td class="file1">
	         		<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="파일 첨부" style="width:50%;"/>
					<c:if test="${lectureInfo.editMode eq 'UPDATE'}">
						<c:if test="${file.file_server_name ne NULL}">
							<div class="item">
								<a href="/cms/module/lecture/lectureInfo/download/${file.homepage_id}/${file.file_server_name}.do"><i class="fa fa-floppy-o"></i>${file.file_original_name}</a><a class="btn btn1 delete-file-btn">삭제</a>
							</div>
						</c:if>
					</c:if>
         		</td>
			</tr>
		</tbody>
	</table>
</form:form>
</div>

