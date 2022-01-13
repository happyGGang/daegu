<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<!-- 도서정보목록 -->


<!-- <h2>이용자 맞춤형 <span style="font-weight:300">추천도서</span></h2> -->
<div class="user_pick_info">
	<img src="/resources/homepage/dgportal/img/user_pick_icon.png">
	<h2>맞춤형도서추천</h2>
</div>
<!-- <div style="text-align: right; margin-top: 10px; "> -->
<%-- 	<a href="excelDownload.do?keyword_name=${bookKeyword.keyword_name}&menu_idx=${fn:escapeXml(param.menu_idx)}" class="btn btn1" style="font-size:14px;">엑셀다운로드</a> --%>
<!-- </div> -->

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="kdcBookList2">
	<ul class="bookListz">
		<c:if test="${fn:length(list) < 1}">
		<div class="data_none">
		<p>추천 도서가 없습니다.</p>
		</div>
		</c:if>

		<c:forEach items="${list}" var="i">
			<li>
				<div class="thumb">
					<a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=${searchMenuIdx}&booktype=BOOKANDNONBOOK&title=${i.TITLE_INFO}#search_result" class="cover" target="_blank">
						<span class="img">

							<img src="${empty i.bookimageURL ? '/resources/common/img/noImg2.png' : i.bookimageURL}" alt="${i.bookname}" >
						</span>
					</a>
				</div>
				<span class="tit">${i.TITLE_INFO}</span>
				<span class="author">${i.AUTHOR}</span>
				<span class="author">${i.ISBN}</span>
<%-- 				<span class="author">${i.LIB_NAME}</span> --%>
			</li>
		</c:forEach>
	</ul>
</div>