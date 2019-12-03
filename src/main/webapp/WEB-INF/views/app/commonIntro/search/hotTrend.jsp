<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	$('a.trendSearch').on('click', function(e) {
		e.preventDefault();
		$('input#title').val($(this).text().trim());
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#librarySearch').serialize());
	});
});
</script>
<h4>인기 검색어 10</h4>
<div class="tabCon active" id="tabCon1">
	<ul style="padding-top: 10px;">
		<c:forEach items="${hotTrendList}" var="i" varStatus="status">
		<li style="padding-bottom: 2px;">
			<span>${i.RANK}</span>
			<span style="padding-left: 10px;">
				<a href="#" class="trendSearch" alt="${fn:trim(i.SEARCH_WORD)}" title="${fn:trim(i.SEARCH_WORD)}">
					<c:choose>
					<c:when test="${fn:length(fn:trim(i.SEARCH_WORD)) > 10}">${fn:substring(fn:trim(i.SEARCH_WORD),0,10)}...</c:when>
					<c:otherwise>${fn:trim(i.SEARCH_WORD)}</c:otherwise>
					</c:choose>
				</a>
			</span>
		</li>
		</c:forEach>
	</ul>
</div>
