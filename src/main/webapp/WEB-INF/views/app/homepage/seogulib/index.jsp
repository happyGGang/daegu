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
	<!--팝업-->
	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>
	<!--//팝업-->

	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />	

	<div id="container" class="main">
		
		<!--section01-->
		<div class="section01_wrap">			
			<div class="section01">
				
				<!--sec01-1-->
				<div class="sec01-1">
					<div class="sec01-1-0">
						<!--모바일/태블릿 popupzone-->
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
						<!--//모바일/태블릿 popupzone-->
					</div>
					<div class="sec01-1-1">
						<!--search-->
						<div class="search_box">
							<div class="search_box_on">
								<span>통합자료검색</span>
								<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
								<a href=""><img src="/resources/homepage/seogulib/img/search_btn.jpg"></a>
							</div>
							<div class="search_box_off">
								<span><img src="/resources/homepage/seogulib/img/search_btn.jpg"></span>
							</div>
						</div>
						<!--//search-->
						<!--quick menu-->
						<div class="quickmenu"> 			
							<ul>
								<li class="quick01" onclick="location.href='html.do?menu_idx=17'">
									<h5>이용안내</h5>
									<p>도서관서비스<br />이렇게 이용해보세요!</p>
								</li>
								<li class="quick02" onclick="location.href='intro/search/loan/history.do?menu_idx=53'">
									<h5>대출현황조회</h5>
									<p>나의 도서대출 이력을<br />조회해보세요!</p>
								</li>
								<li class="quick03" onclick="location.href='html.do?menu_idx=31'">
									<h5>문화강좌</h5>
									<p>다양한 행사와<br />온라인 수강신청</p>
								</li>
							</ul>
						</div>
						<!--//quick menu-->
					</div>
					
					<div class="sec01-1-2">
						<!--PC popupzone-->
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
						<!--//PC popupzone-->
					</div>
				</div>
				<!--//sec01-1-->

				<!--sec01-2-->
				<div class="sec01-2">
					<div class="sec01-2-1">
						<!--quick menu-->
						<div class="quickmenu"> 			
							<ul>
								<li class="quick04" onclick="location.href='html.do?menu_idx=91'">
									<h5>도서관견학신청</h5>
									<p>올바른 도서관 이용법과<br />책을 접할 수 있어요!</p>
								</li>
								<li class="quick05" onclick="location.href=''">
									<h5>DVD자료검색</h5>
									<p>DVD 비도서 자료검색</p>
								</li>
								<li class="quick06" onclick="location.href='html.do?menu_idx=15'">
									<h5>희망도서신청</h5>
									<p>원하는 도서가 없을 경우<br />신청하세요!</p>
								</li>
								<li class="quick07" onclick="location.href='html.do?menu_idx=25'">
									<h5>대구전자도서관</h5>
									<p>대구 시민의<br />스마트한 독서생활!</p>
								</li>
							</ul>
						</div>
						<!--//quick menu-->
					</div>

					<div class="sec01-2-2">
						<!--naver band-->
						<div class="naver_band"> 			
							<h5><span>네이버</span> 밴드 ON</h5>
							<ul>
								<li>
									<a href="https://band.us/@seoguchildlib" target="_blank">
										<img src="/resources/homepage/seogulib/img/naver_band_child.png"><br/>
										<span>서구어린이</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@bisanlib" target="_blank">
										<img src="/resources/homepage/seogulib/img/naver_band_bisan.png"><br/>
										<span>비산</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@selibrary" target="_blank">
										<img src="/resources/homepage/seogulib/img/naver_band_english.png"><br/>
										<span>영어</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@biwonlib" target="_blank">
										<img src="/resources/homepage/seogulib/img/naver_band_biwon.png"><br/>
										<span>비원</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@wongogaelibrary" target="_blank">
										<img src="/resources/homepage/seogulib/img/naver_band_wongogae.png"><br/>
										<span>원고개</span>
									</a>
								</li>
							</ul>
						</div>
						<!--//naver band-->
					</div>
				</div>
				<!--//sec01-2-->

				<!--sec01-2-tab-->
				<div class="sec01-2-tab">
					<div class="sec01-2-1">
						<!--quick menu-->
						<div class="quickmenu"> 			
							<ul>
								<li class="quick04" onclick="location.href='html.do?menu_idx=91'">
									<h5>도서관견학신청</h5>
									<p>올바른 도서관 이용법과<br />책을 접할 수 있어요!</p>
								</li>
								<li class="quick05" onclick="">
									<h5>DVD자료검색</h5>
									<p>DVD 비도서 자료검색</p>
								</li>
								<li class="quick06" onclick="location.href='html.do?menu_idx=15'">
									<h5>희망도서신청</h5>
									<p>원하는 도서가 없을 경우<br />신청하세요!</p>
								</li>
							</ul>
						</div>
						<!--//quick menu-->
					</div>

					<div class="sec01-2-2">
						<div class="quickmenu"> 			
							<ul>
								<li class="quick07" onclick="location.href='html.do?menu_idx=25'">
									<h5>대구전자도서관</h5>
									<p>올바른 도서관 이용법과<br />책을 접할 수 있어요!</p>
								</li>
							</ul>
						</div>
						<!--naver band-->
						<div class="naver_band"> 			
							<h5><span>네이버</span> 밴드 ON</h5>
							<ul>
								<li>
									<a href="https://band.us/@seoguchildlib">
										<img src="/resources/homepage/seogulib/img/naver_band_child.png"><br/>
										<span class="m_none">서구어린이</span>
										<span class="pc_none">어린이</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@bisanlib">
										<img src="/resources/homepage/seogulib/img/naver_band_bisan.png"><br/>
										<span>비산</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@selibrary">
										<img src="/resources/homepage/seogulib/img/naver_band_english.png"><br/>
										<span>영어</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@biwonlib">
										<img src="/resources/homepage/seogulib/img/naver_band_biwon.png"><br/>
										<span>비원</span>
									</a>
								</li>
								<li>
									<a href="https://band.us/@wongogaelibrary">
										<img src="/resources/homepage/seogulib/img/naver_band_wongogae.png"><br/>
										<span>원고개</span>
									</a>
								</li>
							</ul>
						</div>
						<!--//naver band-->
					</div>
				</div>
				<!--//sec01-2-->

				<!--sec01-3-->
				<div class="sec01-3">
					<div class="title">
						<span>
							<strong>오늘의 도서관 일정</strong>을 확인하세요!
						</span>
						<a href="module/calendarManage/index.do?menu_idx=36">전체일정</a>
					</div>

					<div class="date">
						<a href=""><img src="/resources/homepage/seogulib/img/date_prev.png"></a>
						<span>06-15</span>
						<a href=""><img src="/resources/homepage/seogulib/img/date_next.png"></a>
					</div>

					<div class="event">
						<div class="tit"><span>행사</span></div>
						<div><span>어린이</span></div>
						<div><span>비산</span></div>
						<div><span>영어</span></div>
						<div><span>비원</span></div>
						<div><span>원고개</span></div>
					</div>

					<div class="movie">
						<div class="tit"><span>영화</span></div>
						<div><span>어린이</span></div>
						<div><span>비산</span></div>
						<div><span>비원</span></div>
					</div>

					<div class="closed">
						<div class="tit"><span>휴관</span></div>
						<div><span>어린이</span></div>
						<div><span>비산</span></div>
						<div><span>비원</span></div>
					</div>
				</div>
				<!--//sec01-3-->

			</div>
		</div>
		<!--//section01-->




