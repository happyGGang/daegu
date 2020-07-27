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
				<div class="section">
					<div class="txt">
						시민과 함께<Br class="webBr"/>
						미래를 가꾸는<br/>
						<b>대구광역시립서부도서관</b>
					</div>

					<div class="search-icon">

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
											<button id="main-search-btn">검색</button>

										</div>

									</div>
								</fieldset>
							</form>

						</div>
						<span class="instagram-icon"><a href="https://www.instagram.com/seobulib/" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/instagram-icon.png" alt=""></a></span>
						<span class="facebook-icon"><a href="https://www.facebook.com/seobulibrary" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/facebook-icon.png" alt=""></a></span>

					</div>

					<div class="end"></div>
					<div id="holiday-box">
					</div>
				</div>
			</div>
		</div>

		<div class="main2">
			<div class="qmenu">
				<div class="section">
					<ul data-call="bxslider" data-breaks="[{screen:0, slides:1},{screen:340, slides:2},{screen:450, slides:3},{screen:600, slides:4},{screen:767, slides:5},{screen:1000, slides:${fn:length(quickMenuList)}}]">
						<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
					</ul>
				</div>
			</div>
		</div>


		<div class="main3">
			<div class="section">

				<div class="notice tabS">
					<div class="title">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=161" class='t-tabs'>공지사항</a></li>
							<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=151&manage_idx=341" class='t-tabs'>행사안내</a></li>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=161" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a>
						</ul>
					</div>

					<div class="cont con" data-tab="tab1">
						<ul class="list">
							<%--공지사항 상단--%>
							<c:if test="${fn:length(noticeListTopNotice) < 1}">
							<li class="on-notice">
								<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
								<a href="#">
									<em>등록된 공지사항이 없습니다.</em>
									<span></span>
								</a>
							</li>
							</c:if>

							<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" >
							<li class="on-notice">
								<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<em>${i.title}</em>
									<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
								</a>
							</li>
							</c:forEach>
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
						<ul class="list">
							<%--행사안내 목록 공지--%>
							<c:if test="${fn:length(boardList1TopNotice) < 1}">
							<li class="on-notice">
								<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
								<a href="#">
									<em>등록된 공지사항이 없습니다.</em>
									<span></span>
								</a>
							</li>
							</c:if>

							<c:forEach var="i" varStatus="status" items="${boardList1TopNotice}" >
							<li class="on-notice">
								<a href="/${homepage.context_path}/board/view.do?menu_idx=151&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<em>${i.title}</em>
									<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
								</a>
							</li>
							</c:forEach>
							<%--행사안내 목록 공지--%>
							<%--행사안내 목록--%>
							<c:forEach var="i" varStatus="status" items="${boardList1}" begin="0" end="3">
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=151&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
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
							<%--행사안내 목록--%>
						</ul>
					</div>
				</div>

				<!-- 팝업존 -->
				<div class="popZone">
					<div class="title">
						<h2>팝업존</h2>
					</div>
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<homepageTag:popupZone popupZoneList="${popupZoneList}" />
						</c:when>
						<c:otherwise>
							<ul>
								<li><a href="#"><img src="/resources/homepage/dongbu/img/popupnone.jpg" alt="" /></a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>


		<div class="main4">
			<div class="section">
				<div class="quickLink01">
					<ul>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=115" class="q1">학교교육지원</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=124" class="q2">향토문학관</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=122" class="q3">희망장난감도서관</a></li>
					</ul>
				</div>

				<div class="book-s tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=138&manage_idx=290" class='t-tabs'>북큐레이션</a></li>
						<li><a href="#tab2" data-link="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15" class='t-tabs'>대출베스트</a></li>
						<li><a href="#tab3" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14" class='t-tabs'>신착자료</a></li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=138&manage_idx=290" class="more-btn more-more">더보기</a>
					</ul>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							<c:forEach items="${curationList}" var="curation">
							<li>
								<a class="goDetail" href="/${homepage.context_path}/board/view.do?menu_idx=138&manage_idx=${curation.manage_idx}&board_idx=${curation.board_idx}">
									<span class="img">
									<c:choose>
									<c:when test="${curation.preview_img ne null}">
										<c:choose>
											<c:when test="${fn:contains(curation.preview_img, 'http')}">
											<img src="${curation.preview_img}" alt="${curation.title}" />
											</c:when>
											<c:otherwise>
											<img src="/data/board/${curation.manage_idx}/${curation.board_idx}/${curation.preview_img}" alt="${curation.title}" title="${curation.title}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<img src="/resources/common/img/noimg-gall.png" alt="${curation.title}" title="${curation.title}">
									</c:otherwise>
									</c:choose>
									</span>
									<span class="contents">
										<c:set var="text001" value="${curation.title}"/>
										<p class="title">
										<c:choose>
											<c:when test="${fn:length(text001) > 12}">
												${fn:substring(text001, 0, 12)}...
											</c:when>
											<c:otherwise>
												${text001}
											</c:otherwise>
										</c:choose>
										</p>
										<p><b>전시장소</b> ${curation.imsi_v_2}</p>
									</span>
								</a>
							</li>
							</c:forEach>
						</ul>

					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo bestBookUl">
						</ul>
					</div>

					<div class="box con" data-tab="tab3" style="display:none;">
						<ul class="book_photo newBookUl">
						</ul>
					</div>

				</div>

				<div class="quickLink02">
					<ul>
						<li class="qi1"><a href="/${homepage.context_path}/html.do?menu_idx=49">책나래</a></li>
						<li class="qi2"><a href="/${homepage.context_path}/html.do?menu_idx=48" class="link01">책바다</a></li>
						<li class="qi3"><a href="/${homepage.context_path}/html.do?menu_idx=50" class="link02">사서에게물어보세요</a></li>
						<li class="qi4"><a href="https://www.1365.go.kr/vols/main.do" target="_blank" class="link03">1365자원봉사신청</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="section">
			<div class="main7_banner">
				<div class="banner-wrap type1">
					<div class="banner-t5">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a>
						</div>
					</div>
					<div class="banner-box5">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />