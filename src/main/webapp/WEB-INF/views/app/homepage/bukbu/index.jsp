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


		$('div.cal-box').load('calendar3.do');
		$('ul.newBookUl').load('newBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
			$('input#search_text_1').attr('name', $('select#search_type').val());
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
		<div class="main1">
			<div class="section">

				<div class="main1box1">

					<div class="main1box1box1">
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
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
							
								<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요!" style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
										<div class="title-box"><img src="/resources/homepage/${homepage.context_path}/img/search-bg.png" alt=""></div>
									</div>
								</fieldset>
							</form>
						</div>
					</div>

					<div class="main1box1box2">
						<div class="main1box1box2box1">
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

						<div class="main1box1box2box2">
							<ul>
								<li class="bg-blue">
									<a href="/${homepage.context_path}/html.do?menu_idx=104">
									<span class="wt">이용안내</span>
									<span class="wc">우리 도서관에<br/>처음 오셨나요?</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="https://library.daegu.go.kr/bukbu/intro/search/loan/index.do?menu_idx=16">
									<span class="wt">나의도서관</span>
									<span class="wc">대출, 예약현황 조회</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="/${homepage.context_path}/elib.do?menu_idx=46">
									<span class="wt">대구전자도서관</span>
									<span class="wc">전자책, 오디오북 등 디지털콘텐츠</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=1" target="_blank">
									<span class="wt">디지털정보코너</span>
									<span class="wc">쉽고 빠른 좌석 예약</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="/${homepage.context_path}/html.do?menu_idx=26" style="z-index: 9;">
									<span class="wt">희망도서신청</span>
									<span class="wc">읽고 싶은 책 구입 신청</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-blue">
									<a href="https://app.gather.town/app/18A3bUuFZxLvoQnX/Daegu_Bukbu_library" target="_blank">
									<span class="wt">메타북스</span>
									<span class="wc">메타버스 북부도서관</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick07-bg.png" class="mi">
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="main1box2">
					<div class="calendar-box">
						<div class="title">
							<ul>
								<li><h2>휴관일 및 행사</h2></li>
								<li><a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="cal-box">

						</div>

						<div class="library-infomation">
							<div class="top">
								<div class="topBox1">
									<span><h4>종합자료실</h4></span>
									<span>
									<strong>평일 09:00~19:00<br/>
									주말 09:00~17:00</strong>
									</span>
								</div>
								<div class="topBox2">
									<span><h4>어린이자료실</h4></span>
									<span>
									<strong>평일 09:00~18:00<br/>
									주말 09:00~17:00</strong>
									</span>
								</div>
							</div>
							<div class="bottom">
								<span><h4>자유학습실</h4></span>
								<span><strong>07:00~22:00</strong></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="sns-box">
			<h2 class="title"><img src="/resources/homepage/${homepage.context_path}/img/sns-title.png" alt="sns-title"></h2>
			<div class="sns-link">
				<ul>
					<li>
						<a href="https://www.facebook.com/bukbulib" target="_blank">
							<img src="/resources/homepage/${homepage.context_path}/img/facebook-icon.png" alt="FACEBOOK"> <br class="br650"/>FACEBOOK
						</a>
					</li>
					<li>
						<a href="https://www.instagram.com/libbukbu/" target="_blank">
							<img src="/resources/homepage/${homepage.context_path}/img/instargram-icon.png" alt="INSTAGRAM"> <br class="br650"/>INSTAGRAM
						</a>
					</li>
					<li>
						<a href="https://twitter.com/bukbulib" target="_blank">
							<img src="/resources/homepage/${homepage.context_path}/img/twitter-icon.png" alt="TWITTER"> <br class="br650"/>TWITTER
						</a>
					</li>
					<li>
						<a href="https://www.youtube.com/channel/UCQYHZF_a03fl3AIstSLd_Rw" target="_blank">
							<img src="/resources/homepage/${homepage.context_path}/img/youtube-icon.png" alt="YOUTUBE"> <br class="br650"/>YOUTUBE
						</a>
					</li>
				</ul>
			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="book tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1">전시안내</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=189&manage_idx=145" class="more-btn more-more"></a></li>
								<li><a href="#tab2">영화상영</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157" class="more-btn more-more"></a></li>
							</ul>
						</div>
						<div class="box con" data-tab="tab1">
							<div class="movieContent">
								<ul class="book_photo">
								<c:forEach var="i" varStatus="status" items="${exhibitionList}">
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=189&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<c:choose>
												<c:when test="${i.preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'http')}">
															<span class="movieImg">
																<img src="${i.preview_img}" alt="${i.title}" class="book_img"/>
															</span>
														</c:when>
														<c:otherwise>
															<span class="movieImg">
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" class="book_img" onError="this.src='/resources/common/img/noImg2.png'"/>
															</span>
															<span class="movieEx">
																<b>제목 </b> ${i.title}<br /><b>기간 </b> ${i.imsi_v_1}<br /><b>장소 </b> ${i.imsi_v_2}
															</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="movieImg">
														<img src="/resources/common/img/noImg2.png" alt="${i.title}" class="book_img" onError="this.src='/resources/common/img/noImg2.png'"/>
													</span>
												</c:otherwise>
											</c:choose>
										</a>
									</li>
								</c:forEach>
								<c:if test="${fn:length(exhibitionList) < 1}">
									<li>
										<a href="javascript:alert('등록된 전시가 없습니다.'); return false;">
											<img src="/resources/common/img/noimg-gall.png" alt="${i.title}">
											<strong class="title">등록된 전시가 없습니다.</strong>
										</a>
									</li>
								</c:if>
								</ul>
							</div>
						</div>

						<div class="box con" data-tab="tab2" style="display:none;">
							<div class="movieContent">
								<ul class="book_photo">
									<c:forEach var="i" varStatus="status" items="${movieList}" >
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=157&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="movieImg">
											<c:choose>
												<c:when test="${i.preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'http')}">
															<span class="movieImg">
																<img src="${i.preview_img}" alt="${i.title}"/>
															</span>
														</c:when>
														<c:otherwise>
															<span class="movieImg">
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/>
															</span>
															<span class="movieEx">
																<strong class="title">${i.title}</strong><br />

																<c:if test="${i.imsi_v_1 ne '' and i.imsi_v_2 ne ''}">
																<span class="date">
																<b>날짜</b> ${fn:replace(i.imsi_v_1, '-', '.')}.${i.imsi_v_2}
																</span>
																</c:if>

																<c:if test="${i.imsi_v_3 ne null and i.imsi_v_4 ne null}">
																<span class="time">
																<b>시간</b> ${i.imsi_v_3}:${fn:length(i.imsi_v_4) == 1 ? '0' : ''}${i.imsi_v_4}
																</span>
																</c:if><br />

																<c:if test="${i.imsi_v_6 ne null and i.imsi_v_6 ne '0'}">
																<span class="divid">
																<b>장소</b> ${i.imsi_v_6}
																</span>
																</c:if>

																<c:if test="${i.imsi_v_9 ne null and i.imsi_v_9 ne '0'}">
																<span class="desc">
																<b>장르</b>  ${fn:substring(i.imsi_v_9, 0, 6)}<c:if test="${fn:length(i.imsi_v_9) > 6}">...</c:if>
																</span>
																</c:if>
															</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="movieImg">
														<img src="/resources/common/img/noimg-gall.png" alt="${i.title}">
													</span>
												</c:otherwise>
											</c:choose>
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

				<div class="main2box2">
					<ul>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick001-bg.png" alt="책바다"></span><span class="txt">책바다</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=49"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=50"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick003-bg.png" alt="사서에게 물어보세요"></span><span class="txt">사서에게<br/>물어보세요</span></a></li>
						<li><a href="/${homepage.context_path}/board/index.do?menu_idx=110&manage_idx=4"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick004-bg.png" alt="경북대학교 상호대차"></span><span class="txt">경북대학교<br/>상호대차</span></a></li>
					</ul>
				</div>

				<div class="main2box3">
					<div class="book tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1">공지사항</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1" class="more-btn more-more"></a></li>
								<li><a href="#tab2">강좌·행사안내</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=124&manage_idx=146" class="more-btn more-more"></a></li>
							</ul>
						</div>
						<div class="notice box con" data-tab="tab1">
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

						<div class="culture box con" data-tab="tab2" style="display:none;">
							<!-- <div class="cont">
								<ul class="list">
									<c:forEach var="i" varStatus="status" items="${noticeList}" >
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=124&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<em>${i.title}</em>
											<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
										</a>
									</li>
									</c:forEach>

									<c:if test="${fn:length(noticeList) < 1}">
									<li>
										<em>등록된 게시글이 없습니다.</em>
									</li>
									</c:if>
									<%--공지사항 목록--%>
								</ul>
							</div> -->
						</div>
					</div>
				</div>

				<!-- <div class="main2box3">
					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
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
				</div> -->

				<div class="main2box4">
					<!-- <div class="culture">
						<div class="title">
							<ul>
								<li><h2>수강신청</h2></li>
								<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="cont">
							<ul class="list">
								<c:if test="${fn:length(teachList) < 1}">
								<li>
									등록된 강좌가 없습니다.
								</li>
								</c:if>
								<c:forEach items="${teachList}" var="i" varStatus="status">
								<li>
									<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
										<em>${i.teach_name}</em>
										<c:if test="${i.teach_status eq '0'}">
										<span class="status before">접수중</span>
										</c:if>
										<c:if test="${i.teach_status eq '1'}">
										<span class="status before">대기접수</span>
										</c:if>
										<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
										<span class="status after">신청완료</span>
										</c:if>
										<c:if test="${i.teach_status eq '3'}">
										<span class="status after">신청완료</span>
										</c:if>
										<c:if test="${i.teach_status eq '9'}">
										<span class="status after">수강종료</span>
										</c:if>
										<c:if test="${i.teach_status eq '4'}">
										<span class="status after">접수마감</span>
										</c:if>
										<c:if test="${i.teach_status eq '5'}">
										<span class="status after">정원마감</span>
										</c:if>
										<c:if test="${i.teach_status eq '6'}">
										<span class="status before">신청대기</span>
										</c:if>
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div> -->
					
					<div class="quick-btn-box">
						<div class="top-btn-box">
							<ul>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=165&manage_idx=921">북큐레이션</a></li>
								<li><a href="/${homepage.context_path}/intro/search/index.do?menu_idx=120&booktype=BOOK&separateShelfCode=ABH#search_result">교과연계도서</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=144">사서추천도서</a></li>
							</ul>
						</div>
						<div class="bottom-btn-box">
							<ul>
								<li><a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14">신착도서</a></li>
								<li><a href="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15">대출베스트</a></li>
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

	</div>

	<!-- 퀵메뉴 분리 20200226 -->
	<div id="quick-slide">
		<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
		<ul>
			<!--<li><a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=1" target="_blank"><span class="txt">디지털 정보코너<Br/>좌석예약</span></a></li>
			<li><a href="/${homepage.context_path}/html.do?menu_idx=26"><span class="txt">희망도서신청</span></a></li>-->
			<li><a href="/${homepage.context_path}/intro/search/index.do?menu_idx=13#search_result"><span class="txt">자료검색</span></a></li>
			<li><a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=18"><span class="txt">예약현황</span></a></li>
			<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157"><span class="txt">영화상영일정</span></a></li>
			<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30"><span class="txt">수강신청</span></a></li>
			<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16"><span class="txt">대출현황</span></a></li>
			<li><a href="/${homepage.context_path}/html.do?menu_idx=104" ><span class="txt">이용안내</span></a></li>
			<!--<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="txt">책바다신청</span></a></li>-->
			<!--<li><a href="/${homepage.context_path}/board/index.do?menu_idx=65&manage_idx=148"><span class="txt">묻고답하기</span></a></li>-->
			<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1"><span class="txt">공지사항</span></a></li>
			<li><a href="http://dgelib.dkyobobook.co.kr" target="_blank"><span class="txt">대구학생<br/>전자도서관</span></a></li>
			<!--<li><a href="/${homepage.context_path}/bukbu/html.do?menu_idx=78"><span class="txt">행정정보공개</span></a></li>-->
		</ul>
	</div>

<tiles:insertAttribute name="footer" />