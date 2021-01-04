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


		$('div#holiday-box').load('calendar2.do');
		$('div.cal-box').load('calendar3.do');
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

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container" class="main container">
		<div class="section">

			<div class="center-section">
				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">통합검색</button>
							</div>
						</fieldset>
					</form>
				</div>

				<div class="notice">
					<div class="title">
						<ul>
							<li><h2>공지사항</h2></li>
							<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=56"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
						</ul>
					</div>
					<div class="cont">
						<ul class="list">
							<%--공지사항 상단--%>
							<c:if test="${fn:length(noticeListTopNotice) < 1}">
							<li class="on-cont">
								<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
								<a href="#">
									<span class="title">등록된 공지사항이 없습니다.</span>
									<p class="date"></p>
									<span class="content">
									</span>
								</a>
							</li>
							</c:if>
							<c:if test="${fn:length(noticeListTopNotice) > 0}">
							<li class="on-cont">
								<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
								<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${noticeListTopNotice[0].manage_idx}&board_idx=${noticeListTopNotice[0].board_idx}">
									<span class="title">${noticeListTopNotice[0].title}</span>
									<p class="date"><fmt:formatDate value="${noticeListTopNotice[0].add_date}" pattern="yyyy-MM-dd"/></p>
									<span class="content">
										${fn:substring(fn:trim(noticeListTopNotice[0].content_summary), 0, 30)}...
									</span>
								</a>
							</li>
							</c:if>
								<%--공지사항 상단--%>

							<%--공지사항 목록--%>
								<c:forEach var="i" varStatus="status" items="${noticeList}" >
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<em>${i.title}</em>
									<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
								</a>
							</li>
							</c:forEach>

							<c:if test="${fn:length(noticeList) < 1}">
							<li>
								<em>등록된 공지사항이 없습니다.</em>
							</li>
							</c:if>
							<%--공지사항 목록--%>
						</ul>
					</div>
				</div>

				<div class="book tabS">
					<div class="title">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1">신간도서</a> <a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							<li><a href="#tab2">추천도서</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=31" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							<li><a href="#tab3">베스트도서</a> <a href="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
						</ul>
					</div>
					<div class="box con" data-tab="tab1">
						<ul class="book_photo newBookUl">
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${recommendBookList[listNum1].manage_idx}&board_idx=${recommendBookList[listNum1].board_idx}">
									<c:choose>
									<c:when test="${recommendBookList[listNum1].preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(recommendBookList[listNum1].preview_img, 'http')}">
											<img src="${recommendBookList[listNum1].preview_img}" alt="${recommendBookList[listNum1].title}" />
											</c:when>
											<c:otherwise>
											<img src="/data/board/${recommendBookList[listNum1].manage_idx}/${recommendBookList[listNum1].board_idx}/${recommendBookList[listNum1].preview_img}" alt="${recommendBookList[listNum1].title}" title="${recommendBookList[listNum1].title}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noimg-gall.png" alt="${recommendBookList[listNum1].title}" title="${recommendBookList[listNum1].title}">
									</c:otherwise>
									</c:choose>
									<c:set var="text001" value="${recommendBookList[listNum1].title}"/>
									<span class="title">
									<c:choose>
										<c:when test="${fn:length(text001) > 12}">
											${fn:substring(text001, 0, 12)}...
										</c:when>
										<c:otherwise>
											${text001}
										</c:otherwise>
									</c:choose>
									</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${recommendBookList[listNum2].manage_idx}&board_idx=${recommendBookList[listNum2].board_idx}">
									<c:choose>
									<c:when test="${recommendBookList[listNum2].preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(recommendBookList[listNum2].preview_img, 'http')}">
											<img src="${recommendBookList[listNum2].preview_img}" alt="${recommendBookList[listNum2].title}" />
											</c:when>
											<c:otherwise>
											<img src="/data/board/${recommendBookList[listNum2].manage_idx}/${recommendBookList[listNum2].board_idx}/${recommendBookList[listNum2].preview_img}" alt="${recommendBookList[listNum2].title}" title="${recommendBookList[listNum2].title}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noimg-gall.png" alt="${recommendBookList[listNum2].title}" title="${recommendBookList[listNum2].title}">
									</c:otherwise>
									</c:choose>
									<c:set var="text002" value="${recommendBookList[listNum2].title}"/>
									<span class="title">
									<c:choose>
										<c:when test="${fn:length(text002) > 12}">
											${fn:substring(text002, 0, 12)}...
										</c:when>
										<c:otherwise>
											${text002}
										</c:otherwise>
									</c:choose>
									</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${recommendBookList[listNum3].manage_idx}&board_idx=${recommendBookList[listNum3].board_idx}">
									<c:choose>
									<c:when test="${recommendBookList[listNum3].preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(recommendBookList[listNum3].preview_img, 'http')}">
											<img src="${recommendBookList[listNum3].preview_img}" alt="${recommendBookList[listNum3].title}" />
											</c:when>
											<c:otherwise>
											<img src="/data/board/${recommendBookList[listNum3].manage_idx}/${recommendBookList[listNum3].board_idx}/${recommendBookList[listNum3].preview_img}" alt="${recommendBookList[listNum3].title}" title="${recommendBookList[listNum3].title}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noimg-gall.png" alt="${recommendBookList[listNum3].title}" title="${recommendBookList[listNum3].title}">
									</c:otherwise>
									</c:choose>
									<c:set var="text003" value="${recommendBookList[listNum3].title}"/>
									<span class="title">
									<c:choose>
										<c:when test="${fn:length(text003) > 12}">
											${fn:substring(text003, 0, 12)}...
										</c:when>
										<c:otherwise>
											${text003}
										</c:otherwise>
									</c:choose>
									</span>
								</a>
							</li>
						</ul>
					</div>

					<div class="box con" data-tab="tab3" style="display:none;">
						<ul class="book_photo bestBookUl">
						</ul>
					</div>
				</div>
			</div>

			<div class="left-section">
				<div class="popZone">
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<homepageTag:popupZone popupZoneList="${popupZoneList}" />
						</c:when>
						<c:otherwise>
							<ul>
								<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="" /></a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="left-quick-section">
					<ul>
						<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16" class="quick-01"><span class="txt"><p>나의 도서관</p><p>대출 및 도서신청 정보</p></span><img src="/resources/homepage/${homepage.context_path}/img/go-bg.png" alt="나의 도서관" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=48" class="quick-02"><span class="txt"><p>책바다</p><p>국가상호대차서비스</p></span><img src="/resources/homepage/${homepage.context_path}/img/go-bg.png" alt="책바다" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=49" class="quick-03"><span class="txt"><p>책나래</p><p>장애인무료택배서비스</p></span><img src="/resources/homepage/${homepage.context_path}/img/go-bg.png" alt="책나래" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=50" class="quick-04"><span class="txt"><p>사서에게물어보세요</p><p>지식정보서비스</p></span><img src="/resources/homepage/${homepage.context_path}/img/go-bg.png" alt="사서에게물어보세요" class='go-bg'></a></li>
					</ul>
				</div>
			</div>

			<div class="right-section">
				<div class="right-quick-section">
					<ul>
						<li><a href="http://library.daegu.go.kr/suseong/html.do?menu_idx=104" class="quick-05"><span class="txt"><p>이용안내</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="이용안내" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30" class="quick-01"><span class="txt"><p>수강신청</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="수강신청" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=56" class="quick-03"><span class="txt"><p>독서문화행사</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="독서문화행사" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=123" class="quick-04"><span class="txt"><p>시각장애인실</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="시각장애인실" class='go-bg'></a></li>
						<li><a href="https://seat.daegu.go.kr/wb_booking/?LIB_CODE=10" class="quick-02"><span class="txt"><p>디지털정보존 좌석예약</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="디지털정보존좌석예약" class='go-bg'></a></li>
						<!--<li><a href="http://library.daegu.go.kr/suseong/elib.do?menu_idx=46" class="quick-06"><span class="txt"><p>대구전자도서관</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="대구전자도서관" class='go-bg'></a></li>-->
					</ul>
				</div>



				<!--<div class="right-quick-section">
					<ul>
						<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30" class="quick-01"><span class="txt"><p>수강신청</p><p>온라인 수강신청</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="수강신청" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=53" class="quick-02"><span class="txt"><p>평생교육강좌</p><p>다양한 교육문화/평생체험</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="평생교육강좌" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=56" class="quick-03"><span class="txt"><p>독서문화행사</p><p>소통하는 프로그램</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="독서문화행사" class='go-bg'></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=123" class="quick-04"><span class="txt"><p>시각장애인실</p><p>우리도서관 특색사업</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="시각장애인실" class='go-bg'></a></li>
						<!--<li><a href="/${homepage.context_path}/html.do?menu_idx=114" class="quick-05"><span class="txt"><p>소리인문학</p><p>책 읽는 즐거움 소리도서</p></span><img src="/resources/homepage/${homepage.context_path}/img/quick-arrow.png" alt="소리인문학" class='go-bg'></a></li>
					</ul>
				</div>-->




				<div class="calendar-box">
					<div class="title">
						<ul>
							<li><h2>도서관 일정</h2></li>
							<li><a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
						</ul>
					</div>

					<div class="cal-box">
					</div>
				</div>
			</div>

		</div>

		<div class="section">
			<div class="main7_banner">
				<div class="banner-wrap type1">
					<div class="banner-t3">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box3">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
			</div>
         <!--퀵메뉴-->
		 <div id="quick-slide">
			<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
			<ul>
				<li><a href="/${homepage.context_path}/elib.do?menu_idx=46"><span class="txt">전자도서관</span></a></li>
				<!--li><a href="#"><span class="txt">디지털자료실<br/>좌석예약</span></a></li-->
				<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=58"><span class="txt">영화상영</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=26"><span class="txt">희망도서신청</span></a></li>
				<li><a href="https://www.1365.go.kr/vols/main.do" target="_blank"><span class="txt">청소년<br/>자원봉사신청</span></a></li>
				<li><a href="http://dgelib.dkyobobook.co.kr" target="_blank"><span class="txt">대구학생<br/>전자도서관</span></a></li>
			</ul>
		</div>
        <!--//퀵메뉴-->
<tiles:insertAttribute name="footer" />