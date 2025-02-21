<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.swiper.css" />
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/animate.min.css" />

<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/footer.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/section1.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/section4.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/section2.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/calendar.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$('.board_index li').click(function() {
		$('.board_index li').removeClass('index_active');

		$(this).addClass('index_active');

		$('.noticeList, .eventList, .teachList').hide();

		let selected = $(this).attr('id');

		$('.' + selected).show();

		const boardMore = document.querySelector('.board_more');
		
		switch (this.id) {
			case 'noticeList':
				boardMore.setAttribute('onclick', 'noticeDetail()');
				break;
			case 'eventList':
				boardMore.setAttribute('onclick', 'eventDetail()');
				break;
			case 'teachList':
				boardMore.setAttribute('onclick', 'teachDetail()');
				break;
			default:
				boardMore.removeAttribute('onclick');
		}
	});

	$('.book_information_menu_list li').click(function() {
		$('.book_information_menu_list li').removeClass('menu_active');
		
		$(this).addClass('menu_active');

		$('.librarian, .bestBook, .newBook').hide();
		
		let selected = $(this).attr('id');

		$('.' + selected).show();
		$('div#recommandBookContents .swiper_wrapper, div#bestBookContents .swiper_wrapper, div#newBookContents .swiper_wrapper').remove();
		$('.' + selected).append("<div class='c_loading'><img src='https://cdn.pixabay.com/animation/2023/08/11/21/18/21-18-05-265_512.gif' alt=''></div>");
		
		const bookMore = document.querySelector('.book_more');
	
		switch (this.id) {
			case 'librarian':
				bookMore.setAttribute('onclick', 'librarianDetail()');
				$('div#recommandBookContents').load('centerBookList.do');
				break;
				
			case 'bestBook':
				bookMore.setAttribute('onclick', 'bestBookDetail()');
				$('div#bestBookContents').load('bestBook.do');
				break;
				
			case 'newBook':
				bookMore.setAttribute('onclick', 'newBookDetail()');
				$('div#newBookContents').load('newBook.do');
				break;
				
			default:
				bookMore.removeAttribute('onclick');
		}

	});
	
	$('.book_information_menu_list #librarian').addClass('menu_active');
	$('div#recommandBookContents').load('centerBookList.do');
	$('.board_more').attr('onclick', 'noticeDetail()');
	$('.book_more').attr('onclick', 'librarianDetail()');
	$('div#holiday-box').load('calendar2.do');
	$('div#calendar-box').load('calendar3.do');
});

function noticeDetail()
{
	location.href='/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=1274';
}
function eventDetail()
{
	location.href='/${homepage.context_path}/module/teach/index.do?menu_idx=32&searchCate1=16';
}
function teachDetail()
{
	location.href='/${homepage.context_path}/module/teach/index.do?menu_idx=34&searchCate1=17';
}
function librarianDetail()
{
	location.href='/${homepage.context_path}/board/index.do?menu_idx=15&manage_idx=1272';
}
function bestBookDetail()
{
	location.href='/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=12';
}
function newBookDetail()
{
	location.href='/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=11';
}

