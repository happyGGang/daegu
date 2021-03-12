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
		if(doAjaxPost($('#bookRelayClubEdit'))) {
			location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
		}
	});
	
	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
	});
	
	$('select#relay_num').on('change', function() {
		//1.현재길이 구한다.listlength
		var listLength = $('tbody#list_tbody tr').length;
		
		//2.select값을 구한다.
		var selectValue = $('select#relay_num').val();
		
		//3.select와 현재길이 차을 반복한다.(줄어드는 경우는  7번으로) i 
		var changeLength = Math.abs(listLength - selectValue);
		for (var i = 0; i < changeLength; i++) {
			if(listLength < selectValue){
				//증가하는경우
				//4.마지막 tr을 클론한다.
				var clonetr = $('tbody#list_tbody tr:last').clone();
				
				//5.클론객체를 수정한다.  listlength + 1 + i, listlength + i 
				clonetr.find('td:first').text(listLength + 1 + i);
				clonetr.find('input:first').attr('id', 'relayList' + (listLength + i) + '.relay_name');
				clonetr.find('input:first').attr('name', 'relayList[' + (listLength + i) + '].relay_name');
				clonetr.find('input').eq(1).attr('id', 'relayList' + (listLength + i) + '.relay_phone');
				clonetr.find('input').eq(1).attr('name', 'relayList[' + (listLength + i) + '].relay_phone');
				clonetr.find('input').eq(2).attr('id', 'relayList' + (listLength + i) + '.relay_etc');
				clonetr.find('input').eq(2).attr('name', 'relayList[' + (listLength + i) + '].relay_etc');
				
				//6.tbody마지막에 append한다.(3번으로 돌아간다.)
				$('tbody#list_tbody').append('<tr>' + clonetr.html() + '</tr>');
			} else {
				//줄어드는경우
				//7.마지막tr을 삭제한다.
				$('tbody#list_tbody tr:last').remove();
			}
		}		
		
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
});
</script>
<style>
	.bbs-edit th, .bbs-edit td{font-size:14px;}
</style>

<form:form modelAttribute="bookRelayClub" id="bookRelayClubEdit" action="save.do" >
<form:hidden path="menu_idx"/>
<form:hidden path="club_idx"/>

	<div class="wrapper-bbs" style="padding-top:0;">
		<p style="margin-bottom:10px;"><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="독서릴레리-독서동아리 신청">
			<caption>독서릴레리-독서동아리 신청</caption>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th rowspan="3" style="border-right:1px solid #e5e8eb;">동아리</th>
					<th>동아리명<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="club_name" cssClass="text new_text01" />
					</td>
				</tr>
				<tr>
					<th>동아리 결성일</th>
					<td>
						<form:input path="club_date" cssClass="text new_text01"  />
					</td>
				</tr>
				<tr>
					<th>동아리 회원수</th>
					<td>
						<form:input path="club_members" cssClass="text new_text01" cssStyle="width:5%;" numberOnly="true" />명
					</td>
				</tr>
				<tr>
					<th rowspan="4" style="border-right:1px solid #e5e8eb;">대표자</th>
					<th>대표자명<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="leader_name" cssClass="text new_text01" />
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
				<tr>
					<th colspan="2">도서영역<b style="color: red;">(*)</b></th>
					<td>
						<form:radiobutton path="book_area" value="0" label="성인" class="new_input_btn01"/>
						<form:radiobutton path="book_area" value="1" label="청소년" class="new_input_btn01"/>
						<form:radiobutton path="book_area" value="2" label="어린이" class="new_input_btn01"/>
					</td>
				</tr>
				<tr>
					<th colspan="2">독서노트 신청수량<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="book_quantity" cssClass="text new_text01" cssStyle="width:5%;" numberOnly="true" />권
					</td>
				</tr>
				<tr>
					<th colspan="2">릴레이 계획<b style="color: red;">(*)</b></th>
					<td>
						<form:textarea path="relay_plan" cssClass="text new_textarea01" cssStyle="width:90%;border:1px solid #ccd2dc;background:#fafafa;" rows="3"  />
					</td>
				</tr>
			</tbody>
		</table>
		<br/>
		
		<div class="wrapper-bbs">
			<h4>릴레이 명단
				<span style="font-weight: normal;font-size:15px;">(*5인 이상 작성)
					<select id="relay_num">
						<option value="5">5인</option>
						<option value="6">6인</option>
						<option value="7">7인</option>
						<option value="8">8인</option>
						<option value="9">9인</option>
						<option value="10">10인</option>
						<option value="11">11인</option>
						<option value="12">12인</option>
						<option value="13">13인</option>
						<option value="14">14인</option>
						<option value="15">15인</option>
						<option value="16">16인</option>
						<option value="17">17인</option>
						<option value="18">18인</option>
						<option value="19">19인</option>
						<option value="20">20인</option>
					</select>
				</span>
			</h4>
	
			<table class="bbs-edit center" summary="독서릴레리-독서동아리 릴레리명단">
				<caption>독서릴레리-독서동아리 릴레리명단</caption>
				<colgroup>
					<col width="10%">
					<col width="30%">
					<col width="30%">
					<col width="30%">
				</colgroup>
				<thead>
					<tr>
						<th>연번</th>
						<th>이름</th>
						<th>연락처</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody id="list_tbody">
					<c:forEach begin="0" end="4" var="i" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>
								<form:input path="relayList[${i}].relay_name" cssClass="text new_text01" />
							</td>
							<td>
								<form:input path="relayList[${i}].relay_phone" cssClass="text new_text01" />
							</td>
							<td>
								<form:input path="relayList[${i}].relay_etc" cssClass="text new_text01" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<strong style="display: block; text-align: center;font-size:18px;margin-bottom:20px;">※ 위와같이 <2020 수성人문학제> 독서릴레이를 신청합니다.</strong>
		
		<div class="button bbs-btn center">
			<a href="#" id="save_btn" class="btn btn1">신청하기</a>
			<a href="#" id="cancle_btn" class="btn">취소</a>
		</div>
	</div>
</form:form>

