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


		$('div.holiday-box').load('calendar2.do');
		$('div.event-box').load('calendar4.do');
		//$('ul.newBookUl').load('newBook.do');
		//$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

});

function searchCheck() {
	$('input#search_text_1').attr('name', $('select#search_type').val());
}
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

	<div id="container" class="main">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
		<div class="main1">
			<div class="section">

				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do" onsubmit="searchCheck();">
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="title-box">통합자료검색</div>
								<div class="box0">
									<label for="search_type" class="search_type">
										<select id="search_type" name="search_type" style="border:0;font-size:15px">
											<option value="title">서명</option>
											<option value="author">저자</option>
											<option value="publer">발행자</option>
											<option value="keyword">키워드</option>
										</select>
									</label>
								</div>
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="search_text" id="search_text_1" type="text" class="text searchText" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색</button>
							</div>
						</fieldset>
					</form>
				</div>

			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="main2box1box1">
						<ul>
							<li class="bg-blue w40"">
								<a href="/${homepage.context_path}/html.do?menu_idx=104">
								<span class="wt">이용안내</span>
								<span class="wc">남부도서관 이렇게 이용하세요!</span>
								<img src="/resources/homepage/nambu/img/m_icon01.png" class="mi">
								</a>
							</li>
							<li class="bg-background01">
								<a href="/${homepage.context_path}/elib.do?menu_idx=46">
								<span class="wt">대구<br class="qmobileBr"/>전자도서관</span>
								<span class="wc">대구시민의 스마트한<br>독서생활이 시작되는 곳</span>
								</a>
							</li>
							<li class="bg-green">
								<a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=5" target="_blank">
								<span class="wt">좌석예약</span>
								<span class="wc">디지털자료실<br>좌석예약</span>
								<img src="/resources/homepage/nambu/img/m_icon03.png" class="mi"></a>
							</li>
							<li class="bg-background02">
								<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16" style="z-index: 9;">
								<span class="wt">마이페이지</span>
								<span class="wc">대출조회 및 신청현황</span>
								</a>
							</li>
							<li class="bg-lgreen">
								<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
								<span class="wt">수강신청</span>
								<span class="wc">온라인 수강신청</span>
								<img src="/resources/homepage/nambu/img/m_icon04.png" class="mi"></a>
							</li>
							<li class="bg-white">
								<a href="/${homepage.context_path}/html.do?menu_idx=26">
								<span class="wt">희망도서<br>신청</span>
								<!--<span class="wc">도서관 자료<br/>무료우편 서비스</span>-->
								<img src="/resources/homepage/nambu/img/m_icon05.png" class="mi"></a>
							</li>
							<li class="bg-background03">
								<a href="/${homepage.context_path}/html/hopeBook.do?menu_idx=215">
								<span class="wt">희망도서<br>바로대출</span>
								<!--<span class="wc">국가상호대차<br/>서비스</span>-->
								<img src="/resources/homepage/nambu/img/m_icon06.png" class="mi"></a>
							</li>
						</ul>
					</div>


					<div class="main2box1box2">
							<div class="event-box">
							</div>

							<div class="holiday-box">
							</div>
						</ul>
					</div>
				</div>

				<div class="main2box2">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/nambu/img/popupnone.jpg" alt="등록된 팝업존이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>


		<div class="main3">
			<div class="section">

				<div class="main3box1">

					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=109"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
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
								<div class="end"></div>
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

				<div class="main3box2">
					<div class="movie">
						<div class="title">
							<ul>
								<li><h2>영화소개</h2></li><!-- <li><h2>영화상영</h2></li> -->
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=104"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
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
														<img src="/resources/common/img/noImg2.png" alt="${i.title}">
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
											<b>날짜</b> ${i.imsi_v_1}-${i.imsi_v_2}
											</span>
											</c:if>

											<c:if test="${i.imsi_v_3 ne null and i.imsi_v_4 ne null}">
											<span class="time">
											<b>시간</b> ${i.imsi_v_3}:${i.imsi_v_4}
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
								<c:if test="${fn:length(movieList) < 1}">
								<li>
									<a href="javascript:alert('상영예정 영화가 없습니다.'); return false;">
										<span class="movieImg">
											<img src="/resources/common/img/noImg2.png" alt="${i.title}">
										</span>

										<span class="movieEx">
											<strong class="title">상영예정 영화가 없습니다.</strong>
										</span>
									</a>
								</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>

				<div class="main3box3 tabS">
					<div class="book">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=155&manage_idx=384" class='t-tabs'>신착도서</a></li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=145&manage_idx=345" class='t-tabs'>북큐레이션</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=155&manage_idx=384" class="more-btn more-more"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="box con" data-tab="tab1">
							<ul class="book_photo newBookUl">

							<c:forEach var="i" varStatus="status" items="${boardList1}">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/index.do?menu_idx=155&manage_idx=${i.manage_idx}">
									<c:choose>
									<c:when test="${empty i.preview_img}">
									<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." width="100px" height="150px"/>
									</c:when>
									<c:otherwise>
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" width="100px" height="150px"/>
									</c:otherwise>
									</c:choose>
									<span class="title">${i.title}</span>
								</a>
							</li>
							</c:forEach>
							</ul>
						</div>
						<div class="box con" data-tab="tab2" style="display:none;">
							<!-- <ul class="book_photo bestBookUl"> -->
							<ul class="book_photo bestBookUl">

							<c:forEach items="${bookCuration1}" var="curation1">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/index.do?menu_idx=145&manage_idx=${curation1.manage_idx}">
									<c:choose>
									<c:when test="${empty curation1.preview_img}">
									<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." width="100px" height="150px"/>
									</c:when>
									<c:otherwise>
									<img src="/data/board/${curation1.manage_idx}/${curation1.board_idx}/${curation1.preview_img}" alt="${curation1.title}" width="100px" height="150px"/>
									</c:otherwise>
									</c:choose>
									<span class="title">${curation1.title}</span>
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

					<div class="banner-box2">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>

					<div class="banner-t2">
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a><br/>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- 퀵메뉴 -->
		<div id="quick-slide">
			<h4><img src="/resources/homepage/nambu/img/quick-title.png" alt="퀵메뉴"></h4>
			<ul>
				<li style="padding-bottom:10px;"><a href="https://library.daegu.go.kr/nambu/html.do?menu_idx=49" target="_blank" class="newWin" title="새창으로 열립니다."><span class="img"><img src="/resources/homepage/228/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
				<li><a href="https://library.daegu.go.kr/nambu/html.do?menu_idx=48" target="_blank" class="newWin" title="새창으로 열립니다."><img src="/resources/homepage/228/img/quick001-bg.png" alt="책바다"><span class="txt">책바다</span></a></li>
				<li><a href="https://library.daegu.go.kr/nambu/html.do?menu_idx=50" target="_blank" class="newWin" title="새창으로 열립니다."><img src="/resources/homepage/228/img/quick003-bg.png" alt="사서에게 물어보세요"><span class="txt">사서에게<br>물어보세요</span></a></li>
			</ul>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />