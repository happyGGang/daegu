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


		$('div#holiday-box').load('calendar2.do');
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
				<form id="frm_main_search" method="get" action="">
				<div class="search_bar">
					<div class="search_bar_text">
						<label for="search_txt" class="search_m">검색어(도서명 등)를 입력해주세요.</label>
						<input type="text" name="search_txt" class="search_text" id="search_txt" value=""/>
						<input type="submit" name="" id="" class="search_btn" value="검색" />
					</div>
				</div>
				</form>
				<div class="mvisual_btn">
					<ul>
						<li class="mbtn1"><a href="#">도서관이용</a></li>
						<li class="mbtn2"><a href="#">대출자료조회</a></li>
						<li class="mbtn3"><a href="#">수강신청</a></li>
						<li class="mbtn4"><a href="#">희망도서신청</a></li>
						<li class="mbtn5"><a href="#">책드림<span class="eng">(Dream)</span>서비스</a></li>
						<li class="mbtn6"><a href="#">디지털자료실예약</a></li>
						<li class="mbtn7"><a href="#">견학신청</a></li>
						<li class="mbtn8"><a href="#">자원봉사신청</a></li>
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
							<a href="#" ><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="모바일 회원증 바로가기" /></a>
						</p>
					</div>
					<!-- //모바일회원증 -->
					
					
					<div class="free_day">
						<p class="tit">휴관일</p>
						<select id="sel_lib" name="personal_day">
							<option value="1">도원</option>
							<option value="2">성서</option>
							<option value="3">본리</option>
							<option value="4">달서가족문화</option>
							<option value="5">달서어린이</option>
							<option value="6">달서영어</option>
						</select>
						<p class="date">01, 02, 03, 05, 09</p>
						<p class="add_img_wrap">
							<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="휴관일 자세히보기" /></a>
						</p>
					</div>
					<div class="maraton_book">
						<p class="tit"><span>2020</span> 독서마라톤</p>
						<p class="txt">달서구를 구민 또는 달서구 소재 재학생</p>
						<p class="add_img_wrap">
							<a href="#" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/notice_addr.png" alt="독서마라톤 자세히보기" /></a>
						</p>
					</div>

				</div>

				<div class="notice_wrap">
					<!-- 새소식 안내 -->
					<div class="main_notice mnotice_li">
						<div class="notice_title_wrap mnotice_wrap">
							<h2>새소식 안내</h2>
							<select id="notice_cate" name="notice_cate" title="new_notice">
								<option value="" selected>전체</option>
								<option value="">도원</option>
								<option value="">성서</option>
								<option value="">본리</option>
								<option value="">달서가족문화</option>
								<option value="">달서어린이</option>
								<option value="">달서영어</option>
							</select>
						</div>
						<p class="notice_more"><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/notice_more.png" alt="새소식 안내 자세히보기"></a></p>

						<ul id="ul_noticeList" class="notice_text">

							<li class="lib00"><a href="#"><span class="lib_name">성서도서관</span><span class="lib_txt">다문화 특강-정해영 작가와의 ...</span><span class="lib_date">10-24</span></a></li>

							<li class="lib00"><a href="#"><span class="lib_name">전체</span><span class="lib_txt">상호대차, 무인예약, 대출예약...</span><span class="lib_date">10-23</span></a></li>

							<li class="lib00"><a href="#"><span class="lib_name">전체</span><span class="lib_txt">대구 공공도서관 통합허브시스템...</span><span class="lib_date">10-23</span></a></li>

							<li class="lib00"><a href="#"><span class="lib_name">전체</span><span class="lib_txt">임재양 작가초청 강연회 개최 ...</span><span class="lib_date">10-22</span></a></li>

							<li class="lib05"><a href="#"><span class="lib_name">달서어린이</span><span class="lib_txt">찾아가는 어린이집 책 낭독 1...</span><span class="lib_date">10-21</span></a></li>

						</ul>

					</div>
					<!-- //새소식 안내 -->
					<!-- 이달의 행사 -->
					<div class="main_festival mnotice_li">
						<div class="festival_title_wrap mnotice_wrap">
							<h2>이달의 행사</h2>
							<select id="event_lib_anum" name="festival" title="month_festival">
								<option value="" selected>전체</option>
								<option value="">도원</option>
								<option value="">성서</option>
								<option value="">본리</option>
								<option value="">달서가족문화</option>
								<option value="">달서어린이</option>
								<option value="">달서영어</option>
							</select>
						</div>
						<ul id="ul_eventList" class="notice_text fes">

							<li class="fes_lib01"><a href="#"><span class="lib_name">도원</span><span class="lib_txt1">[강좌]2020년 길 위의...</span><span class="lib_date1">08-14 ~ 11-13</span></a></li>

							<li class="fes_lib04"><a href="#"><span class="lib_name">달서가족</span><span class="lib_txt1">[강좌]재미있는 동양 고전...</span><span class="lib_date1">09-04 ~ 11-20</span></a></li>

							<li class="fes_lib04"><a href="#"><span class="lib_name">달서가족</span><span class="lib_txt1">[강좌]펀펀 이야기 놀이(...</span><span class="lib_date1">09-04 ~ 11-20</span></a></li>

							<li class="fes_lib01"><a href="#"><span class="lib_name">도원</span><span class="lib_txt1">[강좌]2020년 길 위의...</span><span class="lib_date1">08-14 ~ 11-13</span></a></li>

							<li class="fes_lib04"><a href="#"><span class="lib_name">달서가족</span><span class="lib_txt1">[강좌]재미있는 동양 고전...</span><span class="lib_date1">09-04 ~ 11-20</span></a></li>

						</ul>
						<p class="notice_more"><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/notice_more.png" alt="이달의 행사 자세히보기"></a></p>
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
						<a href="#" class="more-btn">더보기</a>
					</div>

					<div class="box">
						<div class="data_img">
							<a href="#"><img src="https://ssl.pstatic.net/imgmovie/mdi/mit110/0702/70254_P35_153229.jpg" style="width:110px;height:170px;" alt="아이언맨 3 표지이미지" /></a>
						</div>
						<dl>
							<dt><a href="#">아이언맨 3</a></dt>
							<dd>10.27(화)<span>[도원]홈페이지 점검중</span></dd>
						</dl>
					</div>
				</div>
				<!-- -->
				
				
				<!--추천도서 신착도서 탭 메뉴 시작-->
				<div class="bookpick">

					<div class="book-box tabS">
						<div class="title">
							<ul class="tabMenuS">
								<li class="on"><a href="#tab1" class='t-tabs'>추천도서</a></li>
								<li><a href="#tab2" class='t-tabs'>신착도서</a></li>
							</ul>
							<a href="#" class="btn-more">더보기</a>
						</div>
						<div class="box con box_all02" data-tab="tab1">
							<div class="bx_all">

								<div class="bookbx bx01">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img.jpg" style="width:110px;height:170px;" alt="그거 봤어?  : 밀레니얼을 열광시킨 콘텐츠의 힘 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">그거 봤어?  : 밀레니얼을1 ...</a></dt>
										<dd>김학준 지음<span>이상미디랩</span></dd>
									</dl>
								</div>

								<div class="bookbx bx02">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (1).jpg" style="width:110px;height:170px;" alt="난 모기에 물리지 않아! 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">난 모기에 물리지 않아!</a></dt>
										<dd>펜드레드 노이스 지음  ; 조윤진 옮김<span>뜨인돌</span></dd>
									</dl>
								</div>

								<div class="bookbx bx03">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (2).jpg" style="width:110px;height:170px;" alt="화장실 귀 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">화장실 귀</a></dt>
										<dd>선자은 글 ; 윤태규 그림<span>미래엔</span></dd>
									</dl>
								</div>

								<div class="bookbx bx04">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (3).jpg" style="width:110px;height:170px;" alt="당신의 4분 33초  : 이서수 장편소설 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">당신의 4분 33초  : 이서...</a></dt>
										<dd>이서수 지음<span>은행나무</span></dd>
									</dl>
								</div>
				
							</div>
						</div>

						<div class="box con box_all02" data-tab="tab2" style="display:none;">
							<div class="bx_all">

								<div class="bookbx bx01">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img.jpg" style="width:110px;height:170px;" alt="그거 봤어?  : 밀레니얼을 열광시킨 콘텐츠의 힘 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">그거 봤어?  : 밀레니얼을2 ...</a></dt>
										<dd>김학준 지음<span>이상미디랩</span></dd>
									</dl>
								</div>

								<div class="bookbx bx02">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (1).jpg" style="width:110px;height:170px;" alt="난 모기에 물리지 않아! 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">난 모기에 물리지 않아!</a></dt>
										<dd>펜드레드 노이스 지음  ; 조윤진 옮김<span>뜨인돌</span></dd>
									</dl>
								</div>

								<div class="bookbx bx03">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (2).jpg" style="width:110px;height:170px;" alt="화장실 귀 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">화장실 귀</a></dt>
										<dd>선자은 글 ; 윤태규 그림<span>미래엔</span></dd>
									</dl>
								</div>

								<div class="bookbx bx04">
									<div class="data_img">
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/get_img (3).jpg" style="width:110px;height:170px;" alt="당신의 4분 33초  : 이서수 장편소설 표지이미지" /></a>
									</div>
									<dl>
										<dt><a href="#">당신의 4분 33초  : 이서...</a></dt>
										<dd>이서수 지음<span>은행나무</span></dd>
									</dl>
								</div>
				
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
						<ul class="banner-roll">
						<li>
						<span>
						<a href="https://www.juso.go.kr/openIndexPage.do" target="_blank">
						<img src="/data/banner/h53/1602753558277" alt="새주소안내"/></a></span></li>
						<li>
						<span>
						<a href="https://www.keris.or.kr/main/main.do" target="_blank">
						<img src="/data/banner/h53/1602753585628" alt="한국교육학술정보원"/></a></span></li>
						<li>
						<span>
						<a href="https://www.nl.go.kr/NL/contents/N50203010000.do" target="_blank">
						<img src="/data/banner/h53/1602753658566" alt="사서에게물어보세요"/></a></span></li>
						<li>
						<span>
						<a href="https://www.nl.go.kr/kolisnet/index.do" target="_blank">
						<img src="/data/banner/h53/1602753682524" alt="국가자료종합목록"/></a></span></li>
						<li>
						<span>
						<a href="http://book.nl.go.kr/iplls/Index.do" target="_blank">
						<img src="/data/banner/h53/1602753732469" alt="책이음"/></a></span></li>
						<li>
						<span>
						<a href="https://www.nanet.go.kr/main.do" target="_blank">
						<img src="/data/banner/h53/1602753746743" alt="국회도서관"/></a></span></li>
						<li>
						<span>
						<a href="http://info.edunet.net/" target="_blank">
						<img src="/data/banner/h53/1602753761378" alt="온라인학습"/></a></span></li>
						<li>
						<span>
						<a href="https://www.moe.go.kr/main.do" target="_blank">
						<img src="/data/banner/h53/1602753777663" alt="교육부"/></a></span></li>
						<li>
						<span>
						<a href="https://www.mcst.go.kr/kor/main.jsp" target="_blank">
						<img src="/data/banner/h53/1602753832020" alt="문화체육관광부"/></a></span></li>
						<li>
						<span>
						<a href="https://www.nl.go.kr/" target="_blank">
						<img src="/data/banner/h53/1602753845553" alt="국립중앙도서관"/></a></span></li>
						<li>
						<span>
						<a href="https://www.nlcy.go.kr/index.do" target="_blank">
						<img src="/data/banner/h53/1602753859371" alt="국립어린이도서관"/></a></span></li>
						<li>
						<span>
						<a href="https://www.data.go.kr/" target="_blank">
						<img src="/data/banner/h53/1602753873328" alt="공공데이터포탈"/></a></span></li>
						<li>
						<span>
						<a href="http://library.daegu.go.kr/dgportal/index.do" target="_blank">
						<img src="/data/banner/h53/1602753891087" alt="통합검색"/></a></span></li></ul>
						<!-- <homepageTag:banner bannerList="${bannerList}"/> -->
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