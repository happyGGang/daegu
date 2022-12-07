<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>


<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>


<script type="text/javascript">
	$(function() {
		$('a#search_btn').on('click', function(e) {
			e.preventDefault();
			doGetLoad('performanceExhibition.do', serializeCustom($('form#culture')));
		});

		$('#search_area').on('change', function (e){
			e.preventDefault();
			doGetLoad('performanceExhibition.do', serializeCustom($('form#culture')));
		});
	});
</script>

<style>
	input[type="text"]{width:auto;font-family:'SCoreDream';font-size:19px;}
	input[type="text"]::placeholder{font-family:'SCoreDream';font-size:19px;}

	input.new_text01{height:80px !important;}
	
	@media screen and (max-width: 1024px) { 
		input[type="text"]{font-size:15px;}
		input[type="text"]::placeholder{font-size:15px;}

		input.new_text01{height:50px !important;}
	}
</style>

<form:form modelAttribute="culture" action="performanceExhibition.do" method="GET">
	<from:hidden path="menu_idx"/>
	<div class="search-form showNot01">
		<form:select path="search_area" cssClass="search-form__select new_select_box">
			<form:option value="">지역</form:option>
			<c:forEach var="i" items="${areaCodeList}">
				<form:option value="${i.code_name}">${i.code_name}</form:option>
			</c:forEach>
		</form:select>

		<form:input path="Keyword" placeholder="검색어를 입력하세요." cssClass="text new_text01 search-form__input" ></form:input>
		<button id="search_btn" class="search-form__button"><img src="/resources/homepage/${homepage.context_path}/img/sub_srch_ico.png"></button>
	</div>

	<div class="result-list">
		<c:if test="${fn:length(list) < 1}">
			<div class="product product--stretch">
				검색된 공연전시가 없습니다.
			</div>
		</c:if>
		<c:forEach items="${list}" var="i">
			<div class="product product--stretch">
				<div class="product__header">
					<div class="product__thumnail">
						<img alt="${i.title}" class="product__img" src="${i.imgUrl}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';">
					</div>
					<div class="product__filters">
						<span class="product__filter product__filter--visit">${fn:substring(i.title, 0, 21)}<c:if test="${fn:length(i.title) > 21}">...</c:if></span>
					</div>
				</div>
				<dl class="product__info">
					<dt class="bullet__text--arrow"><b>장르</b></dt>
					<dd>${i.realmName}</dd>

					<dt class="bullet__text--arrow"><b>장소</b></dt>
					<dd>${i.placeAddr}</dd>

					<dt class="bullet__text--arrow"><b>기간</b></dt>
					<dd class="period">${i.startDate}~${i.endDate}</dd>

					<dt class="bullet__text--arrow"><b>문의처</b></dt>
					<dd>${i.phone}</dd>
				</dl>
				<div class="product__buttons">
					<a href="${i.placeUrl}" title="${i.title} 새창보기" target="_blank" class="product__button product__button--ticket">자세히보기</a>
				</div>
			</div>
		</c:forEach>
	</div>
</form:form>


