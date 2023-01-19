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
		$('.movie-box').css('top','5%');
		$('#movie-close-slider').css('display','block');
		//$('.dimmed').css('display','block');
		$('#ProgramLink-container').css('display','none');
		_video.load(); // 새로운 정보를 다시 로드
		_video.play(); // 잘 동작함		
		return false;
	});	
	
	$('a#movie-close-slider').click(function (e) {
		e.preventDefault();
		$('.movie-box').css('top','100%');
		$('#movie-close-slider').css('display','none');
		//$('.dimmed').css('display','none');
		$('#ProgramLink-container').css('display','block');
		_video.load(); // 새로운 정보를 다시 로드
		_video.pause(); // 잘 동작함		
		return false;
	});	
	
	setInterval("kioskGlobal.dateTimer()", 1000);
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

});
</script>

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
							<div class="outer">
								<div class="inner">	
									<video id="video-box" src="/resources/homepage/${homepage.context_path}/movie/nearbylib_video.mp4" controls muted loop playinline></video>
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
				<li class="quick-0">
					<a href="/resources/homepage/${homepage.context_path}/movie/nearbylib_video.mp4" class="quick00">
					<div>
						<h4>내집앞도서관 홍보영상</h4>
					</div>
				</a>
				<li class="quick-1">
					<a href="/${homepage.context_path}/html.do?menu_idx=8" class="quick01">
					<div>
						<h4>내집앞도서관이란?</h4>
					</div>
				</a>
				<li class="quick-2">
				<a href="/${homepage.context_path}/html.do?menu_idx=9" class="quick02">
					<div>
						<h4>도서배송운행코스</h4>
					</div>
				</a>
				</li>
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
</div>
</body>
</html>
