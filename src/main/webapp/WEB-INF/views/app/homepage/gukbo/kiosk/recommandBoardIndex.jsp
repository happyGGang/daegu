<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<style>
.swiper-container {width:880px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:50px;}
.swiper-slide {display:inline-block;text-align:left;}
.list {position:relative;display:inline-block;text-align:center;font-size:18px;width:33.33333334%;height:420px;margin:0 auto 40px;vertical-align:top;}
.list:nth-child(3n) {margin-right:0;}
.list div {vertical-align:top;}
.list div.thumb-image a img {width:227px;height:326px;border-radius:10px;box-shadow: 5px 5px 15px rgba(0,0,0,0.2);}
.list div.thumb-image {display:block;}
.list div.thumb-image a {display:block;}
.list div.cont {position:relative;width:227px;margin:0 auto;}
.list div.cont p.tit {font-size:23px;color:#000;letter-spacing: -0.05em;line-height:125%;text-align:left;margin-top: 10px;}
.list div.cont p.auth {font-size:18px;color:#5d5d5d;letter-spacing:-0.05em;text-align:left;}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>
<script type="text/javascript">
$(function() {
	slideAct();
});
</script>
<div class="recommandbook-wrap">
	<div class="header">
		<h1>추천도서</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="swiper-container slider">
			<div class="inners">
				<div class="swiper-wrapper">

					<c:forEach items="${boardList}" var="i" varStatus="status">
						<div class="list">
							<div class="thumb-image">
								<a href="/${homepage.context_path}/kiosk/recommandBoardView.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'noimg')}">
															<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
														</c:when>
														<c:otherwise>
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png'">
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							<div class="cont">
								<p class="tit">
									${fn:substring(i.title, 0, 25)}<c:if test="${fn:length(i.title) > 25}">...</c:if>
								</p>
								<p class="auth">
									<c:if test="${i.imsi_v_3 ne null and i.imsi_v_3 ne '' and i.imsi_v_3 ne '0'}">
										${fn:substring(i.imsi_v_3, 0, 20)}<c:if test="${fn:length(i.imsi_v_3) > 20}">...</c:if>
									</c:if>
								</p>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
		<script src="/resources/common/js/kiosk/swiper.min.js"></script>
		<script type="text/javascript">
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