<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection02 .slickWrap > div').length
	$('.mainSection02 .slickWrap').not('.slick-initialized').slick({
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
			$('.mainSection02 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
		});

	$('.mainSection02 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection02 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection02 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection02 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection02 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection02 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection02">
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
									<a href="http://www.icuration.co.kr:81/curation/w/218" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_12.png" alt="STOP! 안전을 지켜요" /></p>
										<span class="link">STOP! 안전을 지켜요<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/206" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_11.png" alt="내 마음이 자라는 시간" /></p>
										<span class="link">내 마음이 자라는 시간<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/198" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_10.png" alt="환경 보호, 그림책과 함께하는 작은 실천" /></p>
										<span class="link">환경 보호, 그림책과 함께하는 작은 실천<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/184" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_9.png" alt="스마트한 도서관 이용법" /></p>
										<span class="link">스마트한 도서관 이용법<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/175" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_8.png" alt="메리 크리스마스" /></p>
										<span class="link">메리 크리스마스<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/162" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_7.png" alt="비가 오면 무슨 일이 생길까?" /></p>
										<span class="link">비가 오면 무슨 일이 생길까?<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/135" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_6.png" alt="그림책이 알려주는 과학" /></p>
										<span class="link">그림책이 알려주는 과학<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/134" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_5.png" alt="열려라, 창작 그림책" /></p>
										<span class="link">열려라, 창작 그림책<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/96" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_1.png" alt="그림책 책방이야기" /></p>
										<span class="link">그림책 책방이야기<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/92" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_2.png" alt="그림책 작가" /></p>
										<span class="link">그림책 작가<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/94" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_3.png" alt="영유아를 위한 그림책 추천" /></p>
										<span class="link">영유아를 위한 그림책 추천<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/95" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>그림책</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/pb_img_4.png" alt="어른들을 위한 그림책 추천" /></p>
										<span class="link">어른들을 위한 그림책 추천<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>