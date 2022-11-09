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
+++
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
		<div id="main0" class="section">

			<div class="main-section">

				<div class="main0-box">
					<div class="main0-jj-char">
						<img src="/resources/homepage/${homepage.context_path}/img/main0-jj.png" alt="">
					</div>
					<div class="main0-jj-txt">
						일상의 <b class="red">점자,</b><img src="/resources/homepage/${homepage.context_path}/img/main0-ht.png" alt=""><br/>
						동행을 위한<br/>
						<b>배려의 시작</b>입니다.
					</div>
				</div>

			</div>
			<div class="main0-line"><img src="/resources/homepage/${homepage.context_path}/img/ht-line-right.png" alt=""></div>
			<div class="main_scroll"><div class="main_scroll_wp">SCROLL DOWN</div></div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div id="main1" class="section">
			<div class='main-section2'>
				<div class="main1-box">
					
					<div class="main1-jj-txt-search">
						<div class="main1-top-txt">
							시각장애인이 손으로 만져 사용하는 <br/>
							촉각문자를 <b class="red">'점자'</b>라고 합니다.
						</div>
						<div class="main1-bottom-txt">
							점자는 프랑스에서 군사용 암호문자로 사용하기 위해 만든 것에서 시작되었으며 <br/>
							프랑스맹학교로 전달되어 가로 3줄, 세로 2줄로 된 6점 점자로 개발되었습니다.
						</div>
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
					</div>
					<div class="main1-jj-char">
						<img src="/resources/homepage/${homepage.context_path}/img/main1-jj.png" alt="">
					</div>

				</div>
			</div>
			<div class="main1-line"><img src="/resources/homepage/${homepage.context_path}/img/ht-line-left.png" alt=""></div>
		</div>
		<!-- //main1 -->

		<!-- main2 -->
		<div id="main2" class="section">

			<div class="main-section2">

				<div class="main2-box">
					<div class="main2-jj-char">
						<img src="/resources/homepage/${homepage.context_path}/img/main2-jj.png" alt="">
					</div>
					<div class="main2-jj-notice">
						<div class="main2-top">
							<div class="main2-notice-title">
								<h3>공지사항</h3>
								<a href="" class="more-notice"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt=""></a>
							</div>
							<div class="main2-notice-contents">
								<ul>
									<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=699&board_idx=${i.board_idx}">
												<em>힐링프로그램 「나를만나는 시간, TEA TIME」수강생 모집</em>
												<span class="time">2022-09-14</span>
											</a>
									</li>
									<li></li>
									<li></li>
								</ul>
								<ul>
									<c:forEach items="${noticeList}" var="i" varStatus="status">
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=699&board_idx=${i.board_idx}">
												<em>${i.title}</em>
												<span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="dd" /></b><br/><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" /></span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="main2-bottom">
							우리나라는 송암 박두성 선생님께서 일본어점자만을 사용하는 맹학교 학생들이 안타까워<br/>
							시각장애인 학생들과 연구회를 만들어 한글점자를 개발하였고,<br/>
							1926년 11월 4일 <b class="red">'훈맹정음'</b>이라는 이름으로 반포하여 오늘에 이르렀습니다.
						</div>
					</div>
				</div>

			</div>
			<div class="main2-line"><img src="/resources/homepage/${homepage.context_path}/img/ht-line-right.png" alt=""></div>
		</div>
		<!-- //main2 -->


		<!-- main3 -->
		<div class="section" id="main3">

			<div class="main-section2">
				<img src="/resources/homepage/${homepage.context_path}/img/main3-jj1.png" alt="" class="jjchar01">
				<div class="quick-menu">
					<ul>
						<li class="quick01">
							<a href="/bukgs/html.do?menu_idx=15" class="q01">
								<span>희망도서신청</span>
							</a>
						</li>
						<li class="quick02">
							<a href="/bukgs/html.do?menu_idx=92" class="q02">
								<span>상호대차서비스</span>
							</a>
						</li>
						<li class="quick03">
							<a href="/bukgs/module/teach/index.do?menu_idx=32" class="q03">
								<span>독서문화행사</span>
							</a>
						</li>
						<li class="quick04">
							<a href="/bukgs/intro/search/loan/history.do?menu_idx=53" class="q04">
								<span>대출정보조회</span>
							</a>
						</li>
						<li class="quick05">
							<a href="/bukgs/html.do?menu_idx=91" class="q05">
								<span>스마트도서관</span>
							</a>
						</li>
						<li class="quick06">
							<a href="https://blog.naver.com/bukguarts" class="q06" target="_blank">
								<span>블로그</span>
							</a>
						</li>
						<li class="quick07">
							<a href="https://blog.naver.com/bukguarts" class="q07" target="_blank">
								<span>블로그</span>
							</a>
						</li>
						<li class="quick08">
							<a href="https://blog.naver.com/bukguarts" class="q08" target="_blank">
								<span>블로그</span>
							</a>
						</li>
					</ul>
				</div>
				<img src="/resources/homepage/${homepage.context_path}/img/main3-jj2.png" alt="" class="jjchar02">
			</div>
			
			<div class="banner-box">
				<div class="main-section">
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
		anchors: ['firstPage', 'secondPage', '3rdPage','4thPage'],
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
