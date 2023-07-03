<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css" />
<tiles:insertAttribute name="header" />

<script>
</script>

<div class="userrecommandbookdetail-wrap">
	<div class="header">
		<h1>도서정보</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="img-sec">
			<img src="${bookKeyword.bookimgUrl}" alt="${bookKeyword.book_name}">
		</div>
		<div class="title-sec">
			${bookKeyword.book_name}
		</div>
		<div class="bookinfo-sec">
			<ul>
				<li><span class="">저자명</span> ${bookKeyword.author}</li>
				<li><span class="">소장위치</span> ${detail.SHELF_LOC_NAME}</li>
				<li><span class="">출판사</span> ${detail.PUBLISHER}</li>
				<li><span class="">청구기호</span> ${detail.CALL_NO}</li>
				<li><span class="">ISBN</span> ${bookKeyword.isbn}</li>
				<li><span class="">등록번호</span> ${detail.REG_NO}</li>
			</ul>
		</div>
		<div class="print-sec">
			<div id="print-contents" class="print-contents-toggle">
			</div>
			<div class="print-btn">
				<a href="#" id="print-btn-toggle">국채보상운동기념도서관 소장도서 <strong>서가위치보기</strong></a>
			</div>
		</div>
		<div class="etcinfo-sec">
			${kakaoResult}
		</div>
		<div class="backbutton-sec">
			<a href="">< 이전</a>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />