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


		$('div#calendar-box').load('calendar3.do');
		$('div#holiday-box').load('calendar5.do?homepage_id=${fn:escapeXml(homepage.homepage_id)}');
		$('ul.book_photo').eq(1).load('newBook.do');
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

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main0-visual">
				<div class="main0-wrap">
					<div class="main-section3">
						<div class="main0-left">
							<div class="main0-left-top">
								<h3>책 읽는 작은 여유가<br class="mobile-view"/>마음 속에 큰 행복입니다.</h3>
							</div>
							<div class="main0-left-bottom">
								<div class="quick-box">
									<ul>
										<li class="q1">
											<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=9">
												<p class="tit">자료검색</p>
												<p class="cont">찾으시는 도서의 정보를 입력하여 편리하게 자료를 검색해보세요!</p>
											</a>
										</li>
										<li class="q2">
											<a href="/${homepage.context_path}/html.do?menu_idx=30">
												<p class="tit">문화행사</p>
												<p class="cont">동일공공도서관만의 다양한 문화행사를 통해 책과 더욱 친해져보세요!</p>
											</a>
										</li>
										<li class="q3">
											<a href="/${homepage.context_path}/html.do?menu_idx=27">
												<p class="tit">전자도서관</p>
												<p class="cont">전자책, 오디오북 등 다양한 컨텐츠를 편리하게 이용해보세요!</p>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="main0-right">
						</div>
						<div class="end"></div>
					</div>
				</div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- main1 -->
		<div class="section" id="main1">			
			<div class="main1_tit">
				<p class="tit_text">DONGIL PUBLIC LIBRARY</p>
				<h2 class="title">동일공공도서관 <b>주요서비스</b></h2>
			</div>			
			<div class="mIcon">
				<ul>
					<li>
						<a href="/dongil/html.do?menu_idx=20" class="q01">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2-1.png" alt="이용안내"><br class="webBr"/>이용안내<p>GUIDE</p></span>
						</a>
					</li>
					<li>
						<a href="/dongil/intro/search/loan/index.do?menu_idx=54" class="q02">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2-2.png" alt="대출조회·예약"><br class="webBr"/>대출조회·예약<p>LOAN</p></span>
						</a>
					</li>
					<li>
						<a href="/dongil/board/index.do?menu_idx=69&manage_idx=1062" class="q03">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2-3.png" alt="자주하는질문"><br class="webBr"/>자주하는질문<p>FAQ</p></span>
						</a>
					</li>
					<li>
						<a href="/dongil/html.do?menu_idx=18" class="q04">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2-4.png" alt="희망도서신청"><br class="webBr"/>희망도서신청<p>HOPE</p></span>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- //main1 -->

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
