<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>


<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>


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

<form:form modelAttribute="culture" action="performanceExhibition.do" method="GET">
	<from:hidden path="menu_idx"/>
	<div class="search-form showNot01">
		<form:select path="search_area" cssClass="search-form__select">
			<form:option value="">지역을 선택해주세요 </form:option>
			<c:forEach var="i" items="${areaCodeList}">
				<form:option value="${i.code_name}">${i.code_name}</form:option>
			</c:forEach>
		</form:select>

		<form:input path="Keyword" placeholder="검색어를 입력하세요." cssClass="search-form__input" ></form:input>
		<button id="search_btn" class="search-form__button">검색</button>
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
					<div class="product__filters">
						<span class="product__filter product__filter--class">${i.realmName}/ </span>
						<span class="product__filter product__filter--visit">${i.title}</span>
					</div>
					<div class="product__thumnail">
					<img alt="${i.title}" class="product__img" src="${i.imgUrl}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';">
					</div>
				</div>
				<dl class="product__info">

					<dt class="bullet__text--arrow">장소</dt>
					<dd>${i.placeAddr}</dd>

					<dt class="bullet__text--arrow">기간</dt>
					<dd class="period">${i.startDate}~${i.endDate}</dd>

					<dt class="bullet__text--arrow">문의처</dt>
					<dd>${i.phone}</dd>
				</dl>
				<div class="product__buttons">
					<a href="${i.placeUrl}" title="${i.title} 새창보기" target="_blank" class="product__button">자세히보기</a>
				</div>
			</div>
		</c:forEach>
	</div>
</form:form>


