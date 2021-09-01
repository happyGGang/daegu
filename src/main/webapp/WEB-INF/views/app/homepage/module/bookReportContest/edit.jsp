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
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address_base").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address_detailed").focus();
            }
        }).open();
   	
	});
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		var option = {
			type : 'POST',
			url : 'save.do',
			success: function(response) {
				if(response.valid) {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					}
					if(response.reload) {
						location.reload();
					}
					if(response.targetOpener) {
						window.open(response.url, '','width=500,height=510');
						return false;
					}
					if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
						doGetLoad(response.url, response.data);
					}
				} else {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					} else {
						if (response.result != null && response.result.length > 0) {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								$('#'+response.result[i].field).css('border-color', 'red');
								$('#'+response.result[i].field).on('change', function() {
									$(this).css('border-color', '');
								});
									break;
							}
						}
					}

					if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
						if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
							doAjaxLoad(ajaxBody, response.url, response.data);
						} else {
							doGetLoad(response.url, response.data);
						}
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
			}
		}
		$('#bookReportContestEdit').ajaxSubmit(option);
	});
	
	
	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
});
</script>

<form:form modelAttribute="bookReportContest" id="bookReportContestEdit" action="save.do" method="POST" enctype="multipart/form-data">
<form:hidden path="menu_idx"/>
<form:hidden path="book_report_idx"/>
<form:hidden path="participation_field"/>
	<div class="wrapper-bbs" style="padding-top:0;">
		<p><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="독후감 공모 참가 신청">
			<caption>독후감 공모 참가 신청</caption>
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th>이름<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_name" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>학교명</th>
					<td>
						<form:input path="school_name" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>
						<form:input path="school_year" cssClass="text" maxlength="1" cssStyle="width:5%;" numberOnly="true" />학년
					</td>
				</tr>
				<tr>
					<th>휴대폰(본인)<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_phone" cssClass="text" />
						<span>※ 입력 예)010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>휴대폰(보호자)</th>
					<td>
						<form:input path="protector_phone" cssClass="text" />
						<span>※ 입력 예)010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<form:input path="user_email" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>주소<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="postcode" cssClass="text" maxlength="5" />
						<a href="#" id="searchAddress" class="btn">우편번호찾기</a><br/>
						<form:input path="address_base" cssClass="text" cssStyle="width:90%; margin:5px 0;" /><br/>
						<form:input path="address_detailed" cssClass="text" cssStyle="width:90%;" /><br/>
						<span>※상세주소를 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>첨부파일1</th>
					<td class="file1">
		         		<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="파일 첨부" /><form:hidden path="org_file_name"/>
	         		</td>
				</tr>
				<tr>
					<th>첨부파일2</th>
					<td class="file2">
		         		<input type="file" id="org_file_name_temp2" name="org_file_name_temp2" class="text" title="파일 첨부" /><form:hidden path="org_file_name2"/>
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

