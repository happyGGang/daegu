<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a#listBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', serializeCustom($('form#librarySearch')));
	});
});
</script>
<form:form modelAttribute="librarySearch" action="detail.do" onsubmit="return false;">
	<form:hidden path="menu_idx"/>
	<form:hidden path="gender"/>
	<form:hidden path="age"/>
	<form:hidden path="region"/>
	<form:hidden path="kdc"/>
	<form:hidden path="startDt"/>
	<form:hidden path="endDt"/>
<!-- 시작 -->
<!-- 도서 정보 -->
<div class="book-view">
	<div class="viewBookArea">
		<dl class="bookInfoList clearfix">
			<dt class="bookTitle">${detailBook.bookname}</dt>
			<dd class="thumb">
				<span class="cover"><img class="bookCoverImg" src="${detailBook.bookImageURL}" alt="${detailBook.bookname}"></span>
			</dd>
			<dd class="list">
				<ul class="con2">
					<li>저자 : ${detailBook.authors}</li>
					<li>발행처 : ${detailBook.publisher}</li>
					<li>발행연도 : ${detailBook.publication_year}</li>
					<li>ISBN : ${detailBook.isbn13}</li>
					<li>대출순위 : ${loanInfo.ranking}위</li>
					<li>대출건수 : <fmt:formatNumber value="${loanInfo.loanCnt}" pattern="#,###"/>건 (최근 90일 기준)</li>
				</ul>
			</dd>
		</dl>
	</div>
	<div class="bookContent">
		<h4 class="title">책소개</h4>
		${detailBook.description}
	</div>
	<div class="center">
		<a href="#btn" class="btn" id="listBtn">목록</a>
		<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=13&booktype=BOOKANDNONBOOK&title=${fn:trim(detailBook.bookname)}" class="btn btn1">소장자료검색</a>
	</div>
</div>
<!-- //도서 정보 -->

<!-- 끝 -->
</form:form>