$(function () {

	// 팝업 관련 코드 START
	$('.close-btn').on('click', function () {
		var $this = $(this);
		var checkInput = $this.parent().find('input[data-day="' + $this.data('day') + '"]');
		var popupId = checkInput.val();
		if (checkInput.prop('checked')) {
			var todayDate = new Date();
			todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
			if ($this.data('day') == 7) {
				todayDate.setDate(todayDate.getDate() + 7);
			}
			document.cookie = popupId + '=no' + '; path=/; expires=' + todayDate.toGMTString() + ';';
		}

		$('div#' + popupId).hide();
	});

	$('input[id*=pop]').on('click', function (e) {
		e.preventDefault();
		$(this).prop('checked', true);
		$(this).parent('div').next('a').data('day', $(this).data('day'));
		$(this).parent('div').next('a').click();
	});

	$('#popupLayer > div').each(function (i, v) {
		var result = '';
		var name = $(v).attr('id');
		var nameOfCookie = name + '=';
		var x = 0;
		while (x <= document.cookie.length) {
			var y = x + nameOfCookie.length;
			if (document.cookie.substring(x, y) == nameOfCookie) {
				if ((endOfCookie = document.cookie.indexOf(';', y)) == -1) endOfCookie = document.cookie.length;
				result = unescape(document.cookie.substring(y, endOfCookie));
			}
			x = document.cookie.indexOf(' ', x) + 1;
			if (x == 0) break;
		}

		if (result != 'no') {
			if (window.innerWidth < $(v).width()) {
				$(v).css('width', 'auto');
			}
			$(v).show();
		}
	});

	$('#main-search-btn').on('click', function () {
		if ($('input#search_text_1').val() == '') {
			alert('검색어를 입력하세요.');
			$('input#search_text_1').focus();
			return false;
		}
		$('#mainSearchForm').submit();
	});

	$('.menu-search-box').on('click', function () {
		alert('준비중');
	});
	
	$('div.search_btn > img').on('click', function(){
		var searchType = $('#searchSelect option:selected').val();
		var searchText = $('#searchInput').val();

		$('input#search_type').val(searchType);
		$('input#search_text_1').attr('name',searchType);
		$('input#search_text_1').val(searchText);
		$('#mainSearchForm').submit();
	});
});
</script>
<div id="wrap">

