<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
// 			var checkInput = $this.parent().find('input');
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

// 		$('input[id*=pop]').on('click', function(e) {
// 			e.preventDefault();
// 			$(this).prop('checked', true);
// 			$(this).parent('div').next('a').data('day', $(this).data('day'));
// 			$(this).parent('div').next('a').click();
// 		});

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
	<div id="container" class="main">
		<div class="main_bg">
			<div class="main1">
				<div class="section" style="overflow:hidden;">
					<div class="txt">
						<img src="/resources/homepage/${homepage.context_path}/img/txt6.png" alt=""/>
					</div>


					<div class="search-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
							<fieldset>
								<legend class="blind">통합검색</legend>
								<div class="main-box">
									<div class="title-box">통합자료검색</div>
									<div class="box1">
										<div class="box2">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
										</div>
									</div>
									<button id="main-search-btn">검색</button>
								</div>
							</fieldset>
						</form>
					</div>

					<div id="holiday-box">

					</div>
				</div>
			</div>
		</div>

		<div class="qmenu">
			<div class="section" style="overflow:hidden;">

				<ul data-call="bxslider" data-breaks="[{screen:0, slides:1},{screen:340, slides:2},{screen:450, slides:3},{screen:600, slides:4},{screen:767, slides:5},{screen:1000, slides:${fn:length(quickMenuList)}}]">
					<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
				</ul>

			</div>
		</div>


		<div class="main_line">
			<div class="section" style="overflow:hidden;">

				<div class="main3">
					<div class="tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=123" class='t-tabs'>공지사항</a></li>
							<li><span style="font-size:13px;color:#aaa;padding:0 5px;">│</span></li>
							<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=170&manage_idx=474" class='t-tabs'>강좌·행사안내</a></li>
							
							<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=123" class="more-btn more-more">더보기</a>
						</ul>

						<div class="con" data-tab="tab1">
							<div class="news">
								<div class="box">

									<ul>
									<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<c:choose>
												<c:when test="${i.date_gap <= 2}">
												<span class="new-tit">NEW</span>
												</c:when>
												<c:otherwise>
												<span class="tit">공지</span>
												</c:otherwise>
												</c:choose>
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
									</ul>

								</div>
							</div>
						</div>
						<div class="con" data-tab="tab2" style="display:none;">
							<div class="news">
								<div class="box">

								<ul>
									<c:forEach var="i" varStatus="status" items="${boardList1}" >
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=170&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<c:choose>
												<c:when test="${i.date_gap <= 2}">
													<span class="new-tit">NEW</span>
												</c:when>
												<c:otherwise>
													<span class="tit">이벤트</span>
												</c:otherwise>
											</c:choose>
											<em>${i.title}</em>
											<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
										</a>
									</li>
									</c:forEach>
									<c:if test="${fn:length(boardList1) < 1}">
										<li>
											<em>등록된 행사안내가 없습니다.</em>
										</li>
									</c:if>
								</ul>

								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 팝업존 -->
				<div class="popZone">
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<homepageTag:popupZone popupZoneList="${popupZoneList}" />
						</c:when>
						<c:otherwise>
							<ul>
								<li><a href="#"><img src="/resources/homepage/dongbu/img/popupnone.jpg" alt="등록된 팝업존이 없습니다." /></a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>

		<div class="main6_bg">
			<div class="main6 section" style="overflow:hidden;">
				<div class="main4 tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=157&manage_idx=378" class='t-tabs'>사서&북큐레이션</a></li>
						<li><a href="#tab2" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='t-tabs'>신착자료</a></li>
						<li><a href="#tab3" data-link="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15" class='t-tabs'>대출베스트</a></li>
						
						<a href="/${homepage.context_path}/board/index.do?menu_idx=157&manage_idx=378" class="more-btn more-more">더보기</a>
					</ul>

					<div class="box con" data-tab="tab1">
						<ul class="lt_photo bookQuration">
							<c:forEach items="${bookCuration1}" var="curation1">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=130&manage_idx=${curation1.manage_idx}&board_idx=${curation1.board_idx}&group_idx=0&viewPage=1&search_type=title%2Bcontent">
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
							<c:forEach items="${bookCuration2}" var="curation2">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=132&manage_idx=${curation2.manage_idx}&board_idx=${curation2.board_idx}&group_idx=0&viewPage=1&search_type=title%2Bcontent">
									<c:choose>
									<c:when test="${empty curation2.preview_img}">
									<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." width="100px" height="150px"/>
									</c:when>
									<c:otherwise>
									<img src="/data/board/${curation2.manage_idx}/${curation2.board_idx}/${curation2.preview_img}" alt="${curation2.title}" width="100px" height="150px"/>
									</c:otherwise>
									</c:choose>
									<span class="title">${curation2.title}</span>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="lt_photo newBookUl">
						</ul>
					</div>

					<div class="box con" data-tab="tab3" style="display:none;">
						<ul class="lt_photo bestBookUl">
						</ul>
					</div>


				</div>

				<div class="movie">
					<div class="title">
						<h3>이달의 추천 영화</h3>
						<a class="more-btn more-more" href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=927">더보기</a>
					</div>
					<!-- 영화 추천 출력 소스-->
					<p style="font-size:14px;color:#ff0000;font-weight:bold;margin-bottom:5px;">※ 코로나 19로 인해 시청각실 영화상영은 중단</p>
					<div>
						<a href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=927&board_idx=449964&group_idx=0&viewPage=1&search_type=title%2Bcontent">
							<img src="/data/menuResources/h5/60/1625109795651.png" style="width:130px;">
						</a>
						<a href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=927&board_idx=449963&group_idx=0&viewPage=1&search_type=title%2Bcontent">
							<img src="/data/menuResources/h5/60/1625109813943.png" style="width:130px;">
						</a>
					</div>
					<!--//영화 추천 출력 소스-->

					<!-- 기존 영화 상영 출력 소스
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
					-->
				</div>

				<div class="quickLink">
					<ul>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=107">야간예약대출 <span class="plus-btn">+</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=51" class="link01">책이음 <span>공공도서관 도서대출</span> <span class="plus-btn">+</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=49"  class="link02">책나래 <span>장애인 도서관 자료 무료우편</span><span class="plus-btn">+</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=48" class="link03">책바다 <span>국가상호대차서비스</span><span class="plus-btn">+</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=50">사서에게물어보세요 <span class="plus-btn">+</span></a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="section">
			<div class="main7_banner">
				<div class="banner-wrap type1">
					<div class="banner-t4">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box4">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />