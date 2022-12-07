<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
});
</script>

<style>
	.selectmenu{min-width:12%;}
</style>

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
	<div class="product product--stretch">
		<div class="product__header">
			<div class="product__thumnail">
				<p class="lib-cate">${i.homepage_alias}</p>
				<img src="/data/teach/${i.homepage_id}/img/${i.image_server_file_name}" alt="${i.teach_name}" title="${i.teach_name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" class="product__img"/>
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
