<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
				text: "승인취소",
				"class": 'btn btn1',
				click: function() {
					if ( doAjaxPost($('#facilityReasonForm')) ) {
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
		width: 500,
		height: 250
	});
 
});

</script>
<form:form id="facilityReasonForm" modelAttribute="facilityReq" method="post" action="apply.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>									
	<form:hidden path="req_idx"/>
	<form:hidden path="apply_state"/>
	<form:hidden path="facility_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>       		
       		<tr>
	         	<th>미승인 사유</th>
	         	<td>        		
	         		<textarea rows="5" cols="30" id="reason" name="reason"></textarea>
	         	</td>
	        </tr>       		
		</tbody>
	</table>
</form:form>
