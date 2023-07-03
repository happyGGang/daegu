<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<style>
.swiper-container {width:880px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:30px;}
.swiper-slide {display:inline-block;text-align:left;}
.list {position:relative;display:inline-block;text-align:center;font-size:18px;width:33.33333334%;height:400px;margin:0 auto 40px;vertical-align:top;}
.list:nth-child(3n) {margin-right:0;}
.list div {vertical-align:top;}
.list div.thumb-image a img {width:227px;height:326px;border-radius:5px;box-shadow:3px 1px 11px 1px #888786;}
.list div.thumb-image {display:block;}
.list div.thumb-image a {display:block;}
.list div.cont {position:relative;width:227px;margin:0 auto;}
.list div.cont p.tit {font-size:23px;color:#000;letter-spacing:-1.25px;line-height:125%;text-align:left;}
.list div.cont p.auth {font-size:18px;color:#383838;letter-spacing:-1.25px;text-align:left;}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>
<script type="text/javascript">
$(function() {
	slideAct();
});
</script>
<div class="userrecommandbook-wrap">
	<div class="header">
		<h1>능동형도서추천</h1>
		<p>SMART book recommendation</p>
	</div>

	<div class="contents">
		<c:if test="${fn:length(list) < 1}">
			<h1>추천 도서가 없습니다.</h1>
		</c:if>
		<div class="swiper-container slider">
			<div class="inners">
				<div class="swiper-wrapper">

				<c:forEach items="${list}" var="i">
					<div class="list">
						<div class="thumb-image">
							<a href="/${homepage.context_path}/kiosk/bookKeywordView.do?book_name=${i.bookname}&isbn=${i.isbn}&author=${i.author}&bookimgUrl=${empty i.bookimageURL ? '/resources/common/img/noImg2.png' : i.bookimageURL}">
								<img src="${empty i.bookimageURL ? '/resources/common/img/noImg2.png' : i.bookimageURL}" alt="${i.bookname}"/>
							</a>
						</div>
						<div class="cont">
							<p class="tit">${fn:substring(i.bookname, 0, 25)}<c:if test="${fn:length(i.bookname) > 25}">...</c:if></p>
							<p class="auth">${i.author}</p>
						</div>
					</div>
				</c:forEach>

				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>

		<!-- Swiper JS -->
		<script src="/resources/common/js/kiosk/swiper.min.js"></script>

		<!-- Initialize Swiper -->
		<script>
		/*
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				slidesPerView: 3,
				slidesPerColumn: 3,
				paginationClickable: true,
				spaceBetween: 30
			});
		*/
		</script>

		<div class="backbutton-sec">
			<a href="javascript:history.back(-1);">< 이전</a>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />
<script type="text/javascript">
function slideAct(){
	var view = 0; //보이는 슬라이드 개수
	var realInx = [] //현재 페이지
	var swiperArr = [] //슬라이드 배열

	//슬라이드 배열 생성
	$(".slider").each(function(index){
		realInx.push(0);
		swiperArr.push(undefined);
	})

	//디바이스 체크
	var winWChk = ''
	$(window).on('load resize', function (e){
		e.preventDefault();
		var winW = window.innerWidth;
		if(winWChk != 'mo' && winW <= 1024){ //모바일 버전으로 전환할 때
			slideList()
			winWChk = 'mo';
		}
		if(winWChk != 'pc' && winW >= 1025){ //PC 버전으로 전환할 때
			slideList()
			winWChk = 'pc';
		}
	}) 

	function slideList(){
		//리스트 초기화
		if ($('.slider .list').parent().hasClass('swiper-slide')){
			$('.slider .swiper-slide-duplicate').remove();
			$('.slider .list').unwrap('swiper-slide');
		}
		
		//보이는 슬라이드 개수 설정
		$(".slider").each(function(index){
			if (window.innerWidth > 1024){ //PC 버전
				view = 9;
			}else{ //mobile 버전
				view = 9;
			}

			//리스트 그룹 생성 (swiper-slide element 추가)
			var num = 0;
			$(this).addClass("slider-" + index);
			$(".slider-" + index).find('.list').each(function(i) {
				$(this).addClass("list"+(Math.floor((i+view)/view)));
				num = Math.floor((i+view)/view)
			}).promise().done(function(){
				for (var i = 1; i < num+1; i++) {
					$(".slider-" + index).find('.list'+i+'').wrapAll('<div class="swiper-slide"></div>');
					$(".slider-" + index).find('.list'+i+'').removeClass('list'+i+'')
				}
			});
		}).promise().done(function(){
			sliderStart()
		});
	}
	
	function sliderStart(){
		$(".slider").each(function(index){
			//슬라이드 초기화
			if(swiperArr[index] != undefined) {
				swiperArr[index].destroy();
				swiperArr[index] == undefined;
			}

			//슬라이드 실행
			swiperArr[index] = new Swiper('.slider-' + index + ' .inners', {
				slidesPerView: 1,
				initialSlide :Math.floor(realInx[index]/view),
				resistanceRatio : 0,
				observer : true,
				observeParents : true,
				loop:true,
				pagination: '.swiper-pagination',
				on: {
					slideChange: function () {
						realInx[index] = this.realIndex*view
					}
				},
			});

			//슬라이드 배열 값 추가
			if(swiperArr[index] == undefined) {
				swiperArr[index] = swiper;
			}
		}); 
	}
}
</script>