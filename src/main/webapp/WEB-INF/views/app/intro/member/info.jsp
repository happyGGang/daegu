<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!-- content [START] -->
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
		
<div class="join-wrap" style="padding: 0">				
<form id="memberJoinForm"  name="memberJoinForm" method="post" >
<input type="hidden" id="email_id"  name="email_id" value=""/>
<input type="hidden" id="email_domain"  name="email_domain" value=""/>
	<div class="editTitle">
		정보수정
	</div>
	<table class="editTbl">
		<tbody>
			<tr>
				<th>
					성명
				</th>
				<td>
					${memberInfoResult.user_data.name}
				</td>
			</tr>

			<!-- 대출번호 있을 경우 노출 -->
			<c:if test="${memberInfoResult.user_data.user_no ne '' || memberInfoResult.user_data.user_no ne null}">
			<tr>
				<th>
					대출번호
				</th>
				<td>
					${memberInfoResult.user_data.user_no}
				</td>
			</tr>
			</c:if>
			<tr>
				<th>
					아이디
				</th>
				<td>
					${memberInfoResult.user_data.user_id}
				</td>
			</tr>
			
			<tr>
				<th>
					비밀번호 변경여부
				</th>
				<td>
					<input type="checkbox" id="change_password_flag" name="change_password_flag" value="Y" /> 비밀번호 변경
				</td>
			</tr>

			<tr id="new_password_area1" style="display:none;width:100%;">
				<th>
					변경할 비밀번호
				</th>
				<td>
					<input type="password" id="new_password" name="new_password" class="text" />
				</td>
			</tr>
			<tr id="new_password_area2" style="display:none;width:100%;">
				<th>
					변경할 비밀번호 확인
				</th>
				<td>
					<input type="password" id="confirm_new_password" name="confirm_new_password" class="text" />
				</td>
			</tr>
			<tr>
				<th>
					휴대폰 번호
				</th>
				<td>
					<div id="cell_phone_div">
					
					<c:set var="tmpMobileNo"  value="${memberInfoResult.user_data.handphone}"/>
					<c:set var="tmpMobileNo1"  value=""/>
					<c:set var="tmpMobileNo2"  value=""/>
					<c:set var="tmpMobileNo3"  value=""/>
					
					<c:set var="tmpMobileNo" value="${fn:split(memberInfoResult.user_data.handphone,'-')}" />
					<c:forEach var="mobileNo" items="${tmpMobileNo}" varStatus="g1">
						<c:if test="${g1.count==1}">
							<c:set var="tmpMobileNo1"  value="${mobileNo}"/>
						</c:if>
						<c:if test="${g1.count==2}">
							<c:set var="tmpMobileNo2"  value="${mobileNo}"/>
						</c:if>
						<c:if test="${g1.count==3}">
							<c:set var="tmpMobileNo3"  value="${mobileNo}"/>
						</c:if>
					</c:forEach> 
					
					
					<input id="exchange_mobile" name="exchange_mobile" style="width:60px;" maxlength="3" numberOnly="true" class="text" type="hidden" value="${tmpMobileNo1}"/> 
					<input id="mobile1" name="mobile1" style="width:60px;" maxlength="4" numberOnly="true" class="text" type="hidden" value="${tmpMobileNo2}"/> 
					<input id="mobile2" name="mobile2" style="width:60px;" maxlength="4" numberOnly="true" class="text" type="hidden" value="${tmpMobileNo3}"/>
					${tmpMobileNo1} - ${tmpMobileNo2} - ${tmpMobileNo3}
					<div class="highlight">
					<input id="sms_use_yn" name="sms_use_yn" style="vertical-align:middle;" type="hidden" value="Y"/><label for="sms_service_yn1"> * 입력한 휴대폰 번호로 반납 및 연체문자가 수신됩니다.</label><input type="hidden" name="_sms_service_yn" value="on"/>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					성별
				</th>
				<td>
					<input type="hidden" id="gpin_sex" name="gpin_sex" value="${memberInfoResult.user_data.gpin_sex}"/>
					<c:if test="${memberInfoResult.user_data.gpin_sex == '0'}">남자</c:if>
					<c:if test="${memberInfoResult.user_data.gpin_sex == '1'}">여자</c:if>
				</td>
			</tr>
			
			<tr>
				<th>
					생년월일
				</th>
				<td >
					<c:set var="tmpBirthday"  value="${memberInfoResult.user_data.birthday}"/>
					<c:set var="tmpBirthday1"  value="${fn:substring(tmpBirthday, 0, 4)}"/>
					<c:set var="tmpBirthday2"  value="${fn:substring(tmpBirthday, 5, 7)}"/>
					<c:set var="tmpBirthday3"  value="${fn:substring(tmpBirthday, 8, 10)}"/>
					
					<input type="hidden"  id="birthday_type" name="birthday_type" style="width: 80px;" class="text" value="${memberInfoResult.user_data.birthday_type}"/>
					<input type="hidden"  id="birthday_year" name="birthday_year" style="width: 80px;" class="text" value="${tmpBirthday1}"/>
					<input type="hidden"  id="birthday_month" name="birthday_month" style="width: 80px;" class="text" value="${tmpBirthday2}"/> 
					<input type="hidden"  id="birthday_day" name="birthday_day" style="width: 80px;" class="text" value="${tmpBirthday3}"/>
					${tmpBirthday1}년 ${tmpBirthday2}월 ${tmpBirthday3}일
					<c:if test="${memberInfoResult.user_data.birthday_type == '+'}">( 양력 ) </c:if>
					<c:if test="${memberInfoResult.user_data.birthday_type == '-'}">( 음력 ) </c:if>
				</td>
			</tr>
			
			<tr>
				<th>
					주소
				</th>
				<td>
					<div class="line2">
						<p>
							<input type="hidden" id="h_zipcode" name="h_zipcode" value="${memberInfoResult.user_data.h_zipcode}"/>
							${memberInfoResult.user_data.h_zipcode}
						</p>
						<p>
							<input type="hidden" id="h_addr1" name="h_addr1" value="${memberInfoResult.user_data.h_addr1}"/>
							${memberInfoResult.user_data.h_addr1}
						</p>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					집전화번호
				</th>
				<td>
					<c:set var="tmpHomeNo1"  value=""/>
					<c:set var="tmpHomeNo2"  value=""/>
					<c:set var="tmpHomeNo3"  value=""/>
					
					<c:set var="tmpHomeNo" value="${fn:split(memberInfoResult.user_data.h_phone,'-')}" />
					<c:forEach var="homeNo" items="${tmpHomeNo}" varStatus="g2">
						<c:if test="${g2.count==1}">
							<c:set var="tmpHomeNo1"  value="${homeNo}"/>
						</c:if>
						<c:if test="${g2.count==2}">
							<c:set var="tmpHomeNo2"  value="${homeNo}"/>
						</c:if>
						<c:if test="${g2.count==3}">
							<c:set var="tmpHomeNo3"  value="${homeNo}"/>
						</c:if>
					</c:forEach> 
					<input id="phone" name="phone" type="hidden" value=""/>
					<input id="home_exchange_phone" name="home_exchange_phone" style="width:60px;;" numberOnly="true" class="text" type="text" value="${tmpHomeNo1}" maxlength="3"/>
					- <input id="home_phone1" name="home_phone1" style="width:60px;;" numberOnly="true" class="text" type="text" value="${tmpHomeNo2}" maxlength="4"/>
					- <input id="home_phone2" name="home_phone2" style="width:60px;;" numberOnly="true" class="text" type="text" value="${tmpHomeNo3}" maxlength="4"/>	
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<c:set var="tmpEmail"  value="${memberInfoResult.user_data.e_mail}"/>
					<c:set var="tmpEmail1"  value=""/>
					<c:set var="tmpEmail2"  value=""/>
					
					<c:set var="tmpEmail" value="${fn:split(memberInfoResult.user_data.e_mail,'@')}" />
					<c:forEach var="emailNo" items="${tmpEmail}" varStatus="g3">
						<c:if test="${g3.count==1}">
							<c:set var="tmpEmail1"  value="${emailNo}"/>
						</c:if>
						<c:if test="${g3.count==2}">
							<c:set var="tmpEmail2"  value="${emailNo}"/>
						</c:if>
					</c:forEach>
					
					<input id="email" name="email" type="hidden" value=""/>
					<input id="email1" name="email1" class="text" type="text" value="${tmpEmail1}"/> @
					<input id="email2" name="email2" class="text" type="text" value="${tmpEmail2}"/>
					<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
						<option value="" >--직접입력--</option>
						<option value="naver.com" >naver.com</option>
						<option value="daum.net" >daum.net</option>
						<option value="gmail.com" >gmail.com</option>
						<option value="nate.com" >nate.com</option>
						<option value="korea.com" >korea.com</option>
						<option value="hotmail.com" >hotmail.com</option>
						<option value="yahoo.com" >yahoo.com</option>
						<option value="korea.kr" >korea.kr</option>
					</select>

					<div class="highlight">
					<input type="hidden" id="mailing_use_yn" name="mailing_use_yn" value="Y"/><input type="hidden" name="_email_service_yn" value="on"/>
					<!-- <input id="mailing_use_yn" name="mailing_use_yn" style="vertical-align: middle;" type="checkbox"  ${memberInfoResult.user_data.mailing_use_yn == 'Y' ? 'checked' : ''} value="Y"/> --><!-- <label for="email_service_yn1"> EMAIL 수신 여부</label><input type="hidden" name="_email_service_yn" value="on"/> -->
					</div>
				</td>
			</tr>
			
		</tbody>
	</table>
	
	<div class="btn-wrap">
		<a href="#" id="cancel-btn" class="btn btn02">취소</a>
		<a href="#" id="save-btn" class="btn btn03">확인</a>
	</div>
	</form>
</div>

	<script type="text/javascript">

	$(function() {

		$('input#change_password_flag').on('click', function(e) {
			var newPasswordObj1 = $("#new_password_area1");
			var newPasswordObj2 = $("#new_password_area2");
			
			if($("input#change_password_flag").is(":checked")){
				if(newPasswordObj1.css("display") == "none") {
					newPasswordObj1.css("display", "table-row"); 
				}
				if(newPasswordObj2.css("display") == "none") {
					newPasswordObj2.css("display", "table-row");
				}
			}else{
				if(newPasswordObj1.css("display") == "table-row") {
					$("#new_password").val("");
					newPasswordObj1.css("display", "none"); 
				}
				if(newPasswordObj2.css("display") == "table-row") {
					$("#confirm_new_password").val("");
					newPasswordObj2.css("display", "none");
				}
			}
		});

	});
	</script>