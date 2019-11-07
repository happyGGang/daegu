<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(function() {
	$('a.trendSearch').on('click', function(e) {
		e.preventDefault();
		$('input#sub_search1').prop('checked', false);
		$('#librarySearch #allBookListStr').val('');
		$('#librarySearch #search_type').val('SEARCH');
		$('#librarySearch #search_text').val($(this).text().trim());
     	$('#librarySearch #do-search').click();
	});
});
</script>
<c:if test="${fn:length(callNoBrowsing.dsCallNoNext) > 0}">
<h4>동일 저자 다른 책 정보</h4>
<table summary="동일 저자 다른 책 정보">
	<colgroup>
		<col/>
		<col width="20%"/>
		<col width="15%"/>
		<col width="15%"/>
	</colgroup>
	<thead>
		<tr>
			<th>서명</th>
			<th>저자</th>
			<th>등록번호</th>
			<th>청구기호</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${callNoBrowsing.dsCallNoNext}" var="i" varStatus="statusi">
		<tr>
			<td class="txt-left">${i.TITLE}</td>
			<td class="txt-left">${i.AUTHOR}</td>
			<td class="txt-left">${i.ACSSON_NO}</td>
			<td class="txt-left">${i.CALL_NO}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>

<c:if test="${fn:length(callNoBrowsing.dsCallNoPrev) > 0}">
<h4>동일 주제 다른 책 정보</h4>
<table summary="동일 주제 다른 책 정보">
	<colgroup>
		<col/>
		<col width="20%"/>
		<col width="15%"/>
		<col width="15%"/>
	</colgroup>
	<thead>
		<tr>
			<th>서명</th>
			<th>저자</th>
			<th>등록번호</th>
			<th>청구기호</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${callNoBrowsing.dsCallNoPrev}" var="i" varStatus="status">
		<tr>
			<td class="txt-left">${i.TITLE}</td>
			<td class="txt-left">${i.AUTHOR}</td>
			<td class="txt-left">${i.ACSSON_NO}</td>
			<td class="txt-left">${i.CALL_NO}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>