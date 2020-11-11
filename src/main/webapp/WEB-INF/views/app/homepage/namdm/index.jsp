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
							<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=132" class="more-btn">더보기</a>
						</div>
						<div class="cont">
							<ul class="list">
								
								
								
								<li class="on-cont">
									<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
									<a href="#">
										<span class="title">(★추가모집) 2020년 제1기 영유아 프로그램 수강생 모집</span>
										<p class="date">2020-10-20</p>
										<span class="content">
											수강신청하러가기수강신청하러가기수강신청하러가기수강신청하러가기수강신청하러가기수강신청하러가기수강신청하러가기
										</span>
									</a>
								</li>
								
								<li>
									<a href="">
										<em><span class="nam002">일반</span>2020 내 가족 뿌리찾기 프로그램 운영 안내</em>
										<span class="date">2020.10.23</span>
									</a>
								</li>
								
								<li>
									<a href="">
										<em><span class="nam001">공지</span>(★추가모집) 2020년 제1기 영유아 프로그램 수강생 모집</em>
										<span class="date">2020.10.20</span>
									</a>
								</li>
								
								<li>
									<a href="">
										<em><span class="nam001">공지</span>[홍보] 2020 학부모 아카데미 제3강 참여 신청 안내</em>
										<span class="date">2020.10.13</span>
									</a>
								</li>
								
								<li>
									<a href="">
										<em><span class="nam001">공지</span>[홍보] 2020 도시재생 아카데미 수강생 모집 안내</em>
										<span class="date">2020.10.13</span>
									</a>
								</li>
						
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
							<a href="#">
								<span>이용안내</span>
							</a>
						</li>
						<li class="qm2">
							<a href="#">
								<span>대출현황</span>
							</a>
						</li>
						<li class="qm3">
							<a href="#">
								<span>희망도서</span>
							</a>
						</li>
						<li class="qm4">
							<a href="#">
								<span>이달의행사</span>
							</a>
						</li>
						<li class="qm5">
							<a href="#">
								<span>문화프로그램</span>
							</a>
						</li>
						<li class="qm6">
							<a href="#">
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
						<li class="on"><a href="#tab1" class='t-tabs'>사서추천도서</a></li>
						<li><a href="#tab2" class='t-tabs'>신착도서</a></li>
					</ul>
					<a href="#" class="btn-more book-more">더보기</a>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">1진정성 마케팅 ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">초록 자전거...</span>
								</a>
							</li>
							
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">2진정성 마케팅 : 끌리...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">초록 자전거...</span>
								</a>
							</li>
							
						</ul>
					</div>

				</div>

				<div class="movie-box">
					<div class="movie">
						<div class="tit">
							<h2>영화상영</h2>
							<a href="#" class="btn-more">더보기</a>
						</div>
						<div class="movieContents">
							<ul>
									<li>
										<a href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
											<span class="movieImg">
												<img src="/resources/common/img/noImg2.png" alt="${i.title}">
												<strong class="title">제목제목제목</strong>
											</span>

											<span class="movieEx">

												<span class="date">
												 2020년 9월 24일<br/>
												 14시 00분 (목)
												</span>

												<span class="desc">
												1987년 1월, 경찰 조사를 받던 스물두 살 대학생이 사망한다. 증거인멸을 위해 박처장(김윤석)의 주도하에 경찰은 시신 ...
												</span>

											</span>
										</a>
									</li>
							<!--
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
							-->
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
					</div>
					<div class="con">
						<ul>

							<li class="on-cont">
								<a href="#">
									<div class="cont">
										<strong>ㅅㅂ도서관 편의시설 운영 안내(2020.10.15~)</strong>
										<span class="txt"><b>접수</b>  2020. 08. 15. ~ 2020. 09. 30.</span>
										<span class="txt"><b>운영</b>  2020. 10. 01. ~ 2020. 12. 20.</span>
									</div>
									<p class="one-status-box status002">접수중</p>
								</a>
							</li>

							<li>
								<a href="#">
									<strong>사회적 거리두기 조정 시행에 따른 ㅅㅂ도서관 운영 안내</strong>
									<span class="status-box status001">대기</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<strong>10월 가족문화한마당 공연 안내</strong>
									<span class="status-box status002">접수중</span>
								</a>
							</li>

							<li>
								<a href="#">
									<strong>9월 가족 추억쌓기 당첨자 발표</strong>
									<span class="status-box status003">마감</span>
								</a>
							</li>

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