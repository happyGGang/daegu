<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
					+ todayDate.toGMTString() + ";"
		}

		$('div#' + popupId).hide();
	});

	//팝업 키보드로 닫기
	$('.close-btn').on('keydown', function(e) {
		if(e.keyCode==32){
			$('html, body').animate({scrollTop: 0 }, 'fast');  //spacebar 바로 인해 내려간 화면을 다시 올려줌
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
				document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
			$('div#' + popupId).hide();
		}
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
<%--
	if(getCookie("1513776125246") != "=checked") {
		selfID = window.open("/resources/homepage/elib/elib_20171220.html","popup_48","width=412,height=420,top=200,left=150,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no");
		selfID.opener = self;
	}
--%>

	<%-- 팝업존 --%>
	if($('.popup-list ul li').length > 0) {
		$('.popup-list ul').bxSlider({
			auto: true,
			responsive: true,
			autoControls: true,
			pagerType:'short'
		});
	}

	$('.site-menu-link-title').on('click', function(){

		var boxText = $(this).next('dd');
		var toggleState = $(boxText).is(':hidden');
		if (toggleState)
		{
			$(boxText).slideToggle();
		} else {
			$(boxText).slideToggle();
		}
	});
	$('.Gnb .gnb-menu > li.menu7').remove();

	$('#more-view-btn').hide();

	$('#more-view-btn').on('click', function(e) {
		e.preventDefault();
		$('.quickMenu').addClass('on');
		$('.notice-box').addClass('on');
		$('#more-view-btn').hide();
	});

	$('#more-close-btn').on('click', function(e) {
		e.preventDefault();
		$('.quickMenu').removeClass('on');
		$('.notice-box').removeClass('on');
		$('#more-view-btn').show();
	});

	$('.ebookContent ul').bxSlider({
		auto: true,
		autoHover: true,
		speed: 500,
		pager: false,
		pagerType: 'short',
		autoControls: false,
		moveSlides: 1,
		maxSlides: 1
	});
});

// 모바일일 경우 fullpage 미사용
if ( $(window).width() < 1025 ) {
	$('.quickMenu').removeClass('on');
	$('.notice-box').removeClass('on');
	$('#more-view-btn').hide();
} else {
		$('.quickMenu').addClass('on');
		$('.notice-box').addClass('on');
		$('#more-view-btn').hide();
};

// 리사이즈 될때 모바일 화면에서 fullpage 미사용
$( window ).resize( function(e) {
	if ( $(window).width() < 1025 ) {
		$('.quickMenu').removeClass('on');
		$('.notice-box').removeClass('on');
		$('#more-view-btn').hide();
	} else {
		$('.quickMenu').addClass('on');
		$('.notice-box').addClass('on');
		$('#more-view-btn').hide();
	};
});

function getCookie(name){
	 var nameOfCookie = name;
	 var x = 0;
	 while ( x <= document.cookie.length ) {
	 	var y = (x+nameOfCookie.length);
	    if ( document.cookie.substring( x, y ) == nameOfCookie ) {
	    	if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) endOfCookie = document.cookie.length;
	   		return unescape( document.cookie.substring( y, endOfCookie ) );
	    }
	 	x = document.cookie.indexOf( " ", x ) + 1;
	 	if ( x == 0 ) break;
	 }
	 return "";
}

$.ajax({
	url: 'https://api.openweathermap.org/data/2.5/weather?lat=35.1711032&lon=128.9849058&appid=3bcf7eca7fc5d5df252135e43043a0a7',
	dataType: "json",
	type: "GET",
	async: "false",
	success: function(data) {
		$('.weather span.temp').html(Math.floor((data.main.temp- 273.15)*10)/10+'˚');
		$('.weather span.icon img').attr('src',"/resources/homepage/elib/img/"+data.weather[0].icon+".png");
		//$('.weather span.icon').addClass('w'+data.weather[0].icon);
	}
});

