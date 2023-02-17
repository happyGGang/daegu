<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<tiles:insertAttribute name="header" />

<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />
<c:if test="${getIp eq '218.48.151.16'}">
</c:if>

<script>
$(function() {
	var _video = document.querySelector('#video-box');
	
	$('a#movie-slider').click(function (e) {
		e.preventDefault();
		$('.movie-box').css('top','2%');
		$('#movie-close-slider').css('display','block');
		//$('.dimmed').css('display','block');
		//$('#ProgramLink-container').css('display','none');
		//_video.load(); // 새로운 정보를 다시 로드
		//_video.play(); // 잘 동작함		
		return false;
	});	
	
	$('a#movie-close-slider').click(function (e) {
		e.preventDefault();
		$('.movie-box').css('top','100%');
		$('#movie-close-slider').css('display','none');
		//$('.dimmed').css('display','none');
		//$('#ProgramLink-container').css('display','block');
		//_video.load(); // 새로운 정보를 다시 로드
		//_video.pause(); // 잘 동작함		
		return false;
	});	
	
	//setInterval("kioskGlobal.dateTimer()", 1000);
});
</script>

<script type="text/javascript">	
$(function() {
	$('#homeup, .homeup').click(function (e) {
		e.preventDefault();
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
	
	$('.book-close-btn').on('click', function() {
		var $this = $(this);
		var checkInput = $this.parent().parent().find('.pop-close-set input[data-day="'+$this.data('day')+'"]');
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

		$('div#recom_wrap').hide();
	});

	$('input[id*=pop]').on('click', function(e) {
		e.preventDefault();
		$(this).prop('checked', true);
		$(this).parent('div').next('a').data('day', $(this).data('day'));
		$(this).parent('div').next('a').click();
	});
	
	$('input[id*=book]').on('click', function(e) {
		e.preventDefault();
		$(this).prop('checked', true);
		$('.book-close-btn').data('day', $(this).data('day'));
		$('.book-close-btn').click();
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

		if( $("input:checkbox[name=libraryCodes]:checked").length == 0 )
		{
			alert('도서관을 선택 하세요.');
			//$('input#search_text_1').focus();
			return false;
		}

		$('#mainSearchForm').submit();
	});

	$('#main-search-btn2').on('click', function() {
		if( $('input#search_text_2').val() == '' ) {
			alert('검색어를 입력하세요.');
			$('input#search_text_2').focus();
			return false;
		}

		$('#mainSearchForm2').submit();
	});

	//search
	$('.searchBox').find('.btn-close').click(function(e){
		$('.searchBox').hide();
	});

	$('a.btn-open, a.m-btn-open').click(function(e){
		e.preventDefault();
		$('.searchBox').show();
	});


	$('.nearbylibinfo01').find('.btn-close').click(function(e){
		$('.nearbylibinfo01').hide();
	});

	$('a.info01-btn-open').click(function(e){
		e.preventDefault();
		$('.nearbylibinfo01').show();
	});

	$('.nearbylibinfo02').find('.btn-close').click(function(e){
		$('.nearbylibinfo02').hide();
	});

	$('a.info02-btn-open').click(function(e){
		e.preventDefault();
		$('.nearbylibinfo02').show();
	});

	$('.nearbylibinfo03').find('.btn-close').click(function(e){
		$('.nearbylibinfo03').hide();
	});

	$('a.info03-btn-open').click(function(e){
		e.preventDefault();
		$('.nearbylibinfo03').show();
	});

	$('.nearbylibinfo04').find('.btn-close').click(function(e){
		$('.nearbylibinfo04').hide();
	});

	$('a.info04-btn-open').click(function(e){
		e.preventDefault();
		$('.nearbylibinfo04').show();
	});

	$('a#mo-cgv-btn').click(function(e){
		e.preventDefault();
		var activeUrl = $(this).attr('href');
		$('.m-youtube-video').attr('src','');
		$('.mo-video-view').hide();
		$(activeUrl).show();
		$('#m-youtube-video-01').attr('src','https://www.youtube.com/embed/2OaRGkZyJjc');
	});

	$('a#mo-esia-btn').click(function(e){
		e.preventDefault();
		var activeUrl = $(this).attr('href');
		$('.m-youtube-video').attr('src','');
		$('.mo-video-view').hide();
		$(activeUrl).show();
		$('#m-youtube-video-02').attr('src','https://www.youtube.com/embed/85Ryq_P9pNw');
	});

	$('a#mo-emart-btn').click(function(e){
		e.preventDefault();
		var activeUrl = $(this).attr('href');
		$('.m-youtube-video').attr('src','');
		$('.mo-video-view').hide();
		$(activeUrl).show();
		$('#m-youtube-video-03').attr('src','https://www.youtube.com/embed/7ZqsLdG9xbg');
	});

	$('a#mo-nearby-btn').click(function(e){
		e.preventDefault();
		var activeUrl = $(this).attr('href');
		$('.m-youtube-video').attr('src','');
		$('.mo-nearby-view').hide();
		$(activeUrl).show();
		$('#m-youtube-video-04').attr('src','https://www.youtube.com/embed/9xoswEzhPIM');
	});

	$('#mo-cgv-view').find('.btn-close').click(function(e){
		$('.mo-video-view').hide();
		$('.m-youtube-video').attr('src','');
	});

	$('#mo-esia-view').find('.btn-close').click(function(e){
		$('.mo-video-view').hide();
		$('.m-youtube-video').attr('src','');
	});

	$('#mo-emart-view').find('.btn-close').click(function(e){
		$('.mo-video-view').hide();
		$('.m-youtube-video').attr('src','');
	});

	$('#mo-nearby-view').find('.btn-close').click(function(e){
		$('.mo-video-view').hide();
		$('.m-youtube-video').attr('src','');
	});
});

function searchIndex() {
	if (isFromFridayToSunday()) {
		alert('내 집 앞 도서관 서비스 예약가능 시간이 아닙니다.\n\n도서예약 가능 시간\n- 월요일 09:00 ~ 금요일 08:59\n* 월요일 휴관이 아닌 도서관의 경우 일요일 18:00부터 신청 가능 합니다.\n\n 검색결과 화면으로 이동합니다.');
	}
	
	doGetLoad('index.do', $('form#mainSearchForm2').serialize());
}

function isFromFridayToSunday() {
	var now = new Date();
	var nowDayOfWeek = now.getDay();
	var nowDay = now.getDate();
	var nowMonth = now.getMonth();
	var nowYear = now.getYear();
	nowYear += (nowYear < 2000) ? 1900 : 0;

	var weekStartDate = new Date(nowYear, nowMonth, nowDay + (5 - nowDayOfWeek), 9);
	var weekEndDate = new Date(nowYear, nowMonth, nowDay + (7 - nowDayOfWeek), 18);

	return weekStartDate <= now && weekEndDate > now;
}
</script>
<style>

</style>
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />
	<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub.css"/>
	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container1" class="main-container">
		<div class="map" id="web-view">
			<span class="yeongyeong">
				<a href="#yeongyeon" class="info01-btn-open">
					<img src="/resources/homepage/${homepage.context_path}/img/yeongyeon.png" alt="">
				</a>
			</span>
			<span class="bayawol">
				<a href="#bayawol" class="info02-btn-open">
					<img src="/resources/homepage/${homepage.context_path}/img/bayawol.png" alt="">
				</a>
			</span>
			<span class="isia">
				<a href="#isia" class="info03-btn-open">
					<img src="/resources/homepage/${homepage.context_path}/img/isia.png" alt="">
				</a>
			</span>
			<span class="lib01">
				<a href="/${homepage.context_path}/html.do?menu_idx=32">
					<img src="/resources/homepage/${homepage.context_path}/img/lib01.png" alt="">
				</a>
			</span>
			<span class="lib02">
				<a href="/${homepage.context_path}/html.do?menu_idx=30">
					<img src="/resources/homepage/${homepage.context_path}/img/lib02.png" alt="">
				</a>
			</span>
			<span class="lib03">
				<a href="/${homepage.context_path}/html.do?menu_idx=31">
					<img src="/resources/homepage/${homepage.context_path}/img/lib03.png" alt="">
				</a>
			</span>
			<span class="lib04">
				<a href="/${homepage.context_path}/html.do?menu_idx=29">
					<img src="/resources/homepage/${homepage.context_path}/img/lib04.png" alt="">
				</a>
			</span>
			<span class="lib05">
				<a href="/${homepage.context_path}/html.do?menu_idx=33">
					<img src="/resources/homepage/${homepage.context_path}/img/lib05.png" alt="">
				</a>
			</span>
			<span class="bal01">
				<a href="/nearbylib/html.do?menu_idx=9">
					<img src="/resources/homepage/${homepage.context_path}/img/bal01.png" alt="">
				</a>
			</span>
			<span class="bal02">
				<a href="/nearbylib/html.do?menu_idx=8">
					<img src="/resources/homepage/${homepage.context_path}/img/bal02.png" alt="">
				</a>
			</span>
			<span class="bal03">
				<a href="#" class="btn-open">
					<img src="/resources/homepage/${homepage.context_path}/img/bal03.png" alt="">
				</a>
			</span>
			<script>
				$(function(){
					$('div.tab_menu.on > ul > li > a').on('click',function(e){
						e.preventDefault();

						$(this).parents('ul').children().removeClass('active');
						$(this).parent().addClass('active');
						//$('.video_box').pause();
						$('.youtube-video').attr('src','');
						var activeTab = $(this).attr('href');

						if(activeTab == '#tabCon1')
						{
							$('#youtube-video-01').attr('src','https://www.youtube.com/embed/2OaRGkZyJjc');
						}
						else if(activeTab == '#tabCon2')
						{
							$('#youtube-video-02').attr('src','https://www.youtube.com/embed/85Ryq_P9pNw');
						}
						else if(activeTab == '#tabCon3')
						{
							$('#youtube-video-03').attr('src','https://www.youtube.com/embed/7ZqsLdG9xbg');
						}
						else if(activeTab == '#tabCon4')
						{
							$('#youtube-video-04').attr('src','https://www.youtube.com/embed/9xoswEzhPIM');
						}

						$('.tabConts').hide();
						$(activeTab).show();

					});
				});
			</script>
			<div class="movie-box">
				<div class="movie-slider">
					<a href="#" id="movie-slider">
						<img src="/resources/homepage/${homepage.context_path}/img/info01-txt.png" alt="" class="movie-btn movie-txt">
						<img src="/resources/homepage/${homepage.context_path}/img/info01.png" alt="" class="movie-btn">
					</a>
					<a href="#" id="movie-close-slider" class="movie-close-slider">
						<img src="http://lib.daegu.go.kr/resources/infoset/homepage/room1/img/bt_closed.png" alt=""/>
					</a>
					<div class="video-box">
						<div class="container">
							<div class="tab_menu main on" style="margin-top:20px;">
								<ul class="no5">
								  <li class="active"><a href="#tabCon0">퀵가이드</a></li>
								  <li><a href="#tabCon1">연경지구 CGV</a></li>
								  <li><a href="#tabCon2">이시아폴리스 메가박스</a></li>
								  <li><a href="#tabCon3">반야월 이마트</a></li>
								  <li><a href="#tabCon4">내 집 앞 도서관 홍보영상</a></li>
								</ul>
							</div>
							<div class="tabConts" id="tabCon0" style="display:block">
								<div class="outer">
									<div class="inner">
										<div class="quickGuide-box">
											<div class="quickGuide fl-left">
												<h5><img src="/resources/homepage/nearbylib/img/quick1-1.png"></h5>
												<p><img src="/resources/homepage/nearbylib/img/quick1-2.png"></p>
											</div>
											<div class="quickGuide fl-right">
												<h5><img src="/resources/homepage/nearbylib/img/quick2-1.png"></h5>
												<p><img src="/resources/homepage/nearbylib/img/quick2-2.png"></p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tabConts" id="tabCon1">
								<div class="outer">
									<div class="inner">
										<iframe class="youtube-video" id='youtube-video-01' width="90%" height="708" src="https://www.youtube.com/embed/2OaRGkZyJjc" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
										<!-- <video id="video-box_1" class="video_box" src="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_CGV.mp4" controls muted loop playinline></video> --> 
									</div>
								</div>
							</div>
							<div class="tabConts" id="tabCon2">
								<div class="outer">
									<div class="inner">
										<iframe class="youtube-video" id='youtube-video-02' width="90%" height="708" src="https://www.youtube.com/embed/85Ryq_P9pNw" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
										<!-- <video id="video-box_2" class="video_box" src="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_ESIA.mp4" controls muted loop playinline></video> -->
									</div>
								</div>
							</div>
							<div class="tabConts" id="tabCon3">
								<div class="outer">
									<div class="inner">
										<iframe class="youtube-video" id='youtube-video-03' width="90%" height="708" src="https://www.youtube.com/embed/7ZqsLdG9xbg" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>										<!-- <video id="video-box_3" class="video_box" src="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_EMART.mp4" controls muted loop playinline></video> -->
									</div>
								</div>
							</div>
							<div class="tabConts" id="tabCon4">
								<div class="outer">
									<div class="inner">	
										<iframe class="youtube-video" id='youtube-video-04' style="" width="90%" height="708" src="https://www.youtube.com/embed/9xoswEzhPIM" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
									</div>
								</div>
							</div>
						</div>	
					</div>
				</div>
				<!-- <div class="dimmed"></div> -->
			</div>
		</div>

		<div class="quickMenu" id="mobile-view">
			<ul>
				<li class="quick-00">
					<div class="tit-box">
						<p>운영기기&nbsp;<br class="mview"/>이용방법&nbsp;</p>
					</div>
					<div class="btn-box">
						<ul>
							<li>
								<a href="#" class="info04-btn-open">
									<span>퀵가이드 바로 보기</span>
								</a>
							</li>
						</ul>
					</div>
				</li>
				<li class="quick-00">
					<div class="tit-box">
						<p>이용방법&nbsp;<br class="mview"/>안내영상&nbsp;</p>
					</div>
					<div class="btn-box">
						<ul>
							<li class="video-cgv">
								<!-- <a href="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_CGV.mp4" title="연경지구 CGV 이용방법"> -->
								<a href="#mo-cgv-view" id='mo-cgv-btn' title="연경지구 CGV 이용방법">
									<span>연경</span>
								</a>
							</li>
							<li class="video-megabox">
								<!-- <a href="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_ESIA.mp4" title="이시아폴리스 메가박스 이용방법"> -->
								<a href="#mo-esia-view" id='mo-esia-btn' title="이시아폴리스 메가박스 이용방법">
									<span>이시아폴리스</span>
								</a>
							</li>
							<li class="video-emart">
								<!-- <a href="/resources/homepage/${homepage.context_path}/movie/NEARBYLIB_EMART.mp4" title="반야월 이마트 이용방법"> -->
								<a href="#mo-emart-view" id='mo-emart-btn' title="반야월 이마트 이용방법">
									<span>반야월</span>
								</a>
							</li>
						</ul>
					</div>
				</li>
				<li class="quick-0">
					<!-- <a href="/resources/homepage/${homepage.context_path}/movie/nearbylib_video.mp4" class="quick00"> -->
					<a href="#mo-nearby-view" id="mo-nearby-btn" class="quick00">
						<div>
							<h4>내 집 앞 도서관 홍보영상</h4>
						</div>
					</a>
				</li>
				<li class="quick-1">
					<a href="/${homepage.context_path}/html.do?menu_idx=8" class="quick01">
						<div>
							<h4>내 집 앞 도서관이란?</h4>
						</div>
					</a>
				</li>
				<li class="quick-2">
					<a href="/${homepage.context_path}/html.do?menu_idx=9" class="quick02">
						<div>
							<h4>도서배송운행코스</h4>
						</div>
					</a>
				</li>
				<li class="quick-3">
					<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=20" class="quick03">
						<div>
							<h4>도서신청</h4>
						</div>
					</a>
				</li>
				<li class="quick-4">
					<a href="/${homepage.context_path}/html.do?menu_idx=16" class="quick04">
						<div>
							<h4>장소안내</h4>
						</div>
					</a>
				</li>
				<li class="quick-5">
					<a href="/${homepage.context_path}/board/index.do?menu_idx=21&manage_idx=1109" class="quick05">
						<div>
							<h4>공지사항</h4>
						</div>
					</a>
				</li>
				<li class="quick-6">
					<a href="/${homepage.context_path}/intro/search/resve/nearby_index.do?menu_idx=23" class="quick06">
						<div>
							<h4>내서재</h4>
						</div>
					</a>
				</li>
			</ul>

		</div>
	</div>

	<div id="foot_section" class="section fp-auto-height footer_area">
		<tiles:insertAttribute name="footer" />
	</div>

	<div class="searchBox" style="display:none;">
		<div class="searchShadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<form id="mainSearchForm2" action="/nearbylib/intro/search/index.do">
			<fieldset>
				<legend class="invisible">검색</legend>
				<div class="searchInput">
					<input type="hidden" name="menu_idx" value="20">
					<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
					<input type="hidden" name="libraryCodes" class="libCheck lib_AA" value="AA"/>
					<input type="hidden" name="libraryCodes" class="libCheck lib_BA" value="BA"/>
					<input type="hidden" name="libraryCodes" class="libCheck lib_CB" value="CB"/>
					<input type="hidden" name="libraryCodes" class="libCheck lib_CA" value="CA"/>
					<input type="hidden" name="libraryCodes" class="libCheck lib_AH" value="AH"/>
					<div class="box1">
						<div class="box2">
							<label for="search_text_2" class="blind">통합자료검색</label>
							<input name="title" id="search_text_2" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
						</div>
					</div>
				</div>
				<input type="submit" class="btnSearch" value="" title="Search">
			</fieldset>
		</form>
	</div>

	<div class="nearbylibinfo01" style="display:none;">
		<div class="nearbylibinfo01-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="infoArea">
			<div class="nbl-info-box1">
				<div class="nbl-position">
					<p>건물 내</p>
					<h5>5층</h5>
				</div>
				<h3 class="nbl">주소</h3>
				<ul class="nbl-list">
					<li>대구광역시 북구 동화천로 290</li>
				</ul>
				<h3 class="nbl">주차정보</h3>
				<ul class="nbl-list">
					<li>건물 주차타워 이용</li>
					<li>무료주차(당일 영화 관람 시) 4시간 초과 시 10분당 500원 추가요금 적용</li>
					<!-- <li>영화관 4층 로비에서 주차인증 필수<br />* 주차공간이 협소하오니 가급적 대중교통 이용바랍니다.</li> -->
				</ul>
				<h3 class="nbl">교통정보</h3>
				<ul class="bus_list">
					<li><span class="ico_bus_m">간선<span class="num">503</span></span></li>
					<li><span class="ico_bus_j">지선<span class="num">동구9</span></span></li>
					<li><span class="ico_bus_j">지선<span class="num">북구2</span></span></li>
					<li><span class="ico_bus_g">급행<span class="num">급행6</span></span></li>
				</ul>
				<div class="end"></div>
				<h3 class="nbl">건물 내 편의시설</h3>
				<ul class="add-fac">
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-1.png">
						<p>주차장</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-2.png">
						<p>무선인터넷</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-3.png">
						<p>화장실</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-4.png">
						<p>식당</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-5.png">
						<p>장애인편의</p>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="nearbylibinfo02" style="display:none;">
		<div class="nearbylibinfo02-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="infoArea">
			<div class="nbl-info-box3">
				<div class="nbl-position">
					<p>건물 내</p>
					<h5>3층</h5>
				</div>
				<h3 class="nbl">주소</h3>
				<ul class="nbl-list">
					<li>대구광역시 동구 안심로 389-2</li>
				</ul>
				<h3 class="nbl">주차정보</h3>
				<ul class="nbl-list">
					<li>주차장 및 건물 주차타워 이용</li>
					<li>이마트 이용고객 무료주차 가능</li>
				</ul>
				<h3 class="nbl">교통정보</h3>
				<ul class="bus_list">
					<li><span class="ico_bus_m">간선<span class="num">518</span></span></li>
					<li><span class="ico_bus_m">간선<span class="num">849</span></span></li>
					<li><span class="ico_bus_m">간선<span class="num">814</span></span></li>
					<li><span class="ico_bus_m">간선<span class="num">808</span></span></li>
					<li><span class="ico_bus_n">일반<span class="num">55</span></span></li>
					<li><span class="ico_bus_n">일반<span class="num">555</span></span></li>
					<li><span class="ico_bus_g">급행<span class="num">급행5</span></span></li>
				</ul>
				<div class="end"></div>
				<h3 class="nbl">건물 내 편의시설</h3>
				<ul class="add-fac">
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-1.png">
						<p>주차장</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-2.png">
						<p>무선인터넷</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-3.png">
						<p>화장실</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-4.png">
						<p>식당</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-5.png">
						<p>장애인편의</p>
					</li>
				</ul>
				<h3 class="nbl">유의사항</h3>
				<ul class="nbl-list">
					<li>2·4째주 월요일은 마트 휴점이므로 반납 불가</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="nearbylibinfo03" style="display:none;">
		<div class="nearbylibinfo03-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="infoArea">
			<div class="nbl-info-box2">
				<div class="nbl-position">
					<p>건물 내</p>
					<h5>2층</h5>
				</div>
				<h3 class="nbl">주소</h3>
				<ul class="nbl-list">
					<li>대구광역시 동구 팔공로49길 51</li>
				</ul>
				<h3 class="nbl">주차정보</h3>
				<ul class="nbl-list">
					<li>건물 주차타워 이용</li>
					<li>무료주차(당일 영화 관람 시) 3시간 30분 초과 시 30분당 1,000원 추가요금 적용</li>
					<!-- <li>출차 시 무인 정산기 이용</li> -->
				</ul>
				<h3 class="nbl">교통정보</h3>
				<ul class="bus_list">
					<li><span class="ico_bus_m">간선<span class="num">101</span></span></li>
					<li><span class="ico_bus_m">간선<span class="num">101-1</span></span></li>
					<li><span class="ico_bus_m">간선<span class="num">401</span></span></li>
					<li><span class="ico_bus_j">지선<span class="num">팔공1</span></span></li>
					<li><span class="ico_bus_g">급행<span class="num">급행6</span></span></li>
				</ul>
				<div class="end"></div>
				<h3 class="nbl">건물 내 편의시설</h3>
				<ul class="add-fac">
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-1.png">
						<p>주차장</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-2.png">
						<p>무선인터넷</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-3.png">
						<p>화장실</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-4.png">
						<p>식당</p>
					</li>
					<li>
						<img src="/resources/homepage/nearbylib/img/nbl-info-ico5-5.png">
						<p>장애인편의</p>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="nearbylibinfo04" style="display:none;">
		<div class="nearbylibinfo03-shadow"></div>
		<div class="closeBtn closeBtn2"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="infoArea infoArea2">
			<!-- <p class="quickGuide-title"><span class="c-blue">내 집 앞 도서관</span> 운영기기<br /><span class="c-green">이렇게 이용하세요!</span></p> -->
			<div class="quickGuide-box">
				<div class="quickGuide fl-left">
					<h5><img src="/resources/homepage/nearbylib/img/quick1-1.png"></h5>
					<p><img src="/resources/homepage/nearbylib/img/quick1-2.png"></p>
				</div>
				<div class="quickGuide fl-right">
					<h5><img src="/resources/homepage/nearbylib/img/quick2-1.png"></h5>
					<p><img src="/resources/homepage/nearbylib/img/quick2-2.png"></p>
				</div>
			</div>
		</div>
	</div>

	<div id="mo-cgv-view" class="mo-video-view" style="display:none;">
		<div class="mo-nearby-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="" style='position:relative;height:100%;z-index:999993;'>
			<div class="outer">
				<div class="inner">
					<div class="video-container">
						<iframe class="m-youtube-video" id='m-youtube-video-01' width="90%" height="67.5%" src="https://www.youtube.com/embed/2OaRGkZyJjc" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="mo-esia-view" class="mo-video-view" style="display:none;">
		<div class="mo-nearby-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="" style='position:relative;height:100%;z-index:999993;'>
			<div class="outer">
				<div class="inner">
					<div class="video-container">
						<iframe class="m-youtube-video" id='m-youtube-video-02' width="90%" height="67.5%" src="https://www.youtube.com/embed/85Ryq_P9pNw" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="mo-emart-view" class="mo-video-view" style="display:none;">
		<div class="mo-nearby-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="" style='position:relative;height:100%;z-index:999993;'>
			<div class="outer">
				<div class="inner">
					<div class="video-container">
						<iframe class="m-youtube-video" id='m-youtube-video-03' width="90%" height="67.5%" src="https://www.youtube.com/embed/7ZqsLdG9xbg" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="mo-nearby-view" class="mo-video-view" style="display:none;">
		<div class="mo-nearby-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="" style='position:relative;height:100%;z-index:999993;'>
			<div class="outer">
				<div class="inner">
					<div class="video-container">
						<iframe class="m-youtube-video" id='m-youtube-video-04' style="" width="90%" height="67.5%" src="https://www.youtube.com/embed/9xoswEzhPIM" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
