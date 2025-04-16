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
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.swiper.css"/>
<style>
	#fp-nav.fp-right{right:95%;}
</style>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.swiper.min.js"></script>
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

		$('div#calendar-box').load('calendar3.do?homepage_id=h73');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

	$('li#menu_147').css('display','none');
	$('li.menu_147').css('display','none');
	$('li#menu_148').css('display','none');
	$('li.menu_148').css('display','none');
	$('li#menu_149').css('display','none');
	$('li.menu_149').css('display','none');
	$('li#menu_150').css('display','none');
	$('li.menu_150').css('display','none');

});
</script>

<style>
	#header .head {position:relative;z-index:20;clear:both;background-color:rgba(0, 0, 0, 0.2);}
</style>


<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-visual">

				<div class="swiper-container mySwiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide mvimg01"><div class="mvText"><img src="/resources/homepage/${homepage.context_path}/img/main_txt_sm.png"><p class="main_text">대구동구도서관</p></div></div>
						<div class="swiper-slide mvimg02"><div class="mvText"><img src="/resources/homepage/${homepage.context_path}/img/main_txt_sm.png"><p class="main_text">대구동구도서관</p></div></div>
						<!-- <div class="swiper-slide mvimg03"><div class="mvText"><img src="/resources/homepage/${homepage.context_path}/img/main_txt_sm.png"><p class="main_text">대구동구도서관</p></div></div> -->
					</div>
				</div>

				<!-- main_search -->
				<div class="search-area" id="main_search">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
					<input type="hidden" name="menu_idx" value="9">
					<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
					<input type="hidden" name="libraryCodes" value="CA">
					<input type="hidden" name="libraryCodes" value="CB">
					<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="main-box">
							<!-- <select id="search_type" name="search_type" class="search_type">
								<option value="L_TITLE">전체</option>
								<option value="L_AUTHOR">저자</option>
								<option value="L_PUBLISHER">발행처</option>
								<option value="L_KEYWORD">키워드</option>
							</select> -->
							<div class="box1">
								<div>
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
								</div>
							</div>
							<button id="main-search-btn"></button>
						</div>
					</fieldset>
					</form>
				</div>
				<!-- //Main_search -->

				<!--quick-->
				<div class="quickmenu-box">
					<div class="main-box">
						<div class="qmenu">
							<ul>
								<li class="qm1">
									<a href="/${homepage.context_path}/html.do?menu_idx=162">
										<span>희망도서</span>
									</a>
								</li>
								<li class="qm2">
									<a href="/${homepage.context_path}/module/teach/index.do?menu_idx=28">
										<span>문화행사</span>
									</a>
								</li>
								<li class="qm3">
									<a href="/${homepage.context_path}/html.do?menu_idx=107">
										<span>휴먼북</span>
									</a>
								</li>
								<li class="qm4">
									<a href="/${homepage.context_path}/html.do?menu_idx=19">
										<span>책나래</span>
									</a>
								</li>
								<li class="qm5">
									<a href="/${homepage.context_path}/html.do?menu_idx=39">
										<span>자원봉사</span>
									</a>
								</li>
								<li class="qm6">
									<a href="/${homepage.context_path}/html.do?menu_idx=33">
										<span>독서회</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!--//quick-->

				<div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section'>
				
				<div class="notice_popup_wrap">
					<div class="notice-box tabS">
						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=614" class='t-tabs'>공지사항</a></li>
							<li><a href="#tab2" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=28" class='t-tabs'>문화행사</a></li>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=614" class="btn-more2 more-more">더보기</a>
						</ul>

						<div class="news con" data-tab="tab1">
							<div class="box">
								<ul>
									<c:forEach items="${noticeList}" var="i" varStatus="status">
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=614&board_idx=${i.board_idx}">
												<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
												<span class="title">${i.title}</span><br />
												<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>

						<div class="news con" data-tab="tab2" style="display:none;">
							<div class="culture-box box">
								<ul>
									<c:forEach items="${teachList}" var="i" varStatus="status" begin="0" end="3">
										<c:if test="${i.homepage_id eq 'h73'}">
											<c:set var="libcode" value="ansim"></c:set>
											<c:set var="libname" value="안심"></c:set>
										</c:if>
										<c:if test="${i.homepage_id eq 'h59'}">
											<c:set var="libcode" value="sincheon"></c:set>
											<c:set var="libname" value="신천"></c:set>
										</c:if>
										<c:if test="${i.homepage_id eq 'h60'}">
											<c:set var="libcode" value="small"></c:set>
											<c:set var="libname" value="작은"></c:set>
										</c:if>
										<li class="${libcode}">
											<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=28&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}">
												<span class="ca">${libname}</span>
												<c:set var="teachDate" value="${fn:split(i.start_date, '-')}"></c:set>
												<span class="title">${i.teach_name}</span><br />
												<span class="date">${teachDate[0]}-${teachDate[1]}-${teachDate[2]}</span>
												<c:if test="${i.teach_status eq '0'}">
													<p class="one-status-box status002">접수</p>
												</c:if>
												<c:if test="${i.teach_status eq '1'}">
													<p class="one-status-box status001">대기</p>
												</c:if>
												<c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}">
													<p class="one-status-box status002">접수</p>
												</c:if>
												<c:if test="${i.teach_status eq '3'}">
													<p class="one-status-box status002">접수</p>
												</c:if>
												<c:if test="${i.teach_status eq '9'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '4'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '5'}">
													<p class="one-status-box status003">마감</p>
												</c:if>
												<c:if test="${i.teach_status eq '6'}">
													<p class="one-status-box status003">대기</p>
												</c:if>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					
					<!--달력-->
					<div class="calendar-box pcmode" id="calendar-box">
					</div>
					<!--//달력-->
				</div>

				<div class="popupzone-box">
					<span>팝업존</span>
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="등록된 팝업이 없습니다." /></a></li>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="등록된 팝업이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<!--달력-->
			<div class="calendar-box mmode" id="calendar-box">
			</div>
			<!--//달력-->

			<!-- <div class="main_scroll"><div class="main_scroll_wp">scroll down</div></div> -->
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">
			<div class='main-section'>

				<div class="book_title_box">
					<img src="/resources/homepage/${homepage.context_path}/img/section03-tit-bg.png">
					<p>무슨 책을 읽을까?</p>
					<h2>추천도서</h2>
					<ul class="pcmode02">
						<li onclick="/${homepage.context_path}/board/index.do?menu_idx=90&manage_idx=611"><span>어린이도서</span></li>
						<li onclick="/${homepage.context_path}/board/index.do?menu_idx=91&manage_idx=612"><span>성인도서</span></li>
					</ul>
				</div>

				<div class="book_box book_box_mb">
					<ul class="book_photo">
						<c:forEach items="${bookList1}" var="i" varStatus="status">
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=90&manage_idx=611&board_idx=${i.board_idx}">
								<span class="cate01">어린이</span>
								<span class="con-image01">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<img src="${i.preview_img}" alt="${i.title}" />
												</c:when>
												<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
													<img src="${i.preview_img}" alt="${i.title}" />
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
										</c:otherwise>
									</c:choose>
								</span>
								<span class="con-title">${fn:length(i.title) > 8 ? fn:substring(i.title, 0, 8) : i.title}<c:if test="${fn:length(i.title) > 8 }">...</c:if></span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>

				<div class="sns_title_box">
					<img src="/resources/homepage/${homepage.context_path}/img/section03-tit-bg.png">
					<p>대구동구도서관<br />소셜네트워크 서비스</p>
					<h2>SNS</h2>
					<ul>
						<li>
							<a class="sns_facebook" href="https://www.facebook.com/ansimlib" target="_blank">
								<span>FACEBOOK</span>
							</a>
						</li>
						<li>
							<a class="sns_kakaostory" href="http://pf.kakao.com/_Mxdlzj" target="_blank">
								<span>KAKAOCHANNEL</span>
							</a>
						</li>
						<li>
							<a class="sns_youtube" href="https://www.youtube.com/channel/UC9147s-XuHgcUnTwBTm--og" target="_blank">
								<span>YOUTUBE</span>
							</a>
						</li>
						<li>
							<a class="sns_naverblog" href="https://blog.naver.com/ansimlib" target="_blank">
								<span>NAVERBLOG</span>
							</a>
						</li>
						<li>
							<a class="sns_instagram_ansim" href="https://www.instagram.com/ansim_lib/" target="_blank">
								<span>INSTAGRAM</span>
							</a>
						</li>
						<li>
							<a class="sns_instagram_sincheon" href="https://www.instagram.com/sincheon_lib/" target="_blank">
								<span>INSTAGRAM</span>
							</a>
						</li>
					</ul>
				</div>

				<div class="book_box book_box_mt">
					<ul class="book_photo">
						<c:forEach items="${bookList2}" var="i" varStatus="status">
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=91&manage_idx=612&board_idx=${i.board_idx}">
								<span class="cate02">성인</span>
								<span class="con-image02">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<img src="${i.preview_img}" alt="${i.title}" />
												</c:when>
												<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
													<img src="${i.preview_img}" alt="${i.title}" />
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
										</c:otherwise>
									</c:choose>
								</span>
									<span class="con-title">${fn:length(i.title) > 8 ? fn:substring(i.title, 0, 8) : i.title}<c:if test="${fn:length(i.title) > 8 }">...</c:if></span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>

			</div>

			<!-- <div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div> -->
		</div>
		<!-- //main2 -->


		<!-- main3 -->
		<div class="section main3" id="main3">

			<div class="main-section">
				<div class="library_box">
					<h4>도서관안내</h4>
					<p>지도의 아이콘을 클릭하시면 해당 도서관의 간략 정보를 확인하실 수 있습니다.</p>
				</div>
				<script>
				$(function() {
					$('.divbInfomationConts').hide();
					$('.divbInfomationContsDetail').hide();
					$('#divbInfo1').show();
					$('#divbInfoDetail1').show();

					$(".maps").on("click", function(e){
						e.preventDefault();
						var libCode = $(this).data('value');
						$("#librarySelectBox > option[value='"+libCode+"']").attr("selected", "selected");
						$('.divbInfomationConts').hide();
						$('#divbInfo'+libCode).show();
						$('.divbInfomationContsDetail').hide();
						$('#divbInfoDetail'+libCode).show();
					});

					$("#librarySelectBox").on("change", function(e) {
						e.preventDefault();
						var libCode = $(this).val();
						$('.divbInfomationConts').hide();
						$('#divbInfo'+libCode).show();
						$('.divbInfomationContsDetail').hide();
						$('#divbInfoDetail'+libCode).show();
					});

				});
				</script>
				<div class="map-area">
					<div class="map-box">
						<img src="/resources/homepage/${homepage.context_path}/img/main-map.png" id="mapImg" alt="대구 동구 지도" title="대구 동구 지도" border="0" usemap="#Map" />
						<map name="Map" id="Map">
						<area shape="rect" coords="287,395,306,423" href="#lib-selector" alt="(공공)안심도서관" class="maps" data-value="1"/>
						<area shape="rect" coords="47,372,61,401" href="#lib-selector" alt="(공공)신천도서관" class="maps" data-value="2"/>
						<area shape="rect" coords="21,366,35,386" href="#lib-selector" alt="(공립)신암2동 작은도서관" class="maps" data-value="3"/>
						<area shape="rect" coords="50,341,63,361" href="#lib-selector" alt="(공립)신암3동 작은도서관" class="maps" data-value="4"/>
						<area shape="rect" coords="71,359,84,380" href="#lib-selector" alt="(공립)신천3동 작은도서관" class="maps" data-value="5"/>
						<area shape="rect" coords="127,354,141,374" href="#lib-selector" alt="(공립)효목1동 작은도서관" class="maps" data-value="7"/>
						<area shape="rect" coords="107,359,120,380" href="#lib-selector" alt="(공립)효목2동 작은도서관" class="maps" data-value="8"/>
						<area shape="rect" coords="177,231,191,252" href="#lib-selector" alt="(공립)도평동 작은도서관" class="maps" data-value="9"/>
						<area shape="rect" coords="101,216,114,237" href="#lib-selector" alt="(공립)불로어울림 작은도서관" class="maps" data-value="10"/>
						<area shape="rect" coords="108,307,122,328" href="#lib-selector" alt="(공립)지저동 작은도서관" class="maps" data-value="11"/>
						<area shape="rect" coords="142,319,156,340" href="#lib-selector" alt="(공립)동촌역사 작은도서관" class="maps" data-value="12"/>
						<area shape="rect" coords="177,336,191,355" href="#lib-selector" alt="(공립)방촌동 작은도서관" class="maps" data-value="13"/>
						<area shape="rect" coords="202,325,216,346" href="#lib-selector" alt="(공립)해안동 작은도서관" class="maps" data-value="14"/>
						<area shape="rect" coords="345,380,359,400" href="#lib-selector" alt="(공립)반야월역사 작은도서관" class="maps" data-value="15"/>
						<!-- <area shape="rect" coords="106,338,9.5" href="#lib-selector" alt="(공립)동구청 작은도서관" class="maps" data-value="16"/> -->
						<area shape="rect" coords="89,352,95,357" href="#lib-selector" alt="(사립)신암5동 작은도서관" class="maps" data-value="17"/>
						<!--<area shape="rect" coords="192,356,198,362" href="#lib-selector" alt="(사립)방촌어린이도서관" class="maps" data-value="18"/>-->
						<area shape="rect" coords="248,426,254,432" href="#lib-selector" alt="(사립)율하5주민도서관" class="maps" data-value="19"/>
						<area shape="rect" coords="356,405,362,411" href="#lib-selector" alt="(사립)꿈날자문고" class="maps" data-value="20"/>
						<area shape="rect" coords="68,391,73,397" href="#lib-selector" alt="(사립)행복도서관" class="maps" data-value="21"/>
						<area shape="rect" coords="134,336,140,342" href="#lib-selector" alt="(사립)늘푸른 도서관" class="maps" data-value="22"/>
						<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
						<!-- <area shape="rect" coords="337,413,7" href="#lib-selector" alt="(사립)초록우산도서관" class="maps" data-value="23"/> -->
						<area shape="rect" coords="388,459,394,464" href="#lib-selector" alt="금강역스마트도서관" class="maps" data-value="24"/>
						<area shape="rect" coords="94,361,100,367" href="#lib-selector" alt="동대구역스마트도서관" class="maps" data-value="25"/>
						<area shape="rect" coords="62,371,67,376" href="#lib-selector" alt="동구청스마트도서관" class="maps" data-value="26"/>
						<area shape="rect" coords="150,351,161,364" href="#lib-selector" alt="동촌역스마트도서관" class="maps" data-value="27"/>
						</map>
					</div>
					<div class="map-info">
					</div>
				</div>
				<div class="info-area">
					<div class="box">
						<ul>
							<li>
								<select name="librarySelectBox" id="librarySelectBox" class="librarySelectBox">
									<option value="1">(공공)안심도서관</option>
									<option value="2">(공공)신천도서관</option>
									<option value="3">(공립)신암2동 작은도서관</option>
									<option value="4">(공립)신암3동 작은도서관</option>
									<option value="5">(공립)신천3동 작은도서관</option>
									<!-- <option value="6">(공립)신천4동 작은도서관</option> -->
									<option value="7">(공립)효목1동 작은도서관</option>
									<option value="8">(공립)효목2동 작은도서관</option>
									<option value="9">(공립)도평동 작은도서관</option>
									<option value="10">(공립)불로어울림 작은도서관</option>
									<option value="11">(공립)지저동 작은도서관</option>
									<option value="12">(공립)동촌역사 작은도서관</option>
									<option value="13">(공립)방촌동 작은도서관</option>
									<option value="14">(공립)해안동 작은도서관</option>
									<option value="15">(공립)반야월역사 작은도서관</option>
									<!-- <option value="16">(공립)동구청 작은도서관</option> -->
									<option value="17">(사립)신암5동 작은도서관</option>
									<!--<option value="18">(사립)방촌어린이도서관</option>-->
									<option value="19">(사립)율하5주민도서관</option>
									<option value="20">(사립)꿈날자문고</option> 
									<option value="21">(사립)행복도서관</option>
									<option value="22">(사립)늘푸른 도서관</option>
									<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
									<!-- <option value="23">(사립)초록우산도서관</option> -->
									<option value="24">금강역스마트도서관</option>
									<option value="25">동대구역스마트도서관</option>
									<option value="26">동구청스마트도서관</option>
									<option value="27">동촌역스마트도서관</option>
								</select>
							</li>
							<li>
								<div class="divbInfomationConts" id="divbInfo1">
									대구광역시 동구 금호강변로 360<br/>053-980-2600
								</div>
								<div class="divbInfomationConts" id="divbInfo2">
									대구광역시 동구 동부로 6길 65<br/>053-980-2600
								</div>
								<div class="divbInfomationConts" id="divbInfo3">
									대구광역시 동구 신성로 56<br/>(신암2동행정복지센터 2층)<br/>053-957-9755
								</div>
								<div class="divbInfomationConts" id="divbInfo4">
									대구광역시 동구 아양로8길 10-1<br/>(동구여성문화공간 3층)<br/>053-957-9756
								</div>
								<div class="divbInfomationConts" id="divbInfo5">
									대구광역시 동구 장등로 90<br/>(신천3동행정복지센터 3층)<br/>053-957-9757
								</div>
								<div class="divbInfomationConts" id="divbInfo6">
									대구광역시 동구 화랑로 3길 10-13<br/>(신천4 경로당 2층)<br/>070-4203-6859
								</div>
								<div class="divbInfomationConts" id="divbInfo7">
									대구광역시 동구 화랑로 41길 46<br/>(효목1동행정복지센터 2층)<br/>053-957-9758
								</div>
								<div class="divbInfomationConts" id="divbInfo8">
									대구광역시 동구 화랑로 25길 45<br/>(효목2동행정복지센터 1층)<br/>053-957-9759
								</div>
								<div class="divbInfomationConts" id="divbInfo9">
									대구광역시 동구 팔공로24길 171<br/>(도평동행정복지센터 3층)<br/>053-957-9760
								</div>
								<div class="divbInfomationConts" id="divbInfo10">
									대구광역시 동구 팔공로24길 5<br/>(불로전통시장 상인교육관 3층)<br/>053-957-9761
								</div>
								<div class="divbInfomationConts" id="divbInfo11">
									대구광역시 동구 해동로3길 80<br/>(지저동 행정복지센터 3층)<br/>053-957-9762
								</div>
								<div class="divbInfomationConts" id="divbInfo12">
									대구 동구 동촌역사로 3길 35<br/>053-957-9763
								</div>
								<div class="divbInfomationConts" id="divbInfo13">
									대구광역시 동구 동촌로 46길 2<br/>(방촌종합상가 2층)<br/>053-957-9764
								</div>
								<div class="divbInfomationConts" id="divbInfo14">
									대구광역시 동구 방촌로 29길 46<br/>(해안동 주민센터 3층)<br/>053-957-9765
								</div>
								<div class="divbInfomationConts" id="divbInfo15">
									대구광역시 동구 신서로 50<br/>(대구선2공원 내 철도역사 1동)<br/>053-957-9766
								</div>
								<!-- <div class="divbInfomationConts" id="divbInfo16">
									대구광역시 동구 아양로 207<br/>(동구청1층)<br/>053-662-2489
								</div> -->
								<div class="divbInfomationConts" id="divbInfo17">
									대구광역시 동구 아양로37길 92<br/>(신암5동 행정복지센터 2층)<br/>053-951-9111
								</div>
								<div class="divbInfomationConts" id="divbInfo18">
									대구광역시 동구 동촌로 46길 17<br/>053-981-8276
								</div>
								<div class="divbInfomationConts" id="divbInfo19">
									대구광역시 동구 율하서로59<br/>(율하휴먼시아5단지 관리실)<br/>053-965-5955
								</div>
								<div class="divbInfomationConts" id="divbInfo20">
									대구광역시 동구 안심로73길 22<br/>(롯데캐슬 레전드관리사무소)<br/>053-247-0755
								</div>
								<div class="divbInfomationConts" id="divbInfo21">
									대구광역시 동구 송라로2길 17-6<br/>(제일기독종합사회복지관)<br/>053-755-9392
								</div>
								<div class="divbInfomationConts" id="divbInfo22">
									대구광역시 동구 입석로 5<br/>(동촌종합사회복지관)<br/>053-983-8211
								</div>
								<div class="divbInfomationConts" id="divbInfo23">
									대구광역시 동구 율하동로 26길 67<br/>(대구종합사회복지관)<br/>053-964-3335
								</div>
								<div class="divbInfomationConts" id="divbInfo24">
									대구광역시 동구 금강로 153
								</div>
								<div class="divbInfomationConts" id="divbInfo25">
									대구광역시 동구 동대구로 550 제2맞이방 통로
								</div>
								<div class="divbInfomationConts" id="divbInfo26">
									대구광역시 동구 아양로 207 구청입구
								</div>
								<div class="divbInfomationConts" id="divbInfo27" style="padding: 32px 35px;">
									대구광역시 동구 해동로 197
								</div>
							</li>
						</ul>
					</div>

					<div class="box2">
						<div class="divbInfomationContsDetail" id="divbInfoDetail1">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 어린이자료실 09:00~18:00</dd>
									<dd>평일 종합자료실 09:00~22:00</dd>
									<dd>평일 디지털자료실 09:00~22:00</dd>
									<dd>주말 09:00~17:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 월요일</dd>
									<dd>일요일을 제외한 관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail2">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 어린이자료실 09:00~18:00</dd>
									<dd>평일 종합자료실 09:00~20:00</dd>
									<dd>주말 09:00~17:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 월요일</dd>
									<dd>일요일을 제외한 관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail3">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail4">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>09:00 ~ 18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail5">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~17:50</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail6">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail7">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail8">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail9">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail10">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 13:00~14:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail11">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail12">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 11:30~12:30</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail13">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 13:00~14:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail14">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 12:00~13:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail15">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
									<dd>점심시간 13:00~14:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail16">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail17">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail18">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>※ 임시휴관중</dd>
									<!-- <dd>평일 09:00~18:00</dd> -->
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail19">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>화, 목, 금 14:00~17:00(월 10회)</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 월, 수, 토, 일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail20">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>※ 임시휴관중</dd>
									<!-- <dd>평일 09:00~18:00</dd> -->
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail21">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 13:00 -18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail22">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail23">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail24">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 : 10:00 ~ 21:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>연중 무휴</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail25">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 : 06:00 ~ 24:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>연중 무휴</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail26">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 : 24시간</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>연중 무휴</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail27">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 : 05:30~23:30</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>연중 무휴</dd>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="end"></div>
			
			<div class="banner-box">
				<div class="main-section">

					<div class="main7_banner">
						<div class="banner-wrap type5">
							<div class="banner-t5">
								<div class="control">
									<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
									<a class="stop active" href="#stop"><img src="/resources/homepage/${homepage.context_path}/img/banner-stop.png" alt="정지" /><span class="blind">정지</span></a>
									<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
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
		</div>
		<!-- //main3 -->

		<!-- footer_section -->
		<div class="section fp-auto-height footer_area" id="foot_section">
			<tiles:insertAttribute name="footer" />
		</div>
		<!-- //footer_section -->


	</div>

