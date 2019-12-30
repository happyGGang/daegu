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

		<div class="main1">
			<div class="section">

				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="7">
						<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="title-box">통합자료검색</div>
								<div class="box0">
									<label for="search_type" class="search_type">
										<select id="search_type" name="search_type" style="border:0;font-size:15px">
											<option value="L_TITLE">서명</option>
											<option value="L_AUTHOR">저자</option>
											<option value="L_PUBLISHER">발행자</option>
											<option value="L_KEYWORD">키워드</option>
										</select>
									</label>
								</div>
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색</button>
							</div>
						</fieldset>
					</form>
				</div>

			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="main2box1box1">
						<ul>
							<li class="bg-blue"">
								<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=138">
								<span class="wt">이용안내</span>
								<span class="wc">남부도서관 이렇게 <br/>이용하세요!</span>
								<img src="/resources/homepage/nambu/img/m_icon01.png" class="mi">
								</a>
							</li>
							<li class="bg-lgray">
								<a href="/${homepage.context_path}/intro/search/hope/index.do?menu_idx=27">
								<span class="wt">마이페이지</span>
								<span class="wc">대출조회 및<br>신청현황</span>
								<img src="/resources/homepage/nambu/img/m_icon02.png" class="mi"></a>
							</li>
							<li class="bg-background01">
								<a href="http://lib.ice.go.kr/elib/index.do" target="_blank">
								<span class="wt">대구<br class="qmobileBr"/>전자도서관</span>
								<span class="wc">대구시민의 스마트한<br>독서생활이 시작되는 곳</span>
								</a>
							</li>
							<li class="bg-green">
								<a href="/${homepage.context_path}/html.do?menu_idx=21">
								<span class="wt">독서회</span>
								<span class="wc">독서와 토론이<br>있는 모임</span>
								<img src="/resources/homepage/nambu/img/m_icon03.png" class="mi"></a>
							</li>
							<li class="bg-background02">
								<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=179" style="z-index: 9;"><span class="wt">중국문화<br class="qmobileBr"/>정보실</span>
								<span class="wc">도서관 속 작은 중국</span>
								</a>
							</li>
							<li class="bg-lgreen">
								<a href="/${homepage.context_path}/html.do?menu_idx=28">
								<span class="wt">수강신청</span>
								<span class="wc">온라인 수강신청</span>
								<img src="/resources/homepage/nambu/img/m_icon04.png" class="mi"></a>
							</li>
							<li class="bg-white">
								<a href="/${homepage.context_path}/html.do?menu_idx=28">
								<span class="wt">책나래</span>
								<span class="wc">도서관 자료<br/>무료우편 서비스</span>
								<img src="/resources/homepage/nambu/img/m_icon05.png" class="mi"></a>
							</li>
							<li class="bg-background03">
								<a href="/${homepage.context_path}/html.do?menu_idx=28">
								<span class="wt">책바다</span>
								<span class="wc">국가상호대차<br/>서비스</span>
								<img src="/resources/homepage/nambu/img/m_icon06.png" class="mi"></a>
							</li>
						</ul>
					</div>


					<div class="main2box1box2">
							<div class="event-box">
								<ul>
									<li>
										<div class="box">
											<h3>행사일</h3>
											<span>2019.12.26</span>
										</div>
										<div class="list-box">
											<ul>
												<li><a href="#">동화속 그림 전시회</a></li>
												<li><a href="#">중국문화 학습동아리</a></li>
												<li><a href="#">플러스 2배 대출</a></li>
											</ul>
										</div>
									</li>

									<li>
										<div class="box">
											<h3>행사일</h3>
											<span>2019.12.27</span>
										</div>
										<div class="list-box">
											<ul>
												<li><a href="#">동화속 그림 전시회</a></li>
												<li><a href="#">중국문화 학습동아리</a></li>
												<li><a href="#">플러스 2배 대출</a></li>
											</ul>
										</div>
									</li>
								</ul>
							</div>

							<div class="holiday-box">
								<ul>
									<li>
										<div class="box">
											<h3>휴관일</h3>
											<span>2019.12</span>
										</div>
										<div class="list-box">
											<ul>
												<li>2</li>
												<li>16</li>
												<li>25</li>
											</ul>
										</div>
									</li>

									<li>
										<div class="box">
											<h3>휴관일</h3>
											<span>2020.01</span>
										</div>
										<div class="list-box">
											<ul>
												<li>1</li>
												<li>25</li>
												<li>26</li>
												<li>27</li>
												<li>28</li>
											</ul>
										</div>
									</li>
								</ul>
							</div>
						</ul>
					</div>
				</div>

				<div class="main2box2">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<!-- <homepageTag:popupZone popupZoneList="${popupZoneList}" /> -->
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/nambu/img/popupnone.jpg" alt="" /></a></li>
									<li><a href="#"><img src="/resources/homepage/nambu/img/popupzone01.png" alt="" /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		

		<div class="main3">
			<div class="section">

				<div class="main3box1">

					<div class="notice">
						<div class="title">
							<ul>
								<li><h2>공지사항</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
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
									<img src="/resources/homepage/nambu/img/main_notice_img.png">
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

				<div class="main3box2">
					<div class="movie">
						<div class="title">
							<ul>
								<li><h2>영화상영</h2></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=12"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
							</ul>
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
										<b>날짜</b> 2019.12.24.
										</span>
										<span class="time">
										<b>시간</b> 14:00
										</span>
										<span class="divid">
										<b>장소</b> 남부도서관
										</span>
										<span class="desc">
										<b>장르</b> 애니
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
										<b>날짜</b> 2019.12.24.
										</span>
										<span class="time">
										<b>시간</b> 14:00
										</span>
										<span class="divid">
										<b>장소</b> 남부도서관
										</span>
										<span class="desc">
										<b>장르</b> 애니
										</span>
									</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="main3box3 tabS">
					<div class="book">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415">신간도서</a></li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=416">대출베스트</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=31&manage_idx=415" class="more-btn more-more"><img src="/resources/homepage/nambu/img/more_btbt.png" alt="더보기"/></a></li>
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
								<li>
									<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
										<img src="/resources/homepage/jungang/img/book02.png" alt="${i.TITLE}" />
										<span class="title">오즈의 의류수거함</span>
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
								<li>
									<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
										<img src="/resources/homepage/jungang/img/book03.png" alt="${i.TITLE}" />
										<span class="title">싱가포르 홀리데이</span>
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

					<div class="banner-box2">
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

					<div class="banner-t2">
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a><br/>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=154"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
	
<tiles:insertAttribute name="footer" />