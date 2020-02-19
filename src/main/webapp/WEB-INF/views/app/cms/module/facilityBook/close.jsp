<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					$('#editMode').val('CLOSE');
					if(doAjaxPost($('#facilityBookClose'))) {
						location.reload();
					};
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
		width: 350,
		height: 250
	});
	
	$('input#close_date').datepicker();
	
});

</script>
<form:form id="facilityBookClose" modelAttribute="facilityBook" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	
	<table class="type1">
		<colgroup>
	       <col width="120" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
				<th>일자</th>
				<td><form:input path="close_date" class="text ui-calendar" cssStyle="width:100px;"/></td>
			</tr>
			<tr>
				<th>시간</th>
				<td>
					<form:checkbox path="close_time" value="0" label="오전"/>
					<form:checkbox path="close_time" value="1" label="오후"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>