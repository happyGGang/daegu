<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.salip.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.swiper.css"/>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.swiper.min.js"></script>

<script type="text/javascript">
	$(function() {
		$('#homeup').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});

		// 팝업 관련 코드 START
		$('.close-btn').on('click', function() {
			var $this = $(this);
			var checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if($this.data('day') == 7) {
					todayDate.setDate(todayDate.getDate() + 7);
				}
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#' + popupId).hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$(this).parent('div').next('a').data('day', $(this).data('day'));
			$(this).parent('div').next('a').click();
		});

		$('#popupLayer > div').each(function(i, v) {
			var result = '';
			var name = $(v).attr('id');
			var nameOfCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie
							.indexOf(";", y)) == -1)
						endOfCookie = document.cookie.length;
					result = unescape(document.cookie
							.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}

			if (result != 'no') {
				if  (window.innerWidth < $(v).width() ) {
					$(v).css('width', 'auto');
				}
				$(v).show();
			}
		});
		// 팝업 관련 코드 END

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('찾으시는 도서의 정보를 입력해주세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

});
</script>
<div id="wrap">
	<c:if test="${fn:length(popupZoneTopList) > 0}">
	<div class="popup_top">
		<div class="popup">
			<div class="pop_contents">
				<div class="topPopZone">
					<homepageTag:popupZoneTop popupZoneList="${popupZoneTopList}"/>
				</div>
			</div>
			<p class="close"><input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기"/></a></p>
		</div>
	</div>
	</c:if>

	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap main-section3">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main0-wrap">
				<div class="main0-top">
					<div class="main-section3">
						<div class="main0-top-left">
							<div class="main0-txt">
								<p class='gray-txt'>Daegu Private Public Yeonam Library</p>
								<p class='txt'><b>연암도서관</b>이<br/>나를 성장시키고, 세상을 바꾼다.</p>
							</div>
							<!-- main_search -->
							<div class="search-area" id="main_search">
								<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="9">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<div class="box2">
												<label for="search_text_1" class="blind">통합자료검색</label>
												<input name="title" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서의 정보를 입력해주세요." style="ime-mode:active;"/>
											</div>
										</div>
										<button id="main-search-btn">검색하기</button>
									</div>
								</fieldset>
								</form>
							</div>
							<!-- //Main_search -->
						</div>						
						<div class="main0-top-right">
							<img src="/resources/homepage/${homepage.context_path}/img/main0-visual-img.png" alt="">
						</div>
					</div>
				</div>
				<div class="main0-bottom">
					<div class="main-section3">
						<div class="quick-menu">
							<ul>
								<li class="quick01">
									<a href="/yeonam/html.do?menu_idx=20" class="q01">
										<span>이용안내</span>
									</a>
								</li>
								<li class="quick02">
									<a href="/yeonam/intro/search/loan/index.do?menu_idx=54" class="q02">
										<span>대출정보조회</span>
									</a>
								</li>
								<li class="quick03">
									<a href="/yeonam/html.do?menu_idx=18" class="q03">
										<span>희망도서신청</span>
									</a>
								</li>
								<li class="quick04">
									<a href="/yeonam/intro/search/loan/index.do?menu_idx=54" class="q04">
										<span>MY도서관</span>
									</a>
								</li>
								<li class="quick05">
									<a href="/yeonam/html.do?menu_idx=43" class="q05">
										<span>찾아오는길</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section3'>
				<div class="book-box web-view">
					<div id="main-slide" class="main-floor1">
						<div class="book-box-title">
							<h4>신착도서</h4>
							<a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=11" class="more-btn">더보기 +</a>
						</div>
						<div class="swiper-container gallery-top-main">
							<div class="swiper-wrapper">
								<c:forEach items="${newBookList}" var="i" begin="0" end="9">
								<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=11&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<div class="swiper-slide">
												<div class="main-slide1-con">
													<div class="text">
														<h4>${i.TITLE_INFO}</h4>
													</div>
													<div class="photo">
														<a href="${detailURL}">
															<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
														</a>
													</div>
												</div>
											</div>
										</c:when>
										<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
											<div class="swiper-slide">
												<div class="main-slide1-con">
													<div class="text">
														<h4>${detail.TITLE_INFO}</h4>
													</div>
													<div class="photo">
														<a href="${detailURL}">
															<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
														</a>
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="swiper-slide">
												<div class="main-slide1-con">
													<div class="text">
														<h4>${i.TITLE_INFO}</h4>
													</div>
													<div class="photo">
														<a href="${detailURL}">
															<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
														</a>
													</div>
												</div>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${empty newBookList}">
									<div class="swiper-slide">
										<div class="main-slide1-con">
											<div class="text">
												<h4>등록된 신착도서가 없습니다.</h4>
											</div>
											<div class="photo">
												<a href="#">
													<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 신착도서가 없습니다." />
												</a>
											</div>
										</div>
									</div>
								</c:if>
							</div>
						</div>
						<div class="swiper-container gallery-thumbs-main">
							<div class="swiper-wrapper">
								<c:forEach items="${newBookList}" var="i" begin="0" end="9">
								<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=11&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<div class="swiper-slide">
												<span>
													<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
												</span>
											</div>
										</c:when>
										<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
											<div class="swiper-slide">
												<span>
													<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
												</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="swiper-slide">
												<span>
													<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
												</span>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${empty newBookList}">
									<div class="swiper-slide">
										<span>
											<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 신착도서가 없습니다." />
										</span>
									</div>
								</c:if>
							</div>
						</div>
						<!-- Add Arrows -->
						<a href="#none" class="swiper-button-next" id="focusA"></a>
						<a href="#none" class="swiper-button-prev"></a>
						<!--등록된 도서 없을 경우-->
						</div>
					<script>
						var galleryThumbsMain = new Swiper('.gallery-thumbs-main', {
							spaceBetween: 10,
							slidesPerView: 7,
							loop: true,
							touchRatio: 0.2,
							slideToClickedSlide: true,
							freeMode: true,
							loopedSlides: 7, //looped slides should be the same
							watchSlidesVisibility: true,
							watchSlidesProgress: true,
						});
						var galleryTopMain = new Swiper('.gallery-top-main', {
							spaceBetween: 7,
							effect: 'fade',
							loop:true,
							autoplay: {
								delay: 3000,
								disableOnInteraction: false,
							},
							loopedSlides: 7, //looped slides should be the same
							navigation: {
								nextEl: '.swiper-button-next',
								prevEl: '.swiper-button-prev',
							},
							 pagination: {
								el: '.swiper-pagination',
								clickable: true,
							},
							on: {
								autoplayStop: function() {
									this.$el.find(".ups-icon-videoplay").addClass('stop-status');
								},
								autoplayStart: function() {
									this.$el.find(".ups-icon-videoplay").removeClass('stop-status');
								},
							},
						});
						galleryTopMain.$el.find(".ups-icon-videoplay").on('click', function() {
							if (galleryTopMain.autoplay.running) {
								galleryTopMain.autoplay.stop();
							} else {
								galleryTopMain.autoplay.start();
							}
						});
						galleryTopMain.controller.control = galleryThumbsMain; 
						galleryThumbsMain.controller.control = galleryTopMain;
					</script>
				</div>

				<div class="book-box mobile-view">
					<div class="book-box-title">
						<h4>신착도서</h4>
						<a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=11" class="more-btn">신착도서 더보기 +</a>
					</div>
					<div class="cont">
						<ul>
							<c:forEach items="${newBookList}" var="i" begin="0" end="9">
							<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=11&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
								<c:choose>
									<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
									<li>
									<a href="${detailURL}">
										<div class="thumbnails">
											<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
										</div>
										<h3 class="book-title">${i.TITLE_INFO}</h3>
									</a>
									</c:when>
									<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
									<a href="${detailURL}">
										<div class="thumbnails">
											<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
										</div>
										<h3 class="book-title">${i.TITLE_INFO}</h3>
									</a>
									</c:when>
									<c:otherwise>
									<a href="${detailURL}">
										<div class="thumbnails">
											<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
										</div>
										<h3 class="book-title">${i.TITLE_INFO}</h3>
									</a>
									</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${empty newBookList}">
							<li>
								<a href="#">
									<div class="thumbnails">
										<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 신착도서가 없습니다."/>
									</div>
									<h3 class="book-title">등록된 신착도서가 없습니다.</h3>
								</a>
							</li>
							</c:if>
						</ul>
					</div>
				</div>

				<div class="culture-box">
					<ul>
						<c:forEach var="i" varStatus="status" items="${teachList1}" begin="0" end="1">
							<li>
								<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=29&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
									<span class="culture-tit">[${i.category_name}] ${i.teach_name}</span>
									<span class="culture-cot">
										<p>강좌기간 : <b>${i.start_date} ~ ${i.end_date}</b></p>
										<p>접수기간 : <b>${i.start_join_date} ~ ${i.end_join_date}</b></p>
									</span>
								</a>
							</li>
						</c:forEach>

						<c:if test="${empty teachList1}">
							<li>
								등록된 문화행사가 없습니다.
							</li>
						</c:if>
					</ul>
				</div>
				<div class="culture-more-box"><a href="/yeonam/module/teach/index.do?menu_idx=29&searchCate1=16">문화행사 더보기 +</a></div>
			</div>
		</div>
		<!-- //main1 -->

		<!-- footer_section -->
		<div class="banner-box">
			<div class="main-section3">
				<div class="banner-wrap type5">
					<div class="banner-t5">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/common/img/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/common/img/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
							<a class="stop active" href="#stop"><img src="/resources/common/img/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
							<a class="play" href="#play"><img src="/resources/common/img/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=67"><img src="/resources/common/img/salip/banner-more-btn.png" alt="목록보기" /><span class="blind">목록보기</span></a>
						</div>
					</div>
					<div class="banner-box5">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
		<div class="section fp-auto-height footer_area" id="foot_section">
			<tiles:insertAttribute name="footer" />
		</div>
		<!-- //footer_section -->


	</div>

</div>


</body>
</html>


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage', '3rdPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				//$('#header').addClass("background-white");
				//$('.Gnb').css('border-bottom','0');
				//$('.Gnb').css('background','none');
				//$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {				
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			} else {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}
		},
		afterResponsive: function(isResponsive){}
	});
};

fullPage();

// 모바일일 경우 fullpage 미사용
if ( $(window).width() < 1025 ) {
	if ($('#fullpage').hasClass('fp-destroyed')){
	} else {
		fullpage_api.destroy('all');
	}
} else {
	fullPage();
};

// 리사이즈 될때 모바일 화면에서 fullpage 미사용
$( window ).resize( function(e) {
	if ( $(window).width() < 1025 ) {
		if ($('#fullpage').hasClass('fp-destroyed')){
		} else {
			fullpage_api.destroy('all');
		}
	} else {
		fullPage();
	};
});
</script>

