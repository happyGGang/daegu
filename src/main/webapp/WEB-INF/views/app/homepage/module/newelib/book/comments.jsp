<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\n"); %>
<c:if test="${member.login}">
<script>
$(document).ready(function() {
	$('a#addcomment').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#comments_form');
		
		$('#comments_editMode').val('ADD');
		$form.prop('action', '../comment/save.do');
		if(doAjaxPost($form)) {
			$('#comments').load('/${homepage.context_path}/module/newelib/book/comments.do?book_idx=${book.book_idx}');
		} else {
			$('#comments').load('/${homepage.context_path}/module/newelib/book/comments.do?book_idx=${book.book_idx}');
		}
		$form.prop('action', 'index.do');
	});
	$('a.deletecomment').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#comments_form');
		
		$('#comments_editMode').val('DELETE');
		if(confirm('삭제하시겠습니까?')) {
			$form.prop('action', '../comment/save.do');
			$('#comments_comment_idx').val($(this).data('comment_idx'));
			if(doAjaxPost($form)) {
				$('#comments').load('comments.do?book_idx=${book.book_idx}');
			}
			$form.prop('action', 'index.do');
		}
	});
	
	$('.no-paste').attr('oncontextmenu', 'alert("마우스 우클릭하실 수 없습니다."); return false;');
	$('.no-paste').attr('ondragstart', 'return false');
	$('.no-paste').attr('onselectstart', 'return false');
	$('.no-paste').attr('oncopy', 'alert("복사 붙여넣기를 하실 수 없습니다."); return false;');
	$('.no-paste').attr('oncut', 'alert("복사 붙여넣기를 하실 수 없습니다."); return false;');
	$('.no-paste').attr('onpaste', 'alert("복사 붙여넣기를 하실 수 없습니다."); return false;');
});
</script>
</c:if>
<form:form id="comments_form" modelAttribute="book" method="GET" action="comments.do">
<input type="hidden" name="comment_idx" id="comments_comment_idx" value="0"/>
<form:hidden path="book_idx" id="comments_book_idx"/>
<form:hidden path="editMode" id="comments_editMode"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<c:if test="${member.login}">
<div class="sbtn">
	<textarea name="user_comment" class="text no-paste" id="user_comment" style="width: 70%;" rows="3"></textarea><a href="#" id="addcomment" class="btn" style="vertical-align: top;"><span>서평 남기기</span></a>
</div>
</c:if>
<table class="no-paste" summary="서평">
	<colgroup>
		<col width="20%"/>
		<col width="20%"/>
		<col/>
		<col width="10%"/>
	</colgroup>
	<thead>
		<tr>
			<th>일자</th>
			<th>작성자</th>
			<th>서평</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(commentList) == 0}">
		<tr>
			<td colspan="4">서평이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach items="${commentList}" var="i" varStatus="status">
		<tr>
			<td>${i.add_date}</td>
			<td class="center">${fn:substring(i.member_id, -1, 3)}*****</td>
			<td style="text-align: left;">${i.user_comment}</td>
			<td>
				<c:if test="${member.member_id == i.member_id}">
				<a href="#" class="btn deletecomment" data-comment_idx="${i.comment_idx}"><span>삭제</span></a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="/WEB-INF/views/app/cms/common/paging_ajax.jsp" flush="false">
	<jsp:param name="formId" value="#comments_form"/>
	<jsp:param name="layerId" value="#comments"/>
	<jsp:param name="pagingUrl" value="comments.do"/>
</jsp:include>
</form:form>