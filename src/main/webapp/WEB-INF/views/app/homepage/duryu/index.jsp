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

		<div class="main0">
			<div class="section">
						<div class="txt">
							<img src="/resources/homepage/${homepage.context_path}/img/duryu_txt.png" alt="전통과 함께 미래를 열어가는 두류도서관">
						</div>
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="title" id="search_text_1" type="text" class="text" placeholder="제목, 저자, 출판사 등 검색어를 입력하세요!" style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
									</div>
								</fieldset>
							</form>
						</div>

			</div>
		</div>

		<div class="main1">
			<div class="section">

				<div class="main1box1">

					<div class="main1box1box1">
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

					<div class="main1box1box2">
						<ul>
							<li class="bg-yellow">
								<a href="/${homepage.context_path}/html.do?menu_idx=104">
								<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
								<span class="wt">이용안내</span>
								<span class="wc">이용시간 및 실별안내</span>
								</a>
							</li>
							<li class="bg-lgray">
								<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16">
								<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
								<span class="wt">나의도서관</span>
								<span class="wc">대출 및 도서신청 정보</span>
								</a>
							</li>
							<li class="bg-wood">
								<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
								<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
								<span class="wt">수강신청</span>
								<span class="wc">강좌안내 및 수강신청</span>
								</a>
							</li>
							<li class="bg-lgray">
								<a href="/duryu/module/archive/index.do?menu_idx=121">
								<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
								<span class="wt">족보자료</span>
								<span class="wc">족보원문DB, 족보상식 등<Br/>다양한 족보이야기</span>
								</a>
							</li>
							<li class="bg-orange">
								<a href="/duryu/elib.do?menu_idx=46">
								<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
								<span class="wt">전자도서관</span>
								<span class="wc">전자책, 오디오북 등<Br/>디지털 콘텐츠</span>
								</a>
							</li>
							<li class="bg-lgray">
								<a href="https://www.youth.go.kr/youth/" target="_blank">
								<img src="/resources/homepage/${homepage.context_path}/img/quick06-bg.png" class="mi">
								<span class="wt">자원봉사</span>
								<span class="wc">자원봉사활동 안내</span>
								</a>
							</li>
						</ul>
					</div>
				</div>

				<div class="main1box2">
					<div class="calendar-box">
						<div class="title">
							<ul>
								<li><h2>도서관 행사</h2></li>
								<li><a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="cal-box">

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
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='t-tabs'>신간도서</a></li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=233" class='t-tabs'>추천도서</a></li>
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
					</ul>
				</div>

				<div class="main2box3">
					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=132"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
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
					<div class="movie">
						<div class="title">
							<ul>
								<li><h2>영화상영</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=25"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="movieContent">
							<ul>
								<c:forEach var="i" varStatus="status" items="${movieList}" >
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
										<span class="movieImg">
										<c:choose>
											<c:when test="${i.preview_img ne null}">
												<c:choose>
													<c:when test="${fn:contains(i.preview_img, 'http')}">
														<img src="${i.preview_img}" alt="${i.title}"/>
													</c:when>
													<c:otherwise>
														<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
														<img src="/resources/common/img/noimg-gall.png" alt="${i.title}">
											</c:otherwise>
										</c:choose>
										</span>

										<span class="movieEx">
											<c:if test="${i.imsi_v_12 ne null and i.imsi_v_12 ne '0'}">
											<div>${fn:substring(i.imsi_v_12, 0, 15)}<c:if test="${fn:length(i.imsi_v_12) > 15}">...</c:if></div>
											</c:if>
											<strong class="title">${i.title}</strong>

											<c:if test="${i.imsi_v_1 ne '' and i.imsi_v_2 ne ''}">
											<span class="date">
											<b>날짜</b> ${fn:replace(i.imsi_v_1, '-', '.')}.${i.imsi_v_2}
											</span>
											</c:if>

											<c:if test="${i.imsi_v_3 ne null and i.imsi_v_4 ne null}">
											<span class="time">
											<b>시간</b> ${i.imsi_v_3}:${fn:length(i.imsi_v_4) == 1 ? '0' : ''}${i.imsi_v_4}
											</span>
											</c:if>

											<c:if test="${i.imsi_v_6 ne null and i.imsi_v_6 ne '0'}">
											<span class="divid">
											<b>장소</b> ${i.imsi_v_6}
											</span>
											</c:if>

											<c:if test="${i.imsi_v_9 ne null and i.imsi_v_9 ne '0'}">
											<span class="desc">
											<b>장르</b>  ${fn:substring(i.imsi_v_9, 0, 15)}<c:if test="${fn:length(i.imsi_v_9) > 15}">...</c:if>
											</span>
											</c:if>
										</span>
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
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=154"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box3">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>

	</div>


<tiles:insertAttribute name="footer" />