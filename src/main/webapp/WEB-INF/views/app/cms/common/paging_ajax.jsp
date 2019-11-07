<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String layerId = request.getParameter("layerId");
	String formId = request.getParameter("formId");
	String pagingUrl = request.getParameter("pagingUrl")==null?"index.do":request.getParameter("pagingUrl");
%>
<form:hidden id="viewPage_ajax" path="viewPage"/>
<div id="cms_paging" class="dataTables_paginate">
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


<script type="text/javascript">
$(document).ready(function() {
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('<%=formId%>').serialize();
		$('<%=layerId%>').load('<%=pagingUrl%>?' + param);
		e.preventDefault();
	});
});
</script>