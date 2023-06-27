<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<style>
.swiper-container {width:800px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:100px;}
.swiper-slide {position:relative;text-align:center;font-size:18px;width:227px;height:405px;display:flex;justify-content:center;align-items:center;}
.swiper-slide div.thumb-image a img {width:227px;height:326px;border-radius:5px;box-shadow:3px 1px 11px 1px #888786;}
.swiper-slide div.thumb-image {display:block;}
.swiper-slide div.thumb-image a {display:block;}
.swiper-slide div.cont {position:absolute;bottom:-20px;}
.swiper-slide div.cont p.tit {font-size:23px;color:#000;letter-spacing:-1.25px;text-align:left;text-shadow:1px 1px 1px #383838;}
.swiper-slide div.cont p.auth {font-size:18px;color:#bbbbbb;letter-spacing:-1.25px;text-align:left;text-shadow:1px 1px 1px #383838;}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>
<script src="/resources/common/js/kiosk/swiper.min.js"></script>
<script type="text/javascript">
var swiper = new Swiper('.swiper-container', {
	pagination: '.swiper-pagination',
	slidesPerView: 3,
	slidesPerColumn: 3,
	paginationClickable: true,
	spaceBetween: 30
});
</script>
<div class="recommandbook-wrap">
	<div class="header">
		<h1>추천도서</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach items="${boardList}" var="i" varStatus="status" begin="0" end="9">
					<div class="swiper-slide">
						<div class="thumb-image">
							<a href="/${homepage.context_path}/kiosk/recommandBoardView.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
								<c:choose>
									<c:when test="${i.preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(i.preview_img, 'http')}">
												<c:choose>
													<c:when test="${fn:contains(i.preview_img, 'noimg')}">
														<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
													</c:when>
													<c:otherwise>
														<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'">
									</c:otherwise>
								</c:choose>
							</a>
						</div>
						<div class="cont">
							<p class="tit">
								${fn:substring(i.title, 0, 30)}<c:if test="${fn:length(i.title) > 30}">...</c:if>
							</p>
							<p class="auth">
								<c:if test="${i.imsi_v_3 ne null and i.imsi_v_3 ne '' and i.imsi_v_3 ne '0'}">
									${fn:substring(i.imsi_v_3, 0, 20)}<c:if test="${fn:length(i.imsi_v_3) > 20}">...</c:if>
								</c:if>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />