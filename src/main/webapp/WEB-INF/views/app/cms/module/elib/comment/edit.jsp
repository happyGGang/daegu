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
					if ( doAjaxPost($('#commentForm')) ) {
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
		width: 500,
		height: 400
	});
	
});

</script>
<form:form id="commentForm" modelAttribute="comment" method="post" action="save.do" >
	<form:hidden path="comment_idx"/>
	<form:hidden path="editMode" value="MODIFY"/>
	<table>
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>회원ID</th>
	         	<td>${comment.member_id}</td>
        	</tr>
			<tr>
	         	<th>일시</th>
	         	<td>${comment.add_date}</td>
        	</tr>
			<tr>
	         	<th>서명</th>
	         	<td>${comment.book_name}</td>
        	</tr>
			<tr>
	         	<th>저자</th>
	         	<td>${comment.author_name}</td>
        	</tr>
			<tr>
	         	<th>출판사</th>
	         	<td>${comment.book_pubname}</td>
        	</tr>
			<tr>
	         	<th>서평</th>
	         	<td><form:textarea path="user_comment" class="text" cssStyle="width:99%" rows="5"/></td>
        	</tr>
		</tbody>
	</table>
</form:form>
