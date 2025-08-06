<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
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
	        $('body > .ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#groupAuthForm'))) {
						$(this).dialog('destroy');
						$('a#btn_${member.search_auth}').click();
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
		width: 400,
		height: 600
	});
	
	$('#checkAll').on('click', function() {
		$('[name="member_id_list"]').prop('checked', $(this).prop('checked'));
	});
	
});

</script>
<form:form id="groupAuthForm" modelAttribute="member" action="/cms/memberAuth/save.do" method="post">
	<form:hidden path="editMode" />
	<form:hidden path="auth_id" value="${member.search_auth}"/>
<table class="type2 center">
	<colgroup>
		<col width="50"/>
		<col width="*"/>
		<col width="*"/>
	</colgroup>
	<thead>
		<tr>
			<th ><input id="checkAll" type="checkbox"></th>
			<th>ID</th>
			<th>이름</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${memberList}" var="i">
			<tr>
				<td>
					<form:checkbox path="member_id_list" value="${i.member_id }"/>
				</td>
				<td class="left">${i.member_id}</td>
				<td class="left">${i.member_name}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form:form>