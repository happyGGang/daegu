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
		if(doAjaxPost($('#bookRelayIndividualEdit'))) {
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
	.tbl2 th, .tbl2 td{text-align:center;border-right:1px solid #e5e8eb !important;}
	.tbl2 th:last-child, .tbl2 td:last-child{border-right:none !important;}
</style>

<form:form modelAttribute="bookRelayIndividual" id="bookRelayIndividualEdit" action="save.do" >
<form:hidden path="menu_idx"/>
<form:hidden path="individual_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="wrapper-bbs" style="padding-top:0;">
		<p style="margin-bottom:10px;"><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="독서릴레아-개인 신청">
			<caption>독서릴레이-개인 신청</caption>
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th>성 명<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_name" cssClass="text new_text01" />
					</td>
				</tr>
				<tr>
					<th>휴대폰<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_phone" cssClass="text new_text01" />
						<span>※ 입력예시 : 010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>대상별<b style="color: red;">(*)</b></th>
					<td>
						<form:radiobutton path="book_area" value="0" label="성인" class="new_input_btn01"/>
						<form:radiobutton path="book_area" value="1" label="청소년" class="new_input_btn01"/>
						<form:radiobutton path="book_area" value="2" label="어린이" class="new_input_btn01"/>
					</td>
				</tr>
				<tr>
					<th>독서노트 신청수량<b style="color: red;">(*)</b></th>
					<td>
						<form:hidden path="book_quantity" value="1"/>
						1권&nbsp;
						<span>(※ 다독자 공모 참여)</span>
					</td>
				</tr>
				<tr>
					<th>수령도서관<b style="color: red;">(*)</b></th>
					<td>
						<form:radiobutton path="receive_lib" value="1" label="범어도서관"/>
						<form:radiobutton path="receive_lib" value="2" label="용학도서관"/>
						<form:radiobutton path="receive_lib" value="3" label="고산도서관"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<strong style="display: block; text-align: center;font-size:18px;margin-bottom:20px;">위와 같이 <제8회 수성인문학제> 독서릴레이에 신청합니다.</strong>

		<p style="text-align:center;margin-bottom:10px;">※개인릴레이용 도서는 도서관 자료실에서 대출</p>

		<div class="rsv-info"></div>
		<div class="auto-scroll">
			<table class="bbs-edit tbl2" summary="수성인문학제 참여 도서관별 자료실 위치를 안내하는 표">
			  <caption class="disnone">
			  수성인문학제 참여 도서관별 자료실 위치
			  </caption>
			  <colgroup>
			  <col width="">
			  <col width="28%">
			  <col width="28%">
			  <col width="28%">
			  </colgroup>
			  <thead>
				<tr>
				  <th>구분</th>
				  <th>범어도서관</th>
				  <th>용학도서관</th>
				  <th>고산도서관</th>
				</tr>
			  </thead>
			  <tbody>
				<tr>
				  <th>일반/청소년</th>
				  <td>종합자료실(3층)</td>
				  <td>종합자료실(3층)</td>
				  <td>종합자료실(2층)</td>
				</tr>
				<tr>
				  <th>어린이</th>
				  <td>어린이자료실(지하1층)</td>
				  <td>어린이자료실(2층)</td>
				  <td>어린이자료실(1층)</td>
				</tr>
			  </tbody>
			</table>
		  </div>
		
		<div class="button bbs-btn center">
			<a href="#" id="save_btn" class="btn btn1">신청하기</a>
			<a href="#" id="cancle_btn" class="btn">취소</a>
		</div>
	</div>
</form:form>

