<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="book1" value="${recommendBookList[listNum1]}"></c:set>
<c:set var="book2" value="${recommendBookList[listNum2]}"></c:set>

<li>
	<a class="goDetail" href="/${recommendBookContextPath}/board/view.do?menu_idx=${recommendBookMenuIdx}&manage_idx=${book1.manage_idx}&board_idx=${book1.board_idx}">
		<img src="/resources/homepage/dgportal/img/book-line.png" alt="" class="book-line">
		<c:choose>
			<c:when test="${fn:contains(book1.preview_img, 'http')}">
			<img src="${book1.preview_img}" alt="${book1.title}" title="${book1.title}"/>
			</c:when>
			<c:otherwise>
			<img src="/data/board/${book1.manage_idx}/${book1.board_idx}/${book1.preview_img}" alt="${book1.title}" title="${book1.title}" />
			</c:otherwise>
		</c:choose>
			<img src="/resources/homepage/dgportal/img/book-shadow.png" alt="book-shadow" class="book-shadow" />
	</a>
</li>
<li>
	<a class="goDetail" href="/${recommendBookContextPath}/board/view.do?menu_idx=${recommendBookMenuIdx}&manage_idx=${book2.manage_idx}&board_idx=${book2.board_idx}" >
		<img src="/resources/homepage/dgportal/img/book-line.png" alt="" class="book-line">
		<c:choose>
			<c:when test="${fn:contains(book2.preview_img, 'http')}">
			<img src="${book2.preview_img}" alt="${book2.title}" title="${book2.title}"/>
			</c:when>
			<c:otherwise>
			<img src="/data/board/${book2.manage_idx}/${book2.board_idx}/${book2.preview_img}" alt="${book2.title}" title="${book2.title}"/>
			</c:otherwise>
		</c:choose>
		<img src="/resources/homepage/dgportal/img/book-shadow.png" alt="book-shadow" class="book-shadow" />
	</a>
</li>