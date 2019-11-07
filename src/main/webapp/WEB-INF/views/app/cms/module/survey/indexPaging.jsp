<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String formId = request.getParameter("formId");
%>
<script type="text/javascript">
$(document).ready(function() {
	$('div.paging.type01 > a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = $('<%=formId%>').serialize();
		doGetLoad('index.do', param);
	});
	
	$('select#rowCount').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		var param = $('<%=formId%>').serialize();
		doGetLoad('index.do', param);
	});
	
	$('a > span.btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		var param = $('<%=formId%>').serialize();
		doGetLoad('index.do', param);
	});
	
	$('input#search_text').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').val(1);
			var param = $('<%=formId%>').serialize();
			doGetLoad('index.do', param);
		}
	});
});
</script>

<form:hidden path="viewPage"/>
<div class="paging type01">
<c:if test="${paging.firstPageNum > 0}">
	<a href="#" class="prev_end"><span lass="go_first">처음</span></a>
</c:if>
<c:if test="${paging.prevPageNum > 0}">
	<a href="#" class="prev"><span class="go_prev">이전</span></a>
</c:if>
<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
<c:choose>
<c:when test="${i eq paging.viewPage}">
	<strong>${i}</strong>
</c:when>
<c:otherwise>
	<a href="#" keyValue="${i}">${i}</a>
</c:otherwise>
</c:choose>
</c:forEach>
<c:if test="${paging.nextPageNum > 0}">
	<a href="#" class="next" keyValue="${paging.nextPageNum}"><span class="go_next">다음</span></a>
</c:if>
<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
	<a href="#" class="next_end" keyValue="${paging.totalPageCount}"><span class="go_last">마지막</span></a>
</c:if>
</div>
<p class="hspace50"></p>