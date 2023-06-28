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

.mySwiper .swiper-slide div.thumb-image img {display:block;width:800px;height:1140px;object-fit:cover;}
.mySwiper .swiper-slide div.thumb-image {display:block;}
.mySwiper .swiper-slide div.thumb-image a {display:block;}
.mySwiper .swiper-slide div.cont {position:absolute;top:1160px;left:18px;}
.mySwiper .swiper-slide div.cont p.tit {font-size:45px;color:#fff;letter-spacing:-1.25px;text-align:left;}

.mySwiper {height:20%;box-sizing: border-box;padding:100px 0 80px;}
.mySwiper .swiper-slide {position:relative;width:10%;height:100%;}
.mySwiper .swiper-slide img {display:block;width:800px;height:1140px;border:3px solid transparent;}
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
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-1.jpg" />
					</div>
					<div class="cont">
						<p class="tit">생활 속 가까이 누리는 기쁨 내 집 앞 도서관! 생활 속 가까이 누리는 기쁨 내 집 앞 도서관!!</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-2.jpg" />
					</div>
					<div class="cont">
						<p class="tit">일상속의 작은 행복! 스마트도서추천!!!!!!!!!!!!!!!!!!!!!!</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-3.jpg" />
					</div>
					<div class="cont">
						<p class="tit">읽고 싶은 책이 도서관에 없다구요? 희망도서바로대출</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-4.jpg" />
					</div>
					<div class="cont">
						<p class="tit">내 마음에 시울림</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-5.jpg" />
					</div>
					<div class="cont">
						<p class="tit">회원 통합인증 안내</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-6.jpg" />
					</div>
					<div class="cont">
						<p class="tit">안상학 시인의 ‘시는 살아간다’ 특강</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-7.jpg" />
					</div>
					<div class="cont">
						<p class="tit">생활 속 가까이 누리는 기쁨 내 집 앞 도서관</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-8.jpg" />
					</div>
					<div class="cont">
						<p class="tit">생활 속 가까이 누리는 기쁨 내 집 앞 도서관</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-9.jpg" />
					</div>
					<div class="cont">
						<p class="tit">생활 속 가까이 누리는 기쁨 내 집 앞 도서관</p>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="thumb-image">
						<img src="https://swiperjs.com/demos/images/nature-10.jpg" />
					</div>
					<div class="cont">
						<p class="tit">생활 속 가까이 누리는 기쁨 내 집 앞 도서관</p>
					</div>
				</div>
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
				slidesPerView: 7,
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