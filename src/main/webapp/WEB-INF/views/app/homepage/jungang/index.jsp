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
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
		<div class="main_bg">
			<div class="main1">
				<div class="section">
					<div class="txt">
						<img src="/resources/homepage/${homepage.context_path}/img/txt6.png" alt=""/>
					</div>


					<div class="search-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="13">
							<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
							<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
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

					<div id="holiday-box" class="">

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
				<div class="main3_4_box">
					<div style="">
						<div class="main3 tabS">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=179" class='t-tabs'>공지사항</a></li>
								<li>/</li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=160&manage_idx=180" class='t-tabs'>입찰정보</a></li>
								<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=179" class="more-btn more-more">더보기</a>
							</ul>

							<div class="news con" data-tab="tab1">
								<div class="box">
									<ul>
										<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" >
										<li class="on-notice">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
										<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>

							<div class="news con" data-tab="tab2" style="display:none;">
								<div class="box">
									<ul>
										<c:forEach var="i" varStatus="status" items="${bidListTopNotice}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=160&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
										<c:forEach var="i" varStatus="status" items="${bidList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=160&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>

						<div class="main4 tabS">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class='t-tabs'>권장도서</a></li>
								<li>/</li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='t-tabs'>신간도서</a></li>
								<li>/</li>
								<li><a href="#tab3" data-link="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15" class='t-tabs'>대출베스트</a></li>
								<a href="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class="more-btn more-more">더보기</a>
							</ul>

							<div class="box con" data-tab="tab1">
								<ul class="lt_photo">
								<c:choose>
									<c:when test="${fn:length(recommendBookList) < 1}">
									<li>
										<a href="javascript:alert('등록된 추천도서가 없습니다.');">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.">
											<span class="title">등록된 추천도서가 없습니다.</span>
										</a>
									</li>
									</c:when>
									<c:otherwise>
									<li>
										<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=115&manage_idx=${recommendBookList[listNum1].manage_idx}&board_idx=${recommendBookList[listNum1].board_idx}">
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
												<img src="/resources/common/img/noImg2.png" alt="${recommendBookList[listNum1].title}" title="${recommendBookList[listNum1].title}">
											</c:otherwise>
											</c:choose>
											<span class="title">${recommendBookList[listNum1].title}</span>
											<span class="author">${recommendBookList[listNum1].imsi_v_3}</span>
										</a>
									</li>
									<li>
										<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=115&manage_idx=${recommendBookList[listNum2].manage_idx}&board_idx=${recommendBookList[listNum2].board_idx}">
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
												<img src="/resources/common/img/noImg2.png" alt="${recommendBookList[listNum2].title}" title="${recommendBookList[listNum2].title}">
											</c:otherwise>
											</c:choose>
											<span class="title">${recommendBookList[listNum2].title}</span>
											<span class="author">${recommendBookList[listNum2].imsi_v_3}</span>
										</a>
									</li>
									<li>
										<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=115&manage_idx=${recommendBookList[listNum3].manage_idx}&board_idx=${recommendBookList[listNum3].board_idx}">
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
												<img src="/resources/common/img/noImg2.png" alt="${recommendBookList[listNum3].title}" title="${recommendBookList[listNum3].title}">
											</c:otherwise>
											</c:choose>
											<span class="title">${recommendBookList[listNum3].title}</span>
											<span class="author">${recommendBookList[listNum3].imsi_v_3}</span>

										</a>
									</li>
									</c:otherwise>
								</c:choose>
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
					</div>
					<div class="display-panel">
						<div class="panelZone">
							<ul>
								<c:forEach items="${newsList}" var="i" varStatus="status">
									<li><a href="${i.link_url}" style="color:#ffcc00;">${i.news_name}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

				<div class="main5">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/jungang/img/popupnone.jpg" alt="" /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>
		</div>


		<div class="main6_bg">
			<div class="main6 section">
				<!-- <div class="lt1"><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=178">문화가 있는 도서관<br/><span class="">영화상영</span></a></div> -->
				<div class="lt2"><a href="/${homepage.context_path}/html.do?menu_idx=212">동영상으로 만나는 사람책<br/><span class="">랜선 타고 ON 사람도서관</span></a></div>
				<div class="lt3"><a href="/${homepage.context_path}/html.do?menu_idx=152">어린이 1:1 맞춤형 독서정보안내<br/><span class="">북코디네이터</span></a></div>
				<div class="lt4"><a href="/${homepage.context_path}/html.do?menu_idx=49">장애인 무료 택배 서비스<br/><span class="">책나래</span></a></div>
				<div class="lt5"><a href="/${homepage.context_path}/html.do?menu_idx=48">국가상호대차 서비스<br/><span class="">책바다</span></a></div>
				<div class="lt6"><a href="/${homepage.context_path}/html.do?menu_idx=50">협력형 온라인 지식정보서비스<br/><span class="">사서에게물어보세요</span></a></div>
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