</script>
<style>
body, html {background:#30706e url('/resources/homepage/elib/img/main-visual.png') no-repeat center top;background-size:cover;}
</style>
<div id="wrap">

	<div id="header">
		<tiles:insertAttribute name="top" />
		<tiles:insertAttribute name="topMenu" />
	</div>

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}"/>
		</div>
	</div>

	<div id="container" class="main container">
		<div class="sectionxs">
			<div class="search-box">
				<form id="mainSearchForm" action="/${homepage.context_path}/module/newelib/search/index.do">
					<input type="hidden" name="menu_idx" value="80">
					<input type="hidden" name="viewPage" value="1">
					<!-- <input type="hidden" name="type" value="EBK"> -->
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="main-box">
							<div class="box1">
								<label for="search_text_1" class="blind">통합자료검색</label>
								<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색" style="ime-mode:active;"/>
							</div>
							<button id="main-search-btn">검색</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>

		<div class="sectionxs">
			<div class="quickMenu on">
				<ul>
					<li class="quick-1">
						<a href="/${homepage.context_path}/module/newelib/book/index.do?menu_idx=14&menu=NEW&type=EBK" title="E-BOOK 바로가기" class="quick01">
						<div>
							<p>전자책</p>
							<h4>E-BOOK</h4>
						</div>
					</a>
					</li>
					<li class="quick-2">
					<a href="/${homepage.context_path}/html/html2.do?menu_idx=90" title="오디오북 바로가기" class="quick02">
						<div>
							<p>귀로 듣는 소리책</p>
							<h4>오디오북</h4>
						</div>
					</a>
					</li>
					<li class="quick-3">
					<a href="/${homepage.context_path}/module/newelib/asp/contents/elearning.do?menu_idx=27" title="E러닝 학습 바로가기" class="quick03">
						<div>
							<p>맞춤형 온라인 학습</p>
							<h4>E-러닝</h4>
						</div>
					</a>
					</li>
					<li class="quick-4">
					<a href="/${homepage.context_path}/html.do?menu_idx=24" title="웹DB 홈페이지 바로가기" class="quick04">
						<div>
							<p>학술논문ㆍ클래식</p>
							<h4>웹DB</h4>
						</div>
					</a>
					</li>
					<li class="quick-5">
					<a href="/${homepage.context_path}/board/index.do?menu_idx=72&manage_idx=284" title="공지사항 바로가기" class="quick05">
						<div>
							<p>알려드립니다</p>
							<h4>공지사항</h4>
						</div>
					</a>
					</li>
					<li class="quick-6">
					<a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=81" title="모바일회원증 바로가기" class="quick06">
						<div>
							<p>도서대출카드</p>
							<h4>모바일회원증</h4>
						</div>
					</a>
					</li>
					<li class="quick-7">
					<a href="/${homepage.context_path}/html.do?menu_idx=31" title="전자도서관 이용안내 바로가기" class="quick07">
						<div>
							<p>이렇게 이용하세요</p>
							<h4>이용안내</h4>
						</div>
					</a>
					</li>
					<li class="quick-8">
					<a href="/${homepage.context_path}/module/newelib/lending/index.do?menu_idx=39&menu=LENDING" title="나의도서관 바로가기"class="quick08">
						<div>
							<p>대출현황조회</p>
							<h4>나의도서관</h4>
						</div>
					</a>
					</li>
				</ul>
			</div>

			<div id="notice-box" class="notice-box on">
				<a href="#close" class="more-close-btn" id="more-close-btn"><img src="/resources/homepage/elib/img/btn-close.png" alt="닫기"></a>
				<c:set var="now" value="<%=new java.util.Date()%>" />
				<fmt:formatDate value="${now}" pattern="HH:mm" var="time" />
				<fmt:formatDate value="${now}" pattern="MM" var="month" />
				<fmt:formatDate value="${now}" pattern="dd" var="day" />
				<fmt:formatDate value="${now}" pattern="E" var="week"/>
				<!-- notice -->
				<div class="alarm-box">
					<div class="date-weather-section">
						<div class="date-time">
							<b>${time}</b> ${month}월 ${day}일 ${week}요일 
						</div>
						<div class="weather">
							<span class='icon'><img src="" alt=""></span><span class="temp">15˚˚  </span>
						</div>
					</div>

					<div class="notice-section">
						<div class="relative">
							<h4 class="title">공지사항</h4>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=72&manage_idx=284" class="more-btn">더보기</a>
						</div>
						<div class="con">
							<ul>
								<c:forEach var="i" varStatus="status" items="${noticeList}" >
								<fmt:formatDate value="${i.add_date}" pattern="yyyy" var="noticeYear"/>
								<fmt:formatDate value="${i.add_date}" pattern="MM.dd" var="noticeMonth"/>
								<li>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=72&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
										<span class="day">${noticeYear}<br/><b>${noticeMonth}</b></span>${i.title}
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>

					<div class="contents-section">
						<div class="curation-box">
							<div class="relative">
								<h4 class="title">BOOK’ 큐레이션</h4>
							</div>
							<div class="relative curation-box-content">
								<div class="curation-box-left">
									<div class="curation-box-left-background">
										<c:if test="${fn:length(bookList) != 0}">
										<a href="/${homepage.context_path}/board/view.do?menu_idx=94&plan_date=${bookList[0].imsi_v_1}&manage_idx=${bookList[0].manage_idx}&board_idx=${bookList[0].board_idx}" alt="${bookList[0].title}" title="${bookList[0].title}"/>
										<span class="img">
											<c:choose>
												<c:when test="${bookList[0].preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(bookList[0].preview_img, 'http')}">
														<img src="${bookList[0].preview_img}" alt="${bookList[0].title}" title="${bookList[0].title}"/>
														</c:when>
														<c:otherwise>
														<img src="/data/board/${bookList[0].manage_idx}/${bookList[0].board_idx}/${bookList[0].preview_img}" alt="${bookList[0].title}" title="${bookList[0].title}"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}">
												</c:otherwise>
											</c:choose>
										</span>
										<span class="txt">
											<p class="title_info">${bookList[0].title}</p>
										</span>
										<p><a href="/${homepage.context_path}/board/view.do?menu_idx=94&plan_date=${bookList[0].imsi_v_1}&manage_idx=${bookList[0].manage_idx}&board_idx=${bookList[0].board_idx}" alt="${bookList[0].title}" alt="${bookList[0].title}" title="${bookList[0].title}"><img src="/resources/homepage/elib/img/cu-more-btn.png" alt="더보기"></a></p>
										</c:if>
									</div>
								</div>
								<div class="curation-box-right">
									<ul>
										<c:forEach items="${bookList}" var="i" varStatus="status">
										<c:choose>
										<c:when test="${fn:length(bookList) < 2}">
										
										</c:when>
										<c:otherwise>
											<c:if test="${!status.first}">
												<li>
													<a href="/${homepage.context_path}/board/view.do?menu_idx=94&plan_date=${i.imsi_v_1}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" alt="${i.title}" title="${i.title}"/>
														<span class="img">
															<c:choose>
																<c:when test="${i.preview_img ne null}">
																	<c:choose>
																		<c:when test="${fn:contains(i.preview_img, 'http')}">
																		<img src="${i.preview_img}" alt="${i.title}" title="${i.title}"/>
																		</c:when>
																		<c:otherwise>
																		<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																	<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}">
																</c:otherwise>
															</c:choose>
														</span>
														<span class="txt">
															<p class="title_info">${i.title}</p>
														</span>
													</a>
												</li>
											</c:if>
										</c:otherwise>
										</c:choose>
										</c:forEach>

									</ul>
								</div>
							</div>
						</div>
					</div>
