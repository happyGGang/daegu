<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<tiles:insertAttribute name="header" />
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />
<script type="text/javascript">
	$(function() {

		// 팝업 관련 코드 START
		$('.close-btn').on('click', function() {
			var $this = $(this);
			var checkInput = $this.parent().find('input');
			var popupId = checkInput.val();
			if ( checkInput.prop('checked') ) {
				var todayDate 	= new Date();
				todayDate 		= new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}

			$('div#'+popupId).hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$(this).parent('div').next('a').click();
		});

		$('#popupLayer > div').each(function(i, v) {
			var result = '';
			var name = $(v).attr('id');
			var nameOfCookie = name + "=";
		    var x = 0;
		    while ( x <= document.cookie.length ) {
		       var y = ( x + nameOfCookie.length );
		       if ( document.cookie.substring( x, y ) == nameOfCookie ) {
		           if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
		               endOfCookie = document.cookie.length;
		           result = unescape( document.cookie.substring( y, endOfCookie ) );
		       }
		       x = document.cookie.indexOf( " ", x ) + 1;
		       if ( x == 0 )
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
	   	$(window).resize(function() {
	   		$('.lt_photo img').height($('.lt_photo img').width() * 0.9);
	   	}).trigger('resize');

	   	$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});
	   	var resizeFunc = function() {
			$('.lt_photo img').height($('.lt_photo img').width() * 0.9);
		};
		$(window).resize(resizeFunc);

	   	$('div#planList').load('calendar2.do', resizeFunc);
		resizeFunc();

	   	doAjaxLoad('ul#likeBook', 'newBook.do','');

	});
	</script>

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}"/>
		</div>
	</div>
	<div id="container" class="main">
		<div class="main_bg">
			<div class="main1">
				<div class="section">
					<div class="txt">
						<img src="/resources/homepage/${homepage.context_path}/img/main-txt.png" alt="도서관, 생활속의 열린 교육 &middot; 문화 공간"/>
					</div>
					<ul class="main_img">
						<li>&nbsp;</li>
					</ul>
				</div>
			</div>
			<div class="main2">
				<div class="section">
					<div class="main2_box">
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="7">
								<input type="hidden" name="search_type2" value="L_TITLEAUTHOR">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="box1">
										<div class="box2">
											<label for="search_text_1" class="blind">자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
										</div>
									</div>
									<button id="main-search-btn">통합검색</button>
								</fieldset>
							</form>
						</div>
						<div id="planList">

						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="qmenu">
			<div class="section">
				<ul data-call="bxslider" data-breaks="[{screen:0, slides:1},{screen:340, slides:2},{screen:450, slides:3},{screen:600, slides:4},{screen:767, slides:6},{screen:1000, slides:${fn:length(quickMenuList)}}]">
					<homepageTag:quickMenu quickMenuList="${quickMenuList}"/>
				</ul>
			</div>
		</div>
		<div class="main_line">
			<div class="section">
				<div class="main3">
					<div class="news">
						<div class="box">
							<h3>공지사항</h3>
							<ul>
								<c:forEach var="i" items="${noticeList}">
								<c:choose>
									<c:when test="${i.date_gap <= i.new_date_count}">
										<li class="new">
									</c:when>
									<c:otherwise>
										<li>
									</c:otherwise>
								</c:choose>
									<a href="/${homepage.context_path}/board/view.do?menu_idx=58&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><em>${i.title}</em></a>
									<span><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></span>
								</li>
								</c:forEach>
							</ul>
							<a href="/${homepage.context_path}/board/index.do?menu_idx=58&manage_idx=196" class="more">더보기</a>
						</div>
					</div>
				</div>
				<div class="main4">
					<div class="box">
						<h3>신착도서</h3>
						<ul class="lt_photo" id="likeBook">

						</ul>
						<a href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=12" class="more">더보기</a>
					</div>
				</div>
				<div class="main5">
					<div class="popupzone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/common/img/type17/popupnone.jpg" alt="" /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="main6_bg">
			<div class="main6 section">
				<div class="lt1"><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=163&categroy_idx_list=1,2,3,4,5">평생교육프로그램</a></div>
				<div class="lt2"><a href="/${homepage.context_path}/html.do?menu_idx=35">독서문화행사</a></div>
				<div class="lt3"><a href="/${homepage.context_path}/board/index.do?menu_idx=21&manage_idx=267">사서추천도서</a></div>
			</div>
		</div>

		<div class="section">
			<div class="main7_banner">
				<div class="banner-wrap type1">
					<div class="banner-t">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><i class="fa fa-chevron-left"></i><span class="blind">이전</span></a>
							<a class="stop active" href="#stop"><i class="fa fa-pause"></i><span class="blind">정지</span></a>
							<a class="play" href="#play"><i class="fa fa-play"></i><span class="blind">시작</span></a>
							<a class="next" href="#next"><i class="fa fa-chevron-right"></i><span class="blind">다음</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=157"><i class="fa fa-navicon"></i><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box">
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<tiles:insertAttribute name="footer" />