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


		$('ul.newBookUl').load('recommendBook.do?category2=${category2List[0].code_id}');
		$('select#recommendBook1').on('change', function() {
			$('ul.newBookUl').load('recommendBook.do?category2='+$(this).val());
		});

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

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-visual">



				<a href="#secondPage"><div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div></a>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='wide-1686-sections'>

				<div class="popupzone-box">
					<h2 class="title">팝업존</h2>
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupzone-img01.png" alt="등록된 팝업존이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="notice-box">
					<h2 class="title">공지사항</h2>
					<div class="news con" >
						<div class="box">
							<ul>
								<c:forEach items="${noticeBoardList}" var="i" varStatus="status">
								<li>
									<a href="/${i.imsi_v_19}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.imsi_n_2}" class="wrap">
										<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy"/><br/><b><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></b></span>
										<span class="link library${i.imsi_v_19}">${i.imsi_v_20}</span>
										<span class="tit title${i.imsi_v_19}">${i.title}</span>
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="more-btn">
						<a href="/${homepage.context_path}/board/index.do?menu_idx=22&manage_idx=282"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
					</div>
				</div>


			</div>

		</div>
		<!-- //main1 -->

		<!-- main2 통합자료검색-->
		<div class="section" id="main2">
			<div class="main2_tit">
				<h2 class="title"><b>통합자료검색</b></h2>
				<p class="tit_text">대구지역 도서관의 자료를 쉽고 빠르게 검색해보세요.</p>
			</div>

			<!-- main_search -->
			<div class="search-area" id="main_search">
				<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
				<input type="hidden" name="menu_idx" value="9">
				<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
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
		<!-- //main2 -->


		<!-- main3 평생교육강좌-->
		<div class="section" id="main3">
			<div class="main2_tit">
				<h2 class="title"><b>평생교육강좌</b></h2>
				<p class="tit_text">대구통합도서관의 다양한 강좌 프로그램을 체험해보세요.</p>
			</div>

			<div class='wide-1686-sections'>
				<div class="cont cultureList">
					<ul>
						<c:forEach items="${teachList}" var="i" varStatus="status">
						<c:set var="imgnum" value="${(status.count % 3)+1}"></c:set>
						<li>
							<a href="/${i.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=${i.menu_idx}&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}" class="border bgimg00${imgnum}">
								<span class="status">진행중</span>
								<span class="txt">
									<p class="lib-name">${i.homepage_name}</p>
									<p class="tit">${fn:substring(i.teach_name, 0, 15)}<c:if test="${fn:length(i.teach_name) > 15}">...</c:if></p>
									<p class="len"><b>접수</b> ${i.start_join_date} ~ ${i.end_join_date}</p>
								</span>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="more-btn">
				<a href=""><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
			</div>
			<div class="end"></div>

		</div>
		<!-- //main3 -->

		<!-- main4 사서추천, 대구의bOOK-->
		<div class="section" id="main4">
			<div class="main4_wrap">

				<div class='wide-1686-sections'>

					<div class="recommand-box">
						<div class="main2_tit">
							<h2 class="title"><b>사서 추천 BOOK’</b></h2>
							<p class="tit_text">이 책 어떠세요?</p>
						</div>
						<div class="title">
							<p>
								<select id="recommendBook1" class="recommendSite1">
									<c:forEach items="${category2List}" var="cate2">
									<option value="${cate2.code_id}" style="color:#000;">${cate2.code_name}</option>
									</c:forEach>
								</select>
							</p>
						</div>
						<div class="book">
							<div class="box con">
								<ul class="book_photo newBookUl">
								</ul>
							</div>
						</div>
						<div class="more-btn">
							<a href=""><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
						</div>
					</div>

					<div class="daegubook-box">
						<div class="main2_tit">
							<h2 class="title"><b>대구의 BOOK’</b></h2>
							<p class="tit_text">북모닝 대구! 올해의 한책</p>
						</div>
						<div class="daegubook">
							<div class="box con">
								<dl>
									<dt>
										<p>
											<b>당신이 옳다<br/>(정혜신의 적정심리학)</b><br/>
											정혜신 / 해냄출판사 / 2018<br/><br/>
											사회적 재난 현장부터 일상의 순간까지 고통
											받는 이들과 함께해온 정신과 의사 정혜신은 
											우리에게 '심리적 CPR(심폐소생술)'이 절실
											하다고 진단한다. 최근 15년 간 진료실을 벗
											어나 보통 사람들은 물론 트라우마 피해자부
											터 CEO까지 다양한 이들의 속마음을...
										</p>
									</dt>
									<dd><img src="/resources/homepage/${homepage.context_path}/img/daegu-book.png" alt="당신이 옳다" /></dd>
								</dl>
							</div>
						</div>

						<div class="more-btn">
							<a href=""><img src="/resources/homepage/${homepage.context_path}/img/more-btn_b.png" alt="더보기" /></a>
						</div>
					</div>

				</div>

			</div>
		</div>

		<!-- main5 큐레이션-->
		<div class="section" id="main5">
			<div class="main2_tit">
				<h2 class="title"><b>큐레이션</b></h2>
				<p class="tit_text">다양한 컨텐츠를 제공해 드리는 맞춤형 서비스</p>
			</div>

			<div class='wide-1686-sections'>
				<div class="cont curationList">
					<ul>

						<li>
							<a href="http://icuration.co.kr/curation/w/58" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu01.png" alt="부산 여행코스"></div>
								<h3 class="book-title">Maker를 위한 북큐레이션</h3>
								<p class="book-desc">상상을 현실로 만드는 메이커스페이스</p>
								<p class="reg-date">2020-12-02</p>
							</a>
						</li>

						<li>
							<a href="http://icuration.co.kr/curation/w/51" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu02.png" alt="부산 서점"></div>
								<h3 class="book-title">10월 그림책 토크 콘서트</h3>
								<p class="book-desc">코로나 19 슬기로운 온라인 도서관 이용법</p>
								<p class="reg-date">2020-12-02</p
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr/curation/w/53" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu03.png" alt="부산 북카페"></div>
								<h3 class="book-title">2020 언택트 독도의 날</h3>
								<p class="book-desc">2020 독도의 날(10.25) 행사 언택트로 진행합니다.</p>
								<p class="reg-date">2020-12-02</p
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr/curation/w/52" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu04.png" alt="부산 여행지</"></div>
								<h3 class="book-title">유투버를 위한 북큐레이션</h3>
								<p class="book-desc">유투버를 위한 큐레이션을 소개합니다</p>
								<p class="reg-date">2020-12-02</p
							</a>
						</li>

					</ul>
				</div>
			</div>
		</div>

		<!-- main6 주요서비스-->
		<div class="section" id="main6">

			<div class="main2_tit">
				<h2 class="title"><b>주요서비스</b></h2>
				<p class="tit_text">대구통합도서관은 다양한 서비스를 제공합니다.</p>
			</div>
			
			<div class="mIcon">
				<ul>
					<li>
						<a href="/bukgs/html.do?menu_idx=15">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q1.png" alt="희망도서신청"><br/>희망도서신청</span>
						</a>
					</li>
					<li>
						<a href="/bukgs/html.do?menu_idx=92">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q2.png" alt="상호대차서비스"><br/>상호대차서비스</span>
						</a>
					</li>
					<li>
						<a href="/bukgs/module/teach/index.do?menu_idx=32">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q3.png" alt="독서문화행사"><br/>독서문화행사</span>
						</a>
					</li>
					<li>
						<a href="/bukgs/intro/login/index.do?menu_idx=69">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q4.png" alt="대출정보조회"><br/>대출정보조회</span>
						</a>
					</li>
					<li>
						<a href="/bukgs/html.do?menu_idx=91">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q5.png" alt="스마트도서관"><br/>스마트도서관</span>
						</a>
					</li>
					<li>
						<a href="https://blog.naver.com/bukguarts" target="_blank">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q6.png" alt="블로그"><br/>블로그</span>
						</a>
					</li>
				</ul>
			</div>
			<div class="end"></div>

			<div class="mBtn">
				<ul>
					<li>
						<a href="/bukgs/html.do?menu_idx=15" class="b01">
							책이음
						</a>
					</li>
					<li>
						<a href="/bukgs/html.do?menu_idx=92" class="b02">
							책바다
						</a>
					</li>
					<li>
						<a href="/bukgs/module/teach/index.do?menu_idx=32" class="b03">
							책나래
						</a>
					</li>
				</ul>
			</div>
		</div>

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
				//$('.Gnb').css('border-bottom','1');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
			}	else if( destination.index == 2 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
			}  else if( destination.index == 3 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
			}  else if( destination.index == 4 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
			}  else if( destination.index == 5 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
			}  else if( destination.index == 6 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
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

