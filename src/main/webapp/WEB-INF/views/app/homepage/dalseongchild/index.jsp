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


<!-- 메인 -->
<link rel="stylesheet" href="/resources/homepage/dalseongchild/css/common/reset.css"/>
<script src="/resources/homepage/dalseongchild/plugin/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/homepage/dalseongchild/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/dalseongchild/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/dalseongchild/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/dalseongchild/css/index/section4.css"/>
<script src="/resources/homepage/dalseongchild/js/common/common.js"></script>
<script src="/resources/homepage/dalseongchild/js/index/section1.js"></script>
<script src="/resources/homepage/dalseongchild/js/index/section2.js"></script>
<script src="/resources/homepage/dalseongchild/js/index/section3.js"></script>
<script src="/resources/homepage/dalseongchild/js/index/section4.js"></script>


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


		$('div.calendar').load('calendar3.do');
		$('div#holiday-area').load('calendar2.do');

		$('.new').html('<div class="book-nodata">LOADING...</div>');

		$('div.new').load('newBook.do', function () {
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
		});

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});


		$('.book-content-tab').click(function() {
			// 탭 활성화 클래스 처리
			$('.book-content-tab').removeClass('active');
			$(this).addClass('active');

			// target 읽기
			var target = $(this).data('target');

			// 링크 URL 결정
			var newUrl = '';
			if (target === 'recommended') {
				newUrl = '/${homepage.context_path}/board/index.do?menu_idx=12&manage_idx=1270';
			} else if (target === 'new') {
				newUrl = '/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=9';
			}

			// 링크 변경
			$('.go-to-book-detail').attr('href', newUrl);
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
			<p class="close">
				<input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기"/></a></p>
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

		<!-- 섹션1 -->
		<div class="section-wrapper" data-anchor="section1">
			<div class="main-bg-slide">
				<div></div>
				<div></div>
			</div>
			<div class="wrapper">
				<div class="slogan">
					<div>미래를 품고 꿈꾸는 공간</div>
					<div>달성어린이숲도서관</div>
				</div>
				<!-- 검색 -->
				<div class="search-area" id="main_search">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="9">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<select id="search_type" name="search_type" class="search_type">
									<option value="L_TITLE">서명</option>
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
								<div id="main-search-btn">
									<img src="/resources/homepage/dalseongchild/img/main/search.svg" alt="">
									<div>검색하기</div>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<!-- 퀵메뉴 -->
				<div class="quick-menu">
					<c:forEach var="i" varStatus="status" items="${quickMenuList}">
						<c:if test="${i.link_target eq 'BLANK' }">
							<a class="quick-menu-item" href="${i.link_url}" target="_blank">
								<img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}" alt="${i.menu_name}">
								<div>${i.menu_name}</div>
							</a>
						</c:if>
						<c:if test="${i.link_target ne 'BLANK' }">
							<a class="quick-menu-item" href="${i.link_url}" target="_blank">
								<img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}" alt="${i.menu_name}">
								<div>${i.menu_name}</div>
							</a>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 섹션2 -->
		<div class="section-wrapper" data-anchor="section2">
			<div class="wrapper">
				<div class="popup-slide-wrapper">
					<div class="popup-slide-header">
						<div class="popup-slide-title">팝업존</div>
						<div class="popup-control">
							<div class="popup-pagination"></div>
							<div class="popup-prev">
								<img src="/resources/homepage/dalseongchild/img/notice/popup-prev.svg" alt=""/>
							</div>
							<div class="popup-play-and-pause">
								<img src="/resources/homepage/dalseongchild/img/notice/pause.svg" alt=""/>
							</div>
							<div class="popup-next">
								<img src="/resources/homepage/dalseongchild/img/notice/popup-next.svg" alt=""/>
							</div>
						</div>
					</div>
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<div class="popup-slide">
								<c:forEach var="i" items="${popupZoneList}">
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
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="popup-slide">
								<a href="">
									<img src="/resources/homepage/dalseongchild/img/common/dummy.png" alt="" />
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="notice-board">
					<div class="notice-board-header">
						<div class="notice-board-title">공지사항</div>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=1263">
							<img src="/resources/homepage/dalseongchild/img/notice/more.svg" alt="">
						</a>
					</div>
					<div class="notice-list">
						<c:if test="${fn:length(noticeListTopNotice) >= 1}">
							<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" begin='0' end='1'>
								<a class="notice-list-item fixed" href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<div class="notice-list-item-date">
										<div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
										<div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
									</div>
									<div class="notice-list-item-title">${i.title}</div>
								</a>
							</c:forEach>
						</c:if>

						<c:if test="${fn:length(noticeList) < 1 && fn:length(noticeListTopNotice) < 1}">
							<div class="notice-no-data">등록된 공지사항이 없습니다.</div>
						</c:if>

						<c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='2'>
							<c:if test="${i.notice_yn eq 'N' or null}">
								<a class="notice-list-item" href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<div class="notice-list-item-date">
										<div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
										<div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
									</div>
									<div class="notice-list-item-title">${i.title}</div>
								</a>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>

			<div class="main-bottom-area">
				<div class="holiday-area" id="holiday-area"></div>
			</div>
		</div>
		<!-- 섹션3 -->
		<div class="section-wrapper" data-anchor="section3">
			<div class="wrapper">
				<div class="calendar"></div>
				<div class="board-wrapper">
					<div class="tab-wrapper">
						<div class="tab active" data-content="culture">
							<div>문화행사</div>
							<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=26&searchCate1=16"><img src="/resources/homepage/dalseongchild/img/culture/active-more.svg" alt="More"></a>
						</div>
						<div class="tab" data-content="program">
							<div>평생학습프로그램</div>
							<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30&searchCate1=17"><img src="/resources/homepage/dalseongchild/img/culture/more.svg" alt="More"></a>
						</div>
					</div>

					<!--         문화행사           -->
					<div class="tab-content1">
						<c:if test="${fn:length(teachList1) < 1}">
							<div class="no-culture">등록된 행사가 없습니다.</div>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${teachList1}" begin='0' end='3'>
							<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=26&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
								<div class="label">${i.large_category_name}</div>
								<div class="tab-content-detail">
									<div>${i.teach_name}</div>
									<div>${i.start_date} ~ ${i.end_date}</div>
								</div>
							</a>
						</c:forEach>
					</div>

					<!--         평생학습프로그램           -->
					<div class="tab-content2" style="display: none">
						<c:if test="${fn:length(teachList2) < 1}">
							<div class="no-culture">등록된 프로그램이 없습니다.</div>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${teachList2}" begin='0' end='3'>
							<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=26&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
								<div class="label">${i.large_category_name}</div>
								<div class="tab-content-detail">
									<div>${i.teach_name}</div>
									<div>${i.start_date} ~ ${i.end_date}</div>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<!-- 섹션4 -->
		<div class="section-wrapper" data-anchor="section4">
			<div class="wrapper">
				<div class="book-content-header">
					<div class="book-content-tab-wrapper">
						<div class="book-content-tab active" data-target="recommended">
							<img src="/resources/homepage/dalseongchild/img/book/recommended.svg" alt="">
							<div>추천도서</div>
						</div>
						<div class="book-content-tab" data-target="new">
							<img src="/resources/homepage/dalseongchild/img/book/new.svg" alt="">
							<div>신착도서</div>
						</div>
					</div>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=12&manage_idx=1270" class="go-to-book-detail">
						<img src="/resources/homepage/dalseongchild/img/book/more.svg" alt="">
					</a>
				</div>

				<div class="recommended">
					<c:if test="${fn:length(bookList) < 1}">
						<div class="book-nodata">등록된 추천도서가 없습니다.</div>
					</c:if>
					<c:if test="${fn:length(bookList) >= 1}">
					<div class="book-slide">
						<c:forEach var="i" varStatus="status" items="${bookList}">
						<div class="book-slide-item">
							<a href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
								<c:choose>
									<c:when test="${i.preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(i.preview_img, 'http')}">
												<img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
											</c:when>
											<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
												<img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
											</c:when>
											<c:otherwise>
												<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									</c:otherwise>
								</c:choose>
							</a>
							<a href="" class="title">
								<div>${i.title}</div>
								<img src="/resources/homepage/dalseongchild/img/book/arrow.svg" alt="">
							</a>
						</div>
						</c:forEach>
					</div>
					</c:if>
				</div>

				<div class="new" style="display: none;"></div>
			</div>

			<!-- footer -->
			<div class="footer">
				<!-- banner -->
				<div class="banner-area">
					<img class="banner-prev" src="/resources/homepage/dalseongchild/img/common/banner-prev.svg" alt=""/>
					<div class="banner-slide">
						<a class="banner-slide-item" href="https://www.daegu.go.kr/index.do">
							<img src="/resources/homepage/dalseongchild/img/common/01.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.dge.go.kr/main/main.do">
							<img src="/resources/homepage/dalseongchild/img/common/02.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.edunavi.kr/portal/main.do">
							<img src="/resources/homepage/dalseongchild/img/common/03.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.nanet.go.kr/main.do">
							<img src="/resources/homepage/dalseongchild/img/common/04.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.nl.go.kr/">
							<img src="/resources/homepage/dalseongchild/img/common/05.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://nlcy.go.kr/NLCY/main/index.do">
							<img src="/resources/homepage/dalseongchild/img/common/06.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://books.nl.go.kr/PU/contents/P20700000000.do">
							<img src="/resources/homepage/dalseongchild/img/common/07.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://books.nl.go.kr/PU/contents/P10400000000.do">
							<img src="/resources/homepage/dalseongchild/img/common/08.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://cn.nld.go.kr/index.do">
							<img src="/resources/homepage/dalseongchild/img/common/09.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.nl.go.kr/NL/contents/N30502000000.do">
							<img src="/resources/homepage/dalseongchild/img/common/10.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.data4library.kr/">
							<img src="/resources/homepage/dalseongchild/img/common/11.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.1365.go.kr/vols/main.do">
							<img src="/resources/homepage/dalseongchild/img/common/12.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.youth.go.kr/youth/">
							<img src="/resources/homepage/dalseongchild/img/common/13.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.nlcy.go.kr/NLCY/contents/C10503010000.do">
							<img src="/resources/homepage/dalseongchild/img/common/14.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://info.edunet.net/">
							<img src="/resources/homepage/dalseongchild/img/common/15.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.safetyreport.go.kr/#main">
							<img src="/resources/homepage/dalseongchild/img/common/16.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.mcst.go.kr/kor/main.jsp">
							<img src="/resources/homepage/dalseongchild/img/common/17.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.keris.or.kr/main/main.do">
							<img src="/resources/homepage/dalseongchild/img/common/18.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.data.go.kr/index.do">
							<img src="/resources/homepage/dalseongchild/img/common/19.jpg" alt="">
						</a>
						<a class="banner-slide-item" href="https://www.nl.go.kr/kolisnet/index.do">
							<img src="/resources/homepage/dalseongchild/img/common/20.jpg" alt="">
						</a>
					</div>
					<img class="banner-next" src="/resources/homepage/dalseongchild/img/common/banner-next.svg" alt=""/>
				</div>

				<tiles:insertAttribute name="footer"/>
			</div>
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

