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

		$('div.calendar-box').load('calendar5.do?homepage_id=h1');
		
		$('ul.newBookUl').load('recommendBook.do?category2=${category2List[0].code_id}');
		$('select#recommendBook1').on('change', function() {
			$('ul.newBookUl').load('recommendBook.do?category2='+$(this).val());
		});
		
		$('select#holidaySite1').on('change', function() {
			$('div.calendar-box').load('calendar5.do?homepage_id='+$(this).val());
			var val = $(this).val();

			if (val == 'h1') {
				$('div.info-more-boxes a').attr('href', '/228/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h2') {
				$('div.info-more-boxes a').attr('href', '/228lib/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h3') {
				$('div.info-more-boxes a').attr('href', '/nambu/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h4') {
				$('div.info-more-boxes a').attr('href', '/dalseong/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h5') {
				$('div.info-more-boxes a').attr('href', '/dongbu/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h6') {
				$('div.info-more-boxes a').attr('href', '/duryu/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h7') {
				$('div.info-more-boxes a').attr('href', '/bukbu/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h8') {
				$('div.info-more-boxes a').attr('href', '/seobu/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h9') {
				$('div.info-more-boxes a').attr('href', '/suseong/module/calendarManage/index.do?menu_idx=63');

			} else if (val == 'h10') {
				$('div.info-more-boxes a').attr('href', '/jungang/module/calendarManage/index.do?menu_idx=63');

			}
		});

		$('select#recommendSite1').on('change', function() {
			if ($(this).val() != '') {
				window.open($(this).val());
			}
		});

		$('select#recommendSite2').on('change', function() {
			if ($(this).val() != '') {
				window.open($(this).val());
			}
		});

		$('.Gnb .gnb-menu > li.menu7').remove();
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
							<li><a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=7"><strong class="quick-01"></strong><span class="">통합자료검색</span></a></li>
							<li class="txt-line"></li>
							<li><a href="/${homepage.context_path}/html.do?menu_idx=8"><strong class="quick-02"></strong><span class="">대구BOOK</span></a></li>
							<li class="txt-line"></li>
							<li><a href="/${homepage.context_path}/elibsso.do?menu_idx=13"><strong class="quick-03"></strong><span class="">대구전자도서관</span></a></li>
						</ul>
					</div>
				</div>

				<div class="main2box2">
					<div class="title">
						<h2><b>추천도서</b></h2>
						<p>
							<select id="recommendBook1" class="recommendSite1">
								<c:forEach items="${category2List}" var="cate2">
								<option value="${cate2.code_id}" label="${cate2.code_name}">
								</c:forEach>
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
					<b>평생교육강좌</b>
					<em>우리 도서관에는<br/>
					어떤 강좌가 있을까?</em><br/><br/>
					<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=11&editMode=ALL"><img src="/resources/homepage/${homepage.context_path}/img/culture-icon.png" alt="독서문화행사 안내"></a>
				</div>

				<div class="cont cultureList">
					<ul>
						<c:forEach items="${teachList}" var="i" varStatus="status">
						<c:set var="imgnum" value="${(status.count % 8)+1}"></c:set>
						<li>
						<a href="/${i.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=${i.menu_idx}&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}" class="border bgimg00${imgnum}">
							<span class="txt">
								<p class="lib-name">${i.homepage_name}</p>
								<p class="tit">${fn:substring(i.teach_name, 0, 15)}<c:if test="${fn:length(i.teach_name) > 15}">...</c:if></p>
								<p class="len"><b>접수</b><br/>${i.start_join_date} ~ ${i.end_join_date}</p>
							</span>
							<span class="btnn"><img src="/resources/homepage/${homepage.context_path}/img/more-culture-btn.png" alt="신청하기"></span>
						</a>
						</li>
						</c:forEach>
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
						<a href="/${homepage.context_path}/board/index.do?menu_idx=22&manage_idx=282" class="more-notice"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기"></a>
						<ul class="clearfix list">
							<c:forEach items="${noticeBoardList}" var="i" varStatus="status">
							<li>
								<a href="/${i.imsi_v_19}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.imsi_n_2}" class="wrap">
									<p class="tit title${i.imsi_v_19}">${i.title}</p>
									<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
								</a>
								<a href="/${i.imsi_v_19}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.imsi_n_2}" class="link library${i.imsi_v_19}">${i.imsi_v_20}</a>
							</li>
							</c:forEach>
						</ul>
					</div>

					<div class="site-recomender">
						<div class="site-recomender-inbox">
							<div class="title">
								<h2><b>이달의</b> 휴관일</h2>
								<p>
									<select id="holidaySite1" class="holidaySite1" style="color:#fff;">
										<option value="h1" style="color:#000;">대구2·28기념학생도서관</option>
										<option value="h2" style="color:#000;">대구2·28민주운동기념회관</option>
										<option value="h3" style="color:#000;">대구광역시립 남부도서관</option>
										<option value="h4" style="color:#000;">대구광역시립 달성도서관</option>
										<option value="h5" style="color:#000;">대구광역시립 동부도서관</option>
										<option value="h6" style="color:#000;">대구광역시립 두류도서관</option>
										<option value="h7" style="color:#000;">대구광역시립 북부도서관</option>
										<option value="h8" style="color:#000;">대구광역시립 서부도서관</option>
										<option value="h9" style="color:#000;">대구광역시립 수성도서관</option>
										<option value="h10" style="color:#000;">대구광역시립 중앙도서관</option>
									</select>
								</p>
							</div>
							<div class="calendar-box">
							</div>

							<div class="info-more-boxes">
								<a href="/228/module/calendarManage/index.do?menu_idx=63"  target="_blank">휴관일 더보기</a>
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
							<homepageTag:banner bannerList="${bannerList}"/>
						</div>
						<div class="banner-t6-right">
							<div class="control">
								<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
								<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
								<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=61"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<tiles:insertAttribute name="footer" />
</div>
