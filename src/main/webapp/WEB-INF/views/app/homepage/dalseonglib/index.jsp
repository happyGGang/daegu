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
		$('.movie').each(function(){
			$(this).find('.bxslider').bxSlider({
				pager:false,
				slideMargin:0,
			});
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

					<div class="book-box tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" class='t-tabs'>추천도서</a></li>
							<li><a href="#tab2" class='t-tabs'>신착도서</a></li>
						</ul>
						<a href="#" class="btn-more btn-w top35">더보기</a>

						<div class="box con" data-tab="tab1">
							<ul class="book_photo">
								
								<li>
									<a href="">
										<span class="con-image">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
										</span>
										<span class="con-title">1진정성 마케팅 ...</span>
									</a>
								</li>

								<li>
									<a href="">
										<span class="con-image">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
										</span>
										<span class="con-title">주식회사 히어로즈 : ...</span>
									</a>
								</li>

							</ul>
						</div>

						<div class="box con" data-tab="tab2" style="display:none;">
							<ul class="book_photo">
								
								<li>
									<a href="">
										<span class="con-image">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
										</span>
										<span class="con-title">2진정성 마케팅 : 끌리...</span>
									</a>
								</li>
								
								<li>
									<a href="">
										<span class="con-image">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
										</span>
										<span class="con-title">주식회사 히어로즈 : ...</span>
									</a>
								</li>

							</ul>
						</div>

					</div>
				</div>

				<div class="center-box">
					<div class="search-box">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
							<input type="hidden" name="menu_idx" value="13">
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
							<b>자주찾는 검색어</b> <span class="key-word"><a href="">아몬드</a>   <a href="">수학도둑</a>   <a href="">내일은 실험왕</a></span>      
						</div>
					</div>

					<div class="notice-box">
						<h2>공지사항</h2>
						<a href="#" class="btn-more btn-b top30">더보기</a>
						<div class="cont">
							<ul>

								<li>
								<a href="#"><em class="noti">공지</em>문화가 있는 날, 두배로 대출데이! (추석연휴로 인해 날짜 변경)<span>2020-09-01</span></a>
								</li>
								
								<li>
								<a href="#"><em class="noti">공지</em>2020년 "9월 독서의 달" 행사 축소 운영<span>2020-08-26</span></a>
								</li>
								
								<li>
								<a href="#"><em class="">공지</em>‘사회적거리두기 2단계’격상에 따른 안동시립도서관 부분개관 변경 운영<span>2020-08-22</span></a>
								</li>
								
								<li>
								<a href="#"><em class="">공지</em>안동시립중앙도서관 기간제근로자(도서관 운영보조) 채용 공고<span>2020-08-19</span></a>
								</li>
								
								<li>
								<a href="#"><em class="">공지</em>‘사회적거리두기 2단계’격상에 따른 안동시립도서관 부분개관 변경 운영<span>2020-08-22</span></a>
								</li>

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
								<li>
									<a href="#">
										<!-- 상영일 처리 -->
										<span class="view-date">
											08/31
										</span>

										<span class="movieImg">
											<img src="https://image.aladin.co.kr/product/1561/64/cover/8983946946_1.jpg" alt="광고의 비밀 : 왜 자꾸 사고 싶을까?" class="book_img"/>
										</span>

										<span class="movieEx1">광고의 비밀 : 왜 자...</span>
										<span class="movieEx2">전체관람가</span>
									</a>
								</li>
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
							<li class="on"><a href="#tab1" class='t-tabs'>문화행사</a></li>
							<li><a href="#tab2" class='t-tabs'>평생학습프로그램</a></li>
						</ul>

						<div class="box cont" data-tab="tab1">

							<ul>

								<li>
									<a href="#"><em>접수중</em>[동화구연] 도서관에서 만나는 그림책 이야기이야기이야기이야기이야기이야기이야기이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

								<li>
									<a href="#"><em>대기</em>[동화구연] 도서관에서 만나는 그림책 이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

								<li>
									<a href="#"><em>마감</em>[동화구연] 도서관에서 만나는 그림책 이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

							</ul>

						</div>

						<div class="box cont" data-tab="tab2" style="display:none;">
							<ul>

								<li>
									<a href="#"><em>마감</em>[동화구연] 도서관에서 만나는 그림책 이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

								<li>
									<a href="#"><em>접수중</em>[동화구연] 도서관에서 만나는 그림책 이야기이야기이야기이야기이야기이야기이야기이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

								<li>
									<a href="#"><em>대기</em>[동화구연] 도서관에서 만나는 그림책 이야기<br class="qmobileBr"/><span><b>접수</b> 2020-08-20 ~ 2020-09-15</span></a>
								</li>

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
						<ul class="banner-roll">
<li>
<span>
<a href="https://www.nl.go.kr/NL/contents/N30502000000.do" target="_blank">
<img src="/data/banner/h44/1603356355606" alt="사서에게물어보세요"/></a></span></li>
<li>
<span>
<a href="https://www.nl.go.kr/nill/user/index.jsp" target="_blank">
<img src="/data/banner/h44/1603356386948" alt="책바다"/></a></span></li>
<li>
<span>
<a href="http://www.dalseonglib.kr/img/main/book.pdf" target="_blank">
<img src="/data/banner/h44/1603356403093" alt="책나래"/></a></span></li>
<li>
<span>
<a href="http://www.dsart.or.kr/index.php" target="_blank">
<img src="/data/banner/h44/1603356421375" alt="달성문화재단"/></a></span></li>
<li>
<span>
<a href="https://www.dalseong.daegu.kr/" target="_blank">
<img src="/data/banner/h44/1603356434808" alt="달성군"/></a></span></li></ul>

					</div>
				</div>

			</div>
		</div>

	</div>

	<tiles:insertAttribute name="footer" />

</div>

</body>
</html>