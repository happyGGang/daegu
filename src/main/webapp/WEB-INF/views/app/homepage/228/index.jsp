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

		<div class="main1">
			<div class="section">
				<div class="main1box2">
					<div class="main1box2box1">
						<div class="main1box2box1box1">
							<ul>
								<li class="bg-lgray">
									<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16">
									<span class="wt">대출/예약현황</span>
									<span class="wc">대출/예약 현황 조회<br/>하실 수 있습니다.</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick01-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lorange">
									<a href="/${homepage.context_path}/html.do?menu_idx=26">
									<span class="wt">희망도서신청</span>
									<span class="wc">원하시는 도서를<Br/>신청하세요.</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick02-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="/${homepage.context_path}/html.do?menu_idx=129">
									<span class="wt">2ㆍ28청소년존</span>
									<span class="wc">민주운동의 횃불 <br/>2·28</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick03-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-orange">
									<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30">
									<span class="wt">온라인강좌신청</span>
									<span class="wc">운영중인 프로그램을<br/>신청해보세요.</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick04-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-lgray">
									<a href="https://library.daegu.go.kr/228/html.do?menu_idx=114">
									<span class="wt" style="letter-spacing:-2px;font-size:120%;">스마트도서관</span>
									<span class="wc">도서관을 스마트하게<br/>이용해보세요.</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick05-bg.png" class="mi">
									</a>
								</li>
								<li class="bg-dorange">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=245&manage_idx=1018">
									<span class="wt">AI도서추천서비스</span>
									<span class="wc">빅데이터를 기반으로<br />책을 추천해드립니다.</span>
									<img src="/resources/homepage/${homepage.context_path}/img/quick06-bg.png" class="mi">
									</a>
								</li>
							</ul>
						</div>
						<div class="main1box2box1box2">
							<a href="/${homepage.context_path}/html.do?menu_idx=135">
								<div class="big-btn-box">
									<h2>
										<span>학교도서관지원서비스</span>
										<span class="second-line">학교도서관</span>
										<span class="third-line"><b>집중지원센터</b></span>
									</h2>
								</div>
							</a>
							<div class="big-btn-box box2">
								<h2>
									<span>디지털지식나눔터</span>
									<span class="second-line">대구학생</span>
									<span class="third-line"><b>전자도서관</b></span>
								</h2>
								<div class="link_box">
									<a href="https://dgelib.dkyobobook.co.kr" target="_blank" class="link01">바로가기 &gt;</a>
									<a href="https://dgelib.dkyobobook.co.kr/board/boardList.ink?blbrSrmb=5" target="_blank" class="link02">이용안내 &gt;</a>
								</div>
							</div>
						</div>
					</div>

					<div class="main1box2box2">
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="13">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="title-box">통합자료검색</div>
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
									</div>
								</fieldset>
							</form>
						</div>
					</div>
				</div>

				<div class="main1box1">
					<div class="quick-btn-box">
						<h2>
							<span>대구2ㆍ28기념학생도서관 사서가 추천하는</span>
							<span><b>사서&북큐레이션</b></span>
						</h2>
						<div class="top-btn-box">
							<ul>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=124&manage_idx=71">주제가 있는 책장(일반)</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=125&manage_idx=72">청소년, 내일을 위한 책</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=126&manage_idx=73">책이 나에게 말걸다(어린이)</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=127&manage_idx=74">초등교과연계도서</a></li>
							</ul>
						</div>
						<div class="bottom-btn-box">
							<ul>
								<li><a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14">신착도서</a></li>
								<li><a href="/${homepage.context_path}/board/index.do?menu_idx=41&manage_idx=75">추천도서</a></li>
							</ul>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box1">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="등록된 팝업이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="main2box2">
					<div class="notice">
						<div class="tabS">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=88" class='t-tabs'>공지사항</a></li>
								<li><a href="#tab2" data-link="/${homepage.context_path}/board/index.do?menu_idx=198&manage_idx=394" class='t-tabs'>행사안내</a></li>
								<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=88" class="more-btn more-more">더보기</a>
							</ul>
							
							<div class="news con" data-tab="tab1">
								<div class="box">
									<ul>
										<c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" >
										<li class="on-notice">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
										<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							
							<div class="news con" data-tab="tab2" style="display:none;">
								<div class="box">
									<ul>
										<c:forEach var="i" varStatus="status" items="${bidListTopNotice}" >
										<li class="on-notice">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=198&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
										<c:forEach var="i" varStatus="status" items="${bidList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=198&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="main2box3">
					<div class="calendar-box">
						<div class="title">
							<ul>
								<li><h2>도서관휴관일 및 일정</h2></li>
								<li><a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63"><img src="/resources/homepage/${homepage.context_path}/img/more_bt.png" alt="더보기"/></a></li>
							</ul>
						</div>

						<div class="cal-box">

						</div>
						<%-- 임시문구 --%>
						<div class="center">
						<!-- <p style="font-size:13px; color:#ff0000;margin-top:5px;"><strong>임시휴관</strong> 8.23.(일) ~ 별도 안내 시까지</p> -->
						</div>
						<%-- 임시문구 끝 --%>
					</div>
				</div>
			</div>
		</div>

		<div class="section">
			<div class="main7_banner">
				<div class="banner-wrap type1">
					<div class="banner-box2">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>

					<div class="banner-t2">
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a><br/>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="quick-slide">
			<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
			<ul>
				<li style="padding-bottom:10px;"><a href="http://dgelib.dkyobobook.co.kr" target="_blank"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick006-bg.png" alt="청소년자원봉사"></span><span class="txt">대구학생<br/>전자도서관</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick001-bg.png" alt="책바다"></span><span class="txt">책바다</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=49"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick002-bg.png" alt="책나래"></span><span class="txt">책나래</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=50"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick003-bg.png" alt="사서에게 물어보세요"></span><span class="txt">사서에게<br/>물어보세요</span></a></li>
				<li><a href="https://www.youth.go.kr/youth/" target="_blank"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick004-bg.png" alt="청소년자원봉사"></span><span class="txt">청소년<br/>자원봉사</span></a></li>
				<li><a href="http://seat.daegu.go.kr/wb_booking/?LIB_CODE=4" target="_blank"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick005-bg.png" alt="청소년자원봉사"></span><span class="txt">좌석예약<br/>시스템</span></a></li>
				<li><a href="http://www.dge.go.kr/press/main.do" target="_blank"><span class="img"><img src="/resources/homepage/${homepage.context_path}/img/quick007-bg.png" alt="대구교육기자단"></span><span class="txt">「대구교육」<br/>기자단</span></a></li>
			</ul>
		</div>

	</div>


<tiles:insertAttribute name="footer" />