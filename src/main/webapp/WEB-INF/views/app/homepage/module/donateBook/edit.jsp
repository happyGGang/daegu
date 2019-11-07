<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function() {
		if($('#phone1').val() != "") {
			$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());	
		}
		if($('#cell_phone1').val() != "") {
			$('#cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());	
		}
		if ( doAjaxPost($('#donateBookEdit')) ) {
			location.reload();
		}
	});
	
	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/html.do';		
		var formData = serializeParameter(['menu_idx']);
		doGetLoad(url, formData);
	});
	
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';
		
		if ( optionYear == year ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#donate_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화 
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);
		
		if ( j == month ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#donate_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	
	if ( '${donateBook.donate_yn}' != '' ) {
		$(':radio.${donateBook.donate_yn}').click();	
	}
	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});

</script>

<c:forEach items="${termsList}" var="terms">
	${terms.contents }
</c:forEach>

<form:form id="donateBookEdit" modelAttribute="donateBook" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>	
	<form:hidden path="editMode"/>		
	<form:hidden path="menu_idx"/>
	<form:hidden path="donate_idx"/>							
	<div style="text-align: right"><b>이용약관 및 개인정보의 수집·이용 동의 여부</b>(<span style="color: red; font-weight: bold;">*</span>)
		<form:select path="self_info_yn" cssClass="selectmenu" cssStyle="width : 70px">
			<form:option value="Y" label="동의"/>
			<form:option value="N" label="미동의"/>
		</form:select>
	</div>
	<br/>
	<table class="type2">		
       <colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>기증자명</th>			
	         	<td>
	         		<form:hidden path="name" value="${member.member_name }"/>
	         		${member.member_name }
	         	</td>
        	</tr>
        	<%-- 
        	<tr>
        		<th>기증년/월</th>			
	         	<td>
	         		<div class="monthYear">
						<form:select path="donate_year" class="" style="width:90px;"></form:select>
				        <form:select path="donate_month" class="" style="width:70px;"></form:select>
				    </div>
	         	</td>
        	</tr>
        	--%>
	        <tr> 
				<th>전화번호</th>
				<td>
					<form:hidden path="phone"/>
					<form:input path="phone1" cssStyle="width:40px;" class="text" maxlength="3" numberonly="true"/> -
					<form:input path="phone2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
					<form:input path="phone3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>	
				</td>
			</tr>
			<tr> 
				<th>휴대전화번호</th>
				<td>
					${fn:substring(member.mobile_no, 0, 3)}-${fn:substring(member.mobile_no, 3, 7)}-${fn:substring(member.mobile_no, 7, 11)}
					<form:hidden path="cell_phone"/>
					<form:hidden path="cell_phone1" cssStyle="width:40px;" class="text" maxlength="3" numberonly="true" value="${fn:substring(member.mobile_no, 0, 3)}"/>
					<form:hidden path="cell_phone2" cssStyle="width:50px;" class="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 3, 7)}"/>
					<form:hidden path="cell_phone3" cssStyle="width:50px;" class="text" maxlength="4" numberonly="true" value="${fn:substring(member.mobile_no, 7, 11)}"/>	
				</td>
			</tr>
	        <tr>
	         	<th>기증도서정보</th>
	         	<td><form:textarea path="donate_book" class="text" cssStyle="width:80%; height:150px"/></td>
	        </tr>
	        <tr>
	         	<th>기증권수</th>
	         	<td><form:input path="donate_count" class="text" cssStyle="width:80px;" numberonly="true"/></td>
	        </tr>
        	<tr>
	         	<th>기증방법</th>
	         	<td><form:input path="donate_method" class="text" cssStyle="width:300px;" maxlength="10"/></td>
	        </tr>
		</tbody>
	</table>
</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
