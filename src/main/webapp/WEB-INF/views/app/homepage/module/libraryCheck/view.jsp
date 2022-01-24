<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('a#list-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#libraryCheck').serialize());
	});
	
// 	$('a#modify-btn').on('click', function(e) {
// 		e.preventDefault();
// // 		$('#dialog-1').load('edit.do?editMode=MODIFY&library_check_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
// // 			$('#dialog-1').dialog('open');
// // 		});
// 		$('#editMode').val('MODIFY');
// 		var formData = $('form#libraryCheck').serialize() + '&library_check_idx='+$(this).attr('keyValue');
// 		doGetLoad('edit.do', formData);
// 	});
	
// 	$('a#delete-btn').on('click', function(e) {
// 		e.preventDefault();
// 		if(confirm('정말 삭제하시겠습니까?')) {
// 			$('#library_check_idx_d').val($(this).attr('keyValue'));
// 			if(doAjaxPost($('form#bookPackageDel'))) {
// 				doGetLoad('index.do', $('form#libraryCheck').serialize());
// 			}
// 		}
// 	});
	
});
</script>

<form:form modelAttribute="libraryCheck" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="library_check_idx" id="library_check_idx_d"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="libraryCheck" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="viewPage"/>
<table>
	<tr>
		<th style="text-align: center;">장서점검기 ${libraryCheck.library_check_number}</th>
	</tr>
	<tr>
		<td style="padding: 30px 15px;">${libraryCheck.content}</td>
	</tr>
</table>
</form:form>
<div class="infodesk">
	<div class="button">
		<a href="#" class="btn" id="list-btn">목록으로</a>
<%-- 		<c:if test="${member.admin or authMBA}"> --%>
<%-- 		<a href="#" class="btn btn3" id="modify-btn" keyValue="${libraryCheck.library_check_idx}">수정</a> --%>
<%-- 		<a href="#" class="btn btn4" id="delete-btn" keyValue="${libraryCheck.library_check_idx}">삭제</a> --%>
<%-- 		</c:if> --%>
	</div>
</div>