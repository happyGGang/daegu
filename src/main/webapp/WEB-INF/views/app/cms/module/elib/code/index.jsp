<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookListForm').submit();
	});
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&type=${code.type}', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&type=${code.type}&comp_idx=' + $(this).data('comp_idx'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if(confirm('삭제하시겠습니까?')) {
			$('#hiddenForm_comp_idx').val($(this).data('comp_idx'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
});
</script>
<form:form id="hiddenForm" modelAttribute="code" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="comp_idx" id="hiddenForm_comp_idx"/>
<form:hidden path="type" id="hiddenForm_type"/>
</form:form>
<form:form id="bookListForm"  modelAttribute="code" action="index.do" >
<c:if test="${!member.admin}">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</c:if>
<form:hidden path="type"/>
	<div class="infodesk">
		<div class="button">
			<c:if test="${authC || member.admin}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="*"/>
			<col width="15%"/>
		</colgroup>
		<thead>
			<tr>
				<th>코드</th>
				<th>공급사명</th>
				<th>타입</th>
				<th>유저수</th>
				<th>사용기간 시작일</th>
				<th>사용기간 종료일</th>
				<th>사용여부</th>
				<th>저작권</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(compList) < 1}">
				<tr style="height:100%">
					<td colspan="8" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${compList}">
				<tr>
					<td>${i.com_code}</td>
					<td>${i.comp_name}</td>
					<td>${i.type}</td>
					<td>${i.user_cnt}</td>
					<td>${i.license_sdate}</td>
					<td>${i.license_edate}</td>
					<td>${i.use_yn}</td>
					<td>${i.copyright}</td>
					<td>
						<c:if test="${member.auth_id <= 200}">
							<a href="" class="btn dialog-modify" data-comp_idx="${i.comp_idx}">수정</a>
							<a href="" class="btn delete-btn" data-comp_idx="${i.comp_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="공급사 관리"></div>