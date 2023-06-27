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

	$(window).resize(function() {
		$('.lt_photo img').height($('.lt_photo img').width() * 0.9);
	}).trigger('resize');
	
	$('#main-search-btn').on('click', function() {
		if( $('input#search_text_1').val() == '' ) {
			alert('찾으시는 도서 정보를 입력하세요.');
			$('input#search_text_1').focus();
			return false;
		}
			$('#mainSearchForm').submit();
	});
	
	$('#calendar-box').load('calendar3.do');
	$('#main3 div.list .bookListTop').load('newBook.do');
	$('#main3 .main3-wrap .title ul li').on('click', function() {
		var tab = $(this).attr('keyValue');
		if (!$(this).hasClass("on")) {
			if (tab == 'tab1') {
				$('#more-link').attr('href', '/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14');
				$('#main3 div.list .bookListTop').load('newBook.do');
			} else {
				$('#more-link').attr('href', '/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=1183');
				$('#main3 div.list .bookListTop').load('bestBook.do?manage_idx=1183&count=10');
			}
			
			$('#main3 .main3-wrap .title ul li').removeClass('on');
			$(this).addClass('on');
		}
	});
});
</script>
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}"/>
		</div>
	</div>
	
	<div id="fullpage">
		<!--메인-->
		<div id="main0" class="section">
			<div class="main-visual">

				<div class="sections top">
					<div class="main_txt">
						<p><span>SAMGUKYUSA GUNWI LIBRARY</span></p>
						<p>두손에는 책이 가득!</p>
						<p>가슴에는 꿈이 가득!</p>
					</div>

					<div class="qmenu">
						<ul>
							<li class="qm1">
									<a href="/${homepage.context_path}/html.do?menu_idx=26" title="희망도서신청">
									<div class="outer">
										<div class="inner">
											<div class="qtxt">희망도서신청</div>
											<div class="image"><img src="/resources/homepage/gw/img/more-icon.png" alt="더보기"></div>
										</div>
									</div>
								</a>

							</li>
							<li class="qm2">
									<a href="/${homepage.context_path}/html.do?menu_idx=104" title="이용안내">
									<div class="outer">
										<div class="inner">
											<div class="qtxt">이용안내</div>
											<div class="image"><img src="/resources/homepage/gw/img/more-icon.png" alt="더보기"></div>
										</div>
									</div>
								</a>
							</li>
							<li class="qm3">
									<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16" title="대출조회·예약">
									<div class="outer">
										<div class="inner">
											<div class="qtxt">대출조회·예약</div>
											<div class="image"><img src="/resources/homepage/gw/img/more-icon.png" alt="더보기"></div>
										</div>
									</div>
								</a>
							</li>
							<li class="qm4">
									<a href="https://library.daegu.go.kr/elib/index.do" title="전자도서관 새창으로 열립니다." target="_blank">
									<div class="outer">
										<div class="inner">
											<div class="qtxt">전자도서관</div>
											<div class="image"><img src="/resources/homepage/gw/img/more-icon.png" alt="더보기"></div>
										</div>
									</div>
								</a>
							</li>
						</ul>
					</div>
					<div class="end"></div>
				</div>
	
				<div class="sections middle">
					<img src="/resources/homepage/gw/img/visual-bg.jpg" alt="">
				</div>

				<div class="sections bottom">

					<div class="search-box">
						<h2>원하시는 도서를 검색해보세요!</h2>
						<div class="main-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="13">
							<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
							<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
							<input type="hidden" name="search_type" value="L_TITLE">
							<fieldset>
								<div class="box1">
									<div class="box2">
										<input name="title" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서 정보를 입력하세요." title="통합검색"/>
									</div>
								</div>
								<button id="main-search-btn">통합검색</button>
							</fieldset>
						</form>
						</div>
					</div>

				</div>

			</div>
		</div>
		
		<!--공지+팝업존-->
		<div id="main1" class="section">
			<div class="main1_wrap">
				
				<div class="outer">
					<div class="inner">
						<div class='mid-sections'>
							<div class="main1-left-box">
								<div class="popupzonenew">
									<h2>POPUPZONE</h2>
									<c:choose>
										<c:when test="${fn:length(popupZoneList) > 0}">
											<homepageTag:popupZone popupZoneList="${popupZoneList}" />
										</c:when>
										<c:otherwise>
											<ul>
												<li><a href="javascript:void(0);"><img src="/resources/homepage/gw/img/popupnone.png" alt="" /></a></li>
											</ul>
										</c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="main1-right-box">
								<script>
									$(function(){
										var ___width = $(window).width();
										var _noticeList;

										var Notices = function(){
											try {
												if( _noticeList ) _noticeList.destroySlider();
											} catch (e) {
												// TODO: handle exception
											}

											if( ___width <= 768 ){
												_noticeList = $('.notice-list ul').bxSlider({
													auto: true,
													autoHover: true,
													speed: 500,
													pager: false,
													moveSlides:1,
													maxSlides: 1,
													slideWidth: 335,
													slideMargin: 0
												});
											}
											else if( ___width <= 1024 && ___width > 768 ){
												_noticeList = $('.notice-list ul').bxSlider({
													auto: true,
													autoHover: true,
													speed: 500,
													pager: false,
													moveSlides:1,
													maxSlides: 2,
													slideWidth: 335,
													slideMargin: 10
												});
											}
											else if( ___width <= 1770 && ___width > 1024 ){
												_noticeList = $('.notice-list ul').bxSlider({
													auto: true,
													autoHover: true,
													speed: 500,
													pager: false,
													moveSlides:1,
													maxSlides: 2,
													slideWidth: 335,
													slideMargin: 20
												});
											}
											else {
												_noticeList = $('.notice-list ul').bxSlider({
													auto: true,
													autoHover: true,
													speed: 500,
													pager: false,
													moveSlides:1,
													maxSlides: 3,
													slideWidth: 335,
													slideMargin: 20
												});
											}
										};
										Notices();
										/*
										$(window).on('resize', function(){
											___width = $(window).width();
											Notices();
										});
										*/
									});
								</script>
								<div class="news">
									<h2>NOTICE</h2>
									<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1186" class="more">MORE <img src="/resources/homepage/gw/img/notice-view-btn.png" alt="더보기" ></a>
									<div class="box notice-list">
										<ul>
											<c:forEach var="i" items="${noticeList}">
												<li>
													<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
														<div class="outer">
															<div class="inner">
																<div class="ctitle">${i.title}</em></div>
																<div class="cdate"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></div>
															</div>
														</div>
													</a>
												</li>
											</c:forEach>
											<c:if test="${empty noticeList}">
												<li>
													<a href="javascript:void(0)">
														<div class="outer">
															<div class="inner">
																<div class="ctitle">등록된 공지사항이 없습니다.</em></div>
																<div class="cdate"></div>
															</div>
														</div>
													</a>
												</li>
											</c:if>
										</ul>
									</div>

								</div>
							</div>
							<div class="end"></div>
						</div>
					</div>
				</div>

			</div>
		</div>
		
		<!--일정+행사-->
		<div id="main2" class="section">
			<div class="main2-wrap mid-sections">
				<div class="calendar-box">
					<div class="title">
						<h3>CALENDAR</h3>
						<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=229" title="일정 더보기 버튼">
							<img src="/resources/homepage/gw/img/more-btn-b.png" alt="일정 더보기 이미지" title="일정 더보기 이미지">
						</a>
					</div>
					<div class="calendar-box" id="calendar-box">
						
					</div>
				</div>
				<div class="event-box">
					<div class="title">
						<h3>EVENT</h3>
						<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=218" title="행사 더보기 버튼">
							<img src="/resources/homepage/gw/img/more-btn-b.png" alt="행사 더보기 이미지" title="행사 더보기 이미지">
						</a>
					</div>
					<div class="list">
						<ul>
							<c:forEach var="i" items="${teachList}">
								<li>
									<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=168&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&homepage_id=${i.homepage_id}">
										<div>
											<h3>${i.teach_name }</h3>
											<span>${i.teach_desc }</span><br class="pcBr"/><br />
											<p><b>강좌기간</b>${i.start_date} ~ ${i.end_date }</p>
											<p><b>접수기간</b>${i.start_join_date} ~ ${i.end_join_date}</p>
										</div>
									</a>
								</li>
							</c:forEach>
							<c:if test="${empty teachList}">
								<li>
									<a href="javascript:void(0)">
										<div>
											등록된 강좌가 없습니다.
										</div>
									</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--도서-->
		<div id="main3" class="section">
			<div class="main3-wrap sections">				
				<div class="title">
					<ul>
						<li class="on" keyValue="tab1">
							<a href="javascript:void(0);" title="신착도서 보기">
								신착도서
							</a>
						</li>
						<li keyValue="tab2">
							<a href="javascript:void(0);" title="추천도서 보기" >
								추천도서
							</a>
						</li>
					</ul>
					<div class="more-btn">
						<a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" title="도서 목록 보기" id="more-link">
							<img src="/resources/homepage/gw/img/book-more-btn-b.png" alt="도서목록 더보기 이미지" title="도서목록 더보기 이미지">
						</a>
					</div>
				</div>

				<div class="list">
					<div class="bookListTop">
					
					</div>
				</div>
			</div>
		</div>
		
		<!-- footer_section -->
		<div class="bottom-banner-wrap">
			<div class="banner-box">
				<div class="sections">
					<!-- 작업할거 없음. 이미 다 처리. -->
					<div class="banner-wrap type6">
						<div class="banner-t6">
							<div class="control">
								<a class="prev" href="#prev"><img src="/resources/homepage/gw/img/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
								<a class="next" href="#next"><img src="/resources/homepage/gw/img/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
							</div>
						</div>
						<div class="banner-box6">
							<homepageTag:banner bannerList="${bannerList}"/>
						</div>
						<div class='banner-t6-after'>
							<div class="control">
								<a class="stop active" href="#stop"><img src="/resources/homepage/gw/img/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
								<a class="play" href="#play"><img src="/resources/homepage/gw/img/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
								<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><img src="/resources/homepage/gw/img/banner-more-btn.png" alt="더보기" /><span class="blind">더보기</span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="section fp-auto-height footer_area" id="foot_section">
		<tiles:insertAttribute name="footer" />
		</div>
	</div>

</div>

</body>
</html>


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage', '3rdPage', '4thPage', '5thPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#f2f2f2');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#f2f2f2');
			}	else if( destination.index == 2 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#f2f2f2');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#f2f2f2');
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#f2f2f2');
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