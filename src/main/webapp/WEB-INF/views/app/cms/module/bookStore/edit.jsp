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
					if ( doAjaxPost($('#bookStoreForm')) ) {
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
		height: 350
	});
	
});

</script>
<form:form id="bookStoreForm" modelAttribute="bookStore" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="bookstore_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>대출번호</th>			
	         	<td><form:input path="loan_seq" class="text" /></td>
        	</tr>
        	<tr>
        		<th>대출자명</th>			
	         	<td><form:input path="loan_name" class="text" /></td>
        	</tr>
	        <tr> 
				<th>제목</th>
				<td><form:input path="title" class="text" style="width:90%;"/></td>
			</tr>
			<tr> 
				<th>등록번호</th>
				<td><form:input path="regist_num" class="text" /></td>
			</tr>
	        <tr>
	         	<th>청구기호</th>
	         	<td><form:input path="claim_sign" class="text" /></td>
	        </tr>	        
		</tbody>
	</table>
</form:form>
