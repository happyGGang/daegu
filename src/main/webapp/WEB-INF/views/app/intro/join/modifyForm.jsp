<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('#memberInfoForm'));
	});
});
</script>

<div class="join-wrap">
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="save.do">
		<form:hidden path="editMode" value="MODIFY"/>
		<form:hidden path="member_id"/>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<tbody>
				<tr>
					<th>
						아이디
					</th>
					<td>
						${memberInfo.member_id}
					</td>
				</tr>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
						<span id="pwdcheck">비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						성명
					</th>
					<td>
						${memberInfo.member_name}
					</td>
				</tr>
				<tr>
					<th>
						성별
					</th>
					<td>
						<c:choose>
							<c:when test="${memberInfo.sex eq '0001'}">남자</c:when>
							<c:otherwise>여자</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>
						생년월일
					</th>
					<td >
						${memberInfo.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						휴대폰 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<span id="cell_phone_span"></span>
						<div id="cell_phone_div">
					 	<form:hidden path="cell_phone"/>
					 	<form:select path="cell_phone1" items="${phoneCode}" itemLabel="code_name" itemValue="code_id" cssClass="selectmenu" cssStyle="width: 65px;"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;;" maxlength="4"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;;" maxlength="4"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						주소(<span style="color: red;">*</span>)
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:90%;" />
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						소속도서관
					</th>
					<td>
						${memberInfo.loca_name}
						<form:hidden path="loca"/>
					</td>
				</tr>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
						<form:hidden path="phone"/>
						<form:input path="phone1" class="text" cssStyle="width:60px;;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;;" maxlength="4" numberOnly="true"/>
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text"/> @
						<form:input path="email2" class="text"/> 
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--직접입력--</option>
							<c:forEach items="${email}" var="i" varStatus="status">
							<option value="${i.code_name}" >${i.code_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">저장</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
