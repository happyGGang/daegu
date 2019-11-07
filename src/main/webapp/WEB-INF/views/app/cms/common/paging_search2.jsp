<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String formId = request.getParameter("formId");
	String pagingUrl = request.getParameter("pagingUrl")==null?"index.do":request.getParameter("pagingUrl");
%>
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
	<a id="${i}" href="" class="paginate_button current" keyValue="${i}">${i}</a>
</c:when>
<c:otherwise>
	<a id="${i}" href="" class="paginate_button" keyValue="${i}">${i}</a>
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
	jQuery.ajaxSettings.traditional = true;
	
	$('div#cms_paging a').on('click', function(e) {
// 		location.hash = '#'+$(this).attr('keyValue');
		$('#viewPage').attr('value', parseInt($(this).attr('keyValue')));
		var param = serializeObject($('<%=formId%>'));
		var param2 = serializeObject($('#searchTableForm'));
		$('div#search-results').load('table.do', $.extend(true, param, param2), function() {
			$('div#search-results').scrollTop(0);
			location.href ="#";
		});
		e.preventDefault();
	});
	$('body').scrollTop(0);
	
});
</script>