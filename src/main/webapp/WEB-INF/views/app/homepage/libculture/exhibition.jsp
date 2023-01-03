<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
	$(function() {
		const length = $('.main0Section01 .slickWrap > div').length
		$('.main0Section01 .slickWrap').slick({
			dots: false,
			arrows:false,
			infinite: true,
			speed: 300,
			slidesToShow: 3,
			variableWidth: true,
			autoplay: true,
			autoplaySpeed: 5000,
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
			$('.main0Section01 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
		});

		$('.main0Section01 .arrowBtn a').click(function(){
			if($(this).index() == 0){
				$('.main0Section01 .slickWrap').slick('slickPrev')
			}else{
				$('.main0Section01 .slickWrap').slick('slickNext')
			}
			return false;
		});

		$('.main0Section01 .slickPlay a').click(function(){
			if($(this).hasClass('play')){
				$('.main0Section01 .slickWrap').slick('slickPlay');
			}else {
				$('.main0Section01 .slickWrap').slick('slickPause');
			}
			$(this).hide().siblings('a').show();
			return false;
		});
	});
</script>

<h3>EXHIBITION</h3>
<div class="slideList mainSec00 main0Section01">
	<div class="innerBox">
		<div class="arrowBtn">
			<a href="#" class="prev">이전</a>
			<a href="#" class="next">다음</a>
		</div>

		<div class="slickPlay">
			<p class="status"><span> 01</span> / <fmt:formatNumber var="no" minIntegerDigits="2" value="${fn:length(exhibitionViewList)}" type="number"/> ${no}</p>
			<a href="#" class="play">시작</a>
			<a href="#" class="pause">멈춤</a>
		</div>
		<div class="slickWrap" data-animation="fadeInUp">
			<c:forEach var="i" items="${exhibitionViewList}">
				<div>
					<a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" target="_blank">
						<img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';"/>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div class="point-img">
	<img src="/resources/homepage/${homepage.context_path}/img/exhibition-img.png" alt="">
</div>