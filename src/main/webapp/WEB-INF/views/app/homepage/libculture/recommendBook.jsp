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
<c:set var="book1" value="${recommendBookList[0]}"></c:set>
<c:set var="book2" value="${recommendBookList[1]}"></c:set>

<c:if test="${fn:length(recommendBookList) == 0}">
<li>
	<a class="goDetail" href="javascript:alert('등록된 추천도서가 없습니다.')">
		<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="추천도서 없음" title="추천도서 없음"/>
	</a>
</li>
<li>
	<a class="goDetail" href="javascript:alert('등록된 추천도서가 없습니다.')">
		<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="추천도서 없음" title="추천도서 없음"/>
	</a>
</li>
</c:if>

<c:if test="${fn:length(recommendBookList) == 1}">
<li>
	<a class="goDetail" href="/${recommendBookContextPath}/board/view.do?menu_idx=${recommendBookMenuIdx}&manage_idx=${book1.manage_idx}&board_idx=${book1.board_idx}">
		<c:choose>
			<c:when test="${empty book1.preview_img}">
			<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${book1.title}" title="${book1.title}"/>
			</c:when>
			<c:when test="${fn:contains(book1.preview_img, 'http')}">
			<img src="${book1.preview_img}" alt="${book1.title}" title="${book1.title}"/>
			</c:when>
			<c:otherwise>
			<img src="/data/board/${book1.manage_idx}/${book1.board_idx}/${book1.preview_img}" alt="${book1.title}" title="${book1.title}" />
			</c:otherwise>
		</c:choose>
		<div class="recommendBookTitle">
			${book1.title}
		</div>
	</a>
</li>
<li>
	<a class="goDetail" href="javascript:alert('등록된 추천도서가 없습니다.')">
		<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="추천도서 없음" title="추천도서 없음"/>
	</a>
</li>
</c:if>


<c:if test="${fn:length(recommendBookList) == 2}">
<li>
	<a class="goDetail" href="/${recommendBookContextPath}/board/view.do?menu_idx=${recommendBookMenuIdx}&manage_idx=${book1.manage_idx}&board_idx=${book1.board_idx}">
		<c:choose>
			<c:when test="${empty book1.preview_img}">
			<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${book1.title}" title="${book1.title}"/>
			</c:when>
			<c:when test="${fn:contains(book1.preview_img, 'http')}">
			<img src="${book1.preview_img}" alt="${book1.title}" title="${book1.title}"/>
			</c:when>
			<c:otherwise>
			<img src="/data/board/${book1.manage_idx}/${book1.board_idx}/${book1.preview_img}" alt="${book1.title}" title="${book1.title}" />
			</c:otherwise>
		</c:choose>
		<div class="recommendBookTitle">
			${book1.title}
		</div>
	</a>
</li>
<li>
	<a class="goDetail" href="/${recommendBookContextPath}/board/view.do?menu_idx=${recommendBookMenuIdx}&manage_idx=${book2.manage_idx}&board_idx=${book2.board_idx}" >
		<c:choose>
			<c:when test="${empty book2.preview_img}">
			<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${book2.title}" title="${book2.title}"/>
			</c:when>
			<c:when test="${fn:contains(book2.preview_img, 'http')}">
			<img src="${book2.preview_img}" alt="${book2.title}" title="${book2.title}"/>
			</c:when>
			<c:otherwise>
			<img src="/data/board/${book2.manage_idx}/${book2.board_idx}/${book2.preview_img}" alt="${book2.title}" title="${book2.title}"/>
			</c:otherwise>
		</c:choose>
		<div class="recommendBookTitle">
			${book2.title}
		</div>
	</a>
</li>
</c:if>