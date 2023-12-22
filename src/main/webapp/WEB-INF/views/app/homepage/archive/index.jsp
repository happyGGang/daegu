<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.css"/>
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
	//새로운 소식 이미지 링크
	$('a.goList').on('click', function(e) {
		e.preventDefault();
		var menu_url_param = 'menu_idx=11&large_code='+$(this).attr('keyValue1')+'&mid_code='+$(this).attr('keyValue2')+'&small_code='+$(this).attr('keyValue3')+'&type='+$(this).attr('keyValue4');
		$('form#archiveGoForm input#menu_url_param').val(menu_url_param);
		doGetLoad('/archive/module/archive/go.do', serializeCustom($('form#archiveGoForm')));
	});
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form id="archiveGoForm" action="/archive/module/archive/go.do" method="GET">
	<input type="hidden" id="menu_url_param" name="menu_url_param" value="">
</form>
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

			<main id="content" role="main">
			<div id="frontCarousel" class="carousel slide" data-ride="carousel">

				<ol class="carousel-indicators carousel-indicators--round">
					<li data-target="#frontCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#frontCarousel" data-slide-to="1"></li>
				</ol>

				<div class="carousel-inner">
					<div class="carousel-item active" style="background:url('/resources/homepage/${homepage.context_path}/img/main0-visual.jpg') no-repeat;background-size:cover;">
						<div class="container">
							<div class="carousel-contents">
								<div class="carousel-text">
									<b>대구,</b><br/>
									대구도서관에서<br/>
									만나다.<br/>
									<p>대구의 기억을 기록하는 디지털 아카이브</p>
								</div>
							</div>
							<div class="carousel-caption col-10">
								<h1>대구의 기억</h1>
								<p class="description"><span>대구정신을 일깨운<br />선구자들의 발자취<br /></span></p>
								<a href="/${homepage.context_path}/html.do?menu_idx=7" class="btn-primary"><img src="/resources/homepage/${homepage.context_path}/img/main0-arrow.png" alt="대구학디지털 아카이브 소개 자세히보기" />이동</a>
							</div>
						</div>
					</div>
					<div class="carousel-item" style="background:url('/resources/homepage/${homepage.context_path}/img/main1-visual.jpg') no-repeat;background-size:cover;">
						<div class="container">
							<div class="carousel-contents">
								<div class="carousel-text">
									<b>대구학,</b><br/>
									지식허브<br/>
									디지털 아카이브<br/>
									<p>유ㆍ무형의 대구학 디지털 자료</p>
								</div>
							</div>
							<div class="carousel-caption col-10">
								<h1>새로운 시각의<br/>애뜰전시</h1>
								<p class="description"><span>전시를 통한<br />대구의 기억<br /></span></p>
								<a href="/${homepage.context_path}/module/elib/asp/search/aeddle.do?menu_idx=94" class="btn-primary"><img src="/resources/homepage/${homepage.context_path}/img/main0-arrow.png" alt="애뜰전시 소개 자세히보기" />이동</a>
							</div>
						</div>
					</div>
				</div>

				<a class="carousel-control-prev" href="#frontCarousel" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="carousel-control-next" href="#frontCarousel" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			</main>

			<!-- main_search -->
			<div class="search-area" id="main_search">
				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/archive/index.do">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
						<input type="hidden" name="menu_idx" value="11">
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="search-form">

							<div class="box1">
								<select id="search_type" name="search_type" class="selectmenu" style="width:100%;font-size:105%;padding-left:15px;" title="검색조건">
									<option value="all">전체</option>
									<option value="title">제목</option>
									<option value="description">키워드</option>
									<option value="addle_data_yn">애뜰자료</option>
								</select>
							</div>

							<div class="box">
								<div class="b1">
									<input type="text" id="search_text_1" name="search_text" class="text" title="검색어 입력폼" placeholder="검색어를 입력하세요." style="ime-mode:active; width:90%;" />
								</div>
								<div class="b2">
									<button id="main-search-btn">검색하기</button>
								</div>
							</div>

						</div>
					</fieldset>
					</form>
				</div>
			</div>
			<!-- //Main_search -->


		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section'>

				<div class="card-box">
					<div class="row">
						<div class="col-md-4 my-2">
							<a href="https://library.busan.go.kr/archive/module/archive/index.do?menu_idx=37&large_code=A&product_year=0001">
								<div class="card">
									<img src="/resources/homepage/${homepage.context_path}/img/main1-img02.png" alt="대구기관 이미지">
									<div class="card-body">
										<h2>시대별</h2>
										<p>대구의 재발견ㆍ대구역사 자료 모음</p>
									</div>
								</div>
							</a>
						</div>

						<div class="col-md-4 my-2">
							<a href="https://library.busan.go.kr/archive/module/archive/index.do?menu_idx=40&large_code=A&type=0001">
								<div class="card">
									<img src="/resources/homepage/${homepage.context_path}/img/main1-img01.png" alt="대구학술 이미지">
									<div class="card-body">
										<h2>유형별</h2>
										<p>간행물, 사진 등 유형별 자료 모음</p>
									</div>
								</div>
							</a>
						</div>

						<div class="col-md-4 my-2">
							<a href="https://library.busan.go.kr/archive/module/archive/index.do?menu_idx=71&large_code=A&region=0001">
								<div class="card">
									<img src="/resources/homepage/${homepage.context_path}/img/main1-img03.png" alt="대구행정 이미지">
									<div class="card-body">
										<h2>지역별</h2>
										<p>대구의 행정구역별 자료 모음</p>
									</div>
								</div>
							</a>
						</div>
					</div>
				</div>

				<div class="news-box">
	
					<div class="row">
						<div class="col-md-3 news-box-title">
							<h2>새로운 소식</h2>
							<div class='line'></div>
							<p>새롭게 업데이트 된<br class='webBr'/>자료와 소식을 안내합니다.</p>
						</div>
						<div class="col-md-9 p-sm-0" style="right:-2px;">

								<div class="">
									<div class="row">
										<c:forEach items="${mainNewArchiveList}" var="i" varStatus="status">
										<div class="col-md-6 my-1 new-contents">
											<div class="border">
												<div class="frame p-3">
													<a href="#goList" class="image goList" keyValue1="${i.large_code}" keyValue2="${i.mid_code}" keyValue3="${i.small_code}" keyValue4="${i.type}"><img class="img-fluid" src="/data/archive/img/${i.image_file_name}" onError="this.src='/resources/common/img/noImg.gif'" alt="아카이브메인" title="아카이브메인"/></a>
												</div>
												<div class="contents pr-3 pl-3 pb-3">
													<h3>${i.title}</h3>
													<c:set var="body" value="${i.description}"/>
													<c:if test="${fn:length(i.description) > 50}">
														<c:set var="body" value="${fn:substring(i.description, 0, 50)}..."/>
													</c:if>
													<p class="text-muted">${body}</p>
												</div>
											</div>
										</div>
										</c:forEach>

									</div>
								</div>

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


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage'],
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
				//$('.tnb').css('background','#2a2e37');
			} else if( destination.index == 1 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#2a2e37');
			} else {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#2a2e37');
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
<script src="/resources/homepage/${homepage.context_path}/js/popper.min.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/bootstrap.min.js"></script>

</body>
</html>

