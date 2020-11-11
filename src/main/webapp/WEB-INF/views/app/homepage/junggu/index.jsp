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
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="title-box">통합자료검색</div>
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">검색</button>
							</div>
						</fieldset>
					</form>
				</div>

				<div class="conts-box">

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
					</div>

					<div class="right-box">
						<div class="qmenu">
							<ul>
								<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
							</ul>
						</div>

						<div class="notice-box">
							<h2>공지사항</h2>
							<a href="#" class="btn-more">더보기</a>
							<div class="cont">
								<ul>

									<li>
									<a href="#"><em class="junggu0001">영어</em>문화가 있는 날, 두배로 대출데이! (추석연휴로 인해 날짜 변경)<span>2020-09-01</span></a>
									</li>
									
									<li>
									<a href="#"><em class="junggu0001">영어</em>2020년 “9월 독서의 달 ” 행사 축소 운영<span>2020-08-26</span></a>
									</li>
									
									<li>
									<a href="#"><em class="junggu0000">공통</em>‘사회적거리두기 2단계’격상에 따른 안동시립도서관 부분개관 변경 운영<span>2020-08-22</span></a>
									</li>
									
									<li>
									<a href="#"><em class="junggu0002">동인</em>안동시립중앙도서관 기간제근로자(도서관 운영보조) 채용 공고<span>2020-08-19</span></a>
									</li>
									
									<li>
									<a href="#"><em class="junggu0004">삼덕</em>‘사회적거리두기 2단계’격상에 따른 안동시립도서관 부분개관 변경 운영<span>2020-08-22</span></a>
									</li>

								</ul>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>


		<div class="main2">
			<div class="section">
				<div class="book-box tabS">
					<ul class="tabMenuS">
						<li class="on"><a href="#tab1" class='t-tabs'>추천도서</a></li>
						<li><a href="#tab2" class='t-tabs'>신착도서</a></li>
					</ul>
					<a href="#" class="btn-more2">더보기</a>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">1진정성 마케팅 ...</span>
									<span class="con-author">김상훈,박선미 공저...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
									<span class="con-author">기타가와 에미 지음 ;...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
									<span class="con-author">Jonathan Abr...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">초록 자전거...</span>
									<span class="con-author">이상교 글 ; 오정택 ...</span>
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
									<span class="con-author">김상훈,박선미 공저...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
									<span class="con-author">기타가와 에미 지음 ;...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
									<span class="con-author">Jonathan Abr...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">초록 자전거...</span>
									<span class="con-author">이상교 글 ; 오정택 ...</span>
								</a>
							</li>
							
						</ul>
					</div>

				</div>

				<div class="calendar-box" id="holiday-box">
				</div>
			</div>
		</div>

		<div class="main3">
			<div class="section">
				<div class="banner-wrap type5">
					<div class="banner-t5">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
							<a class="stop active" href="#stop"><img src="/resources/homepage/${homepage.context_path}/img/banner-stop.png" alt="정지" /><span class="blind">정지</span></a>
							<a class="play" href="#play"><img src="/resources/homepage/${homepage.context_path}/img/banner-start.png" alt="시작" /><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><img src="/resources/homepage/${homepage.context_path}/img/banner-more.png" alt="더보기" /><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box5">
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