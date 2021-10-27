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
				document.getElementById('zip_code').value = data.zonecode;
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
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
						data : $('#lectureRequestEdit').serialize(),
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
					$('#lectureRequestEdit').ajaxSubmit(option);
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

	/*// 과정 select 변경
	$('select#course_id').on('change', function() {
		let course_id = $(this).val();
		$.ajax({
			type:"post",
			url:`/cms/module/lecture/lectureRequest/lectureInfoList.do`,
			data: JSON.stringify({"course_id":course_id}),
			contentType:"application/json; charset=utf-8",
			dataType:"json",
		}).done(res=>{
			let lectureInfos = res.data;
			let lectureInfoList = JSON.parse(lectureInfos);
			$('#lecture_id').empty();
			$('#lecture_id').append(selectItem('', '전체'));
			lectureInfoList.forEach(lectureInfo => {
				$('#lecture_id').append(selectItem(lectureInfo.lecture_id, lectureInfo.lecture_title));
			})
		}).fail(error=>{
			alert(error);
		})
	});*/

});


/**
 * select obtion item
 * */
function selectItem(lecture_id, lecture_title) {
	let item = `<option value="`+lecture_id+`">`+lecture_title+`</option>`
	return item;
}
</script>

<form:form modelAttribute="lectureRequest" id="lectureRequestEdit" action="save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="request_id"/>
<form:hidden path="request_status"/>
<form:hidden path="add_id"/>
<form:hidden path="request_type" value="${lectureRequest.request_type eq null ? '오프라인' : lectureRequest.request_type}"/>

	<h3 style="font-size: 13pt">신청방법</h3>
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="25%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
		<tr>
			<th>과정이름(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<c:forEach var="i" varStatus="status" items="${courseInfoList}">
					${lectureRequest.course_id eq i.course_id ? i.course_title : ''}
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>강좌선택(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<%--추가일때--%>
				<c:if test="${lectureRequest.editMode ne 'UPDATE'}">
					<form:select path="lecture_id" cssClass="selectmenu" cssStyle="width: 80%;">
						<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
							<form:option value="${i.lecture_id}">${i.lecture_title} (${i.lecture_status1})(${i.offline_request_count}/${i.offline_person_count})</form:option>
						</c:forEach>
					</form:select>
				</c:if>
				<%--수정일때--%>
				<c:if test="${lectureRequest.editMode eq 'UPDATE'}">
					<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
						<c:if test="${i.lecture_id eq lectureRequest.lecture_id}">
							<form:hidden path="lecture_id"/>
							${i.lecture_title}
						</c:if>
					</c:forEach>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>신청자 이름(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="request_name" cssStyle="width: 70%;" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>생년월일(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="birthday" cssClass="text" maxlength="10"/>
				<span>※ 입력 예) 1990-08-15</span>
			</td>
		</tr>
		<tr>
			<th>성별(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="gender" cssClass="selectmenu">
					<form:option value="0">남자</form:option>
					<form:option value="1">여자</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>휴대전화(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="phone_number" cssClass="text"/>
				<span>※ 입력 예) 010-1234-1234</span>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<form:input path="email" cssClass="text" />
				<span>※ 입력 예) hong123@email.com</span>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<form:input path="zip_code" cssClass="text" maxlength="5" readonly="true"/>
				<a href="#" id="searchAddress" class="btn">우편번호찾기</a><br/>
				<form:input path="address1" cssClass="text" cssStyle="width:90%; margin:5px 0;" readonly="true"/><br/>
				<form:input path="address2" cssClass="text" cssStyle="width:90%;" maxlength="200"/><br/>
				<span>※상세주소를 입력해주세요.</span>
			</td>
		</tr>
		<tr>
			<th>접수방법</th>
			<td>
				${lectureRequest.request_type eq null ? '오프라인' : lectureRequest.request_type}
			</td>
		</tr>
		<%--<tr>
			<th>취소여부</th>
			<td>
				<form:select path="cancel_yn" cssClass="selectmenu">
					<form:option value="N">N</form:option>
					<form:option value="Y">Y</form:option>
				</form:select>
			</td>
		</tr>--%>
		<tr>
			<th>수료여부</th>
			<td>
				<form:select path="complete_yn" cssClass="selectmenu">
					<form:option value="N">N</form:option>
					<form:option value="Y">Y</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>보호자 성함</th>
			<td>
				<form:input path="guardian_name" cssClass="text" maxlength="10"/>
			</td>
		</tr>
		<tr>
			<th>보호자 휴대전화</th>
			<td>
				<form:input path="guardian_tel" cssClass="text" maxlength="13"/>
				<span>※ 입력 예) 010-1234-1234</span>
			</td>
		</tr>
		<tr>
			<th>보호자 이메일</th>
			<td>
				<form:input path="guardian_email" cssClass="text" maxlength="30"/>
				<span>※ 입력 예) hong123@email.com</span>
			</td>
		</tr>
		</tbody>
	</table>

</form:form>

