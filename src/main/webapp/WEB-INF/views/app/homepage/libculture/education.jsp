<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" type="text/css" href="/resources/common/css/education_common.css">
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


<h3>EDUCATION</h3>
<div class="slideList mainSec00 main0Section01">
	<div class="innerBox">
		<div class="arrowBtn">
			<a href="#" class="prev">이전</a>
			<a href="#" class="next">다음</a>
		</div>	

		<div class="slickPlay">
			<p class="status"><span> 01</span> / <fmt:formatNumber var="no" minIntegerDigits="2" value="${fn:length(teachViewList)}" type="number"/> ${no}</p>
			<a href="#" class="play">시작</a>
			<a href="#" class="pause">멈춤</a>
		</div>
		<div class="slickWrap" data-animation="fadeInUp">
			<c:forEach var="i" items="${teachViewList}">
				<c:set var="ran"><%= java.lang.Math.round(java.lang.Math.random() * 9) %></c:set>
				<div>						
					<c:choose>
						<c:when test="${i.image_server_file_name eq null || i.image_server_file_name eq ''}">
							<a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" target="_blank">
								<div class="education-bg edubg0${ran}">
									<c:choose>
										<c:when test="${i.homepage_id eq 'h10' || i.homepage_id eq 'h2' || i.homepage_id eq 'h34' || i.homepage_id eq 'h74' || i.homepage_id eq 'h75' || i.homepage_id eq 'h76' || i.homepage_id eq 'h53'}"><!-- 중구 -->
										<span class="color-junggu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h1' || i.homepage_id eq 'h45' || i.homepage_id eq 'h59' || i.homepage_id eq 'h73' || i.homepage_id eq 'h60' || i.homepage_id eq 'h5' || i.homepage_id eq 'h100'}"><!-- 동구 -->
										<span class="color-donggu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h49' || i.homepage_id eq 'h61' || i.homepage_id eq 'h62' || i.homepage_id eq 'h63' || i.homepage_id eq 'h64' || i.homepage_id eq 'h65' || i.homepage_id eq 'h77' || i.homepage_id eq 'h8'}"><!-- 서구 -->
										<span class="color-seogu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h3' || i.homepage_id eq 'h35' || i.homepage_id eq 'h36'}"><!-- 남구 -->
										<span class="color-namgu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h7' || i.homepage_id eq 'h46' || i.homepage_id eq 'h47' || i.homepage_id eq 'h48'}"><!-- 북구 -->
										<span class="color-bukgu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h9' || i.homepage_id eq 'h50' || i.homepage_id eq 'h51' || i.homepage_id eq 'h52' || i.homepage_id eq 'h54' || i.homepage_id eq 'h55' || i.homepage_id eq 'h56' || i.homepage_id eq 'h57' || i.homepage_id eq 'h58' || i.homepage_id eq 'h93'}"><!-- 수성구 -->
										<span class="color-suseonggu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h6' || i.homepage_id eq 'h37' || i.homepage_id eq 'h66' || i.homepage_id eq 'h67' || i.homepage_id eq 'h68' || i.homepage_id eq 'h69' || i.homepage_id eq 'h70' || i.homepage_id eq 'h71' || i.homepage_id eq 'h72'}"><!-- 달서구 -->
										<span class="color-dalseogu">${i.homepage_alias}</span>
										</c:when>
										<c:when test="${i.homepage_id eq 'h4' || i.homepage_id eq 'h43' || i.homepage_id eq 'h44'}"><!-- 달성군 -->
										<span class="color-dalseonggun">${i.homepage_alias}</span>
										</c:when>
										<c:otherwise><!-- 예외 -->
										<span class="color-etc">${i.homepage_alias}</span>
										</c:otherwise>
									</c:choose>	
									<h4>${i.teach_name}</h4>
									<p class='days'>${i.start_join_date} ~<br />${i.end_join_date}</p>
								</div>
							</a>
						</c:when>
						<c:otherwise>
							<a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" target="_blank">
								<img src="/data/teach/${i.homepage_id}/img/${i.image_server_file_name}" alt="${i.teach_name}" title="${i.teach_name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" />
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div class="point-img">
	<img src="/resources/homepage/${homepage.context_path}/img/education-img.png" alt="">
</div>