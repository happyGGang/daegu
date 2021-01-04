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


		$('div#calendar-box').load('calendar3.do');
		$('ul.book_photo').eq(1).load('newBook.do');
		$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

		$('#onLoadSearch').on('click', function() {
			if($(".search-box").css("display") != "none"){
				$(".search-box").hide();
			}
			else
			{
				$(".search-box").show();
			}

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
											<img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="noimg" style="width:100%;height:100%;"/>
										</li>
									</ul>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
				</div>

				<div class="notice-box">
					<div class="notice">
						<div class="title">
							<h2>공지사항</h2>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=634" class="more-btn">더보기</a>
						</div>
						<div class="cont">
							<ul class="list">
								<c:forEach items="${noticeList}" var="i" varStatus="status">
									<c:choose>
										<c:when test="${status.index == 0}">
											<li class="on-cont">
												<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
												<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=634&board_idx=${i.board_idx}">
													<span class="title">${i.title}</span>
													<p class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></p>
													<span class="content">
															${i.content_summary}
													</span>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li>
												<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=634&board_idx=${i.board_idx}">
													<em><span class="${i.notice_yn eq 'Y' ? 'nam001' : 'nam002'}">${i.notice_yn eq 'Y' ? '공지' : '일반'}</span>${i.title}</em>
													<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

			</div>
		</div>


		<div class="main2">
			<div class="section">
				<div class="qmenu">
					<ul>

						<li class="qm1">
							<a href="/${homepage.context_path}/html.do?menu_idx=17">
								<span>이용안내</span>
							</a>
						</li>
						<li class="qm2">
							<a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=53">
								<span>대출현황</span>
							</a>
						</li>
						<li class="qm3">
							<a href="/${homepage.context_path}/html.do?menu_idx=15">
								<span>희망도서</span>
							</a>
						</li>
						<li class="qm4">
							<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36">
								<span>이달의행사</span>
							</a>
						</li>
						<li class="qm5">
							<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=32">
								<span>문화프로그램</span>
							</a>
						</li>
						<li class="qm6">
							<a href="/${homepage.context_path}/html.do?menu_idx=25">
								<span>대구전자도서관</span>
							</a>
						</li>

					</ul>
				</div>
			</div>
		</div>


		<div class="main3">
			<div class="section">
				<div class="book-box tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=85&manage_idx=606">사서추천도서</a></li>
						<li><a href="#tab2" class='t-tabs' data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=10">신착도서</a></li>
					</ul>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=85&manage_idx=606" class="btn-more book-more more-more">더보기</a>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							<c:forEach items="${bookList1}" var="i" varStatus="status" begin="0" end="3">
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=85&manage_idx=606&board_idx=${i.board_idx}">
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
										<span class="con-title">${fn:substring(i.title, 0, 10)}<c:if test="${fn:length(i.title) > 10}">...</c:if></span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
						</ul>
					</div>

				</div>

				<div class="movie-box">
					<div class="movie">
						<div class="tit">
							<h2>영화상영</h2>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=608" class="btn-more">더보기</a>
						</div>
						<div class="movieContents">
							<ul>
								<c:forEach var="i" varStatus="status" items="${movieList}" >
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
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
												<strong class="title">${i.title}</strong>
											</span>

											<span class="movieEx">

												<span class="date">
												 ${fn:replace(i.imsi_v_1, '-', '년 ')}월 ${i.imsi_v_2}일<br/>
												 ${i.imsi_v_3}시 ${i.imsi_v_4}분
												</span>

												<span class="desc">
												${fn:substring(i.content_summary, 0, 80)}<c:if test="${fn:length(i.content_summary) > 80}">...</c:if>
												</span>

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
			</div>
		</div>

		<div class="main4">
			<div class="section">
				<div class="culture-box">
					<div class="tit">
						<h2>문화프로그램</h2>
						<a href="#" class="btn-more">더보기</a>
						<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=32" class="btn-more">더보기</a>
					</div>
					<div class="con">
						<ul>
							<c:forEach items="${teachList}" var="i" varStatus="status" begin="0" end="3">
								<c:set var="teachMenuIdx" value="94"></c:set>
								<c:if test="${i.large_category_idx eq 16}">
									<c:set var="teachMenuIdx" value="94"></c:set>
								</c:if>
								<c:if test="${i.large_category_idx eq 17}">
									<c:set var="teachMenuIdx" value="32"></c:set>
								</c:if>
								<c:choose>
									<c:when test="${status.index == 0}">
										<li class="on-cont">
											<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=${teachMenuIdx}&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
												<div class="cont">
													<strong>${i.teach_name}</strong>
													<span class="txt"><b>접수</b>  ${i.start_join_date} ~ ${i.end_join_date}</span>
													<span class="txt"><b>운영</b>  ${i.start_date} ~ ${i.end_date}</span>
												</div>
												<c:if test="${i.teach_status eq '0'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '1'}">
													<p class="one-status-box status001">대기</p>
												</c:if>
												<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '3'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '9'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '4'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '5'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '6'}">
													<p class="one-status-box status003">대기</p>
												</c:if>
											</a>
										</li>
									</c:when>
									<c:otherwise>
										<li>
											<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=${teachMenuIdx}&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
												<strong>${i.teach_name}</strong>
												<c:if test="${i.teach_status eq '0'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '1'}">
													<p class="one-status-box status001">대기</p>
												</c:if>
												<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '3'}">
													<p class="one-status-box status002">접수중</p>
												</c:if>
												<c:if test="${i.teach_status eq '9'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '4'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '5'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '6'}">
													<p class="one-status-box status003">대기</p>
												</c:if>
											</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="calendar-box" id="calendar-box">

				</div>
			</div>
		</div>

		<div class="main5">
			<div class="section">
				<div class="banner-wrap type3">
					<div class="banner-t3">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><img src="/resources/homepage/${homepage.context_path}/img/banner-more.png" alt="더보기" /><span class="blind">더보기</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
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
</div>

</body>
</html>