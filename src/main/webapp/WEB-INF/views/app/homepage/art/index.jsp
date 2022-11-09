<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>

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
				alert('검색어를 입력하세요.');
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

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-section2">

				<div class="main0-left">
					<img src="/resources/homepage/${homepage.context_path}/img/art-lachivium.png" alt="">
				</div>
				<div class="main0-right">
					<div class="comment">
						<p class="stxt">ART LIBRARY</p>
						<p class="ltxt">국내 최초<br/><b>미술전문도서관</b></p>
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

			</div>
			<div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div>
		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section3'>

				<div class="notice-title">
					<h3>Notice</h3>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=699" class="btn-more2 more-more">더보기</a>
				</div>
				<div class="con">
					<div class="box">
						<ul>
							<li>
								<a href="">
									<span class="time"><b>2022.09.13</b></span>
									<span class="contents">
										<p class='tit'>아트도서관 관람시간 안내</p>
										<p class='cont'>아트도서관 관람 시간을  다음과 같이 운영합니다. 화요일~토요일:  오전11시~오후9시 일요일~월요일 : 오후2시 ~ 오후9시 문화행사 및 특강 대관등의 마침 시간은 연장할 수 있습니다. 차후 월요일은 휴관 할 예정이오니 참고  바랍니다. 감사합니다. 문의: 010-3588-5252 (허두환 관장) </p>
									</span>
								</a>
							</li>
							<li>
								<a href="">
									<span class="time"><b>2022.09.13</b></span>
									<span class="contents">
										<p class='tit'>아트도서관 관람시간 안내</p>
										<p class='cont'>아트도서관 관람 시간을  다음과 같이 운영합니다. 화요일~토요일:  오전11시~오후9시 일요일~월요일 : 오후2시 ~ 오후9시 문화행사 및 특강 대관등의 마침 시간은 연장할 수 있습니다. 차후 월요일은 휴관 할 예정이오니 참고  바랍니다. 감사합니다. 문의: 010-3588-5252 (허두환 관장) </p>
									</span>
								</a>
							</li>
							<li>
								<a href="">
									<span class="time"><b>2022.09.13</b></span>
									<span class="contents">
										<p class='tit'>아트도서관 관람시간 안내</p>
										<p class='cont'>아트도서관 관람 시간을  다음과 같이 운영합니다. 화요일~토요일:  오전11시~오후9시 일요일~월요일 : 오후2시 ~ 오후9시 문화행사 및 특강 대관등의 마침 시간은 연장할 수 있습니다. 차후 월요일은 휴관 할 예정이오니 참고  바랍니다. 감사합니다. 문의: 010-3588-5252 (허두환 관장) </p>
									</span>
								</a>
							</li>
							<c:forEach items="${noticeList}" var="i" varStatus="status">
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=699&board_idx=${i.board_idx}">
										<span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="dd" /></b><br/><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" /></span>
										<em>${i.title}</em>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="qmenu">
					<ul>
						<li class="qm1">
								<a href="#" title="이용안내">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu1.png" alt="이용안내"></div>
										<div class="qtxt">이용안내</div>
									</div>
								</div>
							</a>

						</li>
						<li class="qm2">
								<a href="#" title="대출조회">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu2.png" alt="대출조회"></div>
										<div class="qtxt">대출조회</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm3">
								<a href="#" title="희망도서신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu3.png" alt="희망도서신청"></div>
										<div class="qtxt">희망도서신청</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm4">
								<a href="#" title="문화행사신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu4.png" alt="문화행사신청"></div>
										<div class="qtxt">문화행사신청</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm5">
								<a href="#" title="평생교육신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu5.png" alt="평생교육신청"></div>
										<div class="qtxt">평생교육신청</div>
									</div>
								</div>
							</a>

						</li>
						<li class="qm6">
								<a href="#" title="독서퀴즈">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu6.png" alt="독서퀴즈"></div>
										<div class="qtxt">독서퀴즈</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm7">
								<a href="#" title="자원봉사신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu7.png" alt="자원봉사신청"></div>
										<div class="qtxt">자원봉사신청</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm8">
								<a href="#" title="통합도서관 새창으로 열립니다." target="_blank">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu8.png" alt="통합도서관"></div>
										<div class="qtxt">통합도서관</div>
									</div>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="main_scroll"><div class="main_scroll_wp">scroll down</div></div>
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">

			<div class="main-section3">
				<div class="book-title">
					<h3>NEW BOOK</h3>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=85&manage_idx=697" class="btn-more2 more-more">더보기</a>
				</div>

				<script>
					$(function(){
						var _width = $(window).width();
						var _books;

						var Books = function(){
							try {
								if( _books ) _books.destroySlider();
							} catch (e) {
								// TODO: handle exception
							}

							if( _width <= 320 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 1,
									slideWidth: 270,
									slideMargin: 0
								});
							}
							else if( _width <= 550 && _width > 320 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 1,
									slideWidth: 270,
									slideMargin: 0
								});
							}
							else if( _width <= 1024 && _width > 550 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 3,
									slideWidth: 270,
									slideMargin: 30
								});
							}
							else if( _width <= 1450 && _width > 1024 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 4,
									slideWidth: 270,
									slideMargin: 40
								});
							}
							else {
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:true,
									pagerType:'short',
									controls:true,
									autoControls: true,
									autoControlsCombine: true,
									moveSlides:1,
									maxSlides: 6,
									slideWidth: 270,
									slideMargin: 50
								});
							}
						};
						
						Books();
						/*$(window).on('resize', function(e){
							e.preventDefault();
							_width = $(window).width();
							console.log(_width);
							Cultures();
						});*/
					});
				</script>
				<div class="bookList">
					<ul>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
						<li>
							<a href="">
								<img src="/resources/homepage/${homepage.context_path}/img/bookimg01.png" alt="">
							</a>
						</li>
					<!--
						<c:if test="${fn:length(bookList1) < 1}">
							<li>등록된 데이터가 없습니다.</li>
						</c:if>
						<c:forEach items="${bookList1}" var="i" varStatus="status">
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
								<span class="con-image">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/common/img/noImg2.png'"/>
												</c:when>
												<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
													<img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/common/img/noImg2.png'"/>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noImg2.png'"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
										</c:otherwise>
									</c:choose>
								</span>
									<span class="con-title">${fn:length(i.title) > 11 ? fn:substring(i.title, 0, 12) : i.title}<c:if test="${fn:length(i.title) > 11 }">...</c:if></span>
								</a>
							</li>
						</c:forEach>
					-->
					</ul>
				</div>


			</div>
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
							</div>
						</div>
						<div class="banner-box5">
							<homepageTag:banner bannerList="${bannerList}"/>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- //main3 -->

		<!-- footer_section -->
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
				$('#header').addClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #626262');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
			} else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #626262');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else if( destination.index == 2 ) {				
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #626262');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
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
