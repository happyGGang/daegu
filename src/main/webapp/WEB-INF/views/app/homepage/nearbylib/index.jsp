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

	/*
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
	*/
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
			<span class="yeongyeong"><a href="/nearbylib/html.do?menu_idx=15"><img src="/resources/homepage/${homepage.context_path}/img/yeongyeon.png" alt=""></a></span>
			<span class="bayawol"><a href="/nearbylib/html.do?menu_idx=17"><img src="/resources/homepage/${homepage.context_path}/img/bayawol.png" alt=""></a></span>
			<span class="isia"><a href="/nearbylib/html.do?menu_idx=16"><img src="/resources/homepage/${homepage.context_path}/img/isia.png" alt=""></a></span>
			<span class="lib01"><a href="https://library.daegu.go.kr/donggu/html.do?menu_idx=132" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/lib01.png" alt=""></a></span>
			<span class="lib02"><a href="https://library.daegu.go.kr/dongbu/html.do?menu_idx=109" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/lib02.png" alt=""></a></span>
			<span class="lib03"><a href="https://library.daegu.go.kr/228/html.do?menu_idx=165" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/lib03.png" alt=""></a></span>
			<span class="lib04"><a href="https://library.daegu.go.kr/bukgs/html.do?menu_idx=49" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/lib04.png" alt=""></a></span>
			<span class="lib05"><a href="https://library.daegu.go.kr/donggu/html.do?menu_idx=132" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/lib05.png" alt=""></a></span>
			<span class="bal01"><a href="/nearbylib/html.do?menu_idx=7" class="info01-btn-open"><img src="/resources/homepage/${homepage.context_path}/img/bal01.png" alt=""></a></span>
			<span class="bal02"><a href="/nearbylib/html.do?menu_idx=6" class="info02-btn-open"><img src="/resources/homepage/${homepage.context_path}/img/bal02.png" alt=""></a></span>
			<span class="bal03"><a href="#" class="btn-open"><img src="/resources/homepage/${homepage.context_path}/img/bal03.png" alt=""></a></span>
			<div class="movie-box">
				<div class="movie-slider">
					<a href="javascript:alert('준비중입니다.');" id="movie-slider">
						<img src="/resources/homepage/${homepage.context_path}/img/info01-txt.png" alt="" class="movie-btn movie-txt">
						<img src="/resources/homepage/${homepage.context_path}/img/info01.png" alt="" class="movie-btn">
					</a>
				</div>
			</div>
		</div>

		<div class="quickMenu" id="mobile-view">

			<ul>
				<li class="quick-1">
					<a href="/${homepage.context_path}/html.do?menu_idx=6" class="quick01">
					<div>
						<h4>내집앞도서관이란?</h4>
					</div>
				</a>
				<li class="quick-2">
				<a href="/${homepage.context_path}/html.do?menu_idx=7" class="quick02">
					<div>
						<h4>도서배송운행코스</h4>
					</div>
				</a>
				</li>
				</li>
				<li class="quick-3">
				<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=8" class="quick03">
					<div>
						<h4>도서신청</h4>
					</div>
				</a>
				</li>
				<li class="quick-4">
				<a href="/${homepage.context_path}/html.do?menu_idx=15" class="quick04">
					<div>
						<h4>장소안내</h4>
					</div>
				</a>
				</li>
				<li class="quick-5">
				<a href="/${homepage.context_path}/board/index.do?menu_idx=4&manage_idx=1110" class="quick05">
					<div>
						<h4>공지사항</h4>
					</div>
				</a>
				</li>
				<li class="quick-6">
				<a href="/${homepage.context_path}/html.do?menu_idx=9" class="quick06">
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
					<input type="hidden" name="menu_idx" value="8">
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
			도서배송 운행코스
		</div>
	</div>

	<div class="nearbylibinfo02" style="display:none;">
		<div class="nearbylibinfo02-shadow"></div>
		<div class="closeBtn"><button class="btn btn-close"><span class="blind">닫기</span></button></div>
		<div class="infoArea">
			내집앞도서관안내
		</div>
	</div>

</div>
</body>
</html>
