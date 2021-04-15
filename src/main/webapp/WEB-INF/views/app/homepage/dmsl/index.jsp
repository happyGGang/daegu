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


		$('div#holiday-box').load('calendar3.do');
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

		$('.qm1 a').on('click', function(e) {
			e.preventDefault();

			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<c:choose>
						<c:when test="${sessionScope.member.user_class_code eq '701'}">
							location.href='/dmsl/html/dmslSearch.do?menu_idx=94';
						</c:when>
						<c:otherwise>
							alert('직원 전용 메뉴입니다.');
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					alert('직원 전용 메뉴입니다.');
				</c:otherwise>
			</c:choose>
		});

		$('.g-menu li.menu_94 a').on('click', function(e) {
			e.preventDefault();

			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<c:choose>
						<c:when test="${sessionScope.member.user_class_code eq '701'}">
							location.href='/dmsl/html/dmslSearch.do?menu_idx=94';
						</c:when>
						<c:otherwise>
							alert('직원 전용 메뉴입니다.');
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					alert('직원 전용 메뉴입니다.');
				</c:otherwise>
			</c:choose>
		});

		$('.g-menu li#menu_94 a').on('click', function(e) {
			e.preventDefault();

			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<c:choose>
						<c:when test="${sessionScope.member.user_class_code eq '701'}">
							location.href='/dmsl/html/dmslSearch.do?menu_idx=94';
						</c:when>
						<c:otherwise>
							alert('직원 전용 메뉴입니다.');
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					alert('직원 전용 메뉴입니다.');
				</c:otherwise>
			</c:choose>
		});

		$('ul.SubMenu li#menu_94 a').on('click', function(e) {
			e.preventDefault();

			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<c:choose>
						<c:when test="${sessionScope.member.user_class_code eq '701'}">
							location.href='/dmsl/html/dmslSearch.do?menu_idx=94';
						</c:when>
						<c:otherwise>
							alert('직원 전용 메뉴입니다.');
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					alert('직원 전용 메뉴입니다.');
				</c:otherwise>
			</c:choose>
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

		<div class="main1">
			<div class="section">

				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="9">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box1">
									<select id="search_type" name="search_type" class="search_type" style="border:0;">
										<option value="L_TITLE">서명</option>
										<option value="L_AUTHOR">저자</option>
										<!-- <option value="L_PUBLISHER">발행자</option> -->
										<option value="L_KEYWORD">키워드</option>
									</select>
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색</button>
							</div>
						</fieldset>
					</form>
				</div>

				<div class="conts-box">
					<div class="notice-box">
						<h2>공지사항</h2>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=752" class="btn-more-more">더보기</a>
						<div class="cont">
							<ul>
								<ul>
									<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em class="${i.notice_yn eq 'Y' ? 'noti' : ''}">공지</em>
													${i.title}
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</ul>
						</div>
					</div>

					<div class="popupzone-box">
						<div class="popZone">
							<div class="cont">
								<c:choose>
									<c:when test="${fn:length(popupZoneList) > 0}">
										<homepageTag:popupZone popupZoneList="${popupZoneList}"/>
									</c:when>
									<c:otherwise>
									<ul class="popupImg">
										<li>
											<img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="noimg" style="width:100%;"/>
										</li>
									</ul>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>

					<div class="calendar-box" id="holiday-box">
						
					</div>
				</div>
			</div>
		</div>


		<div class="main2">
			<div class="section">
				<div class="qmenu">
					<ul>
						<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
					</ul>
				</div>
			</div>
		</div>

		<div class="main3">
			<div class="section">

				<div class="books-tits">
					<ul>
						<li>작은도서관 사서가 권하는</li>
						<li><b>다양한 북큐레이션</b> <Br class='webBr'/><span class="m_none">이럴땐 이런책</span></li>
						<li class="m_none">이 달의 테마 주제는 무엇일까요?<br/>도서 클릭 시 테마소개 페이지로<br/>이동합니다.</li>
					</ul>
				</div>

				<div class="books-conts">
					<div class="book-box tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=744">사서추천</a></li>
							<li><a href="#tab2" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=84&manage_idx=745">테마북</a></li>
							<li><a href="#tab3" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=85&manage_idx=746">그림책</a></li>
						</ul>
						<div class="btn-link-box">
							<a href="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=744" class="btn-link-more more-more">더보기</a>
						</div>

						<div class="box con" data-tab="tab1">
							<ul class="book_photo">
								<c:if test="${fn:length(bookList1) < 1}">
									<li>등록된 데이터가 없습니다.</li>
								</c:if>
								<c:forEach items="${bookList1}" var="i" varStatus="status">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=83&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="con-image">
												<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:otherwise>
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
													</c:otherwise>
												</c:choose>
											</span>
											<span class="con-title">${i.title}</span>
											<span class="con-author">${i.imsi_v_3}</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>

						<div class="box con" data-tab="tab2" style="display:none;">
							<ul class="book_photo">
								<c:if test="${fn:length(bookList2) < 1}">
									<li>등록된 데이터가 없습니다.</li>
								</c:if>
								<c:forEach items="${bookList2}" var="i" varStatus="status">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=84&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="con-image">
												<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:otherwise>
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
													</c:otherwise>
												</c:choose>
											</span>
											<span class="con-title">${i.title}</span>
											<span class="con-author">${i.imsi_v_3}</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>

						<div class="box con" data-tab="tab3" style="display:none;">
							<ul class="book_photo">
								<c:if test="${fn:length(bookList3) < 1}">
									<li>등록된 데이터가 없습니다.</li>
								</c:if>
								<c:forEach items="${bookList3}" var="i" varStatus="status">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=85&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="con-image">
												<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
																<img src="${i.preview_img}" alt="${i.title}" />
															</c:when>
															<c:otherwise>
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
													</c:otherwise>
												</c:choose>
											</span>
											<span class="con-title">${i.title}</span>
											<span class="con-author">${i.imsi_v_3}</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class='main4'>
			<div class="section">
				<div class="banner-wrap type4">
					<div class="banner-t4">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=81"><img src="/resources/homepage/${homepage.context_path}/img/banner-more.png" alt="더보기" /><span class="blind">더보기</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
						</div>
					</div>
					<div class="banner-box4">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
	</div>

	<tiles:insertAttribute name="footer" />

</div>

</body>
</html>