<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />

<tiles:insertAttribute name="header" />

<style>
.swiper-container {width:800px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:100px;}
.swiper-slide {position:relative;text-align:center;font-size:18px;width:227px;height:405px;display:flex;justify-content:center;align-items:center;}
.swiper-slide div.thumb-image a img {width:227px;height:326px;border-radius:5px;box-shadow:3px 1px 11px 1px #888786;}
.swiper-slide div.thumb-image {display:block;}
.swiper-slide div.thumb-image a {display:block;}
.swiper-slide div.cont {position:absolute;bottom:-20px;}
.swiper-slide div.cont p.tit {font-size:23px;color:#fff;letter-spacing:-1.25px;text-align:left;text-shadow:1px 1px 3px #383838;}
.swiper-slide div.cont p.auth {font-size:18px;color:#cccccc;letter-spacing:-1.25px;text-align:left;text-shadow:1px 1px 3px #383838;}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>

<div class="userrecommandbook-wrap">
	<div class="header">
		<h1>맞춤형도서추천</h1>
		<p>Customized book recommendation</p>
	</div>
	<div class="contents">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach items="${list}" var="i">
					<div class="swiper-slide">
						<div class="thumb-image">
							<a href="/${homepage.context_path}/kiosk/librarianPickBookView.do?book_name=${i.TITLE_INFO}&isbn=${i.ISBN}&author=${i.AUTHOR}&bookimgUrl=${empty i.imageUrl ? '/resources/common/img/noImg2.png' : i.imageUrl}&regNo=${i.REG_NO}">
								<img src="${empty i.imageUrl ? '/resources/common/img/noImg2.png' : i.imageUrl}" alt="${i.TITLE_INFO}"/>
							</a>
						</div>
						<div class="cont">
							<p class="tit">${i.TITLE_INFO}</p>
							<p class="auth">${i.AUTHOR}</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>

		<!-- Swiper JS -->
		<script src="/resources/common/js/kiosk/swiper.min.js"></script>

		<!-- Initialize Swiper -->
		<script>
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				slidesPerView: 3,
				slidesPerColumn: 3,
				paginationClickable: true,
				spaceBetween: 30
			});
		</script>

		<div class="backbutton-sec">
			<a href="">< 이전</a>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />