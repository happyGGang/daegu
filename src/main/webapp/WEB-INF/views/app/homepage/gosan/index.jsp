<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
int listNum3 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
do {
	listNum3 = rnd.nextInt(10);
} while (listNum1 == listNum3 || listNum2 == listNum3);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>
<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
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


		$('div#calendar-box').load('calendar3.do');
		$('ul.newBookUl').load('newBook.do');
		$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

		$('.menu-search-box').on('click', function() {
			alert('준비중');
		});
});
</script>
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-visual">

				<div class="swiper-container mySwiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide mvimg01"><div class="mvText">책장에서 꺼내는 나의 꿈<strong>수성구립 고산도서관</strong></div></div>
						<div class="swiper-slide mvimg02"><div class="mvText">책장에서 꺼내는 나의 꿈<strong>수성구립 고산도서관</strong></div></div>
						<div class="swiper-slide mvimg03"><div class="mvText">책장에서 꺼내는 나의 꿈<strong>수성구립 고산도서관</strong></div></div>
					</div>

					<div class="mvBtn_wp">
						<div class="mvBtn">
							<div class="swiper-button-next"><img src="/resources/homepage/${homepage.context_path}/img/next-btn.png" alt="다음"></div>
							<div class="swiper-button-prev"><img src="/resources/homepage/${homepage.context_path}/img/prev-btn.png" alt="이전"></div>
						</div>
						<div class="swiper-pagination"></div>

						<div class="ctrBtn">
							<a href="#" class="stop">stop</a>
							<a href="#" class="start">play</a>
						</div>
					</div>
				</div>

				<!-- main_search -->
				<div class="search-area" id="main_search">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
					<input type="hidden" name="menu_idx" value="9">
					<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="main-box">
							
							<div class="search-box">
								<div class="box1">
									<div class="box2">
										<label for="search_text_1" class="blind">통합자료검색</label>
										<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
									</div>
								</div>
								<button id="main-search-btn">검색하기</button>
							</div>

						</div>
					</fieldset>
					</form>
				</div>
				<!-- //Main_search -->

				<div class="quickmenu-box">
					<div class="main-box">
						<div class="qmenu">
							<ul>
								<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
							</ul>
						</div>
					</div>
				</div>

				<div class="main_scroll"><div class="main_scroll_wp">scroll down</div></div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">

			<div class="main1-top">
				<div class='main-section'>

					<div class="notice-box tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" data-link="board/index.do?menu_idx=35&manage_idx=730" class='t-tabs'>공지사항</a></li>
							<li><a href="#tab2" data-link="module/teach/index.do?menu_idx=90" class='t-tabs'>문화행사</a></li>
						</ul>
						<a href="board/index.do?menu_idx=35&manage_idx=730" class="btn-more2 more-more">더보기</a>

						<div class="news con" data-tab="tab1">
							<div class="box">
								<ul>
									<c:forEach items="${noticeList}" var="i" varStatus="status" begin="0" end="4">
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=730&board_idx=${i.board_idx}">
												<span class="sulib001">수성</span>
												<em>${i.title}</em>
												<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>

						<div class="news con" data-tab="tab2" style="display:none;">
							<div class="box">
								<ul>
									<c:forEach items="${teachList}" var="i" varStatus="status" begin="0" end="4">
										<c:set var="teachMenuIdx" value="90"></c:set>
										<c:if test="${i.large_category_idx eq 16}">
											<c:set var="teachMenuIdx" value="90"></c:set>
										</c:if>
										<c:if test="${i.large_category_idx eq 17}">
											<c:set var="teachMenuIdx" value="32"></c:set>
										</c:if>
										<c:if test="${i.large_category_idx eq 18}">
											<c:set var="teachMenuIdx" value="91"></c:set>
										</c:if>
										<li>
											<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=${teachMenuIdx}&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&homepage_id=${i.homepage_id}">
												<span class="sulib001">수성</span>
												<em>${i.teach_name}</em>
												<span class="date">${i.start_date}</span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>

					<div class="information-box">
						<ul>
							<li><span>어린이자료실</span>평일 09:00 - 18:00 / 주말 09:00 - 17:00</li>
							<li><span>종합자료실1,2</span>평일 09:00 - 20:00 / 주말 09:00 - 17:00</li>
							<li><span>국제자료실</span>평일 09:00 - 20:00 / 주말 09:00 - 17:00</li>
						</ul>
						<p>휴관일은 <span style="color:#ff0000;">매주 월요일 및 국경일, 정부지정 공휴일</span>입니다.<Br/>(공휴일과 일요일이 겹칠 경우 휴관합니다.) </p>
					</div>

					<div class="end"></div>
				</div>
			</div>

			<div class="main1-bottom">
				<div class="top-box">
					<div class="main-section">
						<h2 class="title"><img src="/resources/homepage/${homepage.context_path}/img/sns-title.png" alt="sns-title"></h2>
						<div class="sns-link">
							<ul>
								<li>
									<a href="https://www.youtube.com/channel/UCpFk_NLreb3wW5AOpXH0e5w" target="_blank">
										<img src="/resources/homepage/${homepage.context_path}/img/youtube-icon.png" alt="YOUTUBE"> <br class="br650"/>YOUTUBE
									</a>
								</li>
								<li>
									<a href="https://www.facebook.com/lib.gosan/" target="_blank">
										<img src="/resources/homepage/${homepage.context_path}/img/facebook-icon.png" alt="FACEBOOK"> <br class="br650"/>FACEBOOK
									</a>
								</li>
								<li>
									<a href="https://www.instagram.com/gosanlibrary/" target="_blank">
										<img src="/resources/homepage/${homepage.context_path}/img/instargram-icon.png" alt="INSTAGRAM"> <br class="br650"/>INSTAGRAM
									</a>
								</li>
								<li>
									<a href="" target="_blank">
										<img src="/resources/homepage/${homepage.context_path}/img/kakaostory-icon.png" alt="KAKAOSTORY"> <br class="br650"/>KAKAOSTORY
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="middle-box">
					<div class="main-section">
						<div class="book-box">
							<div class="book-tit-box">
								<h2>추천도서</h2>
								<p>수성구립 고산도서관에서 <Br class='webBr'/>추천드리는 도서를 <Br class='webBr'/>소개합니다.</p>
							</div>

							<div class="book-con-box">
								<div class="bookList">
									<ul>
										<c:forEach items="${bookList1}" var="i" varStatus="status">
											<li class="item">
												<a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
													<c:choose>
														<c:when test="${i.preview_img ne null}">
															<c:choose>
																<c:when test="${fn:contains(i.preview_img, 'http')}">
																	<img src="${i.preview_img}" alt="${i.title}" />
																</c:when>
																<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
																	<img src="${i.preview_img}" alt="${i.title}" />
																</c:when>
																<c:otherwise>
																	<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
														</c:otherwise>
													</c:choose>
													<div class="figure-bg-section">
														<div class="figure-btn-section">
																${i.title}
														</div>
													</div>
												</a>
											</li>
										</c:forEach>

									</ul>
								</div>
							</div>
						</div>

						<div class="quickLink-box">
							<ul>
								<li><a href="html.do?menu_idx=98">과학문화@suseong</a></li>
								<li><a href="">동네책방in고산도서관</a></li>
								<li><a href="html.do?menu_idx=87">북큐레이션</a></li>
								<li><a href="">원문제공서비스</a></li>
								<li><a href="html.do?menu_idx=25">대구전자도서관</a></li>
								<li><a href="html.do?menu_idx=22">책나래서비스</a></li>
								<li><a href="html.do?menu_idx=23">책바다서비스</a></li>
								<li><a href="html.do?menu_idx=24">사서에게물어보세요</a></li>
							</ul>
						</div>

						<div class="end"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">

			<div class="main1-bottom">
				<div class='main-section'>
					<div class="calendar-box" id="calendar-box">
					</div>
					<div class="popupzone-box">
						<div class="popZone">
							<c:choose>
								<c:when test="${fn:length(popupZoneList) > 0}">
									<homepageTag:popupZone popupZoneList="${popupZoneList}" />
								</c:when>
								<c:otherwise>
									<ul>
										<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="등록된 팝업이 없습니다." /></a></li>
									</ul>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>

			<div class="bottom-box">
				<div class="main-section">
					<div class="banner-wrap type4">
						<div class="banner-t4">
							<div class="control">
								<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
								<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
							</div>
						</div>
						<div class="banner-box4">
							<homepageTag:banner bannerList="${bannerList}"/> 
						</div>
					</div>
				</div>

				<!-- footer_section -->
				<div class="section fp-auto-height footer_area" id="foot_section">
					<tiles:insertAttribute name="footer" />
				</div>
				<!-- //footer_section -->
			</div>	
		</div>
		<!-- //main2 -->
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
				$('#header').addClass("background-white");
				$('.Gnb').css('border-top','1px solid rgba(255,255,255,0.15)');
				$('.Gnb').css('border-bottom','1px solid rgba(255,255,255,0.15)');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
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
<script>
    var mySwiper = new Swiper('.mySwiper', {
      spaceBetween: 30,
      centeredSlides: true,
      autoplay: {
        delay: 5000,
        disableOnInteraction: false,
      },
	  effect: 'fade',
	  loop: true,
      pagination: {
        el: '.swiper-pagination',
        type: 'fraction',
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
	$('.start').on('click', function(){
		mySwiper.autoplay.start();
		return false;
	})
	$('.stop').on('click', function(){
		mySwiper.autoplay.stop();
		return false;
	});

</script>
