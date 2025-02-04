<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection04 .slickWrap > div').length
	$('.mainSection04 .slickWrap').not('.slick-initialized').slick({
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
		$('.mainSection04 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	  });

	$('.mainSection04 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection04 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection04 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection04 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection04 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection04 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection04">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>1</span> / 12</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/210" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_12.png" alt="고전이 들려주는 위대한 이야기" /></p>
										<span class="link">고전이 들려주는 위대한 이야기<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/196" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_11.png" alt="세상을 바꾼 철학자들" /></p>
										<span class="link">세상을 바꾼 철학자들<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/196" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_10.png" alt="공간의 인문학" /></p>
										<span class="link">공간의 인문학<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/187" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_9.png" alt="길라잡이 인문학" /></p>
										<span class="link">길라잡이 인문학<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/182" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_8.png" alt="추운 겨울 따뜻한 인문학" /></p>
										<span class="link">추운 겨울 따뜻한 인문학<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/173" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_7.png" alt="철학이 어려운 당신에게" /></p>
										<span class="link">철학이 어려운 당신에게<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/139" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_6.png" alt="여행을 떠나요, 인문학 만나러" /></p>
										<span class="link">여행을 떠나요, 인문학 만나러<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/138" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_5.png" alt="인문학으로 보는 우리의 미래" /></p>
										<span class="link">인문학으로 보는 우리의 미래<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/103" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_1.png" alt="대구 근교 인문학 투어" /></p>
										<span class="link">대구 근교 인문학 투어<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/104" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_2.png" alt="어른을 위한 인문학 도서 추천" /></p>
										<span class="link">어른을 위한 인문학 도서 추천<i></i></span>
									</a>
								</div>						
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/131" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_3.png" alt="국내 인문학 명소" /></p>
										<span class="link">국내 인문학 명소<i></i></span>
									</a>
								</div>							
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/106" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/im_img_4.png" alt="영화를 통해 인문학 알아보기" /></p>
										<span class="link">영화를 통해 인문학 알아보기<i></i></span>
									</a>
								</div>	
							</div>
						</div>
					</div>