<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function() {

		$('input#editMode').val('ADD');
		doAjaxPost($('#facilityStudy'));

	});

	$('button#cancel-btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?plan_date=${fn:escapeXml(param.study_date)}&menu_idx=${fn:escapeXml(param.menu_idx)}'
	});

	$('button#applyList-btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'applyList.do?menu_idx=${fn:escapeXml(param.menu_idx)}'
	});


});

$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script>


<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="terms${status.count}" name="agree_codes" type="checkbox" keyValue="${terms.title}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의</label><br>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>

<form:form modelAttribute="facilityStudy" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="study_date"/>
	<form:hidden path="study_time"/>
	<form:hidden path="study_num"/>
	<table class="type1">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
       			<td colspan="2" style="background: #edf4fa; color:#204666; font-weight: bold; text-align: center;">신청인 기본정보</td>
       		</tr>
	        <tr>
	         	<th>신청인 성명</th>
	         	<td><form:input path="apply_name" cssClass="text"/></td>
	        </tr>
	        <tr>
	         	<th>비밀번호</th>
	         	<td><form:password path="apply_password" cssClass="text" maxlength="20"/></td>
	        </tr>
	        <tr>
	         	<th>휴대폰번호1<br/>(신청인본인)</th>
	         	<td><form:input path="apply_phone1" cssClass="text" placeholder="숫자만 입력하세요" numberOnly="true"/> * 숫자만 입력하세요</td>
	        </tr>
	        <tr>
	         	<th>휴대폰번호2<br/>(참여인원 중 한명)</th>
	         	<td><form:input path="apply_phone2" cssClass="text" placeholder="숫자만 입력하세요" numberOnly="true"/> * 숫자만 입력하세요</td>
	        </tr>
	        <tr>
       			<td colspan="2" style="background: #edf4fa; color:#204666; font-weight: bold; text-align: center;">신청사항</td>
       		</tr>
	        <tr>
	         	<th>사용시설</th>
	         	<td>301호실 스터디룸 ${fn:escapeXml(facilityStudy.study_num)}팀</td>
	        </tr>
	        <tr>
	         	<th>이용시간</th>
	         	<td>
        			신청일 : ${fn:escapeXml(facilityStudy.study_date)}<br/>
        			신청시간 :
        			<c:if test="${fn:escapeXml(facilityStudy.study_time) eq '1'}">오전 09:00 ~ 14:00</c:if>
        			<c:if test="${fn:escapeXml(facilityStudy.study_time) eq '2'}">오후 14:00 ~ 18:00</c:if>
        			<c:if test="${fn:escapeXml(facilityStudy.study_time) eq '3'}">야간 18:00 ~ 22:00</c:if>
         		</td>
	        </tr>
	        <tr>
				<th>모임명</th>
				<td><form:input path="study_name" cssClass="text" style="width:50%;"/></td>
			</tr>
	        <tr>
				<th>신청목적</th>
				<td><form:input path="study_purpose" cssClass="text" style="width:50%;"/></td>
			</tr>
	        <tr>
				<th>참여인원</th>
				<td>
					<form:select path="apply_count">
						<form:option value="2">2명</form:option>
						<form:option value="4">4명</form:option>
						<form:option value="6">6명</form:option>
						<form:option value="8">8명</form:option>
					</form:select>
				</td>
			</tr>
	        <tr>
				<th>참가자 명단</th>
				<td>
					<form:textarea path="apply_list" cssClass="text" style="width:98%;" rows="5"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<c:if test="${facilityStudy.editMode eq 'ADD'}">
<br/>
<div style="text-align: center;">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
</c:if>
<c:if test="${facilityStudy.editMode eq 'VIEW'}">
<br/>
<div style="text-align: center;">
	<button id="applyList-btn" class="btn btn5">뒤로가기</button>
</div>
</c:if>