<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function(){
	$('input#request_date').datepicker({
		dateFormat:'yy-mm-dd'
	});
	
	$('input#return_plan_date').datepicker({
		dateFormat:'yy-mm-dd'
	});
	
	$('input#loan_date1').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#loan_date2').val(), 
		onClose: function(selectedDate){
			$('input#loan_date2').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${bookDelivery.loan_date1}');
	$('input#loan_date2').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#loan_date1').val(), 
		onClose: function(selectedDate){
			$('input#loan_date1').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${bookDelivery.loan_date2}');
});

function save() {
	if ( doAjaxPost($('#bookDeliveryEdit')) ) {
		location.reload();
	}
}

function checkPhone() {
	let input = document.getElementById("phone").value;

    let phone_format = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
    
    if (!phone_format.test(input)){
    	alert("휴대폰번호를 형식에 맞게 입력해주세요.");
    	document.getElementById("phone").value = "";
    }
}

function checkSchoolPhone() {
	let input = document.getElementById("school_phone").value;

    let phone_format = /^([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/;
    
    if (!phone_format.test(input)){
    	alert("학교연락처를 형식에 맞게 입력해주세요.");
    	document.getElementById("school_phone").value = "";
    }
}

function checkCount() {
	let input = document.getElementById("book_count").value;

    let number_format = /^[0-9]*$/;
    
    if (!number_format.test(input)){
    	alert("숫자만 입력해주세요.");
    	document.getElementById("book_count").value = "0";
    }
}
</script>
<form:form id="bookDeliveryEdit" modelAttribute="bookDelivery" action="save.do" method="POST">
<form:hidden path="editMode" value="MODIFY"/>
<form:hidden path="book_delivery_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
				<th>발송요청일</th>
				<td>
					<form:input path="request_date" class="text ui-calendar"/>
				</td>
	        </tr>
	        <tr>
	        	<th>주제</th>
	        	<td>
		        	<form:input path="subject" cssClass="text" cssStyle="width:250px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>책꾸러미명</th>
	        	<td>
	        		<form:input path="book_package_name" cssClass="text" cssStyle="width:250px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>대출기간</th>
	        	<td>
	        		<form:input path="loan_date1" class="text ui-calendar"/>~<form:input path="loan_date2" class="text ui-calendar"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>학교명</th>
	        	<td>
	        		<form:input path="school_name" cssClass="text" cssStyle="width:200px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>신청자</th>
	        	<td>
	        		<form:input path="member_name" cssClass="text" cssStyle="width:100px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>휴대폰</th>
	        	<td>
	        		<form:input path="phone" cssClass="text" cssStyle="width:100px;" onblur="checkPhone(this);"/>
	        		<div class="ui-state-highlight">
						<em>ex) 010-1234-5678</em>
					</div>
	        	</td>
	        </tr>
	        <tr>
	        	<th>주소</th>
	        	<td>
	        		<form:input path="address" cssClass="text" cssStyle="width:300px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>수령 및 반납장소</th>
	        	<td>
	        		<form:input path="return_plan_place" cssClass="text" cssStyle="width:300px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>학교연락처</th>
	        	<td>
	        		<form:input path="school_phone" cssClass="text" cssStyle="width:100px;" onblur="checkSchoolPhone(this);"/>
	        		<div class="ui-state-highlight">
						<em>ex) 053-123-4567</em>
					</div>
	        	</td>
	        </tr>
	        <tr>
	        	<th>권수</th>
	        	<td>
	        		<form:input path="book_count" cssClass="text" cssStyle="width:50px;" onblur="checkCount(this);"/>권
	        	</td>
	        </tr>
	        <tr>
	        	<th>반송요청일</th>
	        	<td>
	        		<form:input path="return_plan_date" class="text ui-calendar"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>상태</th>
	        	<td>
	        		<form:select path="status">
	        			<form:option value="발송요청중">발송요청중</form:option>
	        			<form:option value="발송완료">발송완료</form:option>
	        			<form:option value="반송요청중">반송요청중</form:option>
	        			<form:option value="반송중">반송중</form:option>
	        			<form:option value="반송완료">반송완료</form:option>
	        		</form:select>
	        	</td>
	        </tr>
		</tbody>
	</table>
</form:form>
