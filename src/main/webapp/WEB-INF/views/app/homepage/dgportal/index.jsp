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


		$('div.holiday-box').load('calendar2.do');
		$('div.event-box').load('calendar4.do');
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

function searchCheck() {
	$('input#search_text_1').attr('name', $('select#search_type').val());
}
</script>
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container" class="main container">

		<div class="main0">
			<div class="section">
				<div class="popZone">
					<c:choose>
						<c:when test="${fn:length(popupZoneList) > 0}">
							<homepageTag:popupZone popupZoneList="${popupZoneList}" />
						</c:when>
						<c:otherwise>
							<ul>
								<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupzone-img01.png" alt="등록된 팝업존이 없습니다." /></a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<div class="main1">
			<div class="quickmenu">
				<div class="section">
					<ul>
						<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
					</ul>
				</div>
				<div class="end"></div>
			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="title">
						<h2><b>주요서비스</b></h2>
						<p>대구광역시통합도서관 주요서비스 입니다</p>
					</div>
					<div class="cont">
						<ul>
							<li><a href="#"><strong class="quick-01"></strong><span class="">통합자료검색</span></a></li>
							<li class="txt-line"></li>
							<li><a href="#"><strong class="quick-02"></strong><span class="">대구BOOK</span></a></li>
							<li class="txt-line"></li>
							<li><a href="#"><strong class="quick-03"></strong><span class="">대구전자도서관</span></a></li>
						</ul>
					</div>
				</div>

				<div class="main2box2">
					<div class="title">
						<h2><b>추천도서</b></h2>
						<p>
							<select id="recommendSite1" class="recommendSite1">
								<option value="">도서관을 선택해주세요.</option>
								<option value="AD">중앙도서관</option>
								<option value="AB">두류도서관</option>
								<option value="AH">동부도서관</option>
								<option value="AF">서부도서관</option>
								<option value="AG">남부도서관</option>
								<option value="AC">북부도서관</option>
								<option value="AJ">달성도서관</option>
								<option value="AE">수성도서관</option>
								<option value="AA">228기념학생도서관</option>
								<option value="AL">228민주운동기념회관</option>
							</select>
						</p>
					</div>
					<div class="book">
						<div class="box con">
							<ul class="book_photo newBookUl">

							</ul>
						</div>
					</div>

				</div>

				<div class="end"></div>
			</div>
		</div>


		<div class="main3">
			<div class="sectionx">

				<div class="title">
					대구통합도서관의<br/>
					<b>독서문화행사</b>
					<em>우리 도서관에는<br/>
					어떤 강좌가 있을까?</em><br/><br/>
					<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/culture-icon.png" alt="독서문화행사 안내"></a>
				</div>

				<div class="cont cultureList">
					<ul>
						<li>
						<a href="${i.imsi_v_1}" class="border${i.category1} bgimg001">
							<span class="txt">
								<p class="lib-name">중앙도서관1</p>
								<p class="tit">영어뮤지컬<br/>갈라콘서트</p>
								<p class="len"><b>접수</b><br/>2020.01.08 ~ 2020.01.10</p>
							</span>
							<span class="btnn"><img src="/resources/homepage/${homepage.context_path}/img/more-culture-btn.png" alt="신청하기"></span>
						</a>
						</li>
						<li>
						<a href="${i.imsi_v_1}" class="border${i.category1} bgimg002">
							<span class="txt">
								<p class="lib-name">중앙도서관</p>
								<p class="tit">영어뮤지컬<br/>갈라콘서트</p>
								<p class="len"><b>접수</b><br/>2020.01.08 ~ 2020.01.10</p>
							</span>
							<span class="btnn"><img src="/resources/homepage/${homepage.context_path}/img/more-culture-btn.png" alt="신청하기"></span>
						</a>
						</li>
						<li>
						<a href="${i.imsi_v_1}" class="border${i.category1} bgimg003">
							<span class="txt">
								<p class="lib-name">중앙도서관</p>
								<p class="tit">영어뮤지컬<br/>갈라콘서트</p>
								<p class="len"><b>접수</b><br/>2020.01.08 ~ 2020.01.10</p>
							</span>
							<span class="btnn"><img src="/resources/homepage/${homepage.context_path}/img/more-culture-btn.png" alt="신청하기"></span>
						</a>
						</li>
						<li>
						<a href="${i.imsi_v_1}" class="border${i.category1} bgimg004">
							<span class="txt">
								<p class="lib-name">중앙도서관</p>
								<p class="tit">영어뮤지컬<br/>갈라콘서트</p>
								<p class="len"><b>접수</b><br/>2020.01.08 ~ 2020.01.10</p>
							</span>
							<span class="btnn"><img src="/resources/homepage/${homepage.context_path}/img/more-culture-btn.png" alt="신청하기"></span>
						</a>
						</li>
					</ul>
				</div>

				<div class="end"></div>
			</div>
		</div>

		<div class="main4">
			<div class="section">
				<div class="section_story">
					<div class="title_bx">
						공지사항
					</div>

					<div class="story_list">
						<a href="#" class="more-notice"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기"></a>
						<ul class="clearfix list">
							<li>
								<a href="javascript:void(0);" class="wrap">
									<p class="tit title0001">2020년 겨울학기 영유아 독서문화프로그램 참가자..</p>
									<span class="date">2019.05.31</span>
								</a>
								<a href="#" class="link library0001">북부</a>
							</li>
										<li>
								<a href="javascript:void(0);" class="wrap">
									<p class="tit title0002">2020 작은도서관 찾아가는 지역작가와의</p>
									<span class="date">2019.03.23</span>
								</a>
								<a href="#" class="link library0002">두류</a>
							</li>
										<li>
								<a href="javascript:void(0);" class="wrap">
									<p class="tit title0003">2020 대구시립도서관 축제 안내</p>
									<span class="date">2019.02.18</span>
								</a>
								<a href="#" class="link library0003">동부</a>
							</li>
										<li>
								<a href="javascript:void(0);" class="wrap">
									<p class="tit title0004">2020년 하반기 작은도서관 관계자 연수 안내</p>
									<span class="date">2019.01.30</span>
								</a>
								<a href="#" class="link library0004">남부</a>
							</li>
						</ul>
					</div>

					<div class="site-recomender">
						<div class="site-recomender-inbox">
							<div class="title">
								<h2><b>이달의</b> 휴관일</h2>
								<p>
									<select id="recommendSite1" class="recommendSite1" style="color:#fff;">
										<option value="" style="color:#000;">도서관을 선택해주세요.</option>
										<option value="AD" style="color:#000;">중앙도서관</option>
										<option value="AB" style="color:#000;">두류도서관</option>
										<option value="AH" style="color:#000;">동부도서관</option>
										<option value="AF" style="color:#000;">서부도서관</option>
										<option value="AG" style="color:#000;">남부도서관</option>
										<option value="AC" style="color:#000;">북부도서관</option>
										<option value="AJ" style="color:#000;">달성도서관</option>
										<option value="AE" style="color:#000;">수성도서관</option>
										<option value="AA" style="color:#000;">228기념학생도서관</option>
										<option value="AL" style="color:#000;">228민주운동기념회관</option>
									</select>
								</p>
							</div>
							<div class="calendar-box">
								<span class="">1</span>
								<span class="">12</span>
								<span class="">30</span>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div class="main5">
			<div class="section">
				<div class="main7_banner">
					<div class="banner-wrap type3">
						<div class="banner-t6-left">
							<div class="control">
								<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
								<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a>
							</div>
						</div>
						<div class="banner-box6">
							<!-- <homepageTag:banner bannerList="${bannerList}"/> -->
							<ul class="banner-roll">
							<li>
							<span>
							<a target="_blank" href="http://book.nl.go.kr/iplls/Index.do">
							<img alt="책이음" src="/data/banner/h10/1579226827630"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="https://www.safetyreport.go.kr/#main">
							<img alt="안전신문고" src="/data/banner/h10/1579225804097"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="http://www.nl.go.kr/nl/index.jsp">
							<img alt="국립중앙도서관" src="/data/banner/h10/1579226089985"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="https://www.nanet.go.kr/main.do">
							<img alt="국회도서관" src="/data/banner/h10/1579226325578"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="https://www.kla.kr/jsp/main.do">
							<img alt="한국도서관" src="/data/banner/h10/1579226374166"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="http://www.dge.go.kr/main/main.do">
							<img alt="대구광역시교육청" src="/data/banner/h10/1579226606788"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="http://www.nl.go.kr/nill/user/">
							<img alt="책바다" src="/data/banner/h10/1579228091444"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href="http://dream.nl.go.kr/dream/chaeknarae">
							<img alt="책나래" src="/data/banner/h10/1579227302592"/></a></span></li>
							<li>
							<span>
							<a target="_blank" href=" http://www.daegu.go.kr/">
							<img alt="대구광역시" src="/data/banner/h10/1579227343291"/></a></span></li></ul>
						</div>
						<div class="banner-t6-right">
							<div class="control">
								<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
								<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
								<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<tiles:insertAttribute name="footer" />
</div>
