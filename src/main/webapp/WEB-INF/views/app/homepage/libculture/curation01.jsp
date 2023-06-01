<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>

$(function(){
	const length = $('.mainSection01 .slickWrap > div').length;

	$('.mainSection01 .slickWrap').not('.slick-initialized').slick({
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
					slidesToShow: 2,
					variableWidth: false
				}
			},
		]
	}).on('beforeChange',function(event, slick, currentSlide, nextSlide){
		$('.mainSection01 .slickPlay .status').html('<span>' + (nextSlide + 1) + '</span> / ' + length)
	});

	$('.mainSection01 .arrowBtn a').click(function(){
		if($(this).index() == 0){
			$('.mainSection01 .slickWrap').slick('slickPrev')
		}else{
			$('.mainSection01 .slickWrap').slick('slickNext')
		}
		return false;
	});

	$('.mainSection01 .slickPlay a').click(function(){
		if($(this).hasClass('play')){
			$('.mainSection01 .slickWrap').slick('slickPlay');
		}else {
			$('.mainSection01 .slickWrap').slick('slickPause');
		}
		$(this).hide().siblings('a').show();
		return false;
	});
});

</script>
					<div class="mainSection01">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>1</span> / 48</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/159" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>문화예술</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ct_img_7.png" alt="버스킹? BUSKING!" /></p>
										<span class="link">버스킹? BUSKING!<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/160" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>제작/체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ex_img_7.png" alt="완벽한 여름을 보내는 방법" /></p>
										<span class="link">완벽한 여름을 보내는 방법<i></i></span>
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
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_3.png" alt="유머가 있는 동화" /></p>
										<span class="link">유머가 있는 동화<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/119" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>동화</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/dh_img_4.png" alt="유아의 생활습관을 기르는 동화" /></p>
										<span class="link">유아의 생활습관을 기르는 동화<i></i></span>
									</a>
								</div>
								<div>
									<a href="http://www.icuration.co.kr:81/curation/w/118" target="_blank" class="newWin" title="새창으로 열립니다.">
										<h2>역사</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_1.png" alt="대구 지명의 유래와 역사" /></p>
										<span class="link">대구 지명의 유래와 역사<i></i></span>
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
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/ht_img_3.png" alt="대구의 역사적 인물" /></p>
										<span class="link">대구의 역사적 인물<i></i></span>
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