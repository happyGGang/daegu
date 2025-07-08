<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Random" %>
<%
Random rnd = new Random();
int[] listNums = new int[10];
for (int i = 0; i < 10; i++) {
int num;
boolean unique;
do {
unique = true;
num = rnd.nextInt(10);
for (int j = 0; j < i; j++) {
if (listNums[j] == num) {
unique = false;
break;
}
}
} while (!unique);
listNums[i] = num;
}
%>

<!-- 메인 -->
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/reset.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section4.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section5.css"/>
<script src="/resources/homepage/${homepage.context_path}/plugin/jquery-3.7.1.min.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section1.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section2.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section4.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section5.js"></script>

<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
	$(function () {
		$('div.calendar').load('calendar3.do');
		$('div#holiday-area').load('calendar2.do');
		loadTabContent('div.tab1', 'newBook.do');
		loadTabContent('div.tab3', 'bestBook.do');


		// 팝업 관련 코드 START
		$('.close-btn').on('click', function() {
			let $this = $(this);
			let checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
			let popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				let todayDate = new Date();
				todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if($this.data('day') == 7) {
					todayDate.setDate(todayDate.getDate() + 7);
				}
				document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";";
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
			let result = '';
			let name = $(v).attr('id');
			let nameOfCookie = name + "=";
			let x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
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

		$('#new_book_wrapper').html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

		$('#new_book_wrapper').load('newBook.do', function () {
			const $bookSlide = $('.book-slide');
			if ($bookSlide.length && !$bookSlide.hasClass('slick-initialized')) {
				$bookSlide.slick({
					slidesToShow: 5,
					slidesToScroll: 1,
					autoplay: false,
					arrows: false,
					dots: false,
					variableWidth: true,
					responsive: [
						{
							breakpoint: 1260,
							settings: {
								slidesToShow: 4,
								variableWidth: true,
							},
						},
						{
							breakpoint: 865,
							settings: {
								slidesToShow: 3,
								variableWidth: true,
							},
						},
					],
				});
			}

			$('.book-slide-prev, .book-slide-next').off('click').on('click', function () {
				if ($bookSlide.hasClass('slick-initialized')) {
					$bookSlide.slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
				}
			});
		});

		$('#main-search-btn').on('click', function () {
			if ($('input#book-search').val() == '') {
				alert('검색어를 입력하세요.');
				$('input#book-search').focus();
				return false;
			}
			$('#main-search-btn').submit();
		});
	});
</script>

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
<div id="wrap" class="main_container">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>

	<tiles:insertAttribute name="top"/>
	<tiles:insertAttribute name="topMenu"/>

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<!-- 통합팝업 -->
	<c:if test="${not empty popupFullList}">
		<div class="total-popup-overlay"></div>
		<div class="total_popup_area" id="total_popup_area">
			<div class="total-popup-controller">
				<div class="total-popup-controller-btn popup-today-close">
					<div>오늘 하루 열지 않기</div>
					<img src="/resources/homepage/${homepage.context_path}/img/common/total-popup-close.svg" alt="">
				</div>
				<div class="total-popup-controller-btn popup-close">
					<div>창 닫기</div>
					<img src="/resources/homepage/${homepage.context_path}/img/common/total-popup-close.svg" alt="">
				</div>
			</div>
			<div class="total-popup-content">
				<div class="total-popup-title">POPUP LIST</div>
				<div class="total-popup-slide-wrapper">
					<img class="total-popup-slide-prev" src="/resources/homepage/${homepage.context_path}/img/common/total-popup-left-arrow.svg" alt="">
					<div class="total-popup-slide">
						<c:forEach items="${popupFullList}" var="i" varStatus="status">
							<div class="total-popup-slide-item">
								<c:choose>
									<c:when test="${not empty i.server_file_name}">
										<img src="${pageContext.request.contextPath}/data/popup/${i.homepage_id}/${i.server_file_name}" alt="${i.alt_text}">
									</c:when>
									<c:otherwise>
										<img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt="${i.alt_text}">
									</c:otherwise>
								</c:choose>
								<c:if test="${not empty i.link_type and i.link_type ne 'NONE'}">
									<a href="${i.link_url}"> ${i.link_type eq 'APPLY' ? '신청하기' : '자세히보기'} </a>
								</c:if>
							</div>
						</c:forEach>
					</div>
					<img class="total-popup-slide-next" src="/resources/homepage/${homepage.context_path}/img/common/total-popup-right-arrow.svg" alt="">
				</div>
			</div>
		</div>
	</c:if>

	<div id="fullpage">
		<!-- 섹션1 -->
		<div class="section-wrapper" data-anchor="section1">
			<div class="main-bg-slide">
				<div class="main-bg-slide-item">
					<div>Memorial Library <br>for 2·28 Students' Movement</div>
					<div><span>머물고 싶은</span> 곳, <br>책이 있는 <span>도서관</span></div>
				</div>
				<div class="main-bg-slide-item">
					<div>Memorial Library <br>for 2·28 Students' Movement</div>
					<div>내 손의 <span>책</span>, <br>내 삶의 <span>힘</span></div>
				</div>
			</div>
			<div class="wrapper">
				<!-- 검색 -->
				<div class="search-bar-wrapper">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do" class="book-search-form">
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
						<input name="title" id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요"/>

						<button class="book-search-btn" id="main-search-btn">
							<img src="/resources/homepage/${homepage.context_path}/img/main/search.svg" alt=""/>
						</button>
					</form>
				</div>
				<!-- 퀵메뉴 -->
				<div class="quick-menu-wrapper">
					<img class="quick-prev" src="/resources/homepage/${homepage.context_path}/img/main/left-arrow.svg" alt="">
					<div class="quick-menu">
						<div class="quick-menu-item quick-menu-item1">
							<a class="go-to-quick-menu" href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16">
								<div>더보기</div>
								<img src="/resources/homepage/${homepage.context_path}/img/main/arrow.svg" alt="">
							</a>
							<div class="quick-menu-icon"></div>
							<div class="quick-menu-title">대출/예약현황</div>
							<div class="quick-menu-description">
								대출/예약 현황 조회를<br>
								하실 수 있습니다.
							</div>
						</div>
						<div class="quick-menu-item quick-menu-item2">
							<a class="go-to-quick-menu" href="/${homepage.context_path}/html.do?menu_idx=26">
								<div>더보기</div>
								<img src="/resources/homepage/${homepage.context_path}/img/main/arrow.svg" alt="">
							</a>
							<div class="quick-menu-icon"></div>
							<div class="quick-menu-title">
								희망도서신청
							</div>
							<div class="quick-menu-description">
								원하시는 도서를<br>
								신청하세요.
							</div>
						</div>
						<div class="quick-menu-item quick-menu-item3">
							<a class="go-to-quick-menu" href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
								<div>더보기</div>
								<img src="/resources/homepage/${homepage.context_path}/img/main/arrow.svg" alt="">
							</a>
							<div class="quick-menu-icon"></div>
							<div class="quick-menu-title">행사/강좌 신청</div>
							<div class="quick-menu-description">
								운영중인 프로그램을<br>
								신청해보세요.
							</div>
						</div>
						<div class="quick-menu-item quick-menu-item4">
							<a class="go-to-quick-menu" href="/${homepage.context_path}/html.do?menu_idx=104">
								<div>더보기</div>
								<img src="/resources/homepage/${homepage.context_path}/img/main/arrow.svg" alt="">
							</a>
							<div class="quick-menu-icon"></div>
							<div class="quick-menu-title">이용안내</div>
							<div class="quick-menu-description">
								도서관 규정 및<br>
								안내사항을 확인하세요.
							</div>
						</div>
						<div class="quick-menu-item quick-menu-item5">
							<div class="quick-menu-icon"></div>
							<div class="quick-menu-title">대구학생전자도서관</div>
							<button class="collection-type" onclick="location.href='https://dgelib.dkyobobook.co.kr/main.ink'">소장형 바로가기</button>
							<button class="active-type" onclick="location.href='https://dgelib-r.dkyobobook.co.kr/main.ink'">구독형 바로가기</button>
						</div>
					</div>
					<img class="quick-next" src="/resources/homepage/${homepage.context_path}/img/main/right-arrow.svg" alt="">
				</div>
			</div>
			<!-- 휴관일 & 공지사항 -->
			<div class="main-bottom-area">
				<div class="holiday-area" id="holiday-area"></div>
			</div>
		</div>
		<!-- 섹션2 -->
		<div class="section-wrapper" data-anchor="section2">
			<div class="wrapper">
				<div class="notice-board">
					<div class="notice-board-header">
						<div class="notice-board-title">공지사항</div>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=88">
							<img src="/resources/homepage/${homepage.context_path}/img/notice/more.svg" alt="">
						</a>
					</div>
					<div class="notice-list">
						<c:if test="${fn:length(noticeList) >= 1}">
							<c:forEach var="i" varStatus="status" items="${noticeList}">
								<a class="notice-list-item" href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<div class="notice-list-item-date">
										<div><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></div>
										<div><fmt:formatDate value="${i.add_date}" pattern="yyyy"/></div>
									</div>
									<div class="notice-list-item-title">${i.title}</div>
								</a>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(noticeList) < 1}">
							<div class="notice-no-data">등록된 공지사항이 없습니다.</div>
						</c:if>
					</div>
				</div>
				<div class="popup-slide-wrapper">
					<div class="popup-slide">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<c:forEach var="i" items="${popupZoneList}">
									<div class="popup-slide-item">
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
								<div class="popup-slide-item">
									<a href="">
										<img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt="" />
									</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="popup-control">
						<div class="popup-prev">
							<img src="/resources/homepage/${homepage.context_path}/img/notice/popup-prev.svg" alt=""/>
						</div>
						<div class="popup-pagination"></div>
						<div class="popup-play-and-pause">
							<img src="/resources/homepage/${homepage.context_path}/img/notice/pause.svg" alt=""/>
						</div>
						<div class="popup-next">
							<img src="/resources/homepage/${homepage.context_path}/img/notice/popup-next.svg" alt=""/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 섹션3 -->
		<div class="section-wrapper" data-anchor="section3">
			<div class="wrapper">
				<div class="course-board">
					<div class="course-board-header">
						<div class="course-board-title">행사안내</div>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=198&manage_idx=394">
							<img src="/resources/homepage/${homepage.context_path}/img/culture/more.svg" alt="">
						</a>
					</div>
					<div class="course-list">
						<c:if test="${fn:length(teachList) < 1}">
							<div class="course-no-data">등록된 행사가 없습니다.</div>
						</c:if>
						<c:if test="${fn:length(teachList) >= 1}">
							<c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='4'>
								<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" class="course-list-item">
									<div class="course-list-item-title">${i.teach_name}</div>
									<div class="course-list-item-date">${i.start_date}</div>
								</a>
							</c:forEach>
						</c:if>
					</div>
				</div>
				<div class="calendar"></div>
			</div>
		</div>
		<!-- 섹션4 -->
		<div class="section-wrapper" data-anchor="section4">
			<div class="wrapper">
				<div class="section4-title">
					<div>library book</div>
					<div>새로 들어온 도서와 사서가  추천하는  도서를 알려드립니다.</div>
				</div>
				<div class="book-tab-wrapper">
					<div class="tab-button active-tab" data-target="tab1">신착도서</div>
					<div class="tab-button" data-target="tab2">추천도서</div>
					<div class="tab-button" data-target="tab3">대출베스트</div>
					<a id="tab-link" href="">
						<img src="/resources/homepage/${homepage.context_path}/img/book/more.svg" alt="">
					</a>
					<div class="deco1"></div>
					<div class="deco2"></div>
				</div>
				<div class="tab-content tab1"></div>
				<div class="tab-content tab2" style="display: none;">
					<c:choose>
						<c:when test="${fn:length(curationList) > 0}">
							<img class="book-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/left-arrow.svg" alt="이전" />
							<div class="tab-list">
								<c:forEach var="i" items="${curationList}">
									<div class="tab-list-item">
										<a href="/${homepage.context_path}/board/view.do?menu_idx=138&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'noimg')}">
													<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" />
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" />
												</c:otherwise>
											</c:choose>
										</a>
										<div class="title">${i.title}</div>
									</div>
								</c:forEach>
							</div>
							<img class="book-slide-next" src="/resources/homepage/${homepage.context_path}/img/book/right-arrow.svg" alt="다음" />
						</c:when>
						<c:otherwise>
							<div class="book-nodata">등록된 추천도서가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="tab-content tab3" style="display: none;"></div>
			</div>
		</div>
		<!-- 섹션5 -->
		<div class="section-wrapper" data-anchor="section5">
			<div class="wrapper">
				<div class="section5-title">
					<div>학교도서관, <span>지혜</span>를 담고 <span>생각</span>을 키우고 <span>꿈</span>을 펼치다!</div>
					<div>학교도서관<br>집중지원센터</div>
				</div>
				<div class="search-bar-wrapper">
					<form id="mainSearchForm" action="/228/module/bookPackage/index.do" class="school-input">
						<input type="hidden" name="menu_idx" value="138">
						<input type="hidden" name="search_type" value="book_package_subject">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="책꾸러미 서명을 입력하세요." style="ime-mode:active;">
								</div>
								<button id="main-search-btn" class="school-search-btn">
									<img src="/resources/homepage/${homepage.context_path}/img/school/search.svg" alt="">
								</button>
							</div>
						</fieldset>
					</form>
					<a class="go-to-login" href="/${homepage.context_path}/module/supportMember/index.do?menu_idx=175">
						<img class="school-img" src="/resources/homepage/${homepage.context_path}/img/school/school.svg" alt="">
						<div class="go-to-login-text">
							<div>학교(기관)로그인</div>
							<img src="/resources/homepage/${homepage.context_path}/img/school/go.svg" alt="">
						</div>
					</a>
				</div>
				<div class="menu-slide-wrapper">
					<img class="menu-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/left-arrow.svg" alt="이전" />
					<div class="menu-slide">
						<a href="/${homepage.context_path}/html/recomBookList.do?menu_idx=259" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu1.svg" alt="">
							</div>
							<div class="menu-slide-item-text">학생추천도서</div>
						</a>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=150&manage_idx=225" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu2.svg" alt="">
							</div>
							<div class="menu-slide-item-text">학교도서관업무지원</div>
						</a>
						<a href="/${homepage.context_path}/module/libraryCheck/index.do?menu_idx=148" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu3.svg" alt="">
							</div>
							<div class="menu-slide-item-text">장서점검기</div>
						</a>
						<a href="/${homepage.context_path}/html.do?menu_idx=267" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu4.svg" alt="">
							</div>
							<div class="menu-slide-item-text">강사인력풀</div>
						</a>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=154&manage_idx=224" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu5.svg" alt="">
							</div>
							<div class="menu-slide-item-text">참고차료</div>
						</a>
						<a href="/${homepage.context_path}/html.do?menu_idx=135" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu6.svg" alt="">
							</div>
							<div class="menu-slide-item-text">센터소개</div>
						</a>
						<a href="/${homepage.context_path}/html.do?menu_idx=113" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu8.svg" alt="">
							</div>
							<div class="menu-slide-item-text">2·28책꾸러미</div>
						</a>
						<a href="/${homepage.context_path}/html.do?menu_idx=143" class="menu-slide-item">
							<div class="menu-slide-item-img">
								<img src="/resources/homepage/${homepage.context_path}/img/school/menu7.svg" alt="">
							</div>
							<div class="menu-slide-item-text">2·28원화꾸러미</div>
						</a>
					</div>
					<img class="menu-slide-next" src="/resources/homepage/${homepage.context_path}/img/book/right-arrow.svg" alt="다음" />
				</div>
			</div>
		</div>

		<!-- footer -->
		<div class="footer section-wrapper fp-auto-height" data-anchor="section6">
			<!-- banner -->
			<div class="banner-area">
				<div class="banner-slide-controller">
					<img class="banner-prev" src="/resources/homepage/${homepage.context_path}/img/common/banner-prev.svg" alt=""/>
					<img class="banner-next" src="/resources/homepage/${homepage.context_path}/img/common/banner-next.svg" alt=""/>
					<img class="banner-play-and-pause" src="/resources/homepage/${homepage.context_path}/img/common/banner-pause.svg" alt="">
					<img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/${homepage.context_path}/img/common/banner-more.svg" alt="">
				</div>
				<homepageTag:newBanner bannerList="${bannerList}"/>
			</div>

			<tiles:insertAttribute name="footer"/>
		</div>
	</div>

	<!-- indicator -->
	<div id="fullpage-indicator">
		<div data-menuanchor="section1"></div>
		<div data-menuanchor="section2"></div>
		<div data-menuanchor="section3"></div>
		<div data-menuanchor="section4"></div>
		<div data-menuanchor="section5"></div>
		<div data-menuanchor="section6"></div>
	</div>
</div>
</body>