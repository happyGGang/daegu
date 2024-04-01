<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection08 .slickWrap > div').length
	$('.mainSection08 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection08 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection08 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection08 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection08 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection08 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection08 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection08 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection08">
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
									<a href="http://www.icuration.co.kr:81/curation/w/188" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_9.png" alt="내 마음 속 나무 심기" /></p>
										<span class="link">내 마음 속 나무 심기<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/176" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_8.png" alt="수고했어 올해도" /></p>
										<span class="link">수고했어 올해도<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/165" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_7.png" alt="오싹오싹 공포동화" /></p>
										<span class="link">오싹오싹 공포동화<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/133" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_6.png" alt="깜짝이야! 팝업북 동화책" /></p>
										<span class="link">깜짝이야! 팝업북 동화책<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/146" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_5.png" alt="동화책으로 즐기는 꽃놀이" /></p>
										<span class="link">동화책으로 즐기는 꽃놀이<i></i></span>
									</a>
								</div>	
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/121" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_1.png" alt="감동이 있는 동화" /></p>
										<span class="link">감동이 있는 동화<i></i></span>
									</a>
								</div>								
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/120" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_2.png" alt="교훈이 있는 동화" /></p>
										<span class="link">교훈이 있는 동화<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/122" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_3.png" alt="해외 동화 작가" /></p>
										<span class="link">해외 동화 작가<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/119" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_4.png" alt="귀로 읽는 구연동화" /></p>
										<span class="link">귀로 읽는 구연동화<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>