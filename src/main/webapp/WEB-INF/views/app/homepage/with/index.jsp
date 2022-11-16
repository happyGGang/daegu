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

	<div class="popupWrap main-section">
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
								두손에는 <b>책</b>이 가득! 가슴에는 <b>꿈</b>이 가득! 
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
				</div>
				<div class="main0-bottom">
				</div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class="main1-full-visual">
				<div class='main-section3'>

					<div class="notice-box">

						<div class="notice-title">
							<h3>NOTICE</h3>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=1105" class="more-btn"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt=""></a>
						</div>

						<div class="notice-contents">

							<div class="notice-list">
								<ul>
									<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=32&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></span>
											</a>
										</li>
									</c:forEach>
		
									<c:if test="${empty noticeList}">
										<li>
											<em>등록된 공지사항이 없습니다.</em>
										</li>
									</c:if>
								</ul>
							</div>

						</div>
					</div>

				</div>
			</div>

			<div class="main-section3">
				<div class="quick-menu">
					<ul>
						<li class="quick01">
							<a href="/${homepage.context_path}/html.do?menu_idx=20" class="q01">
								<span>책이음</span>
							</a>
						</li>
						<li class="quick02">
							<a href="/${homepage.context_path}/html.do?menu_idx=22" class="q02">
								<span>책바다</span>
							</a>
						</li>
						<li class="quick03">
							<a href="/${homepage.context_path}/html.do?menu_idx=21" class="q03">
								<span>책나래</span>
							</a>
						</li>
						<li class="quick04">
							<a href="/${homepage.context_path}/html.do?menu_idx=23" class="q04">
								<span>사서에게물어보세요</span>
							</a>
						</li>
						<li class="quick05">
							<a href="https://library.daegu.go.kr/dgportal/index.do" class="q05">
								<span>통합도서관</span>
							</a>
						</li>
						<li class="quick06">
							<a href="/${homepage.context_path}/html.do?menu_idx=24" class="q06">
								<span>전자도서관</span>
							</a>
						</li>
						<li class="quick07">
							<a href="/${homepage.context_path}/intro/search/hope/req.do?menu_idx=16" class="q07">
								<span>희망도서신청</span>
							</a>
						</li>
						<li class="quick08">
							<a href="/${homepage.context_path}/html.do?menu_idx=38" class="q08">
								<span>자원봉사신청</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="end"></div>
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
							<a class="prev" href="#prev"><img src="/resources/common/img/salip/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/common/img/salip/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
							<a class="stop active" href="#stop"><img src="/resources/common/img/salip/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
							<a class="play" href="#play"><img src="/resources/common/img/salip/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
							<a class="more" href=""><img src="/resources/common/img/salip/banner-more-btn.png" alt="목록보기" /><span class="blind">목록보기</span></a>
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
				//('.Gnb').css('border-bottom','0');
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
