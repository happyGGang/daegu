<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-modify').on('click',  function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val() + '&reception_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-work').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('work.do?editMode=ADD&homepage_id='+$('#homepage_id').val() + '&reception_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	$('a.btn-delete').on('click', function(e) {
		e.preventDefault();
		
		$('input#reception_idx_del').val($(this).attr('keyValue'));
		var message = "정말 삭제하시겠습니까?";
		if(confirm(message)) {
			doAjaxPost($('form#smsReceptionDel'));
		}
	});
	
});
</script>
<form:form modelAttribute="smsReception" id="smsReceptionDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="homeapge_id_del"/>
	<form:hidden path="reception_idx" id="reception_idx_del"/>
</form:form>
<form:form  modelAttribute="smsReception" action="index.do">
	<form:hidden path="homepage_id"/>
	<div class="infodesk">
		<div class="button">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="8%">
			<col width="20%">
			<col>
			<col>
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>담당자명</th>
				<th>연락처</th>
				<th>SMS 수신 여부</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${smsReceptionList}" var="i" varStatus="status">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.reception_name}</td>
					<td>${i.reception_phone}</td>
					
					
					
					
<%-- 					<c:forEach items="${workCodeList}" var="j" varStatus="status"> --%>
<%-- 					<c:if test="${i.reception_list[status.index].work_code eq j.code_id}"> --%>
<%-- 					<td>${i.reception_list[status.index].reception_yn}</td> --%>
<%-- 					</c:if> --%>
<%-- 					</c:forEach> --%>
					<td>
						<c:forEach items="${workCodeList}" var="j" varStatus="jStatus">
						<c:if test="${i.reception_list[jStatus.index].work_code eq j.code_id}">
						<p>${j.code_name} : ${i.reception_list[jStatus.index].reception_yn}</p>
						</c:if>
						</c:forEach>
					</td>
					
					
					
					<td>
						<a href="#" class="btn dialog-modify" keyValue="${i.reception_idx}">수정</a>
						<a href="#" class="btn btn-delete" keyValue="${i.reception_idx}">삭제</a>
						<a href="#" class="btn dialog-work" keyValue="${i.reception_idx}">업무관리</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(smsReceptionList) < 1}">
			<tr>
				<td colspan="9">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
</form:form>


<div id="dialog-1" class="dialog-common" title="SMS수신 담당자 관리"></div>
<div id="dialog-2" class="dialog-common" title="SMS수신 업무 관리"></div>