<div class="popupWrap">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<form name="mainSearchForm" id="mainSearchForm" method="get" action="/${homepage.context_path}/intro/search/index.do">
	<input type="hidden" name="menu_idx" id="menu_idx" value="10" />
	<input type="hidden" name="booktype" id="booktype" value="BOOKANDNONBOOK">
	<input type="hidden" name="search_type" id="search_type" value="">
	<input type="hidden" name="title" id="search_text_1" value="">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	</form>

	<div id="fullpage">

		<div class="section" id="section1">
		
			<div class="section_1_wrapper">
				<div class="main_cation">시간과 공간을 넘어 새로운 상상력을 이어가는 곳</div>
				<div class="main_title"></div>
				<div class="search_area">
					<label for="searchSelect">
						<select id="searchSelect">
							<option value="title">서명</option>
							<option value="author">저자</option>
							<option value="publer">발행자</option>
							<option value="keyword">키워드</option>
						</select>
					</label>
					<label for="searchInput" class="searchInput">
						<input type="text" id="searchInput" placeholder="검색어를 입력해주세요" />
					</label>
					<div class="search_btn">
						<img src="/resources/homepage/center/img/search.svg" alt="" />
					</div>
				</div>
				<ul class="quick_menu">
					<li onclick="location.href='/${homepage.context_path}/intro/search/loan/history.do?menu_idx=75'">
						<img src="/resources/homepage/center/img/short1.gif" alt="" />
						<div>대출조회</div>
					</li>
					<li onclick="location.href='/${homepage.context_path}/intro/search/hope/req.do?menu_idx=19'">
						<img src="/resources/homepage/center/img/short2.gif" alt="" />
						<div>희망도서</div>
					</li>
					<li onclick="location.href='/${homepage.context_path}/module/teach/index.do?searchCate1=16&menu_idx=32'">
						<img src="/resources/homepage/center/img/short3.gif" alt="" />
						<div>행사신청</div>
					</li>
					<li onclick="location.href='/${homepage.context_path}/module/teach/index.do?searchCate1=17&menu_idx=34'">
						<img src="/resources/homepage/center/img/short4.gif" alt="" />
						<div>강좌신청</div>
					</li>
					<li onclick="location.href='/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36'">
						<img src="/resources/homepage/center/img/short5.gif" alt="" />
						<div>도서관일정</div>
					</li>
					<li onclick="location.href='/${homepage.context_path}/html.do?menu_idx=49'">
						<img src="/resources/homepage/center/img/short6.gif" alt="" />
						<div>수영강습안내</div>
					</li>
				</ul>
				<div class="pagination">
					<div class="indicator active_indicator"></div>
					<div class="indicator"></div>
					<div class="indicator"></div>
				</div>
				<div class="information_area">
					<div class="left_area" id="holiday-box"></div>
					<div class="right_area">
						<img src="/resources/homepage/center/img/stop.svg" alt="정지버튼" class="notice_autoplay" role="button" />
						<div class="swiper">
							<div class="swiper-wrapper">
								<c:if test="${not empty newsList}">
									<c:forEach items="${newsList}" var="i">
										<div class="swiper-slide" <c:choose><c:when test="${not empty i.link_url}">onclick="location.href='${i.link_url}'"</c:when><c:otherwise></c:otherwise></c:choose>>
										<c:out value="${i.news_name}" default="제목 없음" />
										</div>
									</c:forEach>
								</c:if>
							<c:if test="${empty newsList}">
								<div class="swiper-slide">등록된 알림이 없습니다.</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="scroll_area">
				<div class="scroll_area_text">SCROLL</div>
				<div class="scroll_area_line">
					<div></div>
				</div>
			</div>
		</div>
	</div>

	<section class="section" id="section2">
		<div class="row_wrapper">
			<div class="board">
				<div class="board_title">Notice & Event lecture</div>
				<div class="board_index_wrapper">
					<ul class="board_index">
						<li id="noticeList">공지사항</li>
						<li id="eventList">행사신청</li>
						<li id="teachList">수강신청</li>
					</ul>
					<div class="board_more"></div>
				</div>
				<div class="noticeList">
					<ul class="board_list">
						<!-- TODO noticeListTopNotice, noticeList null처리-->
						<c:if test="${fn:length(noticeList) < 1 && fn:length(noticeListTopNotice) < 1}">
							<li class="board_list_item">
								<div class="board_list_item_title">
									<div>등록된 공지사항이 없습니다.</div>
								</div>
								<div class="board_list_item_date">
									<div></div>
									<div></div>
								</div>
							</li>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" begin='0' end='1'>
							<li class="board_list_item">
								<div class="board_list_item_title">
									<img src="/resources/homepage/center/img/fix_new.svg" alt="" />
									<div onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'">${i.title}</div>
								</div>
								<div class="board_list_item_date">
									<div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
									<div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
								</div>
							</li>
						</c:forEach>
						<c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='2'>
							<li class="board_list_item">
								<div class="board_list_item_title">
									<img src="/resources/homepage/center/img/new.svg" alt="" />
									<div onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'">${i.title}</div>
								</div>
								<div class="board_list_item_date">
									<div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
									<div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="eventList" style="display:none;">
					<ul class="board_list">
						<!-- TODO noticeListTopNotice, noticeList null처리-->
						<c:if test="${fn:length(teachList1) < 1}">
							<li class="board_list_item">
								<div class="board_list_item_title">
									<div>등록된 행사가 없습니다.</div>
								</div>
								<div class="board_list_item_date">
									<div></div>
									<div></div>
								</div>
							</li>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${teachList1}" begin='0' end='4'>
							<li class="board_list_item">
								<div class="board_list_item_title">
									<img src="/resources/homepage/center/img/new.svg" alt="" />
									<div onclick="location.href='/${homepage.context_path}/module/teach/detail.do?menu_idx=32&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}'">${i.teach_name}</div>
								</div>
								<div class="board_list_item_date">
									<div>${fn:substring(i.start_date,8,10)}</div>
									<div>${fn:substring(i.start_date,0,4)}.${fn:substring(i.start_date,5,7)}</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="teachList" style="display:none;">
					<ul class="board_list">
						<!-- TODO teachList null처리-->
						<c:if test="${fn:length(teachList2) < 1}">
							<li class="board_list_item">
								<div class="board_list_item_title">
									<div>등록된 강좌가 없습니다.</div>
								</div>
								<div class="board_list_item_date">
									<div></div>
									<div></div>
								</div>
							</li>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${teachList2}" begin='0' end='4'>
							<li class="board_list_item">
								<div class="board_list_item_title">
									<img src="/resources/homepage/center/img/new.svg" alt="" />
									<div onclick="location.href='/${homepage.context_path}/module/teach/detail.do?menu_idx=34&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}'">${i.teach_name}</div>
								</div>
								<div class="board_list_item_date">
									<div>${fn:substring(i.start_date,8,10)}</div>
									<div>${fn:substring(i.start_date,0,4)}.${fn:substring(i.start_date,5,7)}</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="popup">
				<div class="popup_en">POPUPZONE</div>
				<div class="popup_kr">팝업존</div>
				<div class="popup_swiper">
					<div class="swiper">
						<div class="swiper-wrapper">
							<c:choose>
								<c:when test="${fn:length(popupZoneList) > 0}">
									<c:forEach var="i" items="${popupZoneList}">
										<div class="swiper-slide">
											<c:choose>
												<c:when test="${i.link_target eq 'BLANK'}">
													<a href="${i.link_url}" target="_blank">
														<img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" />
													</a>
												</c:when>
												<c:otherwise>
													<a href="${i.link_url}">
														<img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" />
													</a>
												</c:otherwise>
											</c:choose>

										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 팝업 예외 처리 -->
									<div class="swiper-slide">
										<img src="/resources/common/img/noImg2.png" alt="" />
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper_action_wrapper">
						<div class="swiper-button-prev"></div>
						<div class="swiper-button-next"></div>
						<c:if test="${fn:length(popupZoneList) > 1}"><img src="/resources/homepage/center/img/popup_stop.svg" alt="정지버튼" class="popup_autoplay" role="button" /></c:if>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="section" id="section3">
		<div class='section3_wrapper'>
			<div class="book_information_title">BOOK INFORMATION</div>
			<div class="book_information_menu">
				<ul class="book_information_menu_list">
					<li class="book_information_item" id="librarian">사서추천도서</li>
					<li class="book_information_item" id="bestBook">대출베스트</li>
					<li class="book_information_item" id="newBook">신착도서</li>
				</ul>
				<img class="book_more" src="/resources/homepage/center/img/plus.svg" alt="더보기" />
			</div>

			<div class="librarian" id="recommandBookContents">

			</div>
			
			<div class="bestBook" id="bestBookContents" style="display:none;">

			</div>
			
			<div class="newBook" id="newBookContents" style="display:none;">

			</div>
		</div>
	</section>


	<div class="section" id="section4">
		<div class="main1-box">
			<div class="top-box">
				<div class="calendar-box" id="calendar-box"></div>
				<div class="end"></div>
			</div>
			<div class="middle-box">
				
			</div>
		</div>

	</div>
	<div class="bottom-box">
		<div class="badge_swiper banner-wrap type8">
				<!--<div class="badge_action">
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
					<img src="/resources/homepage/center/img/more.svg" alt="더보기" class="more" role="button" onclick="location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=94'"/>
					<img src="/resources/homepage/center/img/popup_stop.svg" alt="정지버튼" class="badge_autoplay" role="button" />
				</div>-->
				<div class="banner-t7-after">
							<div class="control">
							     <a class="prev" href="#prev"><span class="blind">이전</span></a>
								<a class="next" href="#next"><span class="blind">다음</span></a>
								<a class="stop active" href="#stop"><img src="/resources/homepage/center/img/popup_stop.svg" alt="정지"><span class="blind">정지</span></a>
								<a class="play" href="#play"><img src="/resources/homepage/center/img/popup_play.svg" alt="정지"><span class="blind">정지</span></a>
								<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=94"><img src="/resources/homepage/center/img/more.svg" alt="더보기"><span class="blind">더보기</span></a>
							</div>
						</div>

				<div class="swiper banner-box8">
					<!--<div class="swiper-wrapper">-->
						<homepageTag:banner bannerList="${bannerList}"/>
					<!--</div>-->
				</div>
			</div>
	</div>
	<!-- footer_section -->
	<div class="section fp-auto-height footer_area" id="foot_section">
		<tiles:insertAttribute name="footer" />
	</div>
	<!-- //footer_section -->
