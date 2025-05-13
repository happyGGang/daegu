<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>
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


<!--  공통  -->
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/reset.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/common.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/footer.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/header.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/total-popup.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/slick.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/slick-theme.css" />
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-face.css" />
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-family.css" />
<script src="/resources/homepage/duryu/plugin/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.js"></script>
<script src="/resources/homepage/duryu/js/common/common.js"></script>
<script src="/resources/homepage/duryu/js/common/fullpage.js"></script>
<script src="/resources/homepage/duryu/plugin/slick.min.js"></script>

<!--  메인  -->
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section1.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section2.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section3.css" />
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section4.css" />
<script src="/resources/homepage/duryu/js/index/section1.js"></script>
<script src="/resources/homepage/duryu/js/index/section2.js"></script>
<script src="/resources/homepage/duryu/js/index/section4.js"></script>


<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header" />

<script type="text/javascript">
	$(function() {
		$('div.calendar').load('calendar3.do');

		$('.tab1').html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

		$('div.tab1').load('newBook.do', function () {

			const $bookSlide = $('.tab-list');
			if ($bookSlide.length && !$bookSlide.hasClass('slick-initialized')) {
				$bookSlide.slick({
					slidesToShow: 5,
					slidesToScroll: 1,
					autoplay: false,
					arrows: false,
					dots: false,
					variableWidth: true,
				});
			}

			$('.book-slide-prev, .book-slide-next').off('click').on('click', function () {
				if ($bookSlide.hasClass('slick-initialized')) {
					$bookSlide.slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
				}
			});
		});


		$('.book-search-btn').on('click', function() {
			if( $('.book-search').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('.book-search').focus();
				return false;
			}
				$('.book-search-btn').submit();
		});
});
</script>

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
	<div id="wrap" class="main_container">
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

		<tiles:insertAttribute name="top" />
		<tiles:insertAttribute name="topMenu" />

		<!-- 통합팝업 -->
		<div class="total-popup-overlay"></div>
		<div class="total_popup_area">
			<div class="total-popup-controller">
				<div class="total-popup-controller-btn popup-today-close">
					<div>오늘 하루 열지 않기</div>
					<img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
				</div>
				<div class="total-popup-controller-btn popup-close">
					<div>창 닫기</div>
					<img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
				</div>
			</div>
			<div class="total-popup-content">
				<div class="total-popup-title">POPUP LIST</div>
				<div class="total-popup-slide-wrapper">
					<img class="total-popup-slide-prev" src="/resources/homepage/duryu/img/common/total-popup-left-arrow.svg" alt="">
					<div class="total-popup-slide">
						<div class="total-popup-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="">
							<a href="">자세히보기</a>
						</div>
					</div>
					<img class="total-popup-slide-next" src="/resources/homepage/duryu/img/common/total-popup-right-arrow.svg" alt="">
				</div>
			</div>
		</div>


		<div id="fullpage">
			<!-- 섹션1 -->
			<div class="section-wrapper" data-anchor="section1">
				<div class="main-bg-slide">
					<div></div>
					<div></div>
					<div></div>
				</div>
				<div class="wrapper">
					<div class="slogan">
						<div><span>전통</span>과 함께<br><span>미래</span>를 열어가는 곳</div>
						<div>두류도서관입니다</div>
					</div>
					<!-- 검색 -->
					<div class="search-bar-wrapper">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="13">
							<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
							<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
							<input id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요" />
						</form>
						<button class="book-search-btn">
							<img src="/resources/homepage/duryu/img/main/search.svg" alt="" />
						</button>
					</div>
					<!-- 퀵메누 -->
					<div class="quick-menu">
						<a href="https://library.daegu.go.kr/duryu/html.do?menu_idx=104" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/information.svg" alt="" />
							</div>
							<div>이용안내</div>
						</a>
						<a href="https://library.daegu.go.kr/duryu/module/teach/index.do?menu_idx=30" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/course.svg" alt="" />
							</div>
							<div>수강신청</div>
						</a>
						<a href="https://library.daegu.go.kr/duryu/html.do?menu_idx=26" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/hope-book.svg" alt="" />
							</div>
							<div>희망도서신청</div>
						</a>
						<a href="https://library.daegu.go.kr/duryu/intro/search/loan/index.do?menu_idx=16" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/loan.svg" alt="" />
							</div>
							<div>대출현황</div>
						</a>
						<a href="https://library.daegu.go.kr/duryu/elib.do?menu_idx=46" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/e-library.svg" alt="" />
							</div>
							<div>전자도서관</div>
						</a>
						<a href="https://library.daegu.go.kr/duryu/board/index.do?menu_idx=121&manage_idx=852" class="quick-menu-item">
							<div>
								<img src="/resources/homepage/duryu/img/main/file.svg" alt="" />
							</div>
							<div>족보자료</div>
						</a>
					</div>
				</div>
				<!-- 휴관일 & 공지사항 -->
				<div class="main-bottom-area">
					<div class="holiday-area">
						<div class="holiday-area-title">휴관일</div>
						<div class="holiday-area-controller">
							<a href="">
								<img src="/resources/homepage/duryu/img/main/holiday-left-arrow.svg" alt="">
							</a>
							<div>2025.<span>04</span></div>
							<a href="">
								<img src="/resources/homepage/duryu/img/main/holiday-right-arrow.svg" alt="">
							</a>
						</div>
						<div class="holiday-list">
							<div>01</div>
							<div>02</div>
							<div>03</div>
							<div>04</div>
							<div>05</div>
							<div>06</div>
							<div>07</div>
						</div>
					</div>
					<div class="notice-slide-wrapper">
						<img src="/resources/homepage/duryu/img/main/notice-slide-pause.svg" alt="">
						<div class="notice-slide">
							<c:forEach var="i" varStatus="status" items="${noticeList}" >
								<div>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
										${i.title}
									</a>
								</div>
							</c:forEach>
							<c:if test="${fn:length(noticeList) < 1}">
								<div>
									등록된 공지사항이 없습니다.
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<!-- 섹션2 -->
			<div class="section-wrapper" data-anchor="section2">
				<div class="wrapper">
					<div class="notice-board">
						<div class="notice-board-header">
							<div class="notice-board-title">공지사항</div>
							<a href="https://library.daegu.go.kr/duryu/board/index.do?menu_idx=36&manage_idx=132">
								<img src="/resources/homepage/duryu/img/notice/more.svg" alt="">
							</a>
						</div>
						<div class="notice-list">
							<c:forEach var="i" varStatus="status" items="${noticeList}">
								<a class="notice-list-item" href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<div class="notice-list-item-date">
										<div><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></div>
										<div><fmt:formatDate value="${i.add_date}" pattern="yyyy"/></div>
									</div>
									<div class="notice-list-item-title">${i.title}</div>
								</a>
							</c:forEach>
							<c:if test="${fn:length(noticeList) < 1}">
								<div class="notice-no-data">등록된 공지사항이 없습니다.</div>
							</c:if>
						</div>
					</div>
					<div class="popup-slide-wrapper">
						<div class="popup-slide">
							<div class="popup-slide-item">
								<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
							</div>
							<div class="popup-slide-item">
								<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
							</div>
						</div>
						<div class="popup-control">
							<div class="popup-prev">
								<img src="/resources/homepage/duryu/img/notice/popup-prev.svg" alt="" />
							</div>
							<div class="popup-pagination"></div>
							<div class="popup-play-and-pause">
								<img src="/resources/homepage/duryu/img/notice/pause.svg" alt="" />
							</div>
							<div class="popup-next">
								<img src="/resources/homepage/duryu/img/notice/popup-next.svg" alt="" />
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
							<div class="course-board-title">강좌 및 행사</div>
							<a href="https://library.daegu.go.kr/duryu/module/calendarManage/index.do?menu_idx=63">
								<img src="/resources/homepage/duryu/img/culture/more.svg" alt="">
							</a>
						</div>
						<div class="course-list">
							<!--	<div class="course-no-data">등록된 강좌 및 행사가 없습니다.</div>	-->
							<a href="" class="course-list-item">
								<div class="course-list-item-title">강좌제목</div>
								<div class="course-list-item-date">
									<div><span>강좌기간</span>2025-03-13 ~ 2025-05-20</div>
									<div><span>접수기간</span>2025-03-13 ~ 2025-05-20</div>
								</div>
							</a>
						</div>
					</div>
					<div class="calendar"></div>
				</div>
			</div>
			<!-- 섹션4 -->
			<div class="section-wrapper" data-anchor="section4">
				<div class="wrapper">
					<a id="tab-link" href="https://library.daegu.go.kr/duryu/intro/search/newBook/index.do?menu_idx=14">
						<img src="/resources/homepage/duryu/img/book/more.svg" alt="">
					</a>
					<div class="book-tab-wrapper">
						<div class="tab-button active-tab" data-target="tab1">신착도서</div>
						<div class="tab-button" data-target="tab2">추천도서</div>
					</div>
					<div class="tab-content tab1"></div>
					<div class="tab-content tab2" style="display: none;">
						<c:if test="${fn:length(recommendBookList) < 1}">
							<div class="book-nodata">등록된 추천도서가 없습니다.</div>
						</c:if>
						<div class="tab-list">
							<c:if test="${fn:length(recommendBookList) >= 1}">
								<c:set var="loopCount" value="${fn:length(recommendBookList) > 10 ? 10 : fn:length(recommendBookList)}"/>
								<c:forEach var="i" begin="0" end="9">
									<div class="tab-list-item">
										<a href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${recommendBookList[listNums[i]].manage_idx}&board_idx=${recommendBookList[listNums[i]].board_idx}">
											<c:choose>
												<c:when test="${recommendBookList[listNums[i]].preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(recommendBookList[listNums[i]].preview_img, 'http')}">
															<img src="${recommendBookList[listNums[i]].preview_img}" alt="${recommendBookList[listNums[i]].title}" onerror="this.onerror=null; this.src='/resources/homepage/duryu/img/common/dummy.png'"/>
														</c:when>
														<c:otherwise>
															<img src="/data/board/${recommendBookList[listNums[i]].manage_idx}/${recommendBookList[listNums[i]].board_idx}/${recommendBookList[listNums[i]].preview_img}" alt="${recommendBookList[listNums[i]].title}" title="${recommendBookList[listNums[i]].title}" onerror="this.onerror=null; this.src='/resources/homepage/duryu/img/common/dummy.png'"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/resources/homepage/duryu/img/common/dummy.png" alt="${recommendBookList[listNums[i]].title}" title="${recommendBookList[listNums[i]].title}">
												</c:otherwise>
											</c:choose>
											<c:set var="text001" value="${recommendBookList[listNums[i]].title}"/>
										</a>
										<div class="title">${text001}</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
						<c:if test="${fn:length(recommendBookList) >= 1}">
							<div class="book-controller">
								<img class="book-slide-prev" src="/resources/homepage/duryu/img/book/arrow-left.svg" alt="">
								<img class="book-slide-next" src="/resources/homepage/duryu/img/book/arrow-right.svg" alt="">
							</div>
						</c:if>
					</div>
				</div>
			</div>

			<!-- footer -->
			<div class="footer section-wrapper fp-auto-height" data-anchor="section5">
				<!-- banner -->
				<div class="banner-area">
					<div class="banner-slide-controller">
						<img class="banner-prev" src="/resources/homepage/duryu/img/common/banner-prev.svg" alt="" />
						<img class="banner-next" src="/resources/homepage/duryu/img/common/banner-next.svg" alt="" />
						<img class="banner-play-and-pause" src="/resources/homepage/duryu/img/common/banner-pause.svg" alt="">
						<img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/duryu/img/common/banner-more.svg" alt="">
					</div>
					<div class="banner-slide">
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
						<a href="" class="banner-slide-item">
							<img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
						</a>
					</div>
				</div>

				<tiles:insertAttribute name="footer" />
			</div>
		</div>

		<!-- indicator -->
		<div id="fullpage-indicator">
			<div data-menuanchor="section1"></div>
			<div data-menuanchor="section2"></div>
			<div data-menuanchor="section3"></div>
			<div data-menuanchor="section4"></div>
			<div data-menuanchor="section5"></div>
		</div>
	</div>
</body>