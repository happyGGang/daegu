<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	var $form = $('form#bookPackage');
	
	$('#list_btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
// 	$('#edit_btn').on('click', function(e) {
// 		e.preventDefault();
// 		$('#editMode').val('MODIFY');
// 		doGetLoad('edit.do', $form.serialize());
// 	});
	
// 	$('#delete_btn').on('click', function(e) {
// 		if(confirm('삭제하시겠습니까?')) {
// 			e.preventDefault();
// 			$('#editMode').val('DELETE');
// 			$form.attr('action', 'save.do');
// 			$form.attr('method', 'POST');
// 			doAjaxPost($form);
// 		}
// 	});
	
});
</script>
<style type="text/css">
table.type2 th, table.type2 td{padding:10px 15px;}
table.type2 tbody tr td dl dt {display: inline-block;border-right: 1px solid silver;padding-right: 5px;margin-right: 5px;}
table.type2 tbody tr td dl dd {display: inline-block;margin-right: 15px;}
</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="bookPackage" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>
<form:hidden path="editMode"/>
<form:hidden path="book_package_idx"/>
<div>
	<table class="type2">
		<thead>
			<tr>
				<th style="font-size:18px;">${bookPackage.book_package_subject}</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<dl>
						<dt>작가</dt><dd>${bookPackage.author}</dd>
						<dt>출판사</dt><dd>${bookPackage.publisher}</dd>
						<dt>출판년도</dt><dd>${bookPackage.publish_year}</dd>
						<dt>대상</dt><dd>${bookPackage.purpose}</dd>
					</dl>
				</td>
			</tr>
			<tr>
				<td>
					<dl>
						<dt>ISBN</dt><dd>${bookPackage.isbn}</dd>
						<dt>가격</dt><dd>${bookPackage.book_price}</dd>
						<dt>쪽수</dt><dd>${bookPackage.book_pages}</dd>
						<dt>대출가능권수</dt><dd>${bookPackage.loan_count}권</dd>
						<dt>소장권수</dt><dd>${bookPackage.quantity}</dd>
					</dl>
				</td>
			</tr>
			<tr>
				<td>
					<dl>
						<dt>수준법</dt>
						<dd>
							<c:choose>
								<c:when test="${bookPackage.grade eq '3'}">초</c:when>
								<c:when test="${bookPackage.grade eq '4'}">중</c:when>
								<c:when test="${bookPackage.grade eq '5'}">고</c:when>
							</c:choose>
						</dd>
						<dt>주류법</dt>
						<dd>
							<c:forTokens items="${bookPackage.category}" delims="," var="category">
							<c:choose>
								<c:when test="${category eq '000'}">총류</c:when>
								<c:when test="${category eq '100'}">철학</c:when>
								<c:when test="${category eq '200'}">종교</c:when>
								<c:when test="${category eq '300'}">사회과학</c:when>
								<c:when test="${category eq '400'}">자연과학</c:when>
								<c:when test="${category eq '500'}">기술과학</c:when>
								<c:when test="${category eq '600'}">예술</c:when>
								<c:when test="${category eq '700'}">언어</c:when>
								<c:when test="${category eq '800'}">문학</c:when>
								<c:when test="${category eq '900'}">역사</c:when>
							</c:choose>
							</c:forTokens>
						</dd>
					</dl>
				</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${not empty bookPackage.image_link}">
						<a href="${i.desc_link}" target="_blank">
							<img src="${bookPackage.image_link}" alt="${bookPackage.book_package_subject}">
						</a>
						</c:when>
						<c:when test="${not empty bookPackage.server_file_name}">
						<a href="#">
							<img src="${getContextPath}/data/bookPackage/${bookPackage.server_file_name}" alt="${bookPackage.book_package_subject}" style="max-width: 500px;margin: 0 auto;">
						</a>
						</c:when>
					</c:choose>
					<br>
					${bookPackage.content}
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form:form>
<div class="button bbs-btn center">
	<a href="" class="btn btn1 list" id="list_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
<%-- 	<c:if test="${member.admin or authMBA}"> --%>
<!-- 	<a href="" class="btn modify" id="edit_btn"><i class="fa fa-pencil-square-o"></i><span>수정</span></a> -->
<!-- 	<a href="" class="btn delete" id="delete_btn"><i class="fa fa-trash-o"></i><span>삭제</span></a> -->
<%-- 	</c:if> --%>
</div>