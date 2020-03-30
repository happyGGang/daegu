<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function() {
	$('div#dialog-2').dialog({ //모달창 기본 스크립트 선언
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
					$('input#auth_group').val($('input.group_check:checked').attr('keyValue2'));
					if(doAjaxPost($('#memberGrouping'))) {
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
	
	$("div#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 300
	});
	
	$('input.group_check').on('click', function() {
		$('input.group_check').not(this).prop("checked", false);
	});
	
});
</script>
<form:form modelAttribute="supportMember" id="memberGrouping" action="saveGroup.do" onsubmit="return false;">
<form:hidden path="member_id"/>
<form:hidden path="support_member_idx"/>
<form:hidden path="auth_group"/>
<table class="type2 center">
	<colgroup>
		<col width="50"/>
		<col width="*"/>
		<col width="*"/>
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>그룹명</th>
			<th>설명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${getMemberGroupList}" var="i" varStatus="status" begin="1">
		<tr>
			<c:set var="isSite" value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0 ? 'th' : 'td'}"></c:set>
			<c:set var="_isSite" value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0}"></c:set>
			
			<c:choose>
				<c:when test="${status.count == 1}"><c:set var="auth_group" value="1" /></c:when>
				<c:when test="${status.count == 2}"><c:set var="auth_group" value="3" /></c:when>
				<c:when test="${status.count == 3}"><c:set var="auth_group" value="4" /></c:when>
			</c:choose>
			
			<${isSite}><c:if test="${!_isSite}"><form:checkbox id="checkAll${status.index}" path="authGroupIdxList" cssClass="group_check" value="${i.member_group_idx}" keyValue2="${auth_group}"/></c:if></${isSite}>
			<${isSite} style="text-align: left;"><label for="checkAll${status.index}" style="padding-left:${(i.member_group_depth-1)*15}px;">${i.member_group_name}</label></${isSite}>
			<${isSite} style="text-align: left;"><label for="checkAll${status.index}">${i.remark}</label></${isSite}>
		</tr>
		</c:forEach>
	</tbody>
</table>
</form:form>