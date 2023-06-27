<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper-bundle.min.css" />
<style>
.swiper {width:100%;height:100%;}
.swiper-slide {text-align:center;display:flex;justify-content:center;align-items:center;}
.swiper-slide img {display: block;width: 100%;height: 100%;object-fit: cover;}

.swiper {width:100%;height:300px;}
.swiper-slide {background-size: cover;background-position: center;}

.mySwiper {height:20%;box-sizing: border-box;padding:100px 0 50px;}
.mySwiper .swiper-slide {width:10%;height:100%;}
.mySwiper .swiper-slide-thumb-active {box-sizing:border-box;}

.mySwiper .swiper-slide img {display:block;width:120px;height:170px;object-fit:cover;border:3px solid transparent;}
.mySwiper .swiper-slide-thumb-active img {border:3px solid #000;}

.mySwiper2 {height:80%;width: 100%;}
.mySwiper2 .swiper-slide img {display:block;width:800px;height:1135px;object-fit:cover;}
</style>
<script src="/resources/common/js/kiosk/swiper-bundle.min.js"></script>
<script type="text/javascript">
var swiper = new Swiper(".mySwiper", {
	loop: true,
	spaceBetween: 10,
	slidesPerView: 7,
	freeMode: true,
	watchSlidesProgress: true,
	/*
	scrollbar: {
		el: ".swiper-scrollbar",
	},
	*/
	pagination: {
		el: ".swiper-pagination",
		clickable: true,
	},
});
var swiper2 = new Swiper(".mySwiper2", {
	loop:true,
	spaceBetween: 10,
	effect: 'fade',
	autoplay: {
		delay: 5000,
		disableOnInteraction: false,
	},
	navigation: {
		nextEl: ".swiper-button-next",
		prevEl: ".swiper-button-prev",
	},
	thumbs: {
		swiper: swiper,
	},
});
</script>
<div class="notice-wrap">
	<div class="header">
		<h1>공지사항</h1>
		<p>library notice</p>
	</div>
	<div class="contents">
		<div class="swiper mySwiper2">
			<div class="swiper-wrapper">
				<c:forEach var="i" varStatus="status" items="${noticeList}">
					<div class="swiper-slide">
						<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
							<c:choose>
								<c:when test="${empty i.preview_img}">
									<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. ${i.title} 상세보기" onError="src='/resources/common/img/noImg2.png';"/>
								</c:when>
								<c:otherwise>
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" onError="src='/resources/common/img/noImg2.png';"/>
								</c:otherwise>
							</c:choose>
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
		<div thumbsSlider="" class="swiper mySwiper">
			<div class="swiper-wrapper">
				<c:forEach var="i" varStatus="status" items="${noticeList}" >
					<div class="swiper-slide">
						<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
							<c:choose>
								<c:when test="${empty i.preview_img}">
									<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. ${i.title} 상세보기" onError="src='/resources/common/img/noImg2.png';"/>
								</c:when>
								<c:otherwise>
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" onError="src='/resources/common/img/noImg2.png';"/>
								</c:otherwise>
							</c:choose>
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />