<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css"
      href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css"
      href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>

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
  });
</script>

<form:form modelAttribute="culture" action="culture.do" method="GET">
<form:hidden path="menu_idx"></form:hidden>
<div class="search-form showNot01">
    <form:select path="search_type" cssClass="search-form__select" title="검색 조건">
        <form:option value="">전체</form:option>
        <form:option value="NAME">명칭</form:option>
        <form:option value="ADDRESS">주소</form:option>
        <form:option value="CONTENTS">설명</form:option>
    </form:select>

    <form:input path="search_text" cssClass="search-form__input" placeholder="검색어를 입력하세요." title="검색어 입력"></form:input>
    <button id="search_btn" type="button" class="search-form__button">검색</button>
</div>

<div class="result-count">
    검색 결과가 총 <b>${paging.totalDataCount}</b>건 이있습니다.
</div>

<div class="result-list">
    <c:if test="${fn:length(cultureList) < 1}">
        검색된 문화공간이 없습니다.
    </c:if>
    <c:forEach var="i" items="${cultureList}" varStatus="status">
    <div class="product product--stretch">
        <div class="product__header">
            <div class="product__thumnail__2">
                <a href="cultureView.do?idx=${i.idx}" target="_blank" title="${i.name}">
                    <c:choose>
                        <c:when test="${i.img_url ne null}">
                            <img src="${i.img_url}" alt="${i.name}" title="${i.name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" class="product__img" />
                        </c:when>
                        <c:otherwise>
                            <img src="/resources/homepage/${homepage.context_path}/img/book_noimg.png" alt="등록된 이미지가 없습니다.  상세보기" class="product__img"/>
                        </c:otherwise>
                    </c:choose>
                </a>
            </div>
        </div>
        <dl class="product__info">
            <dt class="bullet__text--arrow">명칭</dt>
            <dd>${i.name}</dd>

            <dt class="bullet__text--arrow">주소</dt>
            <dd>${i.address}</dd>

            <dt class="bullet__text--arrow">구분</dt>
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



