<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection06 .slickWrap > div').length
	$('.mainSection06 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection06 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection06 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection06 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection06 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection06 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection06 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection06 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection06">
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
									<a href="http://www.icuration.co.kr:81/curation/w/143" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_6.png" alt="식물 테라피 하실래요?" /></p>
										<span class="link">식물 테라피 하실래요?<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/142" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_5.png" alt="책, 커피, 그리고 힐링" /></p>
										<span class="link">책, 커피, 그리고 힐링<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/111" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_1.png" alt="힐링 도서 추천" /></p>
										<span class="link">힐링 도서 추천<i></i></span>
									</a>
								</div>								
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/112" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_2.png" alt="힐링 여행지 추천" /></p>
										<span class="link">힐링 여행지 추천<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/113" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_3.png" alt="대구 근교 힐링스팟" /></p>
										<span class="link">대구 근교 힐링스팟<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/114" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>힐링</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/hl_img_4.png" alt="집에서 편하게 영화로 힐링" /></p>
										<span class="link">집에서 편하게 영화로 힐링<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>