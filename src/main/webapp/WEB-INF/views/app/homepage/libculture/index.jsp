<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.mhportal.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/swiper.css"/>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.mhportal.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/commons.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/slick_ui.js"></script>


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

	// TAB
	$(document).on('click', '.tabMenu a.curationtab', function(e){
		e.preventDefault();
		$('.tabMenu li').removeClass('on');
		$(this).parent('li').addClass('on');
		var target = this.getAttribute('href').replace('#','');
		var code = $(this).attr('keyValue');
		$('.mainSec02').hide();
		$('#'+target).show();

		//setTimeout(() => console.log("2초 후에 실행됨"), 2000);

		switch(code)
		{
			case "01":
				CurationList01();
				break;
			case "02":
				CurationList02();
				break;
			case "03":
				CurationList03();
				break;
			case "04":
				CurationList04();
				break;
			case "05":
				CurationList05();
				break;
			case "06":
				CurationList06();
				break;
		}
		
	});
	$('div#visual-load-box').load('education.do');
	// main0 - 최상단 이벤트
	$(document).on('click', '.tabMenuT a', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		$(this).closest('.tabMenuT').find('li').removeClass('on');
		$(this).parent('li').addClass('on');

		$('div#visual-load-box').empty();

		if(target == 'tab1')
		{
			$('div#visual-load-box').load('education.do');
		}
		else if(target == 'tab2')
		{
			$('div#visual-load-box').load('culture.do');
		}
		else if(target == 'tab3')
		{
			$('div#visual-load-box').load('exhibition.do');
		}
		else if(target == 'tab4')
		{
			$('div#visual-load-box').load('movie.do');
		}
		else
		{
			$('div#visual-load-box').load('education.do');
		}
	});

	/* main1 - 다 드림 부분 이벤트*/
	var culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
	var culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
	var area = $('#area option:selected').val();
	var target = $('#target option:selected').val();
	var hashtag = $('#hashtag option:selected').val();
	var sortType = $('#sortType option:selected').val();

	$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType=REQUEST');


	$('select#area').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag);
	});

	$('select#target').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag);
	});

	$('select#hashtag').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag);
	});

	$('select#sortType').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag);
	});

	$('.culture-search-condition-box-cal ul li a').on('click', function(e) {
		e.preventDefault();

		$('.culture-search-condition-box-cal ul li').removeClass('on');
		$(this).parent('li').addClass('on');

		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag);
	});

	// 지역별 문화체험 버튼 이벤트
	$(document).on('click', '.tabMenuA a.areacluturetab', function(e){
		e.preventDefault();
		var target = this.getAttribute('href').replace('#','');
		$(this).closest('.tabMenuA').find('li').removeClass('on');
		$(this).parent('li').addClass('on');

		var area = $('#daeguArea option:selected').val();

		if(target == 'tabs01')
		{
			$('div#areaculture .areaCultureSlideList').load('areaexhibition.do?search_area='+area);
		}
		else if(target == 'tabs02')
		{
			$('div#areaculture .areaCultureSlideList').load('areacarnival.do?search_area='+area);
		}
		else if(target == 'tabs03')
		{
			$('div#areaculture .areaCultureSlideList').load('areaculture.do?search_area='+area);
		}
		else
		{
			$('div#areaculture .areaCultureSlideList').load('areaexhibition.do?search_area='+area);
		}
	});

	$('div#areaculture .areaCultureSlideList').load('areaexhibition.do?search_area=');

	$('#daeguArea').on('change',function(){
		var area = $(this).find('option:selected').val();
		var id = '';

		$('#main3 .areaculturetab .tabMenuA ul li').each(function(index, item){
			if($(item).hasClass('on')) {
				id = $(item).attr('id');

				if (id == 'tabs001') {
					$('div#areaculture .areaCultureSlideList').load('areaexhibition.do?search_area='+area)
				} else if (id == 'tabs002') {
					$('div#areaculture .areaCultureSlideList').load('areacarnival.do?search_area='+area)
				} else if (id == 'tabs003') {
					$('div#areaculture .areaCultureSlideList').load('areaculture.do?search_area='+area)
				}
			}
		})
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
		<div id="main0" class="section">
			<div class="main0-wrap">
				<div class="main0-scroll">
					<div class="scroll-down">
						<p>Scroll Down</p>
						<div class="scroll_down">
							<span></span>
						</div>
						<div class="scroll_down_line"></div>
					</div>
				</div>
				<div class="main0-center">
					<div class="main0-top-box">
						<div class='wide-1600-sections'>

							<div class="searchBox tabT">
								<h2>대구통합도서관의</h2>
								<ul class="tabMenuT">
									<li class="on"><a href="#tab1">강좌</a></li>
									<li><a href="#tab2">문화</a></li>
									<li><a href="#tab3">전시</a></li>
									<li><a href="#tab4">영화</a></li>
								</ul>
							</div>
							<div id="visual-load-box">

							</div>

						</div>
					</div>
					<div class="main0-bottom-box">
						<div class='wide-1600-sections'>
							<div class="ing-slide-box">
								<div class="ing-title">
									<h3>진행중인 <b>강좌</b></h3>
									<p>대구통합도서관의<br/>현재 진행중인<br/>강좌들을 안내해드립니다.</p>
								</div>
								<div class="ing-slide">
									<div class="ingSlideList">
										<ul>
											<c:if test="${fn:length(teachViewList) < 1}">
												<li>
													등록된 데이터가 없습니다
												</li>
											</c:if>

											<c:forEach var="i" items="${teachViewList}">
												<li>
													<a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" target="_blank">
														<div class="top">
															<h4>${i.teach_name}</h4>
															<p class='days'>${i.start_join_date} ~ ${i.end_join_date}</p>
															<span>${i.homepage_alias}</span>
														</div>
														<div class="bottom">
															<span>모집인원<br/>${i.teach_limit_count}</span>
															<span>신청인원<br/>${i.teach_join_count}</span>
															<span>후보인원<br/>${i.teach_backup_join_count} / ${i.teach_backup_count}</span>
														</div>
													</a>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
								<div class="end"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="main0-empty">
				</div>
			</div>
		</div>
		<!-- //main0 -->

		<!-- main1 - 강좌 조건검색 -->
		<div id="main1" class="section">
			<div class="main1-wrap">
				<div class="main1-scroll">
				</div>
				<div class="main1-center">
					<div class="main1-top-box">
						<div class='wide-1600-sections'>
							<div class="culture-search-title">
								<div class="outer">
									<div class="inner">
										<h3>다多<Br class="web-br2"/>드림Dream</h3>
										<p>다양한 문화 활동과 경험으로 <Br/>꿈을 키워보세요.</p>
									</div>
								</div>
							</div>
							<div class="culture-search-condition">
								<div class="outer">
									<div class="inner">
										<div class="culture-search-condition-box-sel">
											<ul>
												<li>
													<select name="area" id="area" class="cultureSelectBox">
														<option value="">지역을 선택해주세요 </option>
														<c:forEach var="i" items="${areaCodeList}">
															<option value="${i.code_name}">${i.code_name}</option>
														</c:forEach>
													</select>
												</li>
												<li>
													<select name="target" id="target" class="cultureSelectBox">
														<option value="">대상을 선택해주세요 </option>
														<c:forEach var="i" items="${ageCodeList}">
															<option value="${i.code_id}">${i.code_name}</option>
														</c:forEach>
													</select>
												</li>
												<li>
													<select name="hashtag" id="hashtag" class="cultureSelectBox">
														<option value="">주제를 선택해주세요 </option>
														<c:forEach var="i" items="${hashtagCodeList}">
															<option value="${i.hashtag_code}">${i.hashtag_name}</option>
														</c:forEach>
													</select>
												</li>
												<li>
													<select name="sortType" id="sortType" class="cultureSelectBox">
														<option value="REQUEST">신청일</option>
														<option value="OPERATE">운영일</option>
													</select>
												</li>
											</ul>
										</div>
										<div id="culture_cal" class="culture-search-condition-box-cal">
											<div class="web-selector">
											<ul>
												<li>
													<!-- example -->
													<c:set var="now" value="<%=new java.util.Date()%>" />
													<fmt:formatDate value="${now}" pattern="yyyy" type="date"/>
												</li>
												<fmt:formatDate value="${now}" pattern="MM" type="date" var="mm"/>
												<fmt:formatNumber var="mm" minIntegerDigits="2" value="${mm}" type="number"/>
												<c:forEach var="i" begin="1" end="12">
													<fmt:formatNumber var="no" minIntegerDigits="2" value="${i}" type="number"/>
													<li class="${mm == no ? 'on' : ''}"><a href="#" keyValue="${no}">${no}월</a></li>
												</c:forEach>
											</ul>
											</div>
											<div class="mobile-selector">
												<h4><c:set var="now" value="<%=new java.util.Date()%>" />
													<fmt:formatDate value="${now}" pattern="yyyy" type="date"/><!--년도 함수--></h4>&nbsp;
												<select name="">
													<c:forEach var="i" begin="1" end="12">
														<fmt:formatNumber var="no" minIntegerDigits="2" value="${i}" type="number"/>
														<option value="">${no}월</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="end"></div>
						</div>
					</div>

					<div class="main1-bottom-box">

					</div>
				</div>
				<div class="main1-empty">
				</div>
			</div>
		</div>
		<!-- //main1 -->

		<!-- main2 - 큐레이션 -->
		<div id="main2" class="section">
			<div class="main2-wrap">
				<div class="main2-scroll">
				</div>
				<div class="main2-center">
					<div class="mainSec02-title">
						<div class="wide-1650-sections">
							<h2><p class="bt">문화의향유 큐레이션</p> <p class="st">다양한 분야의 문화 콘텐츠를 확인하세요.</p></h2>
							<div class="tabMenu">
								<ul>
									<li class="on"><a href="#tab01" class='curationtab' keyValue="01">전체</a></li>
									<li><a href="#tab02" class='curationtab' keyValue="02">문화생활</a></li>
									<li><a href="#tab03" class='curationtab' keyValue="03">무료전시</a></li>
									<li><a href="#tab04" class='curationtab' keyValue="04">특별강연</a></li>
									<li><a href="#tab05" class='curationtab' keyValue="05">역사인문</a></li>
									<li><a href="#tab06" class='curationtab' keyValue="06">IT체험</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div id="tab01" class="mainSec02 mainSection01">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>전체</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>전체</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>전체</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>전체</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div id="tab02" class="mainSec02 mainSection02">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>문화생활</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>문화생활</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>문화생활</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>문화생활</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div id="tab03" class="mainSec02 mainSection03">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>무료전시</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>무료전시</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>무료전시</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>무료전시</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div id="tab04" class="mainSec02 mainSection04">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>특별강연</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>특별강연</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>특별강연</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>특별강연</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div id="tab05" class="mainSec02 mainSection05">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>역사인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>역사인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>역사인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>역사인문</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div id="tab06" class="mainSec02 mainSection06">
						<div class="innerBox">
							<div class="arrowBtn">
								<a href="#" class="prev">이전</a>
								<a href="#" class="next">다음</a>
							</div>

							<div class="slickPlay">
								<p class="status"><span>01</span> / 04</p>
								<a href="#" class="play">시작</a>
								<a href="#" class="pause">멈춤</a>
							</div>
							<div class="slickWrap" data-animation="fadeInUp">
								<div>
									<a href="">
										<h2>IT체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_1.png" alt="" /></p>
										<span class="link">Q-Basic<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>IT체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_2.png" alt="" /></p>
										<span class="link">Q-Advance<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>IT체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_3.png" alt="" /></p>
										<span class="link">Q-Pro<i></i></span>
									</a>
								</div>
								<div>
									<a href="">
										<h2>IT체험</h2>
										<p class="img"><img src="/resources/homepage/${homepage.context_path}/img/img_4.png" alt="" /></p>
										<span class="link">Q-Mass<i></i></span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="main2-empty">
				</div>
			</div>
		</div>

		<!-- main3 - 지역문화 -->
		<div id="main3" class="section">
			<div class="main3-wrap">

				<div class="main3-center">
					<div class="mainSec03-title">
						<div class="wide-1650-sections">
							<h2>지역별 문화체험</h2>
							<div class="areaculturetab">
								<div class="select-box">
									<select id="daeguArea" class="daegu-area">
										<option value="">지역을 선택해주세요</option>
										<c:forEach var="i" items="${areaCodeList}">
											<option value="${i.code_name}">${i.code_name}</option>
										</c:forEach>
									</select>
								</div>
								<div class="tabMenuA">
									<ul>
										<li class="on" id="tabs001"><a href="#tabs01" class='areacluturetab'>공연전시</a></li>
										<li id="tabs002"><a href="#tabs02" class='areacluturetab' keyValue="02">행사축제</a></li>
										<li id="tabs003"><a href="#tabs03" class='areacluturetab' keyValue="03">문화공간</a></li>
									</ul>
								</div>
							</div>
							<div class="end"></div>
						</div>
					</div>
					<div id="areaculture" class="mainSec03-contents">
						<div class="areaCultureSlideList">

						</div>
					</div>
				</div>

			</div>
		</div>

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
		anchors: ['firstPage', 'secondPage', 'thirdPage','fourthPage','fifthPage','sixthPage','seventhPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				/*
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(213, 213, 213, 0.3)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				*/
			}	else if( destination.index == 1 ) {
				/*
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				*/
			}	else if( destination.index == 2 ) {
				/*
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				*/
			}  else if( destination.index == 3 ) {
				/*
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				*/
			} else {
				/*
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				*/
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

