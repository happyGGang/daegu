<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper-bundle.min.css" />
<style>
.swiper-container {width:100%;height:100%;}
.swiper-slide {text-align:center;width:100%;height:100%;font-size:18px;box-sizing:border-box;padding-bottom:80px;display:inline-block;}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:50px;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>
<script type="text/javascript">
</script>
<div class="selectrecommandbook-wrap">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide slide01">
					<div class="header">
						<div class="head">
							<h2>SMART recommendation</h2>
							<span class="time"><span id="hours" class="time-txt" style="--clr:#fff"></span>:<span id="minutes" class="time-txt" style="--clr:#fff"></span></span>
						</div>
						<div class="end"></div>
						<script>
							setInterval(()=>{
								var day = new Date();

								let hours = document.getElementById('hours');
								let minutes = document.getElementById('minutes');

								let h = day.getHours();
								let m = day.getMinutes();

								h = (h < 10) ? "0" + h : h;
								m = (m < 10) ? "0" + m : m;

								hours.innerHTML = h;
								minutes.innerHTML = m;
							});
						</script>
					</div>
					<div class="contents">
						<div class="">
							<div class="title-sec">
								나만의 책을 추천받아보세요
							</div>
							<div class="img-sec">
								<img src="/resources/common/img/kiosk/smart-img01.png" alt="">
							</div>
							<div class="comment-sec">
								<p class='big-txt'>회원님의<br/>관심사는 무엇인가요?</p>
								<p class='small-txt'>관심 키워드 선택으로 맞춤책을 추천해드려요</p>
							</div>
							<div class="button-sec">
								<a href="/${homepage.context_path}/kiosk/gukboBookKeywordIndex.do">능동형 도서 추천받기</a>
								<!-- <a href="/${homepage.context_path}/kiosk/bookKeywordIndex.do">능동형 도서 추천받기</a> -->
							</div>
						</div>
					</div>
				</div>
				<div class="swiper-slide slide02">
					<div class="header">
						<div class="head">
							<h2>Book recommendation</h2>
							<span class="time"><span id="hours2" class="time-txt" style="--clr:#fff"></span>:<span id="minutes2" class="time-txt" style="--clr:#fff"></span></span>
						</div>
						<div class="end"></div>
						<script>
							setInterval(()=>{
								var day2 = new Date();

								let hours2 = document.getElementById('hours2');
								let minutes2 = document.getElementById('minutes2');

								let h2 = day2.getHours();
								let m2 = day2.getMinutes();

								h2 = (h2 < 10) ? "0" + h2 : h2;
								m2 = (m2 < 10) ? "0" + m2 : m2;

								hours2.innerHTML = h2;
								minutes2.innerHTML = m2;
							});
						</script>
					</div>
					<div class="contents">
						<div class="">
							<div class="title-sec">
								나만의 책을 추천받아보세요
							</div>
							<div class="img-sec">
								<img src="/resources/common/img/kiosk/smart-img02.png" alt="">
							</div>
							<div class="comment-sec">
								<p class='big-txt'>회원님<Br/>독서 취향의 발견</p>
								<p class='small-txt'>나의 정보 및 도서관 이용으로 책을 추천해드려요</p>
							</div>
							<div class="button-sec">
								<a href="/${homepage.context_path}/kiosk/librarianPickBookIndex.do">맞춤형 도서 추천받기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-pagination"></div>
		</div>

		<!-- Swiper JS -->
		<script src="/resources/common/js/kiosk/swiper-bundle.min.js"></script>

		<!-- Initialize Swiper -->
		<script>
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: true,
				autoplay: {
					delay: 5000,
					disableOnInteraction: false,
				},
			});
		</script>
<jsp:include page="/WEB-INF/views/app/homepage/${homepage.context_path}/kiosk/bookNavigation.jsp" flush="false" />

</div>
<tiles:insertAttribute name="footer" />


