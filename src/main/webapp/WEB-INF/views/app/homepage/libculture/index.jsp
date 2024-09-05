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
	/*
	$('#homeup, .homeup').click(function (e) {
		e.preventDefault();
		$('html').scrollTop(0);
		return false;
	});
	*/
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

	$('div#curationTab01').load('curation01.do');
	// TAB
	$(document).on('click', '.tabMenu a.curationtab', function(e){
		e.preventDefault();
		$('.tabMenu li').removeClass('on');
		$(this).parent('li').addClass('on');
		var target = this.getAttribute('href').replace('#','');
		var code = $(this).attr('keyValue');
		$('.mainSec02').hide();
		$('#'+target).show();

		if(target == 'tab01')
		{
			$('div#curationTab01').load('curation01.do');
		}
		else if(target == 'tab02')
		{
			$('div#curationTab02').load('curation02.do');
		}
		else if(target == 'tab03')
		{
			$('div#curationTab03').load('curation03.do');
		}
		else if(target == 'tab04')
		{
			$('div#curationTab04').load('curation04.do');
		}
		else if(target == 'tab05')
		{
			$('div#curationTab05').load('curation05.do');
		}
		else if(target == 'tab06')
		{
			$('div#curationTab06').load('curation06.do');
		}
		else if(target == 'tab07')
		{
			$('div#curationTab07').load('curation07.do');
		}
		else if(target == 'tab08')
		{
			$('div#curationTab08').load('curation08.do');
		}
		else if(target == 'tab09')
		{
			$('div#curationTab09').load('curation09.do');
		}
		else
		{
			$('div#curationTab01').load('curation01.do');
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
			$('div#visual-load-box').load('movie.do');
		}
		else if(target == 'tab4')
		{
			$('div#visual-load-box').load('exhibition.do');
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
	var libraryid = $('#libraryid option:selected').val();	//도서관선택 추가
	var sortType = $('#sortType option:selected').val();

	$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType=REQUEST');


	$('select#area').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		libraryid = $('#libraryid option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
	});

	$('select#target').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		libraryid = $('#libraryid option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
	});

	$('select#hashtag').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		libraryid = $('#libraryid option:selected').val();
		sortType = $('#sortType option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
	});

	//스크립트 처리 요망 - 2023-03-05
	$('select#libraryid').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		libraryid = $('#libraryid option:selected').val();
		sortType = $('#sortType option:selected').val();
		
		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
	});

	$('select#sortType').on('change', function() {
		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue'));
		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();
		libraryid = $('#libraryid option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
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
		libraryid = $('#libraryid option:selected').val();

		$('.mobile-selector select').val(culture_mm).prop('selected', true);

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
	});

	$('.mobile-selector select').on('change', function(e){
		e.preventDefault();

		culture_yy = $.trim($('#culture_cal .web-selector ul li:eq(0)').text());
		culture_mm = $.trim($(this).find('option:selected').val());

		$('.culture-search-condition-box-cal ul li').removeClass('on');
		$('.culture-search-condition-box-cal ul li a[keyvalue='+culture_mm+']').parent('li').addClass('on');


		area = $('#area option:selected').val();
		target = $('#target option:selected').val();
		hashtag = $('#hashtag option:selected').val();
		sortType = $('#sortType option:selected').val();
		libraryid = $('#libraryid option:selected').val();

		$('.main1-bottom-box').load('searchCulture.do?search_yy='+culture_yy+'&search_mm='+culture_mm+'&sortType='+sortType+'&search_area='+area+'&search_target='+target+'&search_hashtag='+hashtag+'&search_libraryid='+libraryid);
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

	$('div#areaculture .areaCultureSlideList').load('areacarnival.do?search_area=');

	$('#daeguArea').on('change',function(){
		var area = $(this).find('option:selected').val();
		var id = '';

		$('#main3 .areaculturetab .tabMenuA ul li').each(function(index, item){
			if($(item).hasClass('on')) {
				id = $(item).attr('id');

				if (id == 'tabs002') {
					$('div#areaculture .areaCultureSlideList').load('areacarnival.do?search_area='+area)
				} else if (id == 'tabs003') {
					$('div#areaculture .areaCultureSlideList').load('areaculture.do?search_area='+area)
				} else if (id == 'tabs001') {
					$('div#areaculture .areaCultureSlideList').load('areaexhibition.do?search_area='+area)
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
								<c:choose>
								<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
								<h2>${sessionScope.member.member_name}님의</h2>
								</c:when>
								<c:otherwise>
								<h2>대구통합도서관의</h2>
								</c:otherwise>
								</c:choose>
								<ul class="tabMenuT">
									<li class="on"><a href="#tab1">강좌</a></li>
									<li><a href="#tab2">문화</a></li>
									<li><a href="#tab3">영화</a></li>
									<li><a href="#tab4">전시</a></li>
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
													<a>등록된 데이터가 없습니다</a>
												</li>
											</c:if>

											<c:forEach var="i" items="${teachViewList}">
												<li>
													<a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" target="_blank">
														<div class="top">
															<h4>${i.teach_name}</h4>
															<p class='days'>${i.start_join_date} ~ ${i.end_join_date}</p>
															<span class="libtag_${i.homepage_id}">${i.homepage_alias}</span>
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
										<span class="dream-img-box"><img src="/resources/homepage/${homepage.context_path}/img/dream-img.png" alt=""></span>
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
														<option value="">지역 선택</option>

														
															<option value="동구">동구</option>
														
															<option value="서구">서구</option>
														
															<option value="남구">남구</option>
														
															<option value="북구">북구</option>
														
															<option value="중구">중구</option>
														
															<option value="수성구">수성구</option>
														
															<option value="달서구">달서구</option>
														
															<option value="달성군">달성군</option>
														
															<option value="군위군">군위군</option>
														<%--
														<c:forEach var="i" items="${areaCodeList}">
															<option value="${i.code_name}">${i.code_name}</option>
														</c:forEach>
														--%>
													</select>
												</li>
												<li>
													<select name="target" id="target" class="cultureSelectBox">
														<option value="">대상 선택</option>
														<c:forEach var="i" items="${ageCodeList}">
															<option value="${i.code_id}">${i.code_name}</option>
														</c:forEach>
													</select>
												</li>
												<li>
													<select name="hashtag" id="hashtag" class="cultureSelectBox">
														<option value="">주제 선택</option>
														<c:forEach var="i" items="${hashtagCodeList}">
															<option value="${i.hashtag_code}">${i.hashtag_name}</option>
														</c:forEach>
													</select>
												</li>
												<li>
													<select name="libraryid" id="libraryid" class="cultureSelectBox">
														<option value="">도서관 선택</option>
														<option value="h35">남구대명어울림도서관</option>
														<option value="h36">남구이천어울림도서관</option>
														<option value="h69">달서구립 달서가족문화도서관</option>
														<option value="h66">달서구립 달서어린이</option>
														<option value="h70">달서구립 달서영어도서관</option>
														<option value="h72">달서구립 도원도서관</option>
														<option value="h68">달서구립 본리도서관</option>
														<option value="h67">달서구립 성서도서관</option>
														<option value="h44">달성군립도서관</option>
														<option value="h1">대구2ㆍ28기념학생도서관</option>
														<option value="h2">대구2ㆍ28민주운동기념회관</option>
														<option value="h3">대구광역시립 남부도서관</option>
														<option value="h4">대구광역시립 달성도서관</option>
														<option value="h5">대구광역시립 동부도서관</option>
														<option value="h6">대구광역시립 두류도서관</option>
														<option value="h7">대구광역시립 북부도서관</option>
														<option value="h8">대구광역시립 서부도서관</option>
														<option value="h9">대구광역시립 수성도서관</option>
														<option value="h10">국채보상운동기념도서관</option>
														<option value="h94">대구광역시교육청 삼국유사군위도서관</option>
														<option value="h34">대구시청작은도서관</option>
														<option value="h59">동구통합 신천도서관</option>
														<option value="h73">동구통합 안심도서관</option>
														<option value="h75">동인느티나무도서관</option>
														<option value="h46">북구구수산도서관</option>
														<option value="h47">북구대현도서관</option>
														<option value="h48">북구태전도서관</option>
														<option value="h61">서구통합 비산도서관</option>
														<option value="h63">서구통합 비원도서관</option>
														<option value="h77">서구통합 서구어린이도서관</option>
														<option value="h62">서구통합 서구영어도서관</option>
														<option value="h64">서구통합 원고개도서관</option>
														<option value="h52">수성구립 고산도서관</option>
														<option value="h57">수성구립 무학숲도서관</option>
														<option value="h55">수성구립 물망이도서관</option>
														<option value="h93">수성구립 황금책문화센터도서관</option>
														<option value="h50">수성구립 범어도서관</option>
														<option value="h58">수성구립 사월역작은도서관</option>
														<option value="h51">수성구립 용학도서관</option>
														<option value="h54">수성구립 책숲길도서관</option>
														<option value="h56">수성구립 파동도서관</option>
														<option value="h76">중구삼덕마루</option>
														<option value="h74">중구영어도서관</option>
													</select>
												</li>
												<!--
												<li>
													<select name="sortType" id="sortType" class="cultureSelectBox">
														<option value="REQUEST">신청일</option>
														<option value="OPERATE">운영일</option>
													</select>
												</li>
												-->
											</ul>
										</div>
										<div id="culture_cal" class="culture-search-condition-box-cal">
											<div class="web-selector">
											<ul>
												<li>
													<!-- example -->
													<span><c:set var="now" value="<%=new java.util.Date()%>" />
													<fmt:formatDate value="${now}" pattern="yyyy" type="date"/></span>
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
												<select name="" id="">
													<fmt:formatDate value="${now}" pattern="MM" type="date" var="mm"/>
													<fmt:formatNumber var="mm" minIntegerDigits="2" value="${mm}" type="number"/>
													<c:forEach var="i" begin="1" end="12">
														<fmt:formatNumber var="no" minIntegerDigits="2" value="${i}" type="number"/>
														<option value="${no}" ${mm == no ? 'selected' : ''}>${no}월</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
							<span class="more-box"><a href="/libculture/module/culture/teach.do?menu_idx=1">더보기 <span>+</span></a></span>
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
									<li><a href="#tab02" class='curationtab' keyValue="02">그림책</a></li>
									<li><a href="#tab03" class='curationtab' keyValue="03">독서</a></li>
									<li><a href="#tab04" class='curationtab' keyValue="04">인문</a></li>
									<li><a href="#tab05" class='curationtab' keyValue="05">제작체험</a></li>
									<li><a href="#tab06" class='curationtab' keyValue="06">힐링</a></li>
									<li><a href="#tab07" class='curationtab' keyValue="07">문화예술</a></li>
									<li><a href="#tab08" class='curationtab' keyValue="08">동화</a></li>
									<li><a href="#tab09" class='curationtab' keyValue="09">역사</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div id="tab01" class="mainSec02">
						<div id="curationTab01">
						</div>
					</div>
					<div id="tab02" class="mainSec02">
						<div id="curationTab02">
						</div>
					</div>
					<div id="tab03" class="mainSec02">
						<div id="curationTab03">
						</div>
					</div>
					<div id="tab04" class="mainSec02">
						<div id="curationTab04">
						</div>
					</div>
					<div id="tab05" class="mainSec02">
						<div id="curationTab05">
						</div>
					</div>
					<div id="tab06" class="mainSec02">
						<div id="curationTab06">
						</div>
					</div>
					<div id="tab07" class="mainSec02">
						<div id="curationTab07">
						</div>
					</div>
					<div id="tab08" class="mainSec02">
						<div id="curationTab08">
						</div>
					</div>
					<div id="tab09" class="mainSec02">
						<div id="curationTab09">
						</div>
					</div>
					<span class="curation-img-box"><img src="/resources/homepage/${homepage.context_path}/img/curation-img.png" alt=""></span>
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
															<option value="동구">동구</option>
														
															<option value="서구">서구</option>
														
															<option value="남구">남구</option>
														
															<option value="북구">북구</option>
														
															<option value="중구">중구</option>
														
															<option value="수성구">수성구</option>
														
															<option value="달서구">달서구</option>
														
															<option value="달성군">달성군</option>
														
															<option value="군위군">군위군</option>
										<%--
										<c:forEach var="i" items="${areaCodeList}">
											<option value="${i.code_name}">${i.code_name}</option>
										</c:forEach>
										--%>
									</select>
								</div>
								<div class="tabMenuA">
									<ul>
										<li class="on" id="tabs002"><a href="#tabs02" class='areacluturetab' keyValue="02">행사축제</a></li>
										<!--<li id="tabs003"><a href="#tabs03" class='areacluturetab' keyValue="03">문화공간</a></li>-->
										<li id="tabs001"><a href="#tabs01" class='areacluturetab'>공연전시</a></li>
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

