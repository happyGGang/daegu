<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address_base").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address_detailed").focus();
            }
        }).open();
   	
	});
	
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		if(doAjaxPost($('#readerContestEdit'))) {
			location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
		}
	});
	
	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
});
</script>
<style>
	.bbs-edit th, .bbs-edit td{font-size:14px;}
</style>

<form:form modelAttribute="readerContest" id="readerContestEdit" action="save.do" >
<form:hidden path="menu_idx"/>
<form:hidden path="reader_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="wrapper-bbs" style="padding-top:0;">
		<p style="margin-bottom:10px;"><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="다독자 공모 참가 신청">
			<caption>다독자 공모 참가 신청</caption>
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th>참가분야<b style="color: red;">(*)</b></th>
					<td>
						<form:radiobutton path="participation_field" value="0" label="소년부(초등~중등)" class="new_input_btn01"/>
						<form:radiobutton path="participation_field" value="1" label="장년부(고등~일반)" class="new_input_btn01"/>
						<br>
						<form:radiobutton path="participation_type" value="on" label="온라인(인스타그램)" checked="true" class="new_input_btn01"/>
						<form:radiobutton path="participation_type" value="off" label="오프라인(독서노트 제출)" class="new_input_btn01"/>
					</td>
				</tr>
				<tr>
					<th>이름<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_name" cssClass="text new_text01" />
					</td>
				</tr>
				<tr>
					<th>생년월일<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_date" cssClass="text new_text01" maxlength="8" />
						<span>※ 입력예시 : 19900101</span>
					</td>
				</tr>
				<tr>
					<th>휴대폰(본인)<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_phone" cssClass="text new_text01" />
						<span>※ 입력예시 : 010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>휴대폰(보호자)</th>
					<td>
						<form:input path="protector_phone" cssClass="text new_text01" />
						<span>※ 입력예시 : 010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<form:input path="user_email" cssClass="text new_text01" />
					</td>
				</tr>
				<tr>
					<th>주소<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="postcode" cssClass="text new_text01" maxlength="5" />
						<a href="#" id="searchAddress" class="btn" style="border:1px solid #ddd;background:#eee;font-size:12px;padding:1px 10px;height:26px;line-height:25px;">우편번호찾기</a><br/>
						<form:input path="address_base" cssClass="text new_text01" cssStyle="width:90%; margin:5px 0;" /><br/>
						<form:input path="address_detailed" cssClass="text new_text01" cssStyle="width:90%;" /><br/>
						<span>※ 상세주소를 입력해주세요.</span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="button bbs-btn center">
			<a href="#" id="save_btn" class="btn btn1">신청하기</a>
			<a href="#" id="cancle_btn" class="btn">취소</a>
		</div>
	</div>
</form:form>