<script type="text/javascript">
$(function() {

	//1차탭
	$(document).on('click', '.tab a.tab-link', function(e){
		e.preventDefault();
		$('.top2wrap').hide();
		$('.top3wrap').hide();

		var target = this.getAttribute('href').replace('#','');

		if(target == 'newswrap')
		{
			$('#top2box_notice').show();
			$('.tab2 li').removeClass('on');
			$('.tab2 li:first-child').addClass('on');
			$('#notibox1_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
		}
		else if(target == 'culturewrap')
		{
			$('#culturebox2_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
		}
		else if(target == 'bookswrap')
		{
			$('#top2box_recomandbook').show();
			$('.tab2 li').removeClass('on');
			$('.tab2 li:first-child').addClass('on');

			$('#recombox3_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
		}
		else if(target == 'moviewrap')
		{
			$('#moviebox4_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
		}

		var $box = $(this).closest('.tab');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.topwrap').hide();
		$('#'+target).show();
	});


	//2차탭
	$(document).on('click', '#newswrap .tab2 a.tab-link2', function(e){
		e.preventDefault();
		$('.top3wrap').hide();

		var target = this.getAttribute('href').replace('#','');

		if(target == 'notice')
		{
		$('#notibox1_all').show();
		$('.tab3 li').removeClass('on');
		$('.tab3 li:first-child').addClass('on');
		}
		else if(target == 'gallery')
		{
		$('#galbox1_all').show();
		$('.tab3 li').removeClass('on');
		$('.tab3 li:first-child').addClass('on');
		}

		var $box = $(this).closest('.tab2');
		$box.find('.on').removeClass('on');
		$(this).parent().parent().addClass('on');

		$('.top2wrap').hide();
		$('#top2box_'+target).show();
	});

	$(document).on('click', '#bookswrap .tab2 a.tab-link2', function(e){
		e.preventDefault();
		$('.top3wrap').hide();

		var target = this.getAttribute('href').replace('#','');

		if(target == 'recomandbook')
		{
		$('#recombox3_all').show();
		$('.tab3 li').removeClass('on');
		$('.tab3 li:first-child').addClass('on');
		}
		else if(target == 'newbook')
		{
		$('#newbookbox3_all').show();
		$('.tab3 li').removeClass('on');
		$('.tab3 li:first-child').addClass('on');
		}

		var $box = $(this).closest('.tab2');

		$box.find('.on').removeClass('on');
		$(this).parent().parent().addClass('on');

		$('.top2wrap').hide();
		$('#top2box_'+target).show();
	});

	//3차탭
	$(document).on('click', '#top2box_notice .tab3 a.tab-link3', function(e){
		e.preventDefault();

		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#notibox1_'+target).show();
	});

	$(document).on('click', '#top2box_gallery .tab3 a.tab-link3', function(e){
		e.preventDefault();

		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#galbox1_'+target).show();
	});

	$(document).on('click', '#culturewrap .tab3 a.tab-link3', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#culturebox2_'+target).show();
	});

	$(document).on('click', '#moviewrap .tab3 a.tab-link3', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#moviebox4_'+target).show();
	});

	$(document).on('click', '#top2box_recomandbook .tab3 a.tab-link3', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#recombox3_'+target).show();
	});

	$(document).on('click', '#top2box_newbook .tab3 a.tab-link3', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tab3');

		$box.find('.on').removeClass('on');
		$(this).parent().addClass('on');

		$('.top3wrap').hide();
		$('#newbookbox3_'+target).show();
	});
});
</script>
		<!--section02-->
		<div class="section02_tab tab">
			<ul>
				<li class="on"><a href="#newswrap" class="tab-link">도서관소식</a></li>
				<li><a href="#culturewrap" class="tab-link">도서관행사</a></li>
				<li><a href="#bookswrap" class="tab-link">도서관'BOOK</a></li>
				<li><a href="#moviewrap" class="tab-link">영화상영</a></li>
			</ul>
		</div>

		<div class="section02_wrap">
			
			<div class='topwrap' id="newswrap" style="display:block;">
				<!--도서관소식 공지사항,갤러리-->
				<div class="section02">
					<div class="title">
						<span>서구통합도서관 소식</span>
					</div>

					<div class="con sec02-1">
						<div class="sec02_tab01 tab2">
							<ul>
								<li class="on"><div class="line2"><a href="#notice" class="tab-link2" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628">공지<br />사항</a></div></li>
								<li><div><a href="#gallery" class="tab-link2" data-link="">갤러리</a></div></li>
							</ul>
							<div class="more_btn">
								<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628"><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a>
							</div>
						</div>

						<div class="top2wrap" id="top2box_notice" style="display:block;">
							<div class="sec02_tab02 tab3">
								<ul>
									<li class="on"><a href="#all" class="tab-link3">전체</a></li>
									<li class="bar">/</li>
									<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
									<li class="bar">/</li>
									<li><a href="#bisan" class="tab-link3">비산</a></li>
									<li class="bar">/</li>
									<li><a href="#english" class="tab-link3">영어</a></li>
									<li class="bar">/</li>
									<li><a href="#biwon" class="tab-link3">비원</a></li>
									<li class="bar">/</li>
									<li><a href="#wongogye" class="tab-link3">원고개</a></li>
								</ul>
							</div>

							<div class="top3wrap" id="notibox1_all" style="display:block;">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이1</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="notibox1_seoguchild">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이2</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="notibox1_bisan">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이3</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="notibox1_english">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이4</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="notibox1_biwon">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이5</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="notibox1_wongogye">
								<div class="board_box">
									<div class="board_notice01">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="cate">서구어린이6</div>
											<div class="tit">2020 대구 올해의 책 선정을 위한 시<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
											<div class="date">2020-07-07</div>
											<div class="txt">2020년 대구 올해의 책 선정을 위한 시민 투표에 참여해주신 분들에게는 추첨을 통합 소정의 선물이 기다리고 있어요. 많은 관심과 참여 부탁드립니다.</div>
										</div>
									</div>

									<div class="board_notice02">
										<div>
										<ul>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
												<div class="date">2020-07-07</div>
											</li>
											<li class="bisan">
												<div class="cate">비산</div>
												<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="biwon">
												<div class="cate">비원</div>
												<div class="tit">책바다서비스 이용안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="common">
												<div class="cate">공통</div>
												<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="english">
												<div class="cate">영어</div>
												<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="wongogae">
												<div class="cate">원고개</div>
												<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
												<span class="date">2020-07-07</span>
											</li>
											<li class="child">
												<div class="cate">서구어린이</div>
												<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
												<span class="date">2020-07-07</span>
											</li>
										</ul>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top2wrap" id="top2box_gallery">
							<div class="sec02_tab02 tab3">
								<ul>
									<li class="on"><a href="#all" class="tab-link3">전체</a></li>
									<li class="bar">/</li>
									<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
									<li class="bar">/</li>
									<li><a href="#bisan" class="tab-link3">비산</a></li>
									<li class="bar">/</li>
									<li><a href="#english" class="tab-link3">영어</a></li>
									<li class="bar">/</li>
									<li><a href="#biwon" class="tab-link3">비원</a></li>
									<li class="bar">/</li>
									<li><a href="#wongogye" class="tab-link3">원고개</a></li>
								</ul>
							</div>

							<div class="top3wrap" id="galbox1_all" style="display:block;">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="galbox1_seoguchild">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="galbox1_bisan">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">32020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="galbox1_english">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">42020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="galbox1_biwon">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">52020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="galbox1_wongogye">
								<div class="gallery_box">
									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">62020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="gallery" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/gallery_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//도서관소식 공지사항,갤러리-->
			</div>

			<div class="topwrap" id="culturewrap">
				<!--도서관행사-->
				<div class="section02">
					<div class="title">
						<span>서구통합도서관 행사안내</span>
					</div>

					<div class="con sec02-1">
						<div class="sec02_tab01" style="margin-top:-30px;">
							<div class="more_btn top-10">
								<a href=""><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a>
							</div>
						</div>

						<div class="sec02_tab02 tab3">
							<ul>
								<li class="on"><a href="#all" class="tab-link3">전체</a></li>
								<li class="bar">/</li>
								<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
								<li class="bar">/</li>
								<li><a href="#bisan" class="tab-link3">비산</a></li>
								<li class="bar">/</li>
								<li><a href="#english" class="tab-link3">영어</a></li>
								<li class="bar">/</li>
								<li><a href="#biwon" class="tab-link3">비원</a></li>
								<li class="bar">/</li>
								<li><a href="#wongogye" class="tab-link3">원고개</a></li>
							</ul>
						</div>

						<div class="top3wrap" id="culturebox2_all" style="display:block;">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이1</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="culturebox2_seoguchild">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이2</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="culturebox2_bisan">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이3</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="culturebox2_english">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이4</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="culturebox2_biwon">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이5</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="culturebox2_wongogye">
							<div class="board_box">
								
								<div class="board_notice03 pt50">
									<div>
									<ul>
										<li class="child">
											<div class="cate">서구어린이6</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
									</div>
								</div>

								<div class="board_notice03 m_none pt50" >
									<ul>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">2020년 6~7월 온라인 문화강좌 접수안내</div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="bisan">
											<div class="cate">비산</div>
											<div class="tit">장하윤작가와 함께하는 7월 문화가 있는 날</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="biwon">
											<div class="cate">비원</div>
											<div class="tit">책바다서비스 이용안내</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="common">
											<div class="cate">공통</div>
											<div class="tit">원문정보서비스 집콕하면서 이용하기 </div>
											<span class="flow_01">접수중</span>
										</li>
										<li class="english">
											<div class="cate">영어</div>
											<div class="tit">도서 예약대출서비스 수령일 변경 안내</div>
											<span class="flow_02">접수대기</span>
										</li>
										<li class="wongogae">
											<div class="cate">원고개</div>
											<div class="tit">2020년 개인정보보호인식주간 캠페인</div>
											<span class="flow_03">접수마감</span>
										</li>
										<li class="child">
											<div class="cate">서구어린이</div>
											<div class="tit">‘북 워크 스루’ 서비스 종료안내  </div>
											<span class="flow_02">접수대기</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//도서관행사-->
			</div>

			<div class="topwrap" id="bookswrap">
				<!--도서관BOOK-->
				<div class="section02">
					<div class="title">
						<span>책 읽는 書구, 서구통합도서관</span>
					</div>

					<div class="con sec02-1">
						<div class="sec02_tab01 tab2">
							<ul>
								<li class="on"><div class="line2"><a href="#recomandbook" class="tab-link2">추천<br />도서</a></div></li>
								<li><div class="line2"><a href="#newbook" class="tab-link2">신착<br />도서</a></div></li>
							</ul>
							<div class="more_btn">
								<a href=""><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a>
							</div>
						</div>

						<div class="top2wrap" id="top2box_recomandbook" style="display:block;">
							<div class="sec02_tab02 tab3">
								<ul>
									<li class="on"><a href="#all" class="tab-link3">전체</a></li>
									<li class="bar">/</li>
									<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
									<li class="bar">/</li>
									<li><a href="#bisan" class="tab-link3">비산</a></li>
									<li class="bar">/</li>
									<li><a href="#english" class="tab-link3">영어</a></li>
									<li class="bar">/</li>
									<li><a href="#biwon" class="tab-link3">비원</a></li>
									<li class="bar">/</li>
									<li><a href="#wongogye" class="tab-link3">원고개</a></li>
								</ul>
							</div>

							<div class="top3wrap" id="recombox3_all" style="display:block;">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 1대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="recombox3_seoguchild">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 2대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="recombox3_bisan">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 3대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="recombox3_english">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 4대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="recombox3_biwon">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 5대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="recombox3_wongogye">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">12020 6대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top2wrap" id="top2box_newbook">
							<div class="sec02_tab02 tab3">
								<ul>
									<li class="on"><a href="#all" class="tab-link3">전체</a></li>
									<li class="bar">/</li>
									<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
									<li class="bar">/</li>
									<li><a href="#bisan" class="tab-link3">비산</a></li>
									<li class="bar">/</li>
									<li><a href="#english" class="tab-link3">영어</a></li>
									<li class="bar">/</li>
									<li><a href="#biwon" class="tab-link3">비원</a></li>
									<li class="bar">/</li>
									<li><a href="#wongogye" class="tab-link3">원고개</a></li>
								</ul>
							</div>

							<div class="top3wrap" id="newbookbox3_all" style="display:block;">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 1대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="newbookbox3_seoguchild">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 2대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="newbookbox3_bisan">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 3대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="newbookbox3_english">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 4대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="newbookbox3_biwon">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 5대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>

							<div class="top3wrap" id="newbookbox3_wongogye">
								<div class="book_box">
									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">22020 6대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>

									<div class="book" onclick="">
										<div class="img_box">
											<img src="/resources/homepage/seogulib/img/notice_img.jpg">
										</div>
										<div class="con_box">
											<div class="tit">2020 대구 올해의 책 선정을 위한 시</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//도서관BOOK---->
			</div>

			<div class="topwrap" id="moviewrap">
				<!--영화상영-->
				<div class="section02">
					<div class="title">
						<span>이달의 영화상영</span>
					</div>

					<div class="con sec02-1">
						<div class="sec02_tab01" style="margin-top:-30px;">
							<div class="more_btn top-10">
								<a href=""><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a>
							</div>
						</div>

						<div class="sec02_tab02 tab3">
							<ul>
								<li class="on"><a href="#all" class="tab-link3">전체</a></li>
								<li class="bar">/</li>
								<li><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
								<li class="bar">/</li>
								<li><a href="#bisan" class="tab-link3">비산</a></li>
								<li class="bar">/</li>
								<li><a href="#english" class="tab-link3">영어</a></li>
								<li class="bar">/</li>
								<li><a href="#biwon" class="tab-link3">비원</a></li>
								<li class="bar">/</li>
								<li><a href="#wongogye" class="tab-link3">원고개</a></li>
							</ul>
						</div>

						<div class="top3wrap" id="moviebox4_all" style="display:block;">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산1</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산1</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산1</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="moviebox4_seoguchild">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산2</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산2</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산2</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="moviebox4_bisan">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산3</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산3</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산3</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="moviebox4_english">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산4</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산4</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산4</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="moviebox4_biwon">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산5</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산5</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산5</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="top3wrap" id="moviebox4_wongogye">
							<div class="movie_box">
								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산6</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산6</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>

								<div class="movie" onclick="">
									<div class="img_box">
										<img src="/resources/homepage/seogulib/img/notice_img.jpg">
									</div>
									<div class="con_box">
										<div class="info">비산6</div>
										<div class="tit">위대한 쇼맨</div>
										<div class="info">만 15세 이상 관람가</div>
										<div class="info" style="margin-top:20px;line-height:170%;">
											<b>일시</b>2020-06-02<br />
											<b>감독</b>시청각실<br />
											<b>장르</b>액션, 스릴러<br />
											<b>시간</b>160분
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
				<!--//영화상영-->
			</div>

			<!--배너-->
			<div class="banner-wrap type1">
				<div class="banner-t4">
					<h3>배너모음</h3>
					<div class="control">
						<a class="prev" href="#prev"><img src="/resources/homepage/seogulib/img/banner_prev_btn.png"><span class="blind">이전</span></a>
						<a class="stop active" href="#stop"><img src="/resources/homepage/seogulib/img/banner_pause_btn.png"><span class="blind">정지</span></a>
						<a class="play" href="#play"><img src="/resources/homepage/seogulib/img/banner_play_btn.png"><span class="blind">시작</span></a>
						<a class="next" href="#next"><img src="/resources/homepage/seogulib/img/banner_next_btn.png"><span class="blind">다음</span></a>
						<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><img src="/resources/homepage/seogulib/img/banner_menu_btn.png"><span class="blind">더보기</span></a>
					</div>
				</div>
				<div class="banner-box4">
					<homepageTag:banner bannerList="${bannerList}"/>
				</div>
			</div>
			<!--//배너-->
		</div>
		<!--//section02-->		

	</div>
</div>

<tiles:insertAttribute name="footer" />