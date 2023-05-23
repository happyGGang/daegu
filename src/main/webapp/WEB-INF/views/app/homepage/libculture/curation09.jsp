<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection09 .slickWrap > div').length
	$('.mainSection09 .slickWrap').not('.slick-initialized').slick({
		dots: false,
		arrows:false,
		infinite: true,
		speed: 300,
		slidesToShow: 3,
		variableWidth: true,
		autoplay: true,
		autoplaySpeed: 5000,
		setPosition: 0,
		responsive: [
			{
			  breakpoint: 1024,
			  settings: {
				slidesToShow: 2
			  }
			},
			{
			  breakpoint: 550,
			  settings: {
				slidesToShow: 1,
				variableWidth: false
			  }
			},
		  ]
	  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection09 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection09 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection09 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection09 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection09 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection09 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection09 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection09">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>1</span> / 6</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/148" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_6.png" alt="지명의 유래와 역사" /></p>
										<span class="link">사극으로 엿보는 역사<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/147" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_5.png" alt="지명의 유래와 역사" /></p>
										<span class="link">5월의 모든 역사<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/118" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_1.png" alt="지명의 유래와 역사" /></p>
										<span class="link">지명의 유래와 역사<i></i></span>
									</a>
								</div>								
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/115" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_2.png" alt="대구의 박물관" /></p>
										<span class="link">대구의 박물관<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/116" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_3.png" alt="독립운동가" /></p>
										<span class="link">독립운동가<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/117" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_4.png" alt="대구의 유적지" /></p>
										<span class="link">대구의 유적지<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>