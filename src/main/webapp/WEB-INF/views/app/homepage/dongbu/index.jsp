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
	
		$('div#holiday-box').load('calendar2.do');

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
						<img src="/resources/homepage/${homepage.context_path}/img/txt6.png" alt=""/>
					</div>


					<div class="search-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="7">
							<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
							<fieldset>
								<legend class="blind">통합검색</legend>
								<div class="main-box">
									<div class="title-box">통합자료검색</div>
									<div class="box1">
										<div class="box2">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
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
			<div class="section">

				<ul data-call="bxslider" data-breaks="[{screen:0, slides:1},{screen:340, slides:2},{screen:450, slides:3},{screen:600, slides:4},{screen:767, slides:5},{screen:1000, slides:${fn:length(quickMenuList)}}]">
					<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
				</ul>

			</div>
		</div>


		<div class="main_line">
			<div class="section">

				<div class="main3">
					<div class="title">
						<ul>
							<li><h2>공지사항</h2></li>
							<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/seobu/img/more_bt.png" alt="더보기"/></a></li>
						</ul>
					</div>

					<div class="news">
						<div class="box">
							<ul>
							<!--
							<c:forEach var="i" items="${noticeList}">
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=58&amp;manage_idx=${i.manage_idx}&amp;board_idx=${i.board_idx}"><em>${i.title}</em></a>
									<span><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></span>
								</li>
							</c:forEach>
							-->
							<li><a href="#"><span class="new-tit">NEW</span><em>구입 예정 고문헌 목록 공개</em><span>2019.12.17</span></a></li>
							<li><a href="#"><span class="new-tit">NEW</span><em>‘규남 하백원이 만든 자동양수기 자승차’</em><span>2019.12.17</span></a></li>
							<li><a href="#"><span class="tit">공지</span><em>빅데이터로 보는 세상과 한국 경제</em><span>2019.12.17</span></a></li>
							<li><a href="#"><span class="tit">공지</span><em>대구광역시립도서관 온라인 서비스 일시..</em><span>2019.12.17</span></a></li>
							<li><a href="#"><span class="tit">공지</span><em>2019년도 대구광역시립도서관 이용만족..</em><span>2019.12.17</span></a></li>
							</ul>
						
						</div>
					</div>

				</div>

				<div class="main4 tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=416">신착자료</a></li>
						<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=417">대출베스트</a></li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415" class="more-btn more-more">더보기</a>
					</ul>

					<div class="box con" data-tab="tab1">
						<ul class="lt_photo">
							<li>
								<a class="goDetail" href="" >
									<img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">욕대장</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">오즈의 의류수거함</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book03.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">싱가포르 홀리데이</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book03.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">싱가포르 홀리데이</span>
								</a>
							</li>
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="lt_photo">
							<li>
								<a class="goDetail" href="" >
									<img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">욕대장</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">오즈의 의류수거함</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book03.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">싱가포르 홀리데이</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<img src="/resources/homepage/jungang/img/book03.png" alt="${i.TITLE}" width="100px" height="150px">
									<span class="title">싱가포르 홀리데이</span>
								</a>
							</li>
						</ul>
					</div>

				</div>

			</div>
		</div>

		<div class="main6_bg">
			<div class="main6 section">
				<!-- 팝업존 -->
				<div class="popZone">
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<!-- <homepageTag:popupZone popupZoneList="${popupZoneList}" /> -->
						</c:when>
						<c:otherwise>
							<ul>
								<li><a href="#"><img src="/resources/homepage/dongbu/img/popupnone.jpg" alt="" /></a></li>
								<li><a href="#"><img src="/resources/homepage/dongbu/img/popupzone01.jpg" alt="" /></a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="movie">
					<div class="title">
						<h3>영화상영</h3>
						<a class="more-btn more-more" href="/${homepage.context_path}/board/index.do?menu_idx=46&manage_idx=88">더보기</a>
					</div>
					<div class="movieContent">
						<ul>
							
							<li>
								<a href="//${homepage.context_path}/board/view.do?manage_idx=88&board_idx=1296104&menu_idx=46">
									<span class="movieImg">
										<img src="/resources/homepage/dongbu/img/movie01.jpg" alt="미녀와 야수">
									</span>
									<span class="movieEx">
										<div>12세미만</div>
										<strong class="title">미녀와 야수</strong>
										<span class="date">
										<b>날짜</b>&nbsp;&nbsp;&nbsp;2019.12.24.
										</span>
										<span class="time">
										<b>시간</b>&nbsp;&nbsp;&nbsp;14:00
										</span>
										<span class="divid">
										<b>장소</b>&nbsp;&nbsp;&nbsp;동부도서관
										</span>
										<span class="desc">
										<b>장르</b>&nbsp;&nbsp;&nbsp;애니
										</span>
									</span>
								</a>
							</li>

							<li>
								<a href="/${homepage.context_path}/board/view.do?manage_idx=88&board_idx=1296104&menu_idx=46">
								<span class="movieImg">
									<img src="/resources/homepage/dongbu/img/movie01.jpg" alt="미녀와 야수">
								</span>
								<span class="movieEx">
									<div>12세미만</div>
									<strong class="title">미녀와 야수</strong>
									<span class="date">
									<b>날짜</b>&nbsp;&nbsp;&nbsp;2019.12.24.
									</span>
									<span class="time">
									<b>시간</b>&nbsp;&nbsp;&nbsp;14:00
									</span>
									<span class="divid">
									<b>장소</b>&nbsp;&nbsp;&nbsp;동부도서관
									</span>
									<span class="desc">
									<b>장르</b>&nbsp;&nbsp;&nbsp;애니
									</span>
								</span>
								</a>
							</li>
						</ul>
					</div>
				</div>

				<div class="quickLink">
					<ul>
						<li><a href="http://cn.nl.go.kr/index.do" target="_blank">야간예약대출 <span class="plus-btn">+</span></a></li>
						<li><a href="http://www.nl.go.kr/nill/user/index.jsp" target="_blank" class="link01">책이음 <span>공공도서관 도서대출</span> <span class="plus-btn">+</span></a></li>
						<li><a href="http://www.nl.go.kr/ask"  target="_blank" class="link02">책나래 <span>장애인 도서관 자료 무료우편</span><span class="plus-btn">+</span></a></li>
						<li><a href="/seogu/html.do?menu_idx=79" class="link03">책바다 <span>국가상호대차서비스</span><span class="plus-btn">+</span></a></li>
						<li><a href="/seogu/html.do?menu_idx=195">사서에게물어보세요 <span class="plus-btn">+</span></a></li>
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
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=154"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box4">
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
	</div>
</div>
	
<tiles:insertAttribute name="footer" />