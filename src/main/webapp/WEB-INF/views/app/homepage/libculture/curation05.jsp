<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection05 .slickWrap > div').length
	$('.mainSection05 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection05 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection05 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection05 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection05 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection05 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection05 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection05 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection05">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>1</span> / 7</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/160" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_7.png" alt="완벽한 여름을 보내는 방법" /></p>
										<span class="link">완벽한 여름을 보내는 방법<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/141" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_6.png" alt="따뜻한 감성, 원목 공예 체험" /></p>
										<span class="link">따뜻한 감성, 원목 공예 체험<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/140" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_5.png" alt="도전! 대구 이색 체험활동" /></p>
										<span class="link">도전! 대구 이색 체험활동<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/107" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_1.png" alt="원데이 클래스" /></p>
										<span class="link">원데이 클래스<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/108" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_4.png" alt="대구 근교 어린이체험" /></p>
										<span class="link">대구 근교 어린이체험<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/109" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_2.png" alt="직업진로체험" /></p>
										<span class="link">직업진로체험<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/110" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_3.png" alt="시각장애인 도서 제작 봉사활동" /></p>
										<span class="link">시각장애인 도서 제작 봉사활동<i></i></span>
									</a>
								</div>	
							</div>
						</div>
					</div>