<!--
					<div class="contents-section">
						<div class="ebook-box">
							<div class="relative">
								<h4 class="title">지금 E-BOOK</h4>
								<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=15&menu=BEST&type=EBK" class="more-btn">더보기</a>
							</div>
							<div>
							<ul id="bestBookList">
								<c:forEach items="${bestBookList1}" var="i" varStatus="status">
									<li>
										<a href="/elib/module/elib/book/view.do?menu_idx=15&menu=BEST&type=EBK&sortField=BOOK_LEND&sortType=DESC&book_idx=${i.book_idx}">
											<span class="img"><img src="${i.book_image}" alt="${i.book_name}" onerror="this.src='/resources/common/img/noImg2.png'"></span>
											<span class="txt">
										<p class="title_info">${i.book_name}</p>
										<p class="author">${i.author_name}</p>
										</span>
										</a>
									</li>
								</c:forEach>
							</ul>
							</div>
						</div>
						<div class="ebook-box2">
							<h4 class="title">신간 E-BOOK</h4>
							<div class="ebookContent">
								<ul id="newBookList">
									<c:forEach items="${newBookList1}" var="i" varStatus="status">
									<li>
										<a href="/elib/module/elib/book/view.do?menu_idx=14&menu=NEW&type=EBK&sortField=BOOK_PUBDT&sortType=DESC&book_idx=${i.book_idx}">
										<span class="movieImg"><img src="${i.book_image}" alt="${i.book_name}" onerror="this.src='/resources/common/img/noImg2.png'"></span>
										<span class="movieEx">${i.book_name}</span>
										</a>
									</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>

					<div class="elearning-section">

							<span>
								<h4 class='title'>오디오북</h4>
								<p><img src="/resources/homepage/${homepage.context_path}/img/play-icon.png" alt="지금 E-BOOK"></p>
							</span>
							<ul>
								<li><a href="/${homepage.context_path}/html/html2.do?menu_idx=90">스마트한 독서 오디오락</a></li>
								<li><a href="/${homepage.context_path}/module/elib/asp/contents/audio.do?menu_idx=86">새로운 독서의 즐거움 오디언소리</a></li>
							</ul>

					</div>
-->
				</div>
			</div>
		</div>

		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>

	<div id="more-view-btn" class="more-view-btn"><a href="#"><img src="/resources/homepage/elib/img/click-btn.png" alt="컨텐츠 더보기"></a></div>


</div>

</body>
</html>


