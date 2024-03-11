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


		$('div.free_day p.date').load('calendar5.do?homepage_id=h72');
		$('div.box_all02').eq(1).load('newBook.do');
		// $('ul.bestBookUl').load('bestBook.do');
		$('ul#ul_noticeList').load('subNotice.do?manage_idx=740');
		$('ul#ul_eventList').load('subCalendar.do')

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

		$('select#sel_lib').on('change', function() {
			$(this).next('.date').load('calendar5.do?homepage_id='+$(this).val());
		});

		$('select#notice_cate').on('change', function() {
			$('ul#ul_noticeList').load('subNotice.do?manage_idx=740&category1='+$(this).val());
		});

		$('select#event_lib_anum').on('change', function() {
			$('ul#ul_eventList').load('subCalendar.do?homepage_id='+$(this).val());
			$('.cal-more').attr('href','/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36&homepage_id='+$(this).val());
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
		<!-- 메인영역 -->
		<div id="mvisual">
			<!-- 비주얼슬라이드 영역 -->
			<div class="main_swiper">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg01 bg_img">메인비주얼1</div>
					</div>
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg02 bg_img">메인비주얼2</div>
					</div>
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg03 bg_img">메인비주얼3</div>
					</div>
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg04 bg_img">메인비주얼4</div>
					</div>
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg05 bg_img">메인비주얼5</div>
					</div>
					<div class="swiper-slide">
						<div class="mtext">
							<p class="stxt"><span>달서, 책으로 희망을 품다</span></p>
							<p class="btxt">달서구립도서관에 오신것을 환영합니다.</p>
						</div>
						<div class="bg06 bg_img">메인비주얼5</div>
					</div>
				</div>
				<div class="contol">
					<div class="swiper-pagination"></div>
					<p class="swiper_play"><a href="javascript:;">시작</a></p>
					<p class="swiper_stop"><a href="javascript:;">멈춤</a></p>
				</div>
			</div>
			<div class="search_btn_wrap">
				<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
					<input type="hidden" name="menu_idx" value="9">
					<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
					<input type="hidden" name="libraryCodes" value="BU">
					<input type="hidden" name="libraryCodes" value="BV">
					<input type="hidden" name="libraryCodes" value="BW">
					<input type="hidden" name="libraryCodes" value="BX">
					<input type="hidden" name="libraryCodes" value="BY">
					<input type="hidden" name="libraryCodes" value="BZ">
					<input type="hidden" name="libraryCodes" value="FA">
					<input type="hidden" name="libraryCodes" value="FB">
					<input type="hidden" name="libraryCodes" value="FC">
					<input type="hidden" name="libraryCodes" value="FD">
					<input type="hidden" name="libraryCodes" value="FW">
					<input type="hidden" name="libraryCodes" value="FX">
					<input type="hidden" name="libraryCodes" value="GK">
					<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
				<div class="search_bar">
					<div class="search_bar_text">
						<!-- <label for="search_txt" class="search_m">검색어(도서명 등)를 입력해주세요.</label> -->
						<input type="text" name="title" class="search_text" id="search_text" value="" placeholder="검색어를 입력해주세요."/>
						<input type="submit" name="" id="main-search-btn" class="search_btn" value="검색" />
					</div>
				</div>
				</form>
				<div class="mvisual_btn">
					<ul>
						<li class="mbtn1"><a href="html.do?menu_idx=19">도서관이용</a></li>
						<li class="mbtn2"><a href="intro/search/loan/history.do?menu_idx=53">대출자료조회</a></li>
						<li class="mbtn3"><a href="module/teach/index.do?menu_idx=32&searchCate1=17&homepage_id=h72">수강신청</a></li>
						<li class="mbtn4"><a href="html.do?menu_idx=15">희망도서신청</a></li>
						<li class="mbtn5"><a href="#">책드림<span class="eng">(Dream)</span>서비스</a></li>
						<li class="mbtn6"><a href="html.do?menu_idx=112">디지털자료실예약</a></li>
						<li class="mbtn7"><a href="module/excursions/index.do?menu_idx=40">견학신청</a></li>
						<li class="mbtn8"><a href="html.do?menu_idx=41">자원봉사신청</a></li>
					</ul>
				</div>
			</div>
		</div>


		<script type="text/javascript">
			  var main_swiper = new Swiper('.main_swiper', {
				slidesPerView: 3,
				spaceBetween: 50,
				breakpoints: {
					1024: {
						slidesPerView: 1,
						spaceBetween:0
					}
				},
				centeredSlides: true,
				direction:'horizontal',
				loop: true,
				autoplay: {delay: 4500, disableOnInteraction: false,},
				speed:1000,
				pagination: {
					el: '.swiper-pagination',
					clickable: true,
				},
			});
			$('.swiper_play').click(function(e){
			main_swiper.autoplay.start();
		
			 $(".swiper_stop").css("display","inline-block");
			 $(".swiper_play").css("display","none");
			});
			 $('.swiper_stop').click(function(e){
				 main_swiper.autoplay.stop();
		
				 $(".swiper_stop").css("display","none");
				 $(".swiper_play").css("display","inline-block");
			});
			
		</script>
		<!-- 공지사항 -->


		<div class="main_notice_wrap">
			<div class="notice_wrap">
				<div class="mnotive_banner">
					
					<!-- 모바일회원증 -->			
					<div class="mobile_cd">
						<p class="tit">모바일 회원증</p>
						<p class="add_img_wrap">
							<a href="/dalseolib/intro/login/mobileCard.do?menu_idx=68" ><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="모바일 회원증 바로가기" /></a>
						</p>
					</div>
					<!-- //모바일회원증 -->
					
					
					<div class="free_day">
						<p class="tit">휴관일</p>
						<select id="sel_lib" name="personal_day">
							<option value="h72">도원</option>
							<option value="h67">성서</option>
							<option value="h68">본리</option>
							<option value="h69">달서가족문화</option>
							<option value="h66">달서어린이</option>
							<option value="h70">달서영어</option>
						</select>
						<p class="date">01, 02, 03, 05, 09</p>
						<p class="add_img_wrap">
							<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36"><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="휴관일 자세히보기" /></a>
						</p>
					</div>
					<div class="maraton_book">
						<p class="tit">달서독서마라톤</p>
						<p class="txt">달서구를 구민 또는 달서구 소재 재학생</p>
						<p class="add_img_wrap">
							<a href="html.do?menu_idx=102" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="독서마라톤 자세히보기" /></a>
						</p>
					</div>

				</div>

				<div class="notice_wrap">
					<!-- 새소식 안내 -->
					<div class="main_notice mnotice_li">
						<div class="notice_title_wrap mnotice_wrap">
							<h2>새소식 안내</h2>
							<select id="notice_cate" title="new_notice">
								<option value="" selected>전체</option>
								<option value="0000">통합</option>
								<option value="0001">도원</option>
								<option value="0002">성서</option>
								<option value="0003">본리</option>
								<option value="0004">달서가족문화</option>
								<option value="0005">달서어린이</option>
								<option value="0006">달서영어</option>
							</select>
						</div>
						<p class="notice_more"><a href="/${homepage.context_path}/board/index.do?manage_idx=740&menu_idx=35"><img src="/resources/homepage/${homepage.context_path}/img/notice_more.png" alt="새소식 안내 자세히보기"></a></p>

						<ul id="ul_noticeList" class="notice_text">
						</ul>

					</div>
					<!-- //새소식 안내 -->
					<!-- 이달의 행사 -->
					<div class="main_festival mnotice_li">
						<div class="festival_title_wrap mnotice_wrap">
							<h2>이달의 행사</h2>
							<select id="event_lib_anum" name="festival" title="month_festival">
								<option value="h72">도원</option>
								<option value="h67">성서</option>
								<option value="h68">본리</option>
								<option value="h69">달서가족문화</option>
								<option value="h66">달서어린이</option>
								<option value="h70">달서영어</option>
							</select>
						</div>

						<p class="notice_more">
							<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36&homepage_id=h72" class='cal-more'>
								<img src="/resources/homepage/${homepage.context_path}/img/notice_more.png" alt="이달의 행사 자세히보기">
							</a>
						</p>

						<ul id="ul_eventList" class="notice_text fes">
						</ul>
					</div>
					<!-- //이달의 행사 -->
				</div>
			</div>
			<div class="fr_cont">
				<!-- 팝업존 -->
				<div class="pop_w">
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupnone.jpg" alt="" /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- //팝업존 -->
			</div>
		</div>
		<!-- //공지사항 -->


		<!-- 지도보기 및 자료안내 -->
		<div class="guide_wrap">	
			<!-- 자료안내 -->
			<div class="data_look">
				<div class="dataBox movie">
					<div class="title">
						<h2>영화상영</h2>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=737" class="more-btn">더보기</a>
					</div>

					<c:forEach items="${movieList}" var="i" varStatus="status">
						<div class="box">
							<div class="data_img">
								<a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=737&board_idx=${i.board_idx}">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<img src="${i.preview_img}" alt="${i.title}" class="book_img" style="width:110px;height:170px;"/>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" class="book_img" style="width:110px;height:170px;"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noImg2.png" alt="${i.title}" class="book_img" style="width:110px;height:170px;">
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							<dl>
								<dt><a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=737&board_idx=${i.board_idx}">${i.title}</a></dt>
								<dd>${fn:split(i.imsi_v_1, '-')[1]}.${i.imsi_v_2}<span>${i.imsi_v_12}</span></dd>
							</dl>
						</div>
					</c:forEach>
					<c:if test="${fn:length(movieList) < 1}">
					<div class="box">
						<div class="data-img">
							<a href="javascript:alert('상영예정 영화가 없습니다.'); return false;">
								<img src="/resources/common/img/noImg2.png" alt="${i.title}">
							</a>
						</div>
						<dl>
							<dd>상영예정 영화가 없습니다.</dd>
						</dl>
					</div>
					</c:if>
				</div>
				<!-- -->
				
				
				<!--추천도서 신착도서 탭 메뉴 시작-->
				<div class="bookpick">

					<div class="book-box tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" class='t-tabs' data-link="/${homepage.context_path}/board/index.do?menu_idx=86&manage_idx=736">추천도서</a></li>
								<li><a href="#tab2" class='t-tabs' data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=10">신착도서</a></li>
							</ul>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=86&manage_idx=736" class="btn-more more-more">더보기</a>
						</div>
						<div class="box con box_all02" data-tab="tab1">
							<div class="bx_all">
								<c:if test="${fn:length(bookList1) < 1}">
									<li>등록된 데이터가 없습니다.</li>
								</c:if>
								<c:forEach items="${bookList1}" var="i" varStatus="status">
									<div class="bookbx bx0${status.count}">
										<div class="data_img">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<c:choose>
													<c:when test="${i.preview_img ne null}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'http')}">
																<img src="${i.preview_img}" alt="${i.title}" style="width:110px;height:170px;" onError="this.src='/resources/common/img/noImg2.png'"/>
															</c:when>
															<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
																<img src="${i.preview_img}" alt="${i.title}" style="width:110px;height:170px;" onError="this.src='/resources/common/img/noImg2.png'"/>
															</c:when>
															<c:otherwise>
																<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" style="width:110px;height:170px;" onError="this.src='/resources/common/img/noImg2.png'"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" style="width:110px;height:170px;" />
													</c:otherwise>
												</c:choose>
											</a>
										</div>
										<dl>
											<dt><a href="/${homepage.context_path}/board/view.do?menu_idx=86&manage_idx=736&board_idx=${i.board_idx}">${i.title}</a></dt>
											<dd>${i.imsi_v_3}<span>${i.imsi_v_4}</span></dd>
										</dl>
									</div>
								</c:forEach>
							</div>
						</div>

						<div class="box con box_all02" data-tab="tab2" style="display:none;">
							<div class="bx_all">
							</div>
						</div>

					</div>


				</div>
				<!--//추천도서 신착도서-->
			</div>
		</div>
		<!-- //자료안내 -->

		<div class="main_bottom">
			<div class="main_bottom_wrap">
				<div class="banner-wrap type1">
					<div class="banner-t1">
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
						</div>
					</div>
					<div class="banner-box1">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>

				<!-- 관련사이트 -->
				<script type="text/javascript">
				function if_showsite(zz) {
					var obj = document.getElementById(zz);
					if(obj.style.display == "none" || obj.style.display == "") {
						obj.style.display = "block";
					} else {
						obj.style.display = "none";
					}
				}
				</script>
				
				<div class="main_site_wrap">
					<div class="site">
						<p class="btns"><a onkeypress="if(event.keyCode==13) {if_showsite('linkservice01'); return false;}" onclick="if_showsite('linkservice01'); return false;">관련사이트 바로가기</a></p>
						<ul id="linkservice01" style="display: none;">
							<li><a title="새 창으로 이동" href="http://www.nl.go.kr/" target="_blank">국립중앙도서관</a></li>
							<li><a title="새 창으로 이동" href="https://www.nanet.go.kr/" target="_blank">국회도서관</a></li>
							<li><a title="새 창으로 이동" href="http://www.gov.kr/" target="_blank">대한민국정부</a></li>
							<li><a title="새 창으로 이동" href="http://www.culture.go.kr/" target="_blank">문화포털</a></li>
						</ul>
					</div>
				</div>
				<!-- //관련사이트 -->

			</div>
		</div>

	</div>

	<tiles:insertAttribute name="footer" />
</div>

</body>
</html>