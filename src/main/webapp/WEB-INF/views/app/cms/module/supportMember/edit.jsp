<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#supportMemberEdit'))) {
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

	$('#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 500
	});

});
</script>
<form:form id="supportMemberEdit" modelAttribute="supportMember" action="save.do" method="POST">
	<form:hidden path="editMode" id="editMode_e"/>
	<form:hidden path="support_member_idx" id="support_member_idx_e"/>
	<table class="type2">
		<colgroup>
			<col width="150" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>기관명(학교명)(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="school_name" cssClass="text"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>한글만 사용하실 수 있습니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>아이디(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="member_id" cssClass="text"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>10자 이내의 영문/숫자만 사용하실 수 있습니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호<c:if test="${supportMember.editMode eq 'ADD'}">(<span style="color: red;font-weight: bold;">*</span>)</c:if></th>
				<td>
					<form:password path="member_password" cssClass="text"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>5자리 이상</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인<c:if test="${supportMember.editMode eq 'ADD'}">(<span style="color: red;font-weight: bold;">*</span>)</c:if></th>
				<td>
					<form:password path="password_check" cssClass="text"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>비밀번호를 한번 더 입력하세요.</em>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>