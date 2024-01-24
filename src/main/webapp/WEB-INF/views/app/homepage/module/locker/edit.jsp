<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function() {
		$('#lockerEditForm #phone').val($('#lockerEditForm #phone1').val()+''+$('#lockerEditForm #phone2').val()+''+$('#lockerEditForm #phone3').val());
		doAjaxPost($('#lockerEditForm'));
	});
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<c:forEach items="${termsList}" var="terms">
	${terms.contents }
</c:forEach>

<form:form id="lockerEditForm" modelAttribute="locker" method="post" action="save.do" >
<div style="text-align: right"><b>이용약관 및 개인정보의 수집·이용 동의 여부</b>(<span style="color: red; font-weight: bold;">*</span>)
	<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 70px">
		<form:option value="Y" label="동의"/>
		<form:option value="N" label="미동의"/>
	</form:select>
</div>
<br/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="req_idx"/>
	<form:hidden path="locker_idx"/>
	<form:hidden path="editMode"/>	
	<form:hidden path="locker_pre_idx"/>
	<form:hidden path="locker_pre_type"/>	
	<form:hidden path="menu_idx" value="${lockerReq.menu_idx }"/>	
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />						
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
	        <tr style="display: none;">
	         	<th>신청자ID</th>
	         	<td><form:input path="apply_id" class="text" cssStyle="width:30%" maxlength="8" readonly="true"/></td>
	        </tr>
	         <tr>
	         	<th>휴대전화번호</th>
	         	<td>
					<c:choose>
	         		<c:when test="${empty lockerReq.cell_phone}">
	         		<form:input path="cell_phone1" style="width:40px;" class="text" maxlength="3" numberOnly="true"/> - 
	         		<form:input path="cell_phone2" style="width:50px;" class="text" maxlength="4" numberOnly="true"/> - 
	         		<form:input path="cell_phone3" style="width:50px;" class="text" maxlength="4" numberOnly="true"/>
	         		</c:when>
	         		<c:otherwise>
	         		<form:hidden path="cell_phone"/>
					${fn:substring(locker.cell_phone, 0, 3)} - ${fn:substring(locker.cell_phone, 3, 7)} - ${fn:substring(locker.cell_phone, 7, 11)}
	         		</c:otherwise>
					</c:choose>	         	
	         	</td>
	        </tr>	
	        <tr>
	         	<th>전화번호</th>
	         	<td>
	         		<form:hidden path="phone"/>
	         		<form:input path="phone1" style="width:40px;" class="text" maxlength="3" /> - 
	         		<form:input path="phone2" style="width:50px;" class="text" maxlength="4" /> - 
	         		<form:input path="phone3" style="width:50px;" class="text" maxlength="4" />
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
