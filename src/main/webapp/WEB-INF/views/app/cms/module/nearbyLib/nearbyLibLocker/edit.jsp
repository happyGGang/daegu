<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
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
					if ( doAjaxPost($('#LockerAdd')) ) {
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 300,
		height: 250
	});
	
	
// 	$('#return_machine_yn').change(function(e){
// 		var val = $(this).val();
// 		if(val == 'Y'){
// 			$('#add_low').hide();
// 		}
// 		if(val== 'N'){
// 			$('#add_low').show();	
// 		}
// 	});
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form id="LockerAdd" modelAttribute="nearbyLibLocker" method="post" action="/cms/module/nearbyLibLocker/save.do" >
	<form:hidden path="editMode" value="${locker.editMode}"/>
	<form:hidden path="device_idx" value="${locker.device_idx}"/>
	<form:hidden path="device_code" value="${locker.device_code }"/>
	<form:hidden path="device_name" value="${locker.device_name }"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
				<th>장비명</th>
				<td>${locker.device_name }</td>
			</tr>
			<tr>
				<th>장비코드</th>
				<td>${locker.device_code }</td>
			</tr>
			<tr>
				<th>사물함갯수</th>
				<td><form:input path="total_count" class="text" cssStyle="width:100%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/></td>
			</tr>
<!--        		<tr> -->
<!-- 	         	<th>열갯수</th> -->
<%-- 	         	<td><form:input path="col_no" class="text" cssStyle="width:100%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/></td> --%>
<!-- 	        </tr> -->
<!-- 			<tr> -->
<!-- 	         	<th>행갯수</th> -->
<%-- 	         	<td><form:input path="row_no" class="text" cssStyle="width:100%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/></td> --%>
<!-- 	        </tr>	         -->
<!-- 	        <tr> -->
<!-- 	         	<th>반납기여부</th> -->
<!--          		<td> -->
<%-- 	         		<form:select path="return_machine_yn" class="selectmenu-search" cssStyle="width:50%"> --%>
<%-- 	         			<form:option value="N">무</form:option> --%>
<%-- 	         			<form:option value="Y">유</form:option>	         			 --%>
<%-- 	         		</form:select> --%>
<!-- 	         	</td>	         		 -->
<!-- 	        </tr> -->
<!-- 	        <tr> -->
<!-- 	         	<th>모니터위치(열)</th> -->
<%-- 	         	<td><form:input path="monitor_position" class="text" cssStyle="width:100%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/></td> --%>
<!-- 	        </tr> -->
<!-- 	        <tr id="add_low"> -->
<!-- 	         	<th>추가행</th> -->
<%-- 	         	<td><form:input path="add_row_no" class="text" cssStyle="width:100%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/></td> --%>
<!-- 	        </tr> -->
		</tbody>
	</table>
</form:form>
