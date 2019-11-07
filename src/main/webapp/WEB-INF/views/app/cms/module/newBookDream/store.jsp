<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	var $form = $('form#bookDreamManage');
	//모달창 링크 버튼
// 	$('a#dialog-add').on('click', function(e) {
// 		e.preventDefault();
// 		doAjaxPost($form);
// 	});
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('storeEdit.do', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.btnModify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('storeEdit.do?editMode=MODIFY&s_no=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.btnDelete').on('click', function(e) {
		e.preventDefault();
		if (confirm('서점을 삭제 하시겠습니까?\n삭제 후 복구가 불가능합니다.')) {
			$('input#editMode', $form).val('DELETE');
			$('input#s_no', $form).val($(this).attr('keyValue'));
			doAjaxPost($form);
		}
	});
	
});	
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script> 
<form:form modelAttribute="bookDreamManage" method="POST" action="saveStore.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="s_no"/>
<form:hidden path="homepage_id"/>
<h3>서점 관리</h3>
<div class="infodesk">
	검색 결과 : 총 ${fn:length(bookDreamStore)}건
	<div class="button">
		<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
	</div>
</div>
<table class="type1 center" summary="서점명, 대표자, 전화번호, 등록일, 관리에 대해 서점관리 부분을 안내하는 표입니다.">
	<caption class="blind">서점관리</caption>
	<colgroup>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th>서점명</th>
			<th>대표자</th>
			<th>전화번호</th>
			<th>등록일</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" varStatus="status" items="${bookDreamStore}">
		<tr>
			<td>${i.s_name}</td>
			<td>${i.s_owner}</td>
			<td>${i.s_tel}</td>
			<td><fmt:formatDate value="${i.s_created}" pattern="yyyy-MM-dd"/></td>
			<td>
				<a class="btn btn-small btnModify" href="#" keyValue="${i.s_no}">수정</a>
				<a class="btn btn-small btnDelete" href="#" keyValue="${i.s_no}">삭제</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<br/>

</form:form>
<div id="dialog-1" class="dialog-common" title="서점관리">
</div>	
	