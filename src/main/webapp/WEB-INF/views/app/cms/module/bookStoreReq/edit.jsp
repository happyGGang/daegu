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
					if ( doAjaxPost($('#bookStoreReqForm')) ) {
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
		width: 450,
		height: 250
	});
});

</script>
<form:form id="bookStoreReqForm" modelAttribute="bookStoreReq" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="req_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>대출자번호</th>			
	         	<td><form:input path="loan_seq" class="text" /></td>
        	</tr>
        	<tr>
        		<th>회원명</th>			
	         	<td><form:input path="member_name" class="text" /></td>
        	</tr>
	        <tr> 
				<th>가게명</th>
				<td><form:input path="store_name" class="text" style="width:90%;"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
