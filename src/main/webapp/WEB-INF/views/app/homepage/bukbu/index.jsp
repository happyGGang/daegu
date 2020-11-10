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
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
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


		$('div.cal-box').load('calendar3.do');
		$('ul.newBookUl').load('newBook.do');

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

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container" class="main">

		<div class="main1">
			<div class="section">

				<div class="main1box1">

					<div class="main1box1box1">
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="title" id="search_text_1" type="text" class="text" placeholder="도서명, 저자, 출판사 등 검색어를 입력하세요!" style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
										<div class="title-box"><img src="/resources/homepage/${homepage.context_path}/img/search-bg.png" alt=""></div>
									</div>
								</fieldset>
							</form>
						</div>
					</div>

					<div class="main1box1box2">
						<div class="main1box1box2box1">
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
						</div>

						<div class="main1box1box2box2">
							<ul>
								<li class="bg-blue">
									<a href="/${homepage.context_path}/html.do?menu_idx=104">
									<span class="wt">이용안내</span>
									<span class="wc">우리 도서관에<br/>처음 오셨나요?</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=124&manage_idx=146">
									<span class="wt">도서관행사</span>
									<span class="wc">다양한 독서프로그램</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="/${homepage.context_path}/elib.do?menu_idx=46">
									<span class="wt">대구전자도서관</span>
									<span class="wc">전자책, 오디오북 등 디지털콘텐츠</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=1" target="_blank">
									<span class="wt">디지털정보코너</span>
									<span class="wc">쉽고 빠른 좌석 예약</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="/${homepage.context_path}/html.do?menu_idx=26" style="z-index: 9;">
									<span class="wt">희망도서신청</span>
									<span class="wc">읽고 싶은 책 구입 신청</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-blue">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157">
									<span class="wt">영화상영</span>
									<span class="wc">재미있는 영화 감상</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick07-bg.png" class="mi">
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="main1box2">
					<div class="calendar-box">
						<div class="title">
							<ul>
								<li><h2>휴관일 및 행사</h2></li>
								<li><a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="cal-box">

						</div>

						<div class="library-infomation">
							<div class="top">
								<div class="topBox1">
									<span><h4>종합자료실</h4></span>
									<span>
									<strong>평일 09:00~19:00<br/>
									주말 09:00~17:00</strong>
									</span>
								</div>
								<div class="topBox2">
									<span><h4>어린이자료실</h4></span>
									<span>
									<strong>평일 09:00~18:00<br/>
									주말 09:00~17:00</strong>
									</span>
								</div>
							</div>
							<div class="bottom">
								<span><h4>자유학습실</h4></span>
								<span><strong>08:00~21:00</strong></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="book tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1">신간도서</a> <a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
								<li><a href="#tab2">추천도서</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=144" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
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
							</ul>
						</div>
					</div>
				</div>

				<div class="main2box2">
					<ul>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick001-bg.png" alt="책바다"></span><span class="txt">책바다</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=49"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=50"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick003-bg.png" alt="사서에게 물어보세요"></span><span class="txt">사서에게<br/>물어보세요</span></a></li>
						<li><a href="/${homepage.context_path}/board/index.do?menu_idx=110&manage_idx=4"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick004-bg.png" alt="경북대학교 상호대차"></span><span class="txt">경북대학교<br/>상호대차</span></a></li>
					</ul>
				</div>

				<div class="main2box3">
					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
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
				</div>

				<div class="main2box4">
					<div class="culture">
						<div class="title">
							<ul>
								<li><h2>수강신청</h2></li>
								<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="cont">
							<ul class="list">
								<c:if test="${fn:length(teachList) < 1}">
								<li>
									등록된 강좌가 없습니다.
								</li>
								</c:if>
								<c:forEach items="${teachList}" var="i" varStatus="status">
								<li>
									<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
										<em>${i.teach_name}</em>
										<c:if test="${i.teach_status eq '0'}">
										<span class="status before">접수중</span>
										</c:if>
										<c:if test="${i.teach_status eq '1'}">
										<span class="status before">대기접수</span>
										</c:if>
										<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
										<span class="status after">신청완료</span>
										</c:if>
										<c:if test="${i.teach_status eq '3'}">
										<span class="status after">신청완료</span>
										</c:if>
										<c:if test="${i.teach_status eq '9'}">
										<span class="status after">수강종료</span>
										</c:if>
										<c:if test="${i.teach_status eq '4'}">
										<span class="status after">접수마감</span>
										</c:if>
										<c:if test="${i.teach_status eq '5'}">
										<span class="status after">정원마감</span>
										</c:if>
										<c:if test="${i.teach_status eq '6'}">
										<span class="status before">신청대기</span>
										</c:if>
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
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

	<!-- 퀵메뉴 분리 20200226 -->
	<div id="quick-slide">
		<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
		<ul>
			<!--<li><a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=1" target="_blank"><span class="txt">디지털 정보코너<Br/>좌석예약</span></a></li>
			<li><a href="/${homepage.context_path}/html.do?menu_idx=26"><span class="txt">희망도서신청</span></a></li>-->
			<li><a href="#"><span class="txt">도서예약</span></a></li>
			<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157"><span class="txt">영화상영일정</span></a></li>
			<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30"><span class="txt">수강신청</span></a></li>
			<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16"><span class="txt">대출현황</span></a></li>
			<li><a href="/${homepage.context_path}/html.do?menu_idx=104"><span class="txt">이용안내</span></a></li>
			<!--<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="txt">책바다신청</span></a></li>-->
			<!--<li><a href="/${homepage.context_path}/board/index.do?menu_idx=65&manage_idx=148"><span class="txt">묻고답하기</span></a></li>-->
			<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1"><span class="txt">공지사항</span></a></li>
			<!--<li><a href="/${homepage.context_path}"><span class="txt">업무추진비<Br/>집행내역</span></a></li>
			<li><a href="/${homepage.context_path}/bukbu/html.do?menu_idx=78"><span class="txt">행정정보공개</span></a></li>-->
		</ul>
	</div>

<tiles:insertAttribute name="footer" />