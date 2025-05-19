<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.swiper.css"/>
<!-- <link rel="stylesheet" type="text/css" href="/resources/common/css/reset.css"/> -->
<link rel="stylesheet" href="/resources/homepage/gukbo/css/animate.min.css">

<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>

<script type="text/javascript">
	$(function() {
		slideAct();
		$('#homeup').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});

		$('#homeup-mobile').click(function () {
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





		// 팝업 관련 코드 START
		//$('.close-btn').on('click', function() {
		//	var $this = $(this);
		//	var checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
		//	var popupId = checkInput.val();
		//	if (checkInput.prop('checked')) {
		//		var todayDate = new Date();
		//		todayDate = new Date(
		//				parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
		//		if($this.data('day') == 7) {
		//			todayDate.setDate(todayDate.getDate() + 7);
		//		}
		//		document.cookie = popupId + "=no"
		//				+ "; path=/; expires="
		//				+ todayDate.toGMTString() + ";";
		//	}

		//	$('div#' + popupId).hide();
		//});

		//$('input[id*=pop]').on('click', function(e) {
		//	e.preventDefault();
		//	$(this).prop('checked', true);
		//	$(this).parent('div').next('a').data('day', $(this).data('day'));
		//	$(this).parent('div').next('a').click();
		//});

		//$('#popupLayer > div').each(function(i, v) {
		//	var result = '';
		//	var name = $(v).attr('id');
		//	var nameOfCookie = name + "=";
		//	var x = 0;
		//	while (x <= document.cookie.length) {
		//		var y = (x + nameOfCookie.length);
		//		if (document.cookie.substring(x, y) == nameOfCookie) {
		//			if ((endOfCookie = document.cookie
		//					.indexOf(";", y)) == -1)
			//			endOfCookie = document.cookie.length;
			//		result = unescape(document.cookie
			//				.substring(y, endOfCookie));
			//	}
			//	x = document.cookie.indexOf(" ", x) + 1;
			//	if (x == 0)
			//		break;
		//	}

		//	if (result != 'no') {
		//		if  (window.innerWidth < $(v).width() ) {
		//			$(v).css('width', 'auto');
		//		}
		//		$(v).show();
		//	}
		//});
		// 팝업 관련 코드 END

		$('div#holiday-box').load('calendar2.do');
		$('div#calendar-box').load('calendar3.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

		$('.menu-search-box').on('click', function() {
			alert('준비중');
		});
});
</script>
<html>
<body>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div id="wrap">
	<c:if test="${fn:length(popupZoneTopList) > 0}">
	<div class="popup_top">
	<p class="close"><input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기"/></a></p>
		<div class="popup">
		
			<div class="pop_contents">
				<div class="topPopZone">
					<homepageTag:popupZoneTop popupZoneList="${popupZoneTopList}"/>
				</div>
			</div>			
		</div>
	</div>
	</c:if>
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-visual">
			<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>
				<div class="swiper-container mySwiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide mvimg01"><div class="mvText top animate__animated animate__fadeInDown"><b>시민과 함께</b>한 100년, <b>새로운 도약</b>의 100년</div>
						        <div class="mvText bottom animate__animated animate__fadeInDown"><strong>국채보상운동기념도서관</strong></div></div>
						<!--<div class="swiper-slide mvimg02"><div class="mvText"><b>시민과 함께</b>한 100년, <b>새로운 도약</b>의 100년<strong>국채보상운동기념도서관</strong></div></div>
						<div class="swiper-slide mvimg03"><div class="mvText"><b>시민과 함께</b>한 100년, <b>새로운 도약</b>의 100년<strong>국채보상운동기념도서관</strong></div></div>-->
					</div>

					<!--div class="mvBtn_wp">
						<div class="mvBtn">
							<div class="swiper-button-next"><img src="/resources/homepage/${homepage.context_path}/img/new-next-btn.png" alt="다음"></div>
							<div class="swiper-button-prev"><img src="/resources/homepage/${homepage.context_path}/img/new-prev-btn.png" alt="이전"></div>
						</div>
						<div class="swiper-pagination"></div>

						<div class="ctrBtn">
							<a href="#" class="stop">stop</a>
							<a href="#" class="start">play</a>
						</div>

						<div class="swiper-scrollbar-wraper">
							<div class="swiper-scrollbar"></div>
						</div>
					</div-->
				</div>

				<!-- main_search -->
				<div class="search-area" id="main_search">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="main-box">
							
							<div class="search-box">
								<div class="box0">
									<label for="search_type" class="search_type">
										<select id="search_type" name="search_type">
											<option value="title">서명</option>
											<option value="author">저자</option>
											<option value="publer">발행자</option>
											<option value="keyword">키워드</option>
										</select>
									</label>
								</div>
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색하기</button>
							</div>

						</div>
					</fieldset>
					</form>
				</div>
				<!-- //Main_search -->

				<div class="quickmenu-box">
					<div class="main-box">
						<div class="qmenu">
							<ul>
								<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
							</ul>
						</div>
					</div>
				</div>

				<div class="main0-panel-holiday-box">
					<div id="holiday-box" class="holiday-box">
						
					</div>
					<div class="panel-box">
						<div class="display-panel">
							<div class="panelZone">
								<ul>
									<c:forEach items="${newsList}" var="i" varStatus="status">
										<li><a href="${i.link_url}" style="color:#fff;">${i.news_name}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="main0-scroll">
					<div class="scroll-down">
						<p>Scroll Down</p>
						<div class="scroll_down_line"></div>
						<div class="deco"></div>
					</div>
				</div>
				


			</div>

		</div>
		<!-- //main0 -->

	    <!-- section1 -->
		<div class="section" id="main1">

			<div class="main1-box">
				<div class='main-section'>

					<div class="notice-box tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=179" class='t-tabs'>공지사항</a></li>
							<li> | </li>
							<li><a href="#tab2" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=30" class='t-tabs'>수강신청</a></li>
						</ul>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=179" class="btn-more2 more-notice">더보기</a>

						<div class="news con" data-tab="tab1">
							<div class="box">
								<ul class="on-notice">
									<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" >
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<div>
												<strong><fmt:formatDate value="${i.add_date}" pattern="dd"/></strong>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></span>
											</div>
											<p>
												<span class="link">N</span>
												<span class="title">${i.title}</span>
											</p>
										</a>
									</li>
									</c:forEach>
								</ul>
								<ul class="notice_other">
									<c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='2'>
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<div>
												<strong><fmt:formatDate value="${i.add_date}" pattern="dd"/></strong>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></span>
											</div>
											<p>
												<span class="link">공지사항</span>
												<span class="title">${i.title}</span>
											</p>
										</a>
									</li>
									</c:forEach>
								</ul>
							</div>
						</div>

						<div class="news con" data-tab="tab2" style="display:none;">
							<div class="box">
								<ul class="culture">
									<c:forEach var="i" items="${teachList}" begin='0' end='4'>
										<li>
											<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
												<div>
													<strong>${fn:substring(i.start_date,8,10)}</strong>
													<span>${fn:substring(i.start_date,0,4)}.${fn:substring(i.start_date,5,7)}</span>
												</div>
												<p>
													<span class="link">수강신청</span>
													<span class="title">${i.teach_name}</span>
												</p>
											</a>
										</li>
									</c:forEach>
									<c:if test="${fn:length(teachList) < 1}">
										<li>
											<a href="#">
												<span class="sulib004"></span>
												<em>등록된 행사가 없습니다.</em>
												<span class="date"></span>
											</a>
										</li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>

					<div class="popupzone-box">
						<h2 class="title">팝업존</h2>
						<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/gukbo/img/gukbo_noimg.png" alt="" /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
						</div>
					</div>

					<div class="end"></div>

				</div>
			</div>

		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">
		<div class="main1-box">
			<div class="main-section">
				<div class="book-box">
					<div class="book-title-box">
						<h1>도서서비스</h1>
						<div class="deco"><img src="/resources/homepage/${homepage.context_path}/img/deco_book.png" alt="BOOK"></div>
					</div>
					<div class="book-contents-box">

						<div class="tabMenu-box tabSS">
							<ul class="tabMenuSS">
								<li class="on"><a href="#tabs1" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=662" class='ct-tabs'>테마가있는북큐레이션</a></li>
								<li><a href="#tabs2" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='ct-tabs'>신간도서</a></li>
								<li><a href="#tabs3" data-link="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15" class='ct-tabs'>대출베스트</a></li>
							</ul>
						</div>
						
						<div class="tabContent-box">
							<div class="con" data-tab="tabs1">

								<div class="slider">
									<div class="inners">

										<div class="swiper-location">
											<div class="swiper-prev">이전</div>
											<div class="">
												<a href="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class="more-book"><img src="/resources/homepage/${homepage.context_path}/img/book-more-btn.png" alt="북큐레이션 더보기"></a>
											</div>
											<div class="swiper-next">다음</div>
										</div>

										<div class="swiper-wrapper">
											<c:if test="${fn:length(recommendBookList) < 1}">
											<div class="list">
												<a href="javascript:void(0);">
												<span class="images-box">
													<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
												</span>
												<span class="title-box">등록된도서가없습니다.</span>
												</a>
											</div>
											</c:if>
											<c:forEach var="i" items="${recommendBookList}">
											<div class="list">
												<a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=13&isbn=${i.imsi_v_5}&regNo=${fn:escapeXml(i.imsi_v_8)}&manageCode=${fn:escapeXml('AD')}">

												<span class="images-box">
													<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noImg2.png';" />
															</c:when>
															<c:otherwise>
															<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"onError="this.src='/resources/common/img/noImg2.png';"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="${i.title}" title="${i.title}"onError="this.src='/resources/common/img/noImg2.png';"/>
													</c:otherwise>
													</c:choose>
												</span>
												<span class="title-box">${fn:length(i.title) > 11 ? fn:substring(i.title, 0, 12) : i.title}<c:if test="${fn:length(i.title) > 11 }">...</c:if></span>
												</a>
											</div>
											</c:forEach>

										</div>

									</div>
								</div>

							</div>
							<div class="con" data-tab="tabs2" style="display:none;">
								<div class="slider">
									<div class="inners">
										<div class="swiper-location">
											<div class="swiper-prev">이전</div>
											<div class="">
												<a href="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class="more-book"><img src="/resources/homepage/${homepage.context_path}/img/book-more-btn.png" alt="신간도서 더보기"></a>
											</div>
											<div class="swiper-next">다음</div>
										</div>

										<div class="swiper-wrapper">

											<c:if test="${fn:length(newBookList) < 1}">
											<div>등록된 데이터가 없습니다.</div>
											</c:if>
											<c:forEach var="i" items="${newBookList}">
											<div class="list">
												<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO">
													<span class="images-box">
													<c:choose>
														<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
															<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:when>
														<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
															<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:when>
														<c:otherwise>
															<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:otherwise>
													</c:choose>
													</span>
													<span class="title-box">${fn:length(i.TITLE_INFO) > 11 ? fn:substring(i.TITLE_INFO, 0, 12) : i.TITLE_INFO}<c:if test="${fn:length(i.TITLE_INFO) > 11 }">...</c:if></span>
												</a>
											</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>
							<div class="con" data-tab="tabs3" style="display:none;">
								<div class="slider">
									<div class="inners">
										<div class="swiper-location">
											<div class="swiper-prev">이전</div>
											<div class="">
												<a href="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class="more-book"><img src="/resources/homepage/${homepage.context_path}/img/book-more-btn.png" alt="대출베스트 더보기"></a>
											</div>
											<div class="swiper-next">다음</div>
										</div>

										<div class="swiper-wrapper">

											<c:if test="${fn:length(bestBookList) < 1}">
											<div>등록된 데이터가 없습니다.</div>
											</c:if>
											<c:forEach var="i" items="${bestBookList}">
											<div class="list">
												<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO">
													<span class="images-box">
														<c:choose>
														<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
														<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:when>
														<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
														<img src="${i.aladin.cover}" alt="${i.TITLE} 상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:when>
														<c:otherwise>
														<img src="${i.imageUrl}" alt="${i.TITLE} 상세보기" onError="this.src='/resources/common/img/noImg2.png';"/>
														</c:otherwise>
														</c:choose>
													</span>
													<span class="title-box">${fn:length(i.TITLE) > 11 ? fn:substring(i.TITLE, 0, 12) : i.TITLE}<c:if test="${fn:length(i.TITLE) > 11 }">...</c:if></span>
												</a>
											</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>

             </div>
			</div>
		</div>
		<!-- //main2 -->

		<!-- main3 -->
		<div class="section" id="main3">
		<div class="main1-box">
			<div class="top-box">
				<div class="main-section">
					<div class="calendar-box" id="calendar-box">
					</div>

					<div class="quickLink-box">
						<ul>
							<li><span class="outer"><span class="inner"><a href="https://library.daegu.go.kr/gukbo/html.do?menu_idx=109" class="quickLink01">찾아오시는길</a></span></span></li>
							<li><span class="outer"><span class="inner"><a href="module/organization/index.do?menu_idx=100" class="quickLink02">전화번호</a></span></span></li>
							<li><span class="outer"><span class="inner"><a href="html.do?menu_idx=104" class="quickLink03">이용안내</a></span></span></li>
						</ul>
					</div>

					<div class="end"></div>
				</div>
			</div>
			<div class="middle-box">
				<div class="main-section">
					<div class="quick-link">
						<ul class="mgb">
							<li><a href="https://library.daegu.go.kr/gukbo/html.do?menu_idx=49"><span class = "sub-t">장애인 무료 택배 서비스</span><span>책나래</span></a></li>
							<li><a href="https://library.daegu.go.kr/gukbo/html.do?menu_idx=48"><span class = "sub-t">국가상호대차 서비스</span><span>책바다</span></a></li>
							<li class = "sub-third"><a href="https://library.daegu.go.kr/gukbo/html.do?menu_idx=50"><span class = "sub-t">협력형 온라인 지식정보서비스</span><span>사서에게 물어보세요</span></a></li>

							<li class = "sub-p"><a href="https://library.daegu.go.kr/gukbo/html.do?menu_idx=207"><span class = "sub-t">나눔·소통·공감을 실천하는 신개념도서관</span><span>사람도서관</span></a></li>
							<li class = "sub-p"><a href="https://library.daegu.go.kr/gukbo/html/hopeBook.do?menu_idx=222"><span class = "sub-t">읽고싶은 새 책 서점대출서비스</span><span>희망도서바로대출</span></a></li>
							<li class = "sub-p"><a href="https://www.nlcy.go.kr/NLCY/contents/C10503010000.do" target="_blank"><span class = "sub-t">국립어린이청소년도서관 독서도움자료</span><span>다국어 동화구연</span></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- //main3 -->
		</div>
			<div class="bottom-box">
				<div class="main-section">
					<div class="banner-wrap type7">
						<div class="banner-t7">
							<div class="control">
								<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
								<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
							</div>
						</div>
						<div class="banner-box7">
							<homepageTag:banner bannerList="${bannerList}"/> 
						</div>
						<div class='banner-t7-after'>
							<div class="control">
								<a class="stop active" href="#stop"><img src="/resources/homepage/${homepage.context_path}/img/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
								<a class="play" href="#play"><img src="/resources/homepage/${homepage.context_path}/img/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
								<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=154"><img src="/resources/homepage/${homepage.context_path}/img/banner-more-btn.png" alt="더보기" /><span class="blind">더보기</span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
				<!-- footer_section -->
		<div class="section fp-auto-height footer_area" id="foot_section">
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
		anchors: ['firstPage', 'secondPage', '3rdPage', '4thPage', '5thPage'],
		navigation:true,
		showActiveTooltip: true,
		scrollOverflow: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css('border-top','1px solid rgba(255,255,255,0.15)');
				$('.Gnb').css('border-bottom','0px solid rgba(255,255,255,0.15)');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else if( destination.index == 4 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else if( destination.index == 5 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #e6e6e6');
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
<script type="text/javascript" src="/resources/common/js/jquery.swiper.min.js"></script>
<script>
$(document).ready(function(){
	new Swiper('.mySwiper', {
		spaceBetween: 30,
		autoHeight : true,
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
		scrollbar: {
			el: '.swiper-scrollbar',
			draggable: true,
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

<script>

function slideAct(){
	var view = 0; //보이는 슬라이드 개수
	var realInx = [] //현재 페이지
	var swiperArr = [] //슬라이드 배열

	//슬라이드 배열 생성
	$(".slider").each(function(index){
		realInx.push(0);
		swiperArr.push(undefined);
	})

	//디바이스 체크
	var winWChk = ''
	$(window).on('load resize', function (e){
		e.preventDefault();
		var winW = window.innerWidth;
		if(winWChk != 'mo' && winW <= 1400){ //모바일 버전으로 전환할 때
			slideList()
			winWChk = 'mo';
		}
		if(winWChk != 'pc' && winW >= 1401){ //PC 버전으로 전환할 때
			slideList()
			winWChk = 'pc';
		}
	}) 

	function slideList(){
		//리스트 초기화
		if ($('.slider .list').parent().hasClass('swiper-slide')){
			$('.slider .swiper-slide-duplicate').remove();
			$('.slider .list').unwrap('swiper-slide');
		}
		
		//보이는 슬라이드 개수 설정
		$(".slider").each(function(index){
           if (window.innerWidth > 1600){ //PC 버전
				view = 8;
		   }else if (window.innerWidth > 1400){ //노트북 버전
				view = 6;
			}else  if (window.innerWidth >= 350){ //mobile 버전
				view = 4;
			} else{ //mobile 버전
				view = 1;
			}

			//리스트 그룹 생성 (swiper-slide element 추가)
			var num = 0;
			$(this).addClass("slider-" + index);
			$(".slider-" + index).find('.list').each(function(i) {
				$(this).addClass("list"+(Math.floor((i+view)/view)));
				num = Math.floor((i+view)/view)
			}).promise().done(function(){
				for (var i = 1; i < num+1; i++) {
					$(".slider-" + index).find('.list'+i+'').wrapAll('<div class="swiper-slide"></div>');
					$(".slider-" + index).find('.list'+i+'').removeClass('list'+i+'')
				}
			});
		}).promise().done(function(){
			sliderStart()
		});
	}
	
	function sliderStart(){
		$(".slider").each(function(index){
			//슬라이드 초기화
			if(swiperArr[index] != undefined) {
				swiperArr[index].destroy();
				swiperArr[index] == undefined;
			}

			//슬라이드 실행
			swiperArr[index] = new Swiper('.slider-' + index + ' .inners', {
				autoHeight : true,
				slidesPerView: 1,
				initialSlide :Math.floor(realInx[index]/view),
				resistanceRatio : 0,
				observer : true,
				observeParents : true,
				loop:true,
				navigation: {
					nextEl: $('.slider-' + index).find('.swiper-next'),
					prevEl: $('.slider-' + index).find('.swiper-prev'),
				},
				on: {
					slideChange: function () {
						realInx[index] = this.realIndex*view
					}
				},
			});

			//슬라이드 배열 값 추가
			if(swiperArr[index] == undefined) {
				swiperArr[index] = swiper;
			}
		}); 
	}
}
</script>