</div>


</body>
</html>


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage', '3rdPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css('border-bottom','0');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','#2a2e37');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#2a2e37');
			}	else if( destination.index == 2 ) {				
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#2a2e37');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#2a2e37');
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#2a2e37');
			}
		},
		afterResponsive: function(isResponsive){}
	});
};

fullPage();

// 모바일일 경우 fullpage 미사용
if ( $(window).width() < 1025 ) {
	if ($('#fullpage').hasClass('fp-destroyed')){
	} else {
		fullpage_api.destroy('all');
	}
} else {
	fullPage();
};

// 리사이즈 될때 모바일 화면에서 fullpage 미사용
$( window ).resize( function(e) {
	if ( $(window).width() < 1025 ) {
		if ($('#fullpage').hasClass('fp-destroyed')){
		} else {
			fullpage_api.destroy('all');
		}
	} else {
		fullPage();
	};
});
</script>
<script>
    var mySwiper = new Swiper('.mySwiper', {
      spaceBetween: 30,
      centeredSlides: true,
      autoplay: {
        delay: 5000,
        disableOnInteraction: false,
      },
	  effect: 'fade',
	  loop: true,
      pagination: {
        el: '.swiper-pagination',
        type: 'fraction',
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
	$('.start').on('click', function(){
		mySwiper.autoplay.start();
		return false;
	})
	$('.stop').on('click', function(){
		mySwiper.autoplay.stop();
		return false;
	});

</script>
