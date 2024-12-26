<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/module_culture.css">
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>

<script type="text/javascript">
  $(function(){
	$('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	$('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')));

	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));

		$('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
		$('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
		var param = serializeCustom($('form#teach'));
		doGetLoad('teach.do', param);
		e.preventDefault();
	});

	$('select#search_area').on('change', function() {
	  $('#viewPage').attr('value', $(this).attr('keyValue'));

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  var param = serializeCustom($('form#teach'));
	  doGetLoad('teach.do', param);
	  e.preventDefault();
	});

	$('select#search_target').on('change', function() {
	  $('#viewPage').attr('value', $(this).attr('keyValue'));

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  var param = serializeCustom($('form#teach'));
	  doGetLoad('teach.do', param);
	  e.preventDefault();
	});

	$('select#search_hashtag').on('change', function() {
	  $('#viewPage').attr('value', $(this).attr('keyValue'));

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  var param = serializeCustom($('form#teach'));
	  doGetLoad('teach.do', param);
	  e.preventDefault();
	});

	//스크립트 처리 요망 - 2023-03-05
	$('select#search_libraryid').on('change', function() {
		$('#viewPage').attr('value', $(this).attr('keyValue'));

		$('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	    $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	    var param = serializeCustom($('form#teach'));
	    doGetLoad('teach.do', param);
	    e.preventDefault();
	});

	$('select#sortType').on('change', function() {
	  $('#viewPage').attr('value', $(this).attr('keyValue'));

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  var param = serializeCustom($('form#teach'));
	  doGetLoad('teach.do', param);
	  e.preventDefault();
	});

	$('.sub-culture-search-condition-box-cal ul li a').on('click', function(e) {
	  $('.sub-culture-search-condition-box-cal ul li').removeClass('on');
	  $(this).parent('li').addClass('on');

	  $('#viewPage').attr('value', 1);

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')));
	  var param = serializeCustom($('form#teach'));
	  doGetLoad('teach.do', param);
	  e.preventDefault();
	});

	$('a#search_btn').on('click', function(e) {
	  e.preventDefault();
	  $('#viewPage').val(1);
	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val($.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  doGetLoad('teach.do', serializeCustom($('form#teach')));

	});

	let search_libraryid = '${teach.search_libraryid}'
	$('#search_libraryid option').each(function(index,value){
		let option = value;
		if (option.value == search_libraryid){
			$(this).prop("selected",true);
		}
	});
});
</script>



<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>
<form:form modelAttribute="teach" action="teach.do" method="GET">
<form:hidden path="search_yy"></form:hidden>
<form:hidden path="search_mm"></form:hidden>
<form:hidden path="menu_idx"></form:hidden>
<div class="sub-culture-search-condition">
	<div class="outer">
		<div class="inner">
			<div class="sub-culture-search-condition-box-cal" id="culture_cal">
				<div class="web-selector">
					<ul>
						<li>
							${teach.search_yy}
						</li>
						<fmt:formatNumber var="mm" minIntegerDigits="2" value="${teach.search_mm}" type="number"/>
						<c:forEach var="i" begin="1" end="12">
							<fmt:formatNumber var="no" minIntegerDigits="2" value="${i}" type="number"/>
							<li class="${mm == no ? 'on' : ''}"><a href="javascript:void(0)" keyValue="${no}">${no}월</a></li>
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
			<div class="sub-culture-search-condition-box-sel">
				<ul>
					<li>
						<form:select path="search_area" cssClass="cultureSelectBox">
							<form:option value="">지역 선택</form:option>
							<c:forEach var="i" items="${areaCodeList}">
								<form:option value="${i.code_name}">${i.code_name}</form:option>
							</c:forEach>
						</form:select>
					</li>
					<li>
						<form:select path="search_target" cssClass="cultureSelectBox">
							<form:option value="">대상 선택</form:option>
							<c:forEach var="i" items="${ageCodeList}">
								<form:option value="${i.code_id}">${i.code_name}</form:option>
							</c:forEach>
						</form:select>
					</li>
					<li>
						<form:select path="search_hashtag" cssClass="cultureSelectBox">
							<form:option value="">주제 선택</form:option>
							<c:forEach var="i" items="${hashtagCodeList}">
								<form:option value="${i.hashtag_code}">${i.hashtag_name}</form:option>
							</c:forEach>
						</form:select>
					</li>
					<li>
						<select name="search_libraryid" id="search_libraryid" class="cultureSelectBox">
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
							<option value="h100">대구혁신도시 복합문화센터</option>
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
						<form:select path="sortType" cssClass="cultureSelectBox">
							<form:option value="REQUEST">신청일</form:option>
							<form:option value="OPERATE">운영일</form:option>
						</form:select>
					</li>
					-->
				</ul>
			</div>
			<div class="search-form showNot01">
				<form:select path="search_type" cssClass="selectmenu new_select_box">
					<form:option value="teach_name">강좌명</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text new_text01 search-form__input" placeholder="검색어를 입력하세요" />
				<button href="#" class="search-form__button" id="search_btn"><img src="/resources/homepage/${homepage.context_path}/img/sub_srch_ico.png"></button>
			</div>
		</div>
	</div>
</div>


<div class="result-count">
	검색 결과 총 <b>${paging.totalDataCount}</b>건
</div>

<div class="result-list">
	<c:if test="${fn:length(teachList) < 1}">
		검색된 강좌가 없습니다.
	</c:if>
	<c:forEach var="i" items="${teachList}" varStatus="status">
	<c:set var="ran"><%= java.lang.Math.round(java.lang.Math.random() * 9) %></c:set>
	<div class="product product--stretch">
		<div class="product__header">
			<div class="product__thumnail">
				<!-- <p class="lib-cate">${i.homepage_alias}</p> -->
					<c:choose>
						<c:when test="${i.image_server_file_name eq null || i.image_server_file_name eq ''}">
							<div class="education-bg edubg0${ran}">
								<c:choose>
									<c:when test="${i.homepage_id eq 'h10' || i.homepage_id eq 'h2' || i.homepage_id eq 'h34' || i.homepage_id eq 'h74' || i.homepage_id eq 'h75' || i.homepage_id eq 'h76' || i.homepage_id eq 'h53'}"><!-- 중구 -->
									<span class="color-junggu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h1' || i.homepage_id eq 'h45' || i.homepage_id eq 'h59' || i.homepage_id eq 'h73' || i.homepage_id eq 'h60' || i.homepage_id eq 'h5' || i.homepage_id eq 'h100'}"><!-- 동구 -->
									<span class="color-donggu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h49' || i.homepage_id eq 'h61' || i.homepage_id eq 'h62' || i.homepage_id eq 'h63' || i.homepage_id eq 'h64' || i.homepage_id eq 'h65' || i.homepage_id eq 'h77' || i.homepage_id eq 'h8'}"><!-- 서구 -->
									<span class="color-seogu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h3' || i.homepage_id eq 'h35' || i.homepage_id eq 'h36'}"><!-- 남구 -->
									<span class="color-namgu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h7' || i.homepage_id eq 'h46' || i.homepage_id eq 'h47' || i.homepage_id eq 'h48'}"><!-- 북구 -->
									<span class="color-bukgu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h9' || i.homepage_id eq 'h50' || i.homepage_id eq 'h51' || i.homepage_id eq 'h52' || i.homepage_id eq 'h54' || i.homepage_id eq 'h55' || i.homepage_id eq 'h56' || i.homepage_id eq 'h57' || i.homepage_id eq 'h58'}"><!-- 수성구 -->
									<span class="color-suseonggu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h6' || i.homepage_id eq 'h37' || i.homepage_id eq 'h66' || i.homepage_id eq 'h67' || i.homepage_id eq 'h68' || i.homepage_id eq 'h69' || i.homepage_id eq 'h70' || i.homepage_id eq 'h71' || i.homepage_id eq 'h72'}"><!-- 달서구 -->
									<span class="color-dalseogu">${i.homepage_alias}</span>
									</c:when>
									<c:when test="${i.homepage_id eq 'h4' || i.homepage_id eq 'h43' || i.homepage_id eq 'h44'}"><!-- 달성군 -->
									<span class="color-dalseonggun">${i.homepage_alias}</span>
									</c:when>
									<c:otherwise><!-- 예외 -->
									<span class="color-etc">${i.homepage_alias}</span>
									</c:otherwise>
								</c:choose>	
								<h4 style="padding:0;">${i.teach_name}</h4>
								<p class='days'>${i.start_join_date} ~<br />${i.end_join_date}</p>
							</div>
						</c:when>
						<c:otherwise>
							<img src="/data/teach/${i.homepage_id}/img/${i.image_server_file_name}" alt="${i.teach_name}" title="${i.teach_name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" class="product__img"/>
						</c:otherwise>
					</c:choose>
				<!-- <img src="/data/teach/${i.homepage_id}/img/${i.image_server_file_name}" alt="${i.teach_name}" title="${i.teach_name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" class="product__img"/> -->
			</div>
			<div class="product__filters">
				<span class="product__filter product__filter-topic">${i.teach_name}</span>
			</div>
		</div>
		<dl class="product__info">

			<dt class="bullet__text--arrow">· 모집기간</dt>
			<dd class="period">${i.start_join_date} ~ ${i.end_join_date}</dd>

			<dt class="bullet__text--arrow">· 교육기간</dt>
			<dd class="period">${i.start_date} ~ ${i.end_date}</dd>

			<dt class="bullet__text--arrow">· 접수자/정원</dt>
			<dd class="period"><b>${i.teach_join_count}</b> / ${i.teach_limit_count}</dd>

			<dt class="bullet__text--arrow">· 대기자/정원</dt>
			<dd class="period"><b>${i.teach_backup_join_count}</b> / ${i.teach_backup_count}</dd>

		</dl>
		<div class="product__buttons">
			<a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}"" target="_blank" class="product__button product__button--ticket">신청하기</a>
		</div>
	</div>
	</c:forEach>
</div>
	<form:hidden path="viewPage"/>
	<div id="board_paging" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="#" class="paginate_button previous" title="처음" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="#" class="paginate_button previous" title="이전" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>
		<span>
<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
	<c:choose>
		<c:when test="${i eq paging.viewPage}">
			<a href="#" class="paginate_button current" title="${i}페이지, 현재페이지" keyValue="${i}">${i}</a>
		</c:when>
		<c:otherwise>
			<a href="#" class="paginate_button" title="${i}페이지" keyValue="${i}">${i}</a>
		</c:otherwise>
	</c:choose>
</c:forEach>
<c:if test="${paging.nextPageNum > 0}">
	<a href="#" class="paginate_button next" title="다음" keyValue="${paging.nextPageNum}">다음</a>
</c:if>
<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
	<a href="#" class="paginate_button next" title="맨끝" keyValue="${paging.totalPageCount}">맨끝</a>
</c:if>
	</span>
	</div>
</form:form>
