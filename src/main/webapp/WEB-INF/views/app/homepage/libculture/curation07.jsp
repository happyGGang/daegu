<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection07 .slickWrap > div').length
	$('.mainSection07 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection07 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection07 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection07 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection07 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection07 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection07 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection07 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection07">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>1</span> / 9</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
                <div>
									<a href="http://www.icuration.co.kr:81/curation/w/170" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_9.png" alt="가을엔 전시회" /></p>
										<span class="link">가을엔 전시회<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/166" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_8.png" alt="해외 스타, 그들이 온다!" /></p>
										<span class="link">해외 스타, 그들이 온다!<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/159" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_7.png" alt="버스킹? BUSKING!" /></p>
										<span class="link">버스킹? BUSKING!<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/145" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_6.png" alt="알록달록 미술의 세계로" /></p>
										<span class="link">알록달록 미술의 세계로<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/144" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_5.png" alt="춤과 노래가 함께하는 뮤지컬" /></p>
										<span class="link">춤과 노래가 함께하는 뮤지컬<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/123" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_1.png" alt="대구 문화예술 공연" /></p>
										<span class="link">대구 문화예술 공연<i></i></span>
									</a>
								</div>								
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/124" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_2.png" alt="대구 전통문화 공연" /></p>
										<span class="link">대구 전통문화 공연<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/125" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_3.png" alt="대구 전시회" /></p>
										<span class="link">대구 전시회<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/126" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_4.png" alt="대구의 공연·전시장" /></p>
										<span class="link">대구의 공연·전시장<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>