</div>
</body>
</html>

<script type="text/javascript">
	function fullPage() {
		var myFullpage = new fullpage('#fullpage', {
			anchors: ['firstPage', 'secondPage', '3rdPage', '4thPage', '5thPage'],
			navigation: true,
			showActiveTooltip: true,
			scrollOverflow: true,
			menu: '#menu',
			responsiveWidth: 1025,
			afterLoad: function (origin, destination, direction) {
				var cur_page = destination.index + 1;
				if (destination.index == 0) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else if (destination.index == 1) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else if (destination.index == 2) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else if (destination.index == 3) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else if (destination.index == 4) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else if (destination.index == 5) {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				} else {
					$('#header').removeClass('background-white');
					$('.Gnb').css('border-top', '1px solid #e6e6e6');
					$('.Gnb').css('border-bottom', '1px solid #e6e6e6');
					$('.Gnb').css('background', '#fff');
					$('.tnb').css('background', '#fff');
				}
			},
			afterResponsive: function (isResponsive) {},
		});
	}

	fullPage();

	// 모바일일 경우 fullpage 미사용
	if ($(window).width() < 1025) {
		if ($('#fullpage').hasClass('fp-destroyed')) {
		} else {
			fullpage_api.destroy('all');
		}
	} else {
		fullPage();
	}

	// 리사이즈 될때 모바일 화면에서 fullpage 미사용
	$(window).resize(function (e) {
		if ($(window).width() < 1025) {
			if ($('#fullpage').hasClass('fp-destroyed')) {
			} else {
				fullpage_api.destroy('all');
			}
		} else {
			fullPage();
		}
	});
	
