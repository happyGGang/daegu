<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(function() {

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
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
					if (doAjaxPost($('form#facilityStudy'))) {
						location.reload();
					}
				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 800
	});

	$('input#study_date').datepicker({
		minDate : 0
	});

});

</script>
<form:form modelAttribute="facilityStudy" action="save.do" method="POST" onsubmit="return false;" >
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="study_idx"/>
<table class="type2">
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
	        <c:if test="${facilityStudy.editMode eq 'ADD'}">
	        <tr>
	         	<th>비밀번호</th>
	         	<td><form:password path="apply_password" cssClass="text" maxlength="20"/> * 등록 후 변경 불가합니다.</td>
	        </tr>
	        </c:if>
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
	         	<td>
	         		<form:select path="study_num">
	         		<form:option value="1">301호실 스터디룸 1팀</form:option>
	         		<form:option value="2">301호실 스터디룸 2팀</form:option>
	         		<form:option value="3">301호실 스터디룸 3팀</form:option>
	         		</form:select>
	         	</td>
	        </tr>
	        <tr>
	         	<th>이용시간</th>
	         	<td>
        			신청일 : <form:input path="study_date"/><br/>
        			신청시간 :
        			<form:select path="study_time">
	         		<form:option value="1">오전 09:00 ~ 14:00</form:option>
	         		<form:option value="2">오후 14:00 ~ 18:00</form:option>
	         		<form:option value="3">야간 18:00 ~ 22:00</form:option>
	         		</form:select>
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