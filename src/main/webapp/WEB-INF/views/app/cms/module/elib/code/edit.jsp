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
					if ( doAjaxPost($('#codeForm')) ) {
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
		width: 800,
		height: 560
	});
	
	$('input#license_sdate').datepicker();
	$('input#license_edate').datepicker();
	
});
</script>
<form:form id="codeForm" modelAttribute="code" method="post" action="save.do" >
	<form:hidden path="comp_idx" value="${param.comp_idx}"/>
	<form:hidden path="editMode" value="${param.editMode}"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
 			<tr>
	         	<th>코드</th>
	         	<td><form:input path="com_code" class="text" cssStyle="width:150px"/></td>
        	</tr>
 			<tr>
	         	<th>유통사명</th>
	         	<td><form:input path="comp_name" class="text" cssStyle="width:150px"/></td>
        	</tr>
 			<tr>
	         	<th>콘텐츠 타입</th>
	         	<td>
	         		<form:select path="type" cssClass="selectmenu">
						<option value="">==선택==</option>
						<form:option value="EBK">전자책</form:option>
						<form:option value="ADO">오디오북</form:option>
						<form:option value="WEB">e러닝</form:option>
					</form:select>
				</td>
        	</tr>
 			<tr>
	         	<th>유저수</th>
	         	<td><form:input path="user_cnt" class="text" cssStyle="width:150px"/></td>
        	</tr>
 			<tr>
	         	<th>사용기간</th>
	         	<td><form:input path="license_sdate" class="text ui-calendar"/> ~ <form:input path="license_edate" class="text ui-calendar"/></td>
        	</tr>
	        <tr>
	         	<th>저작권</th>
	         	<td><form:textarea path="copyright" class="text" cssStyle="width:100%; height:150px"/></td>
	        </tr>
	        <tr>
	         	<th>사용여부</th>
	         	<td>
	         		<form:checkbox path="use_yn" value="Y" class="Y"/><label for="use_yn" style="cursor:pointer;">사용함</label>
				</td>
	        </tr>
		</tbody>
	</table>
</form:form>