$(document).ready(function () {
	// 스크롤탑 클릭 시 section1으로 이동
	$('.scroll_top').click(function (event) {
		event.preventDefault();

		if ($(window).width() < 1025) {
			$('html, body').animate({ scrollTop: 0 }, 500);
		} else {
			if (typeof fullpage_api !== 'undefined' && fullpage_api.moveTo) {
				fullpage_api.moveTo(1);
			} else {
				$(window).scrollTop(0);
			}
		}
	});
	

});

$(function() {
    var bannerSliders = [];
    var autoType = !$('div.banner-wrap').hasClass('noAuto');

    function initBannerSlider(selector, options) {
        if ($(selector).length) {
            var slider = $(selector).bxSlider(options);
            bannerSliders.push(slider);
            return slider;
        }
        return null;
    }

    var commonOptions = {
        slideWidth: 160,
        speed: 500,
        moveSlides: 1,
        maxSlides: 6,
        slideMargin: 16,
        auto: autoType,
        autoHover: true,
        pager: false,
        controls: true,
		 responsive: true,
        responsiveOptions: {
            768: {
                maxSlides: 2,
                slideWidth:156,
                slideMargin: 15
            }
        }
    };


    var bannerSlider8 = initBannerSlider('div.banner-wrap.type8 ul.banner-roll', commonOptions);

    function controlSlider(action) {
        bannerSliders.forEach(function(slider) {
            if (slider) slider[action]();
        });
    }

    $('div.banner-wrap a.prev').on('click', function() {
        controlSlider('goToPrevSlide');
        return false;
    });

    $('div.banner-wrap a.next').on('click', function() {
        controlSlider('goToNextSlide');
        return false;
    });

    $('div.banner-wrap a.stop').on('click', function() {
        controlSlider('stopAuto');
        $(this).removeClass('active')
               .find('img').attr('src', '/resources/homepage/center/img/popup_stop.svg');
        $('div.banner-wrap a.play').addClass('active')
               .find('img').attr('src', '/resources/homepage/center/img/popup_play.svg');
        return false;
    });

    $('div.banner-wrap a.play').on('click', function() {
        controlSlider('startAuto');
        $(this).removeClass('active')
               .find('img').attr('src', '/resources/homepage/center/img/popup_play.svg');
        $('div.banner-wrap a.stop').addClass('active')
               .find('img').attr('src', '/resources/homepage/center/img/popup_stop.svg');
        return false;
    });
});




</script>
