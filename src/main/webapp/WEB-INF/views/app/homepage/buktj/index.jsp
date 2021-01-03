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
		$('div#holiday-box').load('calendar5.do?homepage_id=${fn:escapeXml(homepage.homepage_id)}');
		$('ul.book_photo').eq(1).load('newBook.do');

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
						<div class="swiper-slide mvimg01"><div class="mvText"><span class="main_text01">행복북구문화재단 태전 도서관</span> <span class="main_text02">내일을 향한 <strong>꿈</strong></span></div></div>
						<div class="swiper-slide mvimg02"><div class="mvText"><span class="main_text01">행복북구문화재단 태전 도서관</span> <span class="main_text02">내일을 향한 <strong>꿈</strong></span></div></div>
						<div class="swiper-slide mvimg03"><div class="mvText"><span class="main_text01">행복북구문화재단 태전 도서관</span> <span class="main_text02">내일을 향한 <strong>꿈</strong></span></div></div>
					</div>

					<div class="mvBtn_wp">
						<div class="mvBtn">
							<div class="swiper-button-next"><img src="/resources/homepage/${homepage.context_path}/img/mv_btn_next-w.png" alt="다음"></div>
							<div class="swiper-button-prev"><img src="/resources/homepage/${homepage.context_path}/img/mv_btn_prev-w.png" alt="이전"></div>
						</div>

						<div class="ctrBtn">
							<a href="#" class="start">play</a>
							<a href="#" class="stop">stop</a>
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
							<select id="search_type" name="search_type" class="search_type">
								<option value="L_TITLE">전체</option>
								<option value="L_AUTHOR">저자</option>
								<option value="L_PUBLISHER">발행처</option>
								<option value="L_KEYWORD">키워드</option>
							</select>
							<div class="box1">
								<div class="box2">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
								</div>
							</div>
							<button id="main-search-btn">검색하기</button>
						</div>
					</fieldset>
					</form>
				</div>
				<!-- //Main_search -->

				<div class="holiday-box">
					<div class='main-box'>
						<div class='title'>
							<h2>휴관일</h2>
							<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36" class="btn-more1 more-more">더보기</a>
						</div>
						<div id="holiday-box" class="holiday-section">
							<span>1</span>&nbsp;&nbsp;&nbsp;<span>2</span>&nbsp;&nbsp;&nbsp;
						</div>
					</div>
				</div>

				<div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section'>

				<div class="notice-box tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=718" class='t-tabs'>공지사항</a></li>
						<li><a href="#tab2" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32" class='t-tabs'>프로그램접수</a></li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=718" class="btn-more2 more-more">더보기</a>
					</ul>

					<div class="news con" data-tab="tab1">
						<div class="box">
							<ul>
								<c:forEach items="${noticeList}" var="i" varStatus="status">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=718&board_idx=${i.board_idx}">
											<span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="dd" /></b><br/><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" /></span>
											<em>${i.title}</em>
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
									<c:set var="teachMenuIdx" value="91"></c:set>
									<c:if test="${i.large_category_idx eq 16}">
										<c:set var="teachMenuIdx" value="91"></c:set>
									</c:if>
									<c:if test="${i.large_category_idx eq 17}">
										<c:set var="teachMenuIdx" value="32"></c:set>
									</c:if>
									<li>
										<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=${teachMenuIdx}&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&homepage_id=${i.homepage_id}">
											<c:set var="teachDate" value="${fn:split(i.start_date, '-')}"></c:set>
											<span class="time"><b>${teachDate[2]}</b><br/>${teachDate[0]}.${teachDate[1]}</span>
											<em>${i.teach_name}</em>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
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
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="등록된 팝업이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="main_scroll"><div class="main_scroll_wp">scroll down</div></div>
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">
			
			<div class="main2_tit">
				<p class="tit_text">MAIN SERVICE INFORMATION</p>
				<h2 class="title"><b>주요서비스</b> 안내</h2>
			</div>
			
			<div class="mIcon">
				<ul>
					<li>
						<a href="html.do?menu_idx=15" class="q01">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q1.png" alt="희망도서신청"><br class="webBr"/>희망도서신청</span>
						</a>
					</li>
					<li>
						<a href="html.do?menu_idx=90" class="q02">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2.png" alt="상호대차서비스"><br class="webBr"/>상호대차서비스</span>
						</a>
					</li>
					<li>
						<a href="html.do?menu_idx=27" class="q03">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q3.png" alt="독서문화행사"><br class="webBr"/>독서문화행사</span>
						</a>
					</li>
					<li>
						<a href="intro/search/loan/history.do?menu_idx=53" class="q04">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q4.png" alt="대출정보조회"><br class="webBr"/>대출정보조회</span>
						</a>
					</li>
					<!-- <li>
						<a href="#" class="q05">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q5.png" alt="스마트도서관"><br class="webBr"/>스마트도서관</span>
						</a>
					</li> -->
					<li>
						<a href="https://blog.naver.com/bukguarts" class="q06" target="_blank">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q6.png" alt="블로그"><br class="webBr"/>블로그</span>
						</a>
					</li>
				</ul>
			</div>

			<div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div>
		</div>
		<!-- //main2 -->


		<!-- main3 -->
		<div class="section" id="main3">

			<div class="main-section wid1450">

				<div class="book-box tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=13&manage_idx=716">추천도서</a></li>
						<li><a href="#tab2" class='t-tabs' data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=10">신착도서</a></li>
					</ul>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=13&manage_idx=716" class="btn-more2 more-more">더보기</a>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							<c:forEach items="${bookList1}" var="i" varStatus="status">
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<span class="con-image">
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
									</span>
										<span class="con-title">${fn:length(i.title) > 11 ? fn:substring(i.title, 0, 12) : i.title}<c:if test="${fn:length(i.title) > 11 }">...</c:if></span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
						</ul>
					</div>

				</div>

				<div class="calendar-box" id="calendar-box">
				</div>

			</div>
			<div class="end"></div>

			
			<div class="banner-box">
				<div class="main-section">

					<div class="main7_banner">
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

				</div>

			</div>
		</div>
		<!-- //main3 -->

		<!-- footer_section -->
		<div class="section fp-auto-height footer_area" id="foot_section" style="margin-top:-48px;">
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
				$('.Gnb').css('border-bottom','0');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {				
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else {
				$('#header').removeClass("background-white");
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
