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
.swiper-container {width:880px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:50px;}
.swiper-slide {display:inline-block;text-align:left;}
.swiper-slide {position:relative;display:inline-block;text-align:center;font-size:18px;width:120px;margin:0 auto 40px;vertical-align:top;}
.swiper-slide div {vertical-align:top;}
.swiper-slide div.thumb-image a img {width:120px;height:170px;box-shadow:5px 5px 15px rgba(0,0,0,0.2);}
.swiper-slide div.thumb-image {display:block;width:120px;}
.swiper-slide div.thumb-image a {display:block;}
.swiper-slide div.cont {position:relative;width:120px;margin:0;text-align:left;}
.swiper-slide div.cont p.tit {font-size:18px;color:#000;letter-spacing: -0.05em;line-height:125%;text-align:left;margin-top: 10px;}
.swiper-slide img {display:block;width:120px;height:170px;object-fit:cover;box-shadow: 10px 10px 20px rgba(0,0,0,0.2);}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>

<script>
$(function() {
	$('#print-btn-toggle').on('click', function(e) {
		alert('준비중');
	});
});
</script>

<div class="recommandbookdetail-wrap">
	<div class="header">
		<h1>도서정보</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="img-sec">
			<c:choose>
				<c:when test="${board.preview_img ne null}">
					<c:choose>
						<c:when test="${fn:contains(i.preview_img, 'http')}">
							<c:choose>
								<c:when test="${fn:contains(i.preview_img, 'noimg')}">
									<img src="/resources/common/img/gukbo_noimg.png" alt="${detail.TITLE_INFO}" title="${detail.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
								</c:when>
								<c:otherwise>
									<img src="${i.preview_img}" alt="${detail.TITLE_INFO}" title="${detail.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<img src="/data/board/${board.manage_idx}/${board.board_idx}/${board.preview_img}" alt="${detail.TITLE_INFO}" title="${detail.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
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
			<div class="inner-scroll">
				${kakaoResult}
			</div>
		</div>

		<div class="detail-bookbest-list">
			<h2>인기대출도서</h2>
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<!-- 루프시작 -->
					<c:forEach items="${bestBookList}" var="i" varStatus="status">
						<div class="swiper-slide">
							<div class="thumb-image">
								<a href="/${homepage.context_path}/kiosk/librarianPickBookView.do?book_name=${detail.TITLE_INFO}&isbn=${i.ISBN}&regNo=${i.REG_NO}&author=${i.AUTHOR}&bookimgUrl=${empty i.imageUrl ? '/resources/common/img/noImg2.png' : i.imageUrl}">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다.  상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${detail.TITLE_INFO} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${detail.TITLE_INFO} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							<div class="cont">
								<p class="tit" style="font-size:16px;">
									${fn:substring(i.TITLE, 0, 13)}<c:if test="${fn:length(i.TITLE) > 13}">...</c:if>
								</p>
							</div>
						</div>
					</c:forEach>
					<!-- 루프끝 -->
				</div>
				<!-- <div class="swiper-scrollbar"></div> -->
				<div class="swiper-pagination"></div>
				<!-- <div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div> -->
			</div>
			<script src="/resources/common/js/kiosk/swiper-bundle.min.js"></script>
			<script>
				var swiper = new Swiper(".mySwiper", {
					loop: true,
					spaceBetween: 10,
					slidesPerView: 5,
					freeMode: true,
					watchSlidesProgress: true,
					scrollbar: {
						el: '.swiper-scrollbar',
						draggable: true,
					},
					pagination: {
						el: ".swiper-pagination",
						clickable: true,
					},
				});
			</script>
		</div>

		<div class="backbutton-sec">
			<a href="javascript:history.back(-1);" style="color:#000;">< 이전</a>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />