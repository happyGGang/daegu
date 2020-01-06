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
			var checkInput = $this.parent().find('input');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#' + popupId).hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
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

		<div class="main1">
			<div class="section">

				<div class="main1box1">

					<div class="main1box1box1">
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="7">
								<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서명을 입력해 주세요." style="ime-mode:active;"/>
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
										<!-- <homepageTag:popupZone popupZoneList="${popupZoneList}" /> -->
									</c:when>
									<c:otherwise>
										<ul>
											<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="" /></a></li>
											<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupzone01.png" alt="" /></a></li>
										</ul>
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="main1box1box2box2">
							<ul>
								<li class="bg-blue">
									<a href="#">
									<span class="wt">이용안내</span>
									<span class="wc">우리 도서관에<br/>처음 오셨나요?</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="#">
									<span class="wt">마이페이지</span>
									<span class="wc">대출조회 및 신청현황</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="#">
									<span class="wt">독서문화행사</span>
									<span class="wc">서로 공감하고<br/>소통할 수 있는<br/>프로그램</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="#">
									<span class="wt">디지털코너</span>
									<span class="wc">쉽고 빠른 디지털코너<br/>좌석예약</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgreen">
									<a href="#" style="z-index: 9;">
									<span class="wt">희망도서</span>
									<span class="wc">읽고 싶은 책 신청</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-blue">
									<a href="#">
									<span class="wt">전자도서관</span>
									<span class="wc">다양한 디지털 콘텐츠</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick06-bg.png" class="mi">
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
								<li><h2>휴관일 및 이용안내</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="cal-box">
							
						</div>

						<div class="library-infomation">
							<div class="top">
								<div class="topBox1">
									<span><h4>종합자료실</h4></span>
									<span>
									평일 09:00 ~ 19:00<br/>
									주말 09:00 ~ 17:00
									</span>
								</div>
								<div class="topBox2">
									<span><h4>어린이자료실</h4></span>
									<span>
									평일 09:00 ~ 18:00<br/>
									주말 09:00 ~ 17:00
									</span>
								</div>
							</div>
							<div class="bottom">
								<span><h4>자유학습실</h4></span>
								<span>07:00 ~ 22:00</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="book tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1">신간도서</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
								<li><a href="#tab2">추천도서</a> <a href="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415" class="more-btn more-more"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="box con" data-tab="tab1">
							<ul class="book_photo">
								<li>
									<a class="goDetail" href="" >
										<img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}" />
										<span class="title">욕대장</span>
									</a>
								</li>
							</ul>
						</div>

						<div class="box con" data-tab="tab2" style="display:none;">
							<ul class="book_photo">
								<li>
									<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
										<img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}" />
										<span class="title">오즈의 의류수거함</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="main2box2">
					<ul>
						<li><a href=""><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick001-bg.png" alt="책바다"></span><span class="txt">책바다</span></a></li>
						<li><a href=""><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
						<li><a href=""><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick003-bg.png" alt="사서에게 물어보세요"></span><span class="txt">사서에게<br/>물어보세요</span></a></li>
						<li><a href=""><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick004-bg.png" alt="경북대학교 상호대차"></span><span class="txt">경북대학교<br/>상호대차</span></a></li>
					</ul>
				</div>

				<div class="main2box3">
					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="cont">
							<ul class="list">
							<!--
								<c:forEach var="i" varStatus="status" items="${noticeList}" >
								<c:if test="${status.first}">
								<li class="on-cont">
									<img src="${site.designRoot}/img/incheon_notice_img.png">
									<a href="/${homepage.context_path}/board/view.do?menu_idx=87&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
										<span class="title">${i.title}</span>
										<p class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></p>
										<span class="content">
												${fn:substring(fn:trim(i.content_summary), 0, 90)}...
										</span>
									</a>
								</li>
								</c:if>
								<c:if test="${!status.first}">
								<li><a href="/${homepage.context_path}/board/view.do?menu_idx=87&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<span class="not-sub">${i.title}
										<img src="${site.designRoot}/img/incheon_new_icon.png"></span>
										<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></span></a>
								</li>
								</c:if>
								</c:forEach>

								<c:if test="${fn:length(noticeList) < 1}">
								<li class="noticeCont"  style="min-height: 160px; text-align: center; line-height: 150px">
									등록된 데이터가 없습니다.
								</li>
								</c:if>
							-->
								<li class="on-cont">
									<img src="/resources/homepage/${homepage.context_path}/img/main_notice_img.png">
									<a href="#">
										<span class="title">2019년 12월 31일 자료실 운영시간 변경 안내</span>
										<p class="date">2019-12-24</p>
										<span class="content">
											2019년도 11월 2차 이용자 희망도서 처리결과를..
										</span>
									</a>
								</li>
								
								<li>
								<a href="#">
									<em>2020년도 자료실 평일 및 주말 근무자 최종 합격자 안내</em>
									<span class="date">2019.12.19</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>2020년 겨울방학특별프로그램 학습자 모집</em>
									<span class="date">2019.12.17</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>공유재산 사용·수익허가(이용자 복합기) 낙찰자 결정 공고</em>
									<span class="date">2019.12.16</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>공유재산 사용·수익허가(이용자 복합기) 낙찰자 결정 공고</em>
									<span class="date">2019.12.16</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>공유재산 사용·수익허가(이용자 복합기) 낙찰자 결정 공고</em>
									<span class="date">2019.12.16</span>
								</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="main2box4">
					<div class="culture">
						<div class="title">
							<ul>
								<li><h2>수강신청</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>
						<div class="cont">
							<ul class="list">
							<!--
								<c:forEach var="i" varStatus="status" items="${noticeList}" >

								<li><a href="/${homepage.context_path}/board/view.do?menu_idx=87&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
									<span class="not-sub">${i.title}
										<img src="${site.designRoot}/img/incheon_new_icon.png"></span>
										<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></span></a>
								</li>

								</c:forEach>

								<c:if test="${fn:length(noticeList) < 1}">
								<li class="noticeCont"  style="min-height: 160px; text-align: center; line-height: 150px">
									등록된 데이터가 없습니다.
								</li>
								</c:if>
							-->
								
								<li>
								<a href="#">
									<em>(초등 1~3학년)만들고 체험하는 우리역사 우리역사 우리역사 우리역사</em>
									<span class="status before">접수대기</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>(초등 4-6학년)우리역사 탐험대</em>
									<span class="status ing">접수중</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>(일반인)도서관에서 만나는 세계사</em>
									<span class="status ing">접수중</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>고전철학(동양)</em>
									<span class="status before">접수대기</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>생활영어 기초회화</em>
									<span class="status after">접수마감</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>(일반인)도서관에서 만나는 세계사</em>
									<span class="status after">접수마감</span>
								</a>
								</li>
								<li>
								<a href="#">
									<em>(일반인)도서관에서 만나는 세계사</em>
									<span class="status after">접수마감</span>
								</a>
								</li>
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
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=154"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box3">
						<!-- <homepageTag:banner bannerList="${bannerList}"/> -->
						<ul class="banner-roll">
						<li>
						<span>
						<a target="_blank" href="http://www.nl.go.kr/nl/index.jsp">
						<img alt="국립중앙도서관" src="http://www.gbelib.kr/data/banner/h16/1484821791432"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://www.nlcy.go.kr/index.do">
						<img alt="국립어린이청소년도서관" src="http://www.gbelib.kr/data/banner/h16/1486009824941"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://nlid.nl.go.kr/able?act=searchDetail03">
						<img alt="국립장애인도서관" src="http://www.gbelib.kr/data/banner/h16/1486009952132"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://www.gbe.kr/">
						<img alt="경상북도교육청" src="http://www.gbelib.kr/data/banner/h16/1486009731009"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://www.csed.go.kr/">
						<img alt="청송교육지원청" src="http://www.gbelib.kr/data/banner/h16/1484821773110"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://www.nl.go.kr/nill/user/index.jsp">
						<img alt="책바다" src="http://www.gbelib.kr/data/banner/h16/1484821729632"/></a></span></li>
						<li>
						<span>
						<a target="_blank" href="http://dream.nl.go.kr/dream/chaeknarae/index.do">
						<img alt="책나래" src="http://www.gbelib.kr/data/banner/h16/1484821754536"/></a></span></li>
						<li>
						<span>
						<a href="javascript:linkToAskNl('147022','경상북도립청송공공도서관');">
						<img alt="사서에게물어보세요" src="http://www.gbelib.kr/data/banner/h16/1484821719719"/></a></span></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div id="quick-slide">
			<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
			<ul>
				<li><a href=""><span class="txt">디지털 정보코너<Br/>좌석예약</span></a></li>
				<li><a href=""><span class="txt">희망도서신청</span></a></li>
				<li><a href=""><span class="txt">도서예약</span></a></li>
				<li><a href=""><span class="txt">영화상영일정</span></a></li>
				<li><a href=""><span class="txt">강좌신청</span></a></li>
				<li><a href=""><span class="txt">대출이력조회</span></a></li>
				<li><a href=""><span class="txt">이용안내</span></a></li>
				<li><a href=""><span class="txt">책바다신청</span></a></li>
				<li><a href=""><span class="txt">묻고답하기</span></a></li>
				<li><a href=""><span class="txt">RSS서비스</span></a></li>
				<li><a href=""><span class="txt">업무추진비<Br/>집행내역</span></a></li>
				<li><a href=""><span class="txt">행정정보공개</span></a></li>
			</ul>
		</div>

	</div>

	
<tiles:insertAttribute name="footer" />