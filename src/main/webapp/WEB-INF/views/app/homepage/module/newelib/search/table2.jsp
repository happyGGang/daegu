<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:choose>
<c:when test="${menu == 'TYPE'}">
</c:when>
<c:when test="${menu == 'AUTHOR'}">
<c:forEach items="${bookCountByAuthor}" var="j">
	<c:set var="cnt" value="${j.cnt}"></c:set>
	<li><a href="#" class="doSearchWriter" data-author_name="${j.author_name}"><span>${j.author_name}</span><em>(${j.cnt})</em></a></li>
</c:forEach>
</c:when>
<c:when test="${menu == 'PUBLISHER'}">
<c:forEach items="${bookCountByPublisher}" var="j">
	<c:set var="cnt" value="${j.cnt}"></c:set>
	<li><a href="#" class="doSearchPublisher" data-book_pubname="${j.book_pubname}"><span>${j.book_pubname}</span><em>(${j.cnt})</em></a></li>
</c:forEach>
</c:when>
<c:when test="${menu == 'YEAR'}">
<c:forEach items="${bookCountByYear}" var="j">
	<c:set var="cnt" value="${j.cnt}"></c:set>
	<li><a href="#" class="doSearchYear" data-book_year="${j.book_year}"><span>${j.book_year}</span><em>(${j.cnt})</em></a></li>
</c:forEach>
</c:when>
<c:when test="${menu == 'DEVICE'}">
<c:forEach items="${bookCountByDevice}" var="j">
	<c:set var="cnt" value="${j.cnt}"></c:set>
	<li><a href="#" class="doSearchDevice" data-device="${j.device}"><span>${j.label}</span><em>(${j.cnt})</em></a></li>
</c:forEach>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
