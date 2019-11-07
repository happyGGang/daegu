<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$form = $('form#themeBookOne');
	
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
					if(doAjaxPost($form)) {
						$(this).dialog('destroy');
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
	
	
});



</script>
<form:form modelAttribute="themeBookOne" method="post" action="/cms/module/themeBook/save.do" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="manage_idx"/>
	<form:hidden path="yearmonth"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
       			<th>년월</th>
       			<td>${themeBookOne.yearmonth}</td>
       		</tr>
        	<tr>
	         	<th>주제</th>			
	         	<td>
	         		<form:input path="subject" class="text" cssStyle="width:90%"/>
	       		</td>
	       	</tr>
	       	<tr>
				<th>비고</th>
				<td>
					<form:input path="remark" class="text" cssStyle="width:90%"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
