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
						시민과 함께<Br class="webBr"/>
						미래를 가꾸는<br/>
						<b>대구광역시립서부도서관</b>
					</div>

					<div class="search-icon">

						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="7">
								<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">

										<div class="box1">

											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
											<button id="main-search-btn">검색</button>

										</div>
										
									</div>
								</fieldset>
							</form>

						</div>
						<span class="instagram-icon"><a href=""><img src="/resources/homepage/${homepage.context_path}/img/instagram-icon.png" alt=""></a></span>
						<span class="facebook-icon"><a href=""><img src="/resources/homepage/${homepage.context_path}/img/facebook-icon.png" alt=""></a></span>
						
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

				<div class="notice">
					<div class="title">
						<ul>
							<li><h2>공지사항</h2></li>
							<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/seobu/img/more_btbtbtbt.png" alt="더보기"/></a></li>
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
								<img src="/resources/homepage/seobu/img/main_notice_img.png">
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

			</div>
		</div>


		<div class="main4">
			<div class="section">
				<div class="quickLink01">
					<ul>
						<li><a href="" class="q1">학교교육지원</a></li>
						<li><a href="" class="q2">향토문학관</a></li>
						<li><a href="" class="q3">희망장난감도서관</a></li>
					</ul>
				</div>

				<div class="book-s tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=416">신착자료</a></li>
						<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=417">대출베스트</a></li>
						<li><a href="#tab3" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=417">북큐레이션</a></li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415" class="more-btn more-more">더보기</a>
					</ul>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							<li>
								<a class="goDetail" href="" >
									<span class="img"><img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">욕대장</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<span class="img"><img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">오즈의 의류수거함</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>
								</a>
							</li>
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<span class="img"><img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">오즈의 의류수거함</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>

								</a>
							</li>
							<li>
								<a class="goDetail" href="" >
									<span class="img"><img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">욕대장</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>

								</a>
							</li>

						</ul>
					</div>

					<div class="box con" data-tab="tab3" style="display:none;">
						<ul class="book_photo">
							<li>
								<a class="goDetail" href="" >
									<span class="img"><img src="/resources/homepage/jungang/img/book01.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">욕대장</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>
								</a>
							</li>
							<li>
								<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
									<span class="img"><img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}"></span>
									<span class="contents">
										<p class="title">오즈의 의류수거함</p>
										<p><b>저자</b> 아무개</p>
										<p><b>발행자</b> 아무나</p>
									</span>
								</a>
							</li>
						</ul>
					</div>

				</div>

				<div class="quickLink02">
					<ul>
						<li class="qi1"><a href="http://cn.nl.go.kr/index.do" target="_blank">책나래</a></li>
						<li class="qi2"><a href="http://www.nl.go.kr/nill/user/index.jsp" target="_blank" class="link01">책바다</a></li>
						<li class="qi3"><a href="http://www.nl.go.kr/ask"  target="_blank" class="link02">사서에게물어보세요</a></li>
						<li class="qi4"><a href="/seogu/html.do?menu_idx=79" class="link03">1365자원봉사신청</a></li>
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