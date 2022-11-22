<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>

<div class="search-form showNot01">
  <select id="searchKeywordType" class="search-form__select" title="검색 조건" name="searchKeywordType">
    <option>전체</option>
    <option value="t">서비스명</option>
    <option value="t">설명</option>
  </select>
  <input type="text" class="search-form__input" placeholder="검색어를 입력하세요." id="searchKeyword" name="searchKeyword" value="" titile="검색어 입력">
  <button id="searchSubmit2btn" type="button" class="search-form__button">검색</button>
</div>

<div class="result-list">
  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>


  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

  <div class="product product--stretch">
    <div class="product__header">
      <div class="product__filters">
        <span class="product__filter product__filter--topic">뮤지컬/오페라</span>
        <span class="product__filter product__filter--class">공연/전시</span>
        <span class="product__filter product__filter--cost">유료</span>
        <span class="product__filter product__filter--visit">서울</span>
      </div>
      <div class="product__thumnail">
        <img alt="그렇게 우리는 이야기가 된다 브론테 | 2022.09.04부터 11.07까지 대학로 자유극장" class="product__img" src="/upload/rdf/22/08/rdf_202208122117934340.gif">
      </div>
    </div>
    <dl class="product__info">
      <dt class="bullet__text--arrow">제공유형</dt><!-- th:if="${item.provd_stle != null}"  -->
      <dd>오프라인</dd><!--  ${item.org_online} -->

      <!--  <dt th:if="${item.venue != null}" class="bullet__text--arrow">주최기관</dt>  -->
      <dt class="bullet__text--arrow">장소</dt>
      <dd>자유극장</dd> <!-- ${item.rights} -->

      <dt class="bullet__text--arrow">기간</dt>
      <dd class="period">2022-09-04~2022-11-07</dd> <!-- ${item.period} -->

      <!-- <dt class="bullet__text--arrow">문의처</dt>
										<dd th:text="${item.cul_tel != null} ? ${item.cul_tel} :  (${item.reference != null} ? ${item.reference} : '-') "></dd>   -->
      <dt class="bullet__text--arrow">문의처</dt>
      <dd>070-8095-9734</dd>

      <!-- 나머지 -->

    </dl>
    <div class="product__buttons">
      <a href="/oneeye/oneEyeView.do?seq=218569&amp;uci=G7061660339128617" class="product__button">자세히보기</a>
      <a href="https://tickets.interpark.com/goods/22010373" target="_blank" title="새창" onclick="Call_trk_flashEnvView();" class="product__button product__button--ticket">예매 바로가기</a>
    </div>
  </div>

</div>

