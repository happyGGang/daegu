<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<!-- 도서정보목록 -->
<h5 class="bookTitle">이용자 추천도서 정보</h5>
<div class="kdcBookList">
	<ul class="bookListz">
		<c:forEach items="${userPickBookList}" var="i">
			<li>
				<div class="thumb">
					<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=${searchMenuIdx}&booktype=BOOKANDNONBOOK&title=${i.TITLE}#search_result" class="cover">
						<span class="img">

							<img src="${empty i.THUMBNAIL ? '/resources/common/img/noImg2.png' : i.THUMBNAIL}" alt="${i.bookname}" >
						</span>
					</a>
				</div>
				<span class="tit">${i.TITLE}</span>
				<span class="author">${i.AUTHOR}</span>
			</li>
		</c:forEach>
	</ul>
</div>