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
					if ( doAjaxPost($('#DeviceAdd')) ) {
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
		height: 350
	});
	
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form id="DeviceAdd" modelAttribute="nearbyLibDevice" method="post" action="save.do" >
	<form:hidden path="editMode" value="${device.editMode }"/>
	<form:hidden path="device_idx" value="${device.device_idx }"/>
	
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>장비코드</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${device.editMode eq 'MODIFY'}">
	         				${device.device_idx }
	         				<form:hidden path="device_code" />
	         			</c:when>
	         			<c:otherwise>
	         				<form:input path="device_code"  class="text" cssStyle="width:100%"/>
	         			</c:otherwise>
	         		</c:choose>
	         	</td>
	        </tr>
	        <tr>
	         	<th>장비명</th>
	         	<td><form:input path="device_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>장비장소</th>
	         	<td><form:input path="device_place" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>장비위치</th>
	         	<td><form:input path="device_area" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>사용유무</th>
	         	<td>
	         		<form:select path="use_yn" class="selectmenu-search" cssStyle="width:50%">
	         			<form:option value="N">미사용</form:option>
	         			<form:option value="Y">사용</form:option>	
	         		</form:select>
	         	</td>
	        </tr>
		</tbody>
	</table>
</form:form>
