<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection03 .slickWrap > div').length
	$('.mainSection03 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection03 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection03 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection03 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection03 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection03 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection03 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection03 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>

					<div class="mainSection03">
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
									<a href="http://icuration.co.kr:81/curation/w/167" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_7.png" alt="책으로 만나는 가을" /></p>
										<span class="link">책으로 만나는 가을<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/137" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_6.png" alt="새로운 독서법 어때요?" /></p>
										<span class="link">새로운 독서법 어때요?<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/136" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_5.png" alt="책과 함께 봄을 만나요" /></p>
										<span class="link">책과 함께 봄을 만나요<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/98" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_1.png" alt="독서모임" /></p>
										<span class="link">독서모임<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/99" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_2.png" alt="겨울방학 유아 추천도서" /></p>
										<span class="link">겨울방학 유아 추천도서<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/100" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_3.png" alt="겨울방학 청소년 추천도서" /></p>
										<span class="link">겨울방학 청소년 추천도서<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/101" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>독서</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/bo_img_4.png" alt="겨울방학 성인 추천도서" /></p>
										<span class="link">겨울방학 성인 추천도서<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>