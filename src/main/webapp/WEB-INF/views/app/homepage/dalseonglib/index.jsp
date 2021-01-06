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

		//$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});
		$('.movie').each(function(){
			$(this).find('.bxslider').bxSlider({
				pager:false,
				slideMargin:0,
			});
		});

		$('#newbook').load('newBook.do');

		/*신착, 추천*/
		$('#bo1 ul').bxSlider({
			auto: true,
			pager:false,
			controls:true,
			autoControls:true,
			autoControlsCombine:true,
			moveSlides: 1,
			maxSlides: 2,
			slideWidth: 130,
			slideMargin: 10
		});

		$(".tab-box ul li:first-child").addClass("on");
		$(".tab-box .clt:not("+$(".tab-box ul li.on").data("value")+")").css("z-index","1");

		$(".tab-box ul li a").click(function(){
			$(".tab-box ul li").removeClass("on");
			$(this).parents('li').addClass("on");
			var moreUrl = $(this).data('link');

			$(".clt").css({"z-index":"1"});
			$($(this).attr('href')).css({"z-index":"2"});
			$('.more-more-2').attr('href', moreUrl);
			return false;
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
			<p class="close"><input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/homepage/${homepage.context_path}/img/close_popup_btn.png" alt="닫기"/></a></p>
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

				<div class="left-box">
					<div class="popZone">
						<div class="cont">
							<c:choose>
								<c:when test="${fn:length(popupZoneList) > 0}">
									<homepageTag:popupZone popupZoneList="${popupZoneList}"/>
								</c:when>
								<c:otherwise>
								<ul class="popupImg">
									<li>
										<img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="noimg" style="width:100%;"/>
									</li>
								</ul>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="book-box">
						<div class="tab-box tabS">
							<ul class="tabMenuS">
								<li class="on" data-value="#recommandbook1"><a href="#recommandbook1" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=13&manage_idx=683">추천도서</a></li>
								<li data-value="#newbook"><a href="#newbook" class='t-tabs' data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=10">신착도서</a></li>
							</ul>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=13&manage_idx=683" class="btn-more btn-w btn-more_right20 top35 more-more-2">더보기</a>

							<div class='book-wrap'>
								<div id="recommandbook1" class="con clt">
									<div class="book">
										<div id="bo1" class="cont">
											<ul class="book_photo">
												<c:if test="${fn:length(bookList1) < 1}">
													<li>등록된 데이터가 없습니다.</li>
												</c:if>
												<c:forEach items="${bookList1}" var="i" varStatus="status">
													<li>
														<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=683&board_idx=${i.board_idx}">
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
														</a>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>

								<div id="newbook" class="con clt">

								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="center-box">
					<div class="search-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="9">
							<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
							<fieldset>
								<legend>자료검색</legend>
								<div class="dalseong-slogan"><img src="/resources/homepage/${homepage.context_path}/img/dalseong-slogan.png" alt="대구의 미래 달성 꽃피다."></div>
								<div class="main-box">
									<div class="box1">
										<label for="search_text_1" class="blind">통합자료검색</label>
										<input name="title" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서명을 입력해주세요" style="ime-mode:active;"/>
									</div>
									<button id="main-search-btn">검색</button>
								</div>
							</fieldset>
						</form>

						<div class="bestKeyword">
							<b>자주찾는 검색어</b> <span class="key-word">
							<c:forEach items="${hotTrendList}" varStatus="status" var="i">
								<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=9&booktype=BOOKANDNONBOOKtitle=${fn:escapeXml(i.SEARCH_WORD)}">${fn:trim(i.SEARCH_WORD)}</a>
							</c:forEach>
							</span>
						</div>
					</div>

					<div class="notice-box">
						<h2>공지사항</h2>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=689" class="btn-more btn-b btn-more_right20 top30">더보기</a>
						<div class="cont">
							<ul>
								<c:forEach items="${noticeList}" var="i" varStatus="status">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=689&board_idx=${i.board_idx}">
											<em class="${i.notice_yn eq 'Y' ? 'noti' : ''}">공지</em>${i.title}
											<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

				<div class="right-box">

					<div class="libraryinfo-box">
						<h3 class='time-icon'>어린이 · 유아자료실</h3>
						<ul>
							<li>평일 : 09:00 ~ 18:00</li>
							<li>토일 : 09:00 ~ 17:00</li>
						</ul>

						<h3 class='time-icon'>종합 · 디지털자료실</h3>
						<ul>
							<li>평일 : 09:00 ~ 22:00</li>
							<li>토일 : 09:00 ~ 17:00</li>
						</ul>

						<h3 class='calendar-icon'>휴관일</h3>
						<ul>
							<li>매주 월요일 및 법정공휴일</li>
						</ul>
					</div>

					<div class="movie-box">
						<h2>영화상영</h2>

						<div class="movieContent">
							<ul>
								<c:forEach var="i" varStatus="status" items="${movieList}" begin="0" end="0">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="view-date">
												${fn:split(i.imsi_v_1, '-')[1]}/${i.imsi_v_2}
											</span>

											<span class="movieImg">
												<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
																<img src="${i.preview_img}" alt="${i.title}" class="book_img"/>
															</c:when>
															<c:otherwise>
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" class="book_img"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="${i.title}" class="book_img">
													</c:otherwise>
												</c:choose>
											</span>
											<span class="movieEx1">${i.title}</span>
											<span class="movieEx2">${i.imsi_v_12}</span>
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

			</div>
		</div>


		<div class="main2">
			<div class="sections">
				<div class="qmenu">
					<ul>
						<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
					</ul>
				</div>
			</div>

			<div class="section">
				<div class="schedule-box">

					<div id="holiday-box" class="calendar-box">
						
					</div>

					<div class="culture-box tabSS">

						<ul class="tabMenuSS">
							<li class="on"><a href="#tab1" class='t-tabs' data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=26&searchCate1=16">문화행사</a></li>
							<li><a href="#tab2" class='t-tabs' data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&searchCate1=17">평생학습프로그램</a></li>
							<li style="position:absolute;width:auto;right:0;top:10px;">
								<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=26&searchCate1=16" class="btn-more btn-b top5 more-more" style="padding:0;color:transparent;">더보기</a>
							</li>
						</ul>

						<div class="box cont" data-tab="tab1">

							<ul>
								<c:if test="${fn:length(teachList1) < 1}">
									<li>
										등록된 행사가 없습니다.
									</li>
								</c:if>
								<c:forEach items="${teachList1}" var="i" varStatus="status" begin="0" end="2">
									<li>
										<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=32&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
											<c:if test="${i.teach_status eq '0'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '1'}">
												<em>대기</em>
											</c:if>
											<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '3'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '9'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '4'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '5'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '6'}">
												<em>대기</em>
											</c:if>
											${i.teach_name}
											<br class="qmobileBr"/>
											<span><b>접수</b> ${i.start_join_date} ~ ${i.end_join_date}</span>
										</a>
									</li>
								</c:forEach>
							</ul>

						</div>

						<div class="box cont" data-tab="tab2" style="display:none;">
							<ul>
								<c:if test="${fn:length(teachList2) < 1}">
									<li>
										등록된 행사가 없습니다.
									</li>
								</c:if>
								<c:forEach items="${teachList2}" var="i" varStatus="status" begin="0" end="2">
									<li>
										<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=32&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
											<c:if test="${i.teach_status eq '0'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '1'}">
												<em>대기</em>
											</c:if>
											<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '3'}">
												<em>접수중</em>
											</c:if>
											<c:if test="${i.teach_status eq '9'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '4'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '5'}">
												<em>마감</em>
											</c:if>
											<c:if test="${i.teach_status eq '6'}">
												<em>대기</em>
											</c:if>
												${i.teach_name}
											<br class="qmobileBr"/>
											<span><b>접수</b> ${i.start_join_date} ~ ${i.end_join_date}</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>

				</div>
			</div>
		</div>

		<div class="main3">
			<div class="section">

				<div class="banner-wrap type6">
					<div class="banner-t6">
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/dalseonglib/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/dalseonglib/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
						</div>
					</div>
					<div class="banner-box6">
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