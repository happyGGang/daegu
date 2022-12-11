<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>

<script type="text/javascript">
  $(function() {
	$('div#board_paging a').on('click', function (e) {
	  $('#viewPage').attr('value', $(this).attr('keyValue'));

	  $('#search_yy').val($.trim($('#culture_cal .web-selector ul li:eq(0)').text()));
	  $('#search_mm').val(
		  $.trim($('#culture_cal .web-selector ul li[class=on]').find('a').attr('keyValue')))
	  var param = serializeCustom($('form#culture'));
	  doGetLoad('culture.do', param);
	  e.preventDefault();
	});

	$('a#search_btn').on('click', function(e) {
	  e.preventDefault();
	  $('#viewPage').val(1);
	  doGetLoad('culture.do', serializeCustom($('form#culture')));
	});

	  $('#search_area').on('change',function(e){
		  e.preventDefault();
		  $('#viewPage').attr('value', '1');
		  var param = serializeCustom($('form#culture'));
		  doGetLoad('culture.do', param);
	  });

	  $('#search_cate').on('change',function(e){
		  e.preventDefault();
		  $('#viewPage').attr('value', '1');
		  var param = serializeCustom($('form#culture'));
		  doGetLoad('culture.do', param);
	  });
  });
</script>

<style>
	input[type="text"]{width:auto;font-family:'SCoreDream';font-size:19px;}
	input[type="text"]::placeholder{font-family:'SCoreDream';font-size:19px;}
	.new_select_box.wid2{min-width:150px;}

	.new_select_box.left2{left:210px;}
	.new_select_box.left3{left:370px;}

	input.new_text02{padding-left:650px;}
	.search-form__input2{min-width:calc(100% - 650px);}
	
	@media screen and (max-width: 1024px) { 
		input[type="text"]{font-size:15px;}
		input[type="text"]::placeholder{font-size:15px;}

		input.new_text02{padding-left:30px;margin-top:10px;height:50px !important;}
		.search-form__input2{min-width:calc(97% - 30px);}

		.new_select_box.wid2{min-width:30%;}

		.new_select_box.left2{left:0;}
		.new_select_box.left3{left:0;}

		.nsb3{position:relative;top:0;left:0;min-width:30%;border:1px solid #ddd;border-radius:100px;height:50px;line-height:50px;padding:0 15px;}
	}
	
	@media screen and (max-width: 768px) { 
		.nsb3{min-width:33%;}
	}
	
	@media screen and (max-width: 550px) { 
		.new_select_box.wid2{min-width:100%;}
		.nsb3{min-width:100%;margin-top:8px;}
		.mt0{margin-top:0;}
		.top2{top:190px;}
	}
</style>

<form:form modelAttribute="culture" action="culture.do" method="GET">
<form:hidden path="menu_idx"></form:hidden>
<div class="search-form showNot01">
	<form:select path="search_type" cssClass="search-form__select new_select_box left1 nsb3 wid2 mt0" title="검색 조건">
		<form:option value="">전체</form:option>
		<form:option value="NAME">명칭</form:option>
		<form:option value="ADDRESS">주소</form:option>
		<form:option value="CONTENTS">설명</form:option>
	</form:select>

	<form:select path="search_area" cssClass="search-form__select new_select_box left2 nsb3 wid2">
		<form:option value="">지역전체</form:option>
		<form:option value="0001">동구</form:option>
		<form:option value="0002">서구</form:option>
		<form:option value="0003">남구</form:option>
		<form:option value="0004">북구</form:option>
		<form:option value="0005">수성구</form:option>
		<form:option value="0006">중구</form:option>
		<form:option value="0007">달서구</form:option>
		<form:option value="0008">달성군</form:option>
	</form:select>

	<form:select path="search_cate" cssClass="search-form__select new_select_box left3 nsb3">
		<form:option value="">시설전체</form:option>
		<form:option value="0001">공연장</form:option>
		<form:option value="0006">박물관</form:option>
		<form:option value="0007">영화관</form:option>
		<!-- <form:option value="0003">도서관</form:option> -->
		<form:option value="0005">미술관</form:option>
		<form:option value="0004">문화·복지시군구회관</form:option>
		<form:option value="0008">문화비 소득공제</form:option>
		<form:option value="0002">기타문화공간</form:option>
	</form:select>

	<form:input path="search_text" cssClass="text new_text02 search-form__input2" placeholder="검색어를 입력하세요." title="검색어 입력"></form:input>
	<button id="search_btn" type="button" class="search-form__button top2"><img src="/resources/homepage/${homepage.context_path}/img/sub_srch_ico.png"></button>
</div>

<div class="result-count">
	검색 결과 총 <b>${paging.totalDataCount}</b>건
</div>

<div class="result-list">
	<c:if test="${fn:length(cultureList) < 1}">
		검색된 문화공간이 없습니다.
	</c:if>
	<c:forEach var="i" items="${cultureList}" varStatus="status">
	<div class="product product--stretch">
		<div class="product__header">
			<div class="product__thumnail__2">
				<a href="cultureView.do?menu_idx=${culture.menu_idx}&idx=${i.idx}" title="${i.name}">
					<c:choose>
						<c:when test="${i.img_url ne null}">
							<img src="${i.img_url}" alt="${i.name}" title="${i.name}" onError="src='/resources/homepage/${homepage.context_path}/img/noimg_horizaltal.png';" class="product__img" />
						</c:when>
						<c:otherwise>
							<img src="/resources/homepage/${homepage.context_path}/img/noimg_horizaltal.png" alt="등록된 이미지가 없습니다.  상세보기" class="product__img"/>
						</c:otherwise>
					</c:choose>
				</a>
			</div>
			<div class="product__filters">
				<span class="product__filter product__filter-topic">${i.name}</span>
			</div>
		</div>
		<dl class="product__info">
			<dt class="bullet__text--arrow"><b>주소</b></dt>
			<dd>${i.address}</dd>

			<dt class="bullet__text--arrow"><b>구분</b></dt>
			<dd>${i.catename}</dd>
		</dl>
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



