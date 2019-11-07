<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	
	$('div#module_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#bookReview'));
		doGetLoad('history.do', param);
		e.preventDefault();
	});
	
});
</script>
<form:hidden path="viewPage"/>
<div id="module_paging" class="dataTables_paginate">
	<c:if test="${paging.firstPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
	</c:if>
	<c:if test="${paging.prevPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
	</c:if>	
	<span>
		<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
		<c:choose>
		<c:when test="${i eq paging.viewPage}">	
			<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
		</c:when>
		<c:otherwise>
			<a href="" class="paginate_button" keyValue="${i}">${i}</a>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${paging.nextPageNum > 0}">
			<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
		</c:if>
		<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
			<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
		</c:if>
	</span>
</div>