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
			var checkInput = $this.parent().find('input');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#' + popupId).hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
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
										<div class="title-box">자료검색</div>
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="title" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서명을 입력해 주세요." style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
									</div>
								</fieldset>
							</form>
						</div>
					</div>

					<div class="main1box1box2">

						<div class="main1box1box2box1">
							<ul>
								<li class="bg-green">
									<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
									<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
									<span class="wt">수강신청</span>
									<span class="wc">온라인 수강신청</span>
									</a>
								</li>
								<li class="bg-white">
									<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
									<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
									<span class="wt">평생교육강좌</span>
									<span class="wc">다양한 교육문화<Br/>프로그램</span>
									</a>
								</li>
								<li class="bg-navy">
									<a href="/${homepage.context_path}/html.do?menu_idx=114">
									<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
									<span class="wt">도서관 견학</span>
									<span class="wc">어린이도서관<Br/>체험활동</span>
									</a>
								</li>
								<li class="bg-white">
									<a href="/${homepage.context_path}/elib.do?menu_idx=46">
									<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
									<span class="wt">전자도서관</span>
									<span class="wc">전자책,e러닝 등<Br/>다양한 디지털 콘텐츠</span>
									</a>
								</li>
								<li class="bg-blue">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=95">
									<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
									<span class="wt">독서문화행사</span>
									<span class="wc">서로 공감하고<br/>소통할 수 있는 프로그램</span>
									</a>
								</li>
								<li class="bg-dgreen">
									<a href="javascript:alert('준비 중 입니다.');">
									<img src="/resources/homepage/${homepage.context_path}/img/quick06-bg.png" class="mi">
									<span class="wt">전시관 견학</span>
									<span class="wc">해설 및 전시실 투어</span>
									</a>
								</li>
							</ul>
						</div>

						<div class="main1box1box2box2">
							<div class="book tabS">
								<div class="title">
									<ul class="tabMenuS">
										<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='t-tabs'>신간도서</a></li>
										<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=94" class='t-tabs'>추천도서</a></li>
										<li><a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
									</ul>
								</div>

								<div class="box con" data-tab="tab1">
									<ul class="book_photo newBookUl">

									</ul>
								</div>

								<div class="box con" data-tab="tab2" style="display:none;">
									<ul class="book_photo">
										<li>
											<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=94&board_idx=${newBookBoardList[listNum1].board_idx}">
												<c:choose>
												<c:when test="${newBookBoardList[listNum1].preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(newBookBoardList[listNum1].preview_img, 'http')}">
														<img src="${newBookBoardList[listNum1].preview_img}" alt="${newBookBoardList[listNum1].title}" />
														</c:when>
														<c:otherwise>
														<img src="/data/board/${newBookBoardList[listNum1].manage_idx}/${newBookBoardList[listNum1].board_idx}/${newBookBoardList[listNum1].preview_img}" alt="${newBookBoardList[listNum1].title}" title="${newBookBoardList[listNum1].title}"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/resources/common/img/noimg-gall.png" alt="${newBookBoardList[listNum1].title}" title="${newBookBoardList[listNum1].title}">
												</c:otherwise>
												</c:choose>
												<span class="title">${newBookBoardList[listNum1].title}</span>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="main1box2">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="등록된 팝업존이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">

					<div class="information">
						<h3>도서관 이용안내</h3>

						<h4>유아·어린이자료실, 디지털자료실</h4>
						<ul>
							<li><span class="dot">-</span> <span class="txt">화~금</span> 09:00 ~ 18:00</li>
							<li><span class="dot">-</span> <span class="txt">토~일</span> 09:00 ~ 17:00</li>
						</ul>

						<h4>일반자료실</h4>
						<ul>
							<li><span class="dot">-</span> <span class="txt">화~금</span> 09:00 ~ 21:00</li>
							<li><span class="dot">-</span> <span class="txt">토~일</span> 09:00 ~ 17:00</li>
						</ul>

						<p style="font-size:13px;">※매주 월요일 및 법정공휴일은 휴관입니다</p>
					</div>

				</div>

				<div class="main2box2">
					<div class="calendar-box">

						<div class="cal-box">

						</div>

					</div>
				</div>

				<div class="main2box3">
					<div class="notice tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=97" class='t-tabs'>공지사항</a></li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=64&manage_idx=98" class='t-tabs'>자주묻는질문</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=97" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="cont con" data-tab="tab1">
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

						<div class="cont con" data-tab="tab2" style="display:none;">
							<ul class="lists">
								<%--자주묻는질문 목록--%>
 								<c:forEach var="i" varStatus="status" items="${faqList}" >
								<li>
									<a href="/${homepage.context_path}/board/index.do?menu_idx=64&manage_idx=${i.manage_idx}">
										<em>${i.title}</em>
										<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
									</a>
								</li>
								</c:forEach>

								<c:if test="${fn:length(faqList) < 1}">
								<li>
									<em>등록된 게시물이 없습니다.</em>
								</li>
								</c:if>
								<%--자주묻는질문 목록--%>
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

		<div id="quick-slide">
			<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
			<ul>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick001-bg.png" alt="책바다"></span><span class="txt">책바다</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=49"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=50"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick003-bg.png" alt="사서에게 물어보세요"></span><span class="txt">사서에게<br/>물어보세요</span></a></li>
			</ul>
		</div>

	</div>


<tiles:insertAttribute name="footer" />