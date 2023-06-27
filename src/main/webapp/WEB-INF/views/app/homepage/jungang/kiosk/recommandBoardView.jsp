<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<div class="recommandbookdetail-wrap">
	<div class="header">
		<h1>도서정보</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="img-sec">
			<c:choose>
				<c:when test="${(empty detail.aladin or empty detail.aladin.cover) and empty detail.imageUrl}">
					<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="noImage"/>
				</c:when>
				<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
					<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
				</c:when>
				<c:otherwise>
					<img src="${detail.imageUrl}" alt="${detail.TITLE_INFO}">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="title-sec">
			${detail.TITLE_INFO}
		</div>
		<div class="bookinfo-sec">
			<ul>
				<li><span class="">저자명</span> ${detail.AUTHOR}</li>
				<li><span class="">소장위치</span> ${detail.SHELF_LOC_NAME}</li>
				<li><span class="">출판사</span> ${detail.PUBLISHER}</li>
				<li><span class="">청구기호</span> ${detail.CALL_NO}</li>
				<li><span class="">ISBN</span> ${detail.ISBN}</li>
				<li><span class="">등록번호</span> ${detail.REG_NO}</li>
			</ul>
		</div>
		<div class="print-sec">
			<div class="print-btn">
				<a href="#" id="print-btn-toggle">국채보상운동기념도서관 소장도서 <strong>서가위치보기</strong></a>
			</div>
		</div>
		<div class="etcinfo-sec">
			${kakaoResult}
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />