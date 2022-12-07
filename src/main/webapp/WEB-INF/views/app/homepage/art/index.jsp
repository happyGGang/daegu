<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>

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

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('찾으시는 도서의 정보를 입력해주세요.');
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

	<div class="popupWrap main-section3">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">
			<div class="main-section3">
				<div class="main0-left">
					<div class="circle-box">
						<span class="onedepth"><img src="/resources/homepage/${homepage.context_path}/img/1dep.png" alt=""></span>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=76&manage_idx=1133" class="txt-circle orange-box">LIBRARY</a>
						<span class="twodepth"><img src="/resources/homepage/${homepage.context_path}/img/2dep.png" alt=""></span>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=77&manage_idx=1134" class="txt-circle red-box">ARCHIVE</a>
						<span class="threedepth"><img src="/resources/homepage/${homepage.context_path}/img/3dep.png" alt=""></span>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=78&manage_idx=1135" class="txt-circle blue-box">MUSEUM</a>
						<span class="fourdepth"><img src="/resources/homepage/${homepage.context_path}/img/4dep.png" alt=""></span>
					</div>
				</div>
				<div class="main0-right">
					<div class="comment">
						<p class="stxt">ART LIBRARY</p>
						<p class="ltxt">국내 최초<br/><b>미술전문도서관</b></p>
					</div>
					<!-- main_search -->
					<div class="search-area" id="main_search">
						<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="9">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box1">
									<div class="box2">
										<label for="search_text_1" class="blind">통합자료검색</label>
										<input name="title" id="search_text_1" type="text" class="text" placeholder="찾으시는 도서의 정보를 입력해주세요." style="ime-mode:active;"/>
									</div>
								</div>
								<button id="main-search-btn">검색하기</button>
							</div>
						</fieldset>
						</form>
					</div>
					<!-- //Main_search -->
				</div>
			</div>
			<div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div>
		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section3'>
				<div class="notice-title">
					<h3>Notice</h3>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=33&manage_idx=1076" class="btn-more2 more-more">더보기</a>
				</div>
				<div class="con">
					<div class="box">
						<ul>
							<c:forEach items="${noticeList}" var="i" varStatus="status" begin="0" end="3">
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=33&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
										<span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></b></span>
										<span class="contents">
										<p class='tit'>${i.title}</p>
										<!-- <p class='cont'>${i.content_summary}</p> -->
									</span>
									</a>
								</li>
							</c:forEach>
							<c:if test="${empty noticeList}">
								<li>
									등록된 공지사항이 없습니다.
								</li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="qmenu">
					<ul>
						<li class="qm1">
								<a href="/${homepage.context_path}/html.do?menu_idx=44" title="도서관갤러리">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu1.png" alt="도서관갤러리"></div>
										<div class="qtxt">도서관갤러리</div>
									</div>
								</div>
							</a>

						</li>
						<li class="qm2">
								<a href="/${homepage.context_path}/html.do?menu_idx=17" title="희망도서신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu2.png" alt="희망도서신청"></div>
										<div class="qtxt">희망도서신청</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm3">
								<a href="/${homepage.context_path}/html.do?menu_idx=19" title="회원가입안내">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu3.png" alt="회원가입안내"></div>
										<div class="qtxt">회원가입안내</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm4">
								<a href="/${homepage.context_path}/html.do?menu_idx=20" title="이용시간·휴관일">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu4.png" alt="이용시간·휴관일"></div>
										<div class="qtxt">이용시간·휴관일</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm5">
								<a href="/${homepage.context_path}/html.do?menu_idx=40" title="인사말">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu5.png" alt="인사말"></div>
										<div class="qtxt">인사말</div>
									</div>
								</div>
							</a>

						</li>
						<li class="qm6">
								<a href="/${homepage.context_path}/html.do?menu_idx=45" title="찾아오시는길">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu6.png" alt="찾아오시는길"></div>
										<div class="qtxt">찾아오시는길</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm7">
								<a href="/${homepage.context_path}/module/excursions/index.do?menu_idx=38" title="도서관견학신청">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu7.png" alt="도서관견학신청"></div>
										<div class="qtxt">도서관견학신청</div>
									</div>
								</div>
							</a>
						</li>
						<li class="qm8">
								<a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=1077" title="자주묻는질문">
								<div class="outer">
									<div class="inner">
										<div class="image"><img src="/resources/homepage/${homepage.context_path}/img/qu8.png" alt="자주묻는질문"></div>
										<div class="qtxt">자주묻는질문</div>
									</div>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="main_scroll"><div class="main_scroll_wp">scroll down</div></div>
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div class="section" id="main2">
			<div class="main-section3">
				<div class="book-title">
					<h3>NEW BOOK</h3>
					<a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=11" class="btn-more2 more-more">더보기</a>
				</div>

				<script>
					$(function(){
						var _width = $(window).width();
						var _books;

						var Books = function(){
							try {
								if( _books ) _books.destroySlider();
							} catch (e) {
								// TODO: handle exception
							}

							if( _width <= 320 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 3,
									slideWidth: 200,
									slideMargin: 20
								});
							}
							else if( _width <= 768 && _width > 320 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 3,
									slideWidth: 200,
									slideMargin: 20
								});
							}
							else if( _width <= 1024 && _width > 768 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 3,
									slideWidth: 270,
									slideMargin: 30
								});
							}
							else if( _width <= 1450 && _width > 1024 ){
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:false,
									moveSlides:1,
									maxSlides: 4,
									slideWidth: 270,
									slideMargin: 40
								});
							}
							else {
								_books = $('.bookList ul').bxSlider({
									auto: true,
									autoHover: true,
									speed: 500,
									pager:true,
									pagerType:'short',
									controls:true,
									autoControls: true,
									autoControlsCombine: true,
									moveSlides:1,
									maxSlides: 6,
									slideWidth: 270,
									slideMargin: 50
								});
							}
						};
						
						Books();
						/*$(window).on('resize', function(e){
							e.preventDefault();
							_width = $(window).width();
							console.log(_width);
							Cultures();
						});*/
					});
				</script>
				<div class="bookList">
					<ul>
						<c:forEach items="${newBookList}" var="i" begin="0" end="9">
						<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=11&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
							<c:choose>
								<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
								<li>
								<a href="${detailURL}">
									<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
								</a>
								</li>
								</c:when>
								<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
								<li>
								<a href="${detailURL}">
									<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
								</a>
								</li>
								</c:when>
								<c:otherwise>
								<li>
								<a href="${detailURL}">
									<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
								</a>
								</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${empty newBookList}">
							<li>등록된 신착도서가 없습니다.</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<!-- //main3 -->

		<!-- footer_section -->
		<div class="banner-box">
			<div class="main-section3">
				<div class="banner-wrap type5">
					<div class="banner-t5">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/common/img/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/common/img/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
							<a class="stop active" href="#stop"><img src="/resources/common/img/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
							<a class="play" href="#play"><img src="/resources/common/img/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=69"><img src="/resources/common/img/salip/banner-more-btn.png" alt="목록보기" /><span class="blind">목록보기</span></a>
						</div>
					</div>
					<div class="banner-box5">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
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
				$('.Gnb').css('border-top','1px solid rgba(255,255,255,0.4)');
				$('.Gnb').css('border-bottom','1px solid rgba(255,255,255,0.4)');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
			} else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #ddd');
				$('.Gnb').css('border-bottom','1px solid #ddd');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else if( destination.index == 2 ) {				
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-top','1px solid #ddd');
				$('.Gnb').css('border-bottom','1px solid #ddd');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
			} else {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
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
