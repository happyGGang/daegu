<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.salip.css"/>
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

	<div class="popupWrap main-section3">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main0-wrap">
				<div class="main0-top">
					<div class="main-section3">
						<div class="main0-top-left">
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

						<div class="main0-top-right">
							<div class="main0-txt">
								<b>꿈</b>은 <b>도서관</b>에서, <b>미래</b>는 <b>책</b>속에서
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
												<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
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
				</div>
				<div class="main0-bottom">
				</div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section3'>

				<div class="culture-box">
					<div class="culture-title">
						<h3>문화행사</h3>
						<a href="" class="more-btn"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt=""></a>
					</div>

					<div class="culture-contents">
						<script>
							$(function(){
								var _width = $(window).width();
								var _cultures;

								var Cultures = function(){
									try {
										if( _cultures ) _cultures.destroySlider();
									} catch (e) {
										// TODO: handle exception
									}

									if( _width <= 320 ){
										_cultures = $('.cultureList ul').bxSlider({
											auto: true,
											autoHover: true,
											speed: 500,
											pager:false,
											moveSlides:1,
												maxSlides: 1,
											slideWidth: 400,
											slideMargin: 30
										});
									}
									else if( _width <= 550 && _width > 320 ){
										_cultures = $('.cultureList ul').bxSlider({
											auto: true,
											autoHover: true,
											speed: 500,
											pager:false,
											moveSlides:1,
											maxSlides: 1,
											slideWidth: 400,
											slideMargin: 30
										});
									}
									else if( _width <= 1024 && _width > 550 ){
										_cultures = $('.cultureList ul').bxSlider({
											auto: true,
											autoHover: true,
											speed: 500,
											pager:false,
											moveSlides:1,
											maxSlides: 1,
											slideWidth: 400,
											slideMargin: 30
										});
									}
									else if( _width <= 1450 && _width > 1024 ){
										_cultures = $('.cultureList ul').bxSlider({
											auto: true,
											autoHover: true,
											speed: 500,
											pager:false,
											moveSlides:1,
											maxSlides: 2,
											slideWidth: 400,
											slideMargin: 30
										});
									}
									else {
										_cultures = $('.cultureList ul').bxSlider({
											auto: true,
											autoHover: true,
											speed: 500,
											pager:false,
											moveSlides:1,
											maxSlides: 2,
											slideWidth: 400,
											slideMargin: 30
										});
									}
								};
								
								Cultures();
								$(window).on('resize', function(e){
									e.preventDefault();
									_width = $(window).width();
									Cultures();
								});
							});
						</script>
						<div class="cultureList">
							<ul>
								<li>
									<a href="">
										<div class="culture-contents-top">
											<img src="/resources/homepage/${homepage.context_path}/img/list-bg1.jpg" alt="">
										</div>
										<div class="culture-contents-bottom">
											<div class="culture-contents-txt">
												<div class="culture-contents-txt-top">
													[성인, 학부모] 자녀와 함께 읽는 인문고전 독서코칭
												</div>
												<div class="culture-contents-txt-middle">
													자녀들과 함께 가정에서 다양한 책읽기를 즐길 수 있는 방안과 그것을 인문학과 연결시킬 수 있는 방법을 찾을 수 있다.
												</div>
												<div class="culture-contents-txt-bottom">
													<p>강좌기간 : <b>2022-05-13 ~ 2022-05-20</b></p>
													<p>접수기간 : <b>2022-04-20 ~ 2022-05-10</b></p>
												</div>
											</div>
										</div>
									</a>
								</li>
								<li>
									<a href="">
										<div class="culture-contents-top">
											<img src="/resources/homepage/${homepage.context_path}/img/list-bg2.jpg" alt="">
										</div>
										<div class="culture-contents-bottom">
											<div class="culture-contents-txt">
												<div class="culture-contents-txt-top">
													[성인, 학부모] 자녀와 함께 읽는 인문고전 독서코칭
												</div>
												<div class="culture-contents-txt-middle">
													자녀들과 함께 가정에서 다양한 책읽기를 즐길 수 있는 방안과 그것을 인문학과 연결시킬 수 있는 방법을 찾을 수 있다.
												</div>
												<div class="culture-contents-txt-bottom">
													<p>강좌기간 : <b>2022-05-13 ~ 2022-05-20</b></p>
													<p>접수기간 : <b>2022-04-20 ~ 2022-05-10</b></p>
												</div>
											</div>
										</div>
									</a>
								</li>
							</ul>
						</div>
						<!-- 
						<ul>
							<c:forEach items="${teachList}" var="i" varStatus="status" begin="0" end="4">
								<li>
									<a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=${teachMenuIdx}&searchCate1=${i.large_category_idx}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&homepage_id=${i.homepage_id}">
										<div class="culture-contents-top">
											<img src="/resources/homepage/${homepage.context_path}/img/list-bg2.jpg" alt="">${}
										</div>
										<div class="culture-contents-bottom">
											<div class="culture-contents-txt">
												<div class="culture-contents-txt-top">
													${i.teach_name}
												</div>
												<div class="culture-contents-txt-middle">
													${}자녀들과 함께 가정에서 다양한 책읽기를 즐길 수 있는 방안과 그것을 인문학과 연결시킬 수 있는 방법을 찾을 수 있다.
												</div>
												<div class="culture-contents-txt-bottom">
													<p>강좌기간 : <b>${i.start_date} ~ ${i.end_date}</b></p>
													<p>접수기간 : <b>${} ~ ${}</b></p>
												</div>
											</div>
										</div>
									</a>
								</li>
							</c:forEach>
							<c:if test="${fn:length(teachList) < 1}">
								<li>
									등록된 행사가 없습니다.
								</li>
							</c:if>
						</ul>
						-->
					</div>
				</div>

				<div class="quick-box">
					<ul>
						<li class="quick01">
							<a href="" class="q01">
								<span>희망도서신청</span>
							</a>
						</li>
						<li class="quick02">
							<a href=" class="q02">
								<span>상호대차서비스</span>
							</a>
						</li>
						<li class="quick03">
							<a href="" class="q03">
								<span>독서문화행사</span>
							</a>
						</li>
						<li class="quick04">
							<a href="" class="q04">
								<span>대출정보조회</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="end"></div>

			</div>

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
							</div>
						</div>
						<div class="banner-box5">
							<homepageTag:banner bannerList="${bannerList}"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //main1 -->

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
				//$('#header').addClass("background-white");
				//$('.Gnb').css('border-bottom','0');
				//$('.Gnb').css('background','none');
				//$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {				
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
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

