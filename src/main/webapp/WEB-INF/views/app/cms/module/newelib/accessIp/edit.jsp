<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#accessIp'))) {
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 350
	});
});

</script>
<form:form modelAttribute="accessIp" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="access_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody> 
		<tr>
			<th>접근가능 IP</th>
			<td>
				<form:input path="access_ip" maxlength="20" cssClass="text"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>192.168.1.1<!-- 또는 *(IP 상관없이 모두 허용) --> </em>
				</div>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<form:select path="use_yn">
					<form:option value="Y">Y</form:option>
					<form:option value="N">N</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>차단여부</th>
			<td>
				<form:select path="ban_yn">
					<form:option value="Y">YES</form:option>
					<form:option value="N">NO</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:300px;" cssClass="text" maxlength="30"/>
			</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>
			<c:choose>
			<c:when test="${accessIp.editMode eq 'MODIFY'}">
				<fmt:formatDate value="${accessIp.add_date}" pattern="yyyy.MM.dd" />
			</c:when>
			<c:otherwise>
				자동으로 등록됩니다.
			</c:otherwise>
			</c:choose>
			</td>
		</tr>
	</tbody>
</table>
</form:form>