<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/common/css/mediawall/swiper-bundle.min.css" />

<script src="/resources/common/js/mediawall/swiper-bundle.min.js"></script>
<script type="text/javascript">
</script>
<div class="recommandbook-wrap">
	<div class="header">
		<h1>Book information</h1>
	</div>
	<div class="contents">
		<div class="inlineblock">
			<h2>신간도서</h2>
			<div class="swiper-container">
				<div class="swiper-container-01">
					<div class="swiper-wrapper">
						<c:forEach items="${newBookList}" var="i" begin="0" end="3" varStatus="status">
							<div class="swiper-slide slide0${status.index}">
								<div class="photo-info">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다. " onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<c:choose>
											<c:when test="${i.aladin.cover eq '/resources/images/bg_noImage2.png'}">
												<c:set var='imgUrl' value='/resources/common/img/gukbo_noimg.png'/>
												<img src="${imgUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:when>
											<c:otherwise>
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
											<c:when test="${i.imageUrl eq '/resources/images/bg_noImage2.png'}">
												<c:set var='imgUrl' value='/resources/common/img/gukbo_noimg.png'/>
												<img src="${imgUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:when>
											<c:otherwise>
												<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.TITLE_INFO, 0, 15)}<c:if test="${fn:length(i.TITLE_INFO) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.AUTHOR, 0, 5)}. ${fn:substring(i.PUBLISHER, 0, 3)}. ${fn:substring(i.PUB_YEAR, 0, 4)}.</p>
									<p class="review-info">${i.contentsDetail}</p>
								</div>
								<div class="end"></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div thumbsSlider="" class="swiper-thumbs-container-01">
					<div class="swiper-wrapper">
						<c:forEach items="${newBookList}" var="i" begin="0" end="3">
							<div class="swiper-slide">
								<div class="photo-info">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다. " onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<c:choose>
											<c:when test="${i.aladin.cover eq '/resources/images/bg_noImage2.png'}">
												<c:set var='imgUrl' value='/resources/common/img/gukbo_noimg.png'/>
												<img src="${imgUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:when>
											<c:otherwise>
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
											<c:when test="${i.imageUrl eq '/resources/images/bg_noImage2.png'}">
												<c:set var='imgUrl' value='/resources/common/img/gukbo_noimg.png'/>
												<img src="${imgUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:when>
											<c:otherwise>
												<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
											</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.TITLE_INFO, 0, 15)}<c:if test="${fn:length(i.TITLE_INFO) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.AUTHOR, 0, 5)}. ${fn:substring(i.PUBLISHER, 0, 3)}. ${fn:substring(i.PUB_YEAR, 0, 4)}.</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- Initialize Swiper -->
			<script>
				var galleryTopMain01 = new Swiper('.swiper-container-01', {
					loop:true,
					spaceBetween: 10,
					effect: 'fade',
					autoplay: {
						delay: 5000,
						disableOnInteraction: false,
					},
					thumbs: {
						swiper: galleryThumbsMain01,
					},
					on: {
						activeIndexChange: function () {
							$('.swiper-container-01 .swiper-slide .swiper-slide-con').hide();
							$('.swiper-container-01 .swiper-slide.slide0'+this.realIndex+' .swiper-slide-con').show();
						}
					}
				});

				var galleryThumbsMain01 = new Swiper('.swiper-thumbs-container-01', {
					loop: true,
					spaceBetween: 10,
					slidesPerView: 4,
					freeMode: true,
					watchSlidesProgress: true,
				});
			</script>
		</div>

		<div class="inlineblock">
			<h2>대출베스트</h2>
			<div class="swiper-container">
				<div class="swiper-container-02">
					<div class="swiper-wrapper">
						<c:forEach items="${bestBookList}" var="i" begin="0" end="3" varStatus="status">
							<div class="swiper-slide slide0${status.index}">
								<div class="photo-info">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.TITLE, 0, 15)}<c:if test="${fn:length(i.TITLE) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.AUTHOR, 0, 5)}. ${fn:substring(i.PUBLISHER, 0, 3)}. ${fn:substring(i.PUBLISH_YEAR, 0, 4)}.</p>
									<p class="review-info">${i.contentsDetail}</p>
								</div>
								<div class="end"></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div thumbsSlider="" class="swiper-thumbs-container-02">
					<div class="swiper-wrapper">
						<c:forEach items="${bestBookList}" var="i" begin="0" end="3">
							<div class="swiper-slide">
								<div class="photo-info">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.TITLE, 0, 15)}<c:if test="${fn:length(i.TITLE) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.AUTHOR, 0, 5)}. ${fn:substring(i.PUBLISHER, 0, 3)}. ${fn:substring(i.PUBLISH_YEAR, 0, 4)}.</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- Initialize Swiper -->
			<script>
				var galleryTopMain02 = new Swiper('.swiper-container-02', {
					loop:true,
					spaceBetween: 10,
					effect: 'fade',
					autoplay: {
						delay: 5000,
						disableOnInteraction: false,
					},
					thumbs: {
						swiper: galleryThumbsMain02,
					},
					on: {
						activeIndexChange: function () {
							$('.swiper-container-02 .swiper-slide .swiper-slide-con').hide();
							$('.swiper-container-02 .swiper-slide.slide0'+this.realIndex+' .swiper-slide-con').show();
						}
					}
				});

				var galleryThumbsMain02 = new Swiper('.swiper-thumbs-container-02', {
					loop: true,
					spaceBetween: 10,
					slidesPerView: 4,
					freeMode: true,
					watchSlidesProgress: true,
				});
			</script>
		</div>

		<div class="inlineblock">
			<h2>추천도서</h2>
			<div class="swiper-container">
				<div class="swiper-container-03">
					<div class="swiper-wrapper">
						<c:forEach items="${bookList}" var="i" begin="0" end="3" varStatus="status">
							<div class="swiper-slide slide0${status.index}">
								<div class="photo-info">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'noimg')}">
															<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
														</c:when>
														<c:otherwise>
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.title, 0, 15)}<c:if test="${fn:length(i.title) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.imsi_v_3, 0, 5)}. ${fn:substring(i.imsi_v_4, 0, 3)}. ${fn:substring(i.imsi_v_2, 0, 4)}.</p>
									<p class="review-info">${i.content_summary}</p>
								</div>
								<div class="end"></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div thumbsSlider="" class="swiper-thumbs-container-03">
					<div class="swiper-wrapper">
						<c:forEach items="${bookList}" var="i" begin="0" end="3">
							<div class="swiper-slide">
								<div class="photo-info">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'noimg')}">
															<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
														</c:when>
														<c:otherwise>
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/gukbo_noimg.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/gukbo_noimg.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="swiper-slide-con">
									<h3>${fn:substring(i.title, 0, 15)}<c:if test="${fn:length(i.title) > 15}">...</c:if></h3>
									<p class="author-pub-info">${fn:substring(i.imsi_v_3, 0, 5)}. ${fn:substring(i.imsi_v_4, 0, 3)}. ${fn:substring(i.imsi_v_2, 0, 4)}.</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- Initialize Swiper -->
			<script>
				var galleryTopMain03 = new Swiper('.swiper-container-03', {
					loop:true,
					spaceBetween: 10,
					effect: 'fade',
					autoplay: {
						delay: 5000,
						disableOnInteraction: false,
					},
					thumbs: {
						swiper: galleryThumbsMain03,
					},
					on: {
						activeIndexChange: function () {
							$('.swiper-container-03 .swiper-slide .swiper-slide-con').hide();
							$('.swiper-container-03 .swiper-slide.slide0'+this.realIndex+' .swiper-slide-con').show();
						}
					}
				});

				var galleryThumbsMain03 = new Swiper('.swiper-thumbs-container-03', {
					loop: true,
					spaceBetween: 10,
					slidesPerView: 4,
					freeMode: true,
					watchSlidesProgress: true,
				});
			</script>
		</div>

	</div>
	<div class="copyright" style="color:#825d48;">
		The National Debt Redemption Movement Memorial Library
	</div>
</div>
<tiles:insertAttribute name="footer" />