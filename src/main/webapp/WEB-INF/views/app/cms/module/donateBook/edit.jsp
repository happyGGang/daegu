<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
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
					$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());
					$('#cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());
					if ( doAjaxPost($('#donateBookForm')) ) {
						location.reload();	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 560
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
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="donateBookForm" modelAttribute="donateBook" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="donate_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>기증자명</th>			
	         	<td><form:input path="name" class="text" /></td>
        	</tr>
        	<tr>
        		<th>기증년/월</th>			
	         	<td>
	         		<div class="monthYear">
						<form:select path="donate_year" class="selectmenu" style="width:90px;"></form:select>
				        <form:select path="donate_month" class="selectmenu" style="width:70px;"></form:select>
				    </div>
	         	</td>
        	</tr>
	        <tr> 
				<th>전화번호</th>
				<td>
					<form:hidden path="phone"/>
					<form:select path="phone1" cssClass="selectmenu">
						<form:options items="${phoneCode}" itemLabel="code_name" itemValue="code_id"/>
					</form:select> -
					<form:input path="phone2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
					<form:input path="phone3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>	
				</td>
			</tr>
			<tr> 
				<th>휴대전화번호</th>
				<td>
					<form:hidden path="cell_phone"/>
					<form:select path="cell_phone1" cssClass="selectmenu">
						<form:options items="${cellPhoneCode}" itemLabel="code_name" itemValue="code_id"/>
					</form:select> -
					<form:input path="cell_phone2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
					<form:input path="cell_phone3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>	
				</td>
			</tr>
	        <tr>
	         	<th>기증도서정보</th>
	         	<td><form:textarea path="donate_book" class="text" cssStyle="width:100%; height:150px"/></td>
	        </tr>
	        <tr>
	         	<th>기증권수</th>
	         	<td><form:input path="donate_count" class="text" cssStyle="width:50%" numberonly="true"/></td>
	        </tr>
        	<tr>
	         	<th>기증방법</th>
	         	<td><form:input path="donate_method" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>기증처리동의</th>
	         	<td>
	         		<form:radiobutton path="donate_yn" value="Y" class="Y"/><label for="donate_yn1" style="cursor:pointer;">동의</label>&nbsp;
					<form:radiobutton path="donate_yn" value="N" clasS="N"/><label for="donate_yn2" style="cursor:pointer;">미동의</label>
				</td>
	        </tr>
		</tbody>
	</table>
</form:form>
