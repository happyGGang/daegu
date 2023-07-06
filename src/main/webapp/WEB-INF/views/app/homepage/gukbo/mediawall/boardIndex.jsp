<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/common/css/mediawall/swiper-bundle.min.css" />

<style>
.swiper {width:100%;height:100%;}
.swiper-slide {text-align:center;display:flex;justify-content:center;align-items:center;}
.swiper-slide img {display: block;width: 100%;height: 100%;object-fit: cover;}

.swiper {width:100%;height:300px;}
.swiper-slide {background-size: cover;background-position: center;}

.mySwiper .swiper-slide div.thumb-image img {display:block;width:800px;height:1140px;object-fit:cover;box-shadow: 25px 25px 25px rgba(0,0,0,0.1);}
.mySwiper .swiper-slide div.thumb-image {display:block;}
.mySwiper .swiper-slide div.thumb-image a {display:block;}
.mySwiper .swiper-slide div.cont {position:absolute;top:1170px;left:18px;}
.mySwiper .swiper-slide div.cont p.tit {font-size:45px;color:#fff;letter-spacing:-1.25px;text-align:left;}

.mySwiper {height:20%;box-sizing: border-box;padding:100px 0 80px;}
.mySwiper .swiper-slide {position:relative;width:10%;height:100%;}
.mySwiper .swiper-slide img {display:block;width:800px;height:1140px;/*border:3px solid transparent;*/}
</style>

<script type="text/javascript">
</script>
<div class="notice-wrap">
	<div class="header">
		<h1>공지사항</h1>
		<p>library notice</p>
	</div>
	<div class="contents">
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<c:forEach var="i" varStatus="status" items="${noticeList}">
					<div class="swiper-slide">
						<div class="thumb-image">
							<c:choose>
								<c:when test="${empty i.preview_img}">
									<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다. ${i.title} 상세보기" onError="src='/resources/common/img/gukbo_noimg.png';"/>
								</c:when>
								<c:otherwise>
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" onError="src='/resources/common/img/gukbo_noimg.png';"/>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="cont">
							<p class="tit">${i.title}</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
			<!-- <div class="swiper-scrollbar"></div> -->
		</div>

		<!-- Swiper JS -->
		<script src="/resources/common/js/mediawall/swiper-bundle.min.js"></script>

		<!-- Initialize Swiper -->
		<script>
			var swiper = new Swiper('.mySwiper', {
				pagination: '.swiper-pagination',
				slidesPerView: 6,
				paginationClickable: true,
				spaceBetween: 110,
				autoplay: {
					delay: 5000,
					disableOnInteraction: false,
				},
			});
		</script>
	</div>
	<div class="copyright" style="color:#d0cab5;">
		The National Debt Compensation Movement Memorial Library
	</div>
</div>
<tiles:insertAttribute name="footer" />