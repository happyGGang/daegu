<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function() {
		doAjaxPost($('#lockerEditForm'));
	});
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<form:form id="lockerEditForm" modelAttribute="locker" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="req_idx"/>
	<form:hidden path="locker_idx"/>
	<form:hidden path="editMode"/>	
	<form:hidden path="locker_pre_idx"/>
	<form:hidden path="locker_pre_type"/>	
	<form:hidden path="menu_idx" value="${lockerReq.menu_idx }"/>							
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<c:if test="${locker.editMode eq 'MODIFY' }">
       			<tr align="center">
    	   			<td colspan="2">* 사물함 신청을 완료한 회원입니다.</td>
	       		</tr>
       		</c:if>
	        <tr>
	         	<th>신청자명</th>
	         	<td>
	         		<form:hidden path="req_name" class="text" cssStyle="width:30%"/>
         			${locker.req_name }
	         	</td>
	        </tr>
	        <tr>
	         	<th>신청자ID</th>
	         	<td><form:input path="apply_id" class="text" cssStyle="width:30%" maxlength="8" readonly="true"/></td>
	        </tr>
	        <tr>
	         	<th>전화번호</th>
	         	<td>
	         		<form:input path="phone" class="text" maxlength="12" numberOnly="true" />	         		
	         	</td>
	        </tr>
	        <tr>
	         	<th>휴대전화번호</th>
	         	<td>
	         		<form:input path="cell_phone" class="text" maxlength="11" numberOnly="true" value="${member.mobile_no }"/>
	         	</td>
	        </tr>	        
		</tbody>
	</table>
	<div class="ui-state-highlight">
		* 연락처가 다르실 경우 회원정보 수정 메뉴에서 수정후 신청하시기 바랍니다.
	</div>
</form:form>

<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
