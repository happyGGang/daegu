<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class='full-sections'>
  <div id="result-sort">
    <div class="culture-search-result">
      <ul>
        <c:if test="${fn:length(searchTeachList) < 1}">
          <li>등록된 데이터가 없습니다.</li>
        </c:if>
        <c:forEach var="i" items="${searchTeachList}">
          <li>
            <a href="/${i.context_path}/module/teach/detail.do?menu_idx=${i.menu_idx}&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
              <div>
                <h4>${i.homepage_alias}</h4>
                <p class="days"><span>신청일 </span><b>${i.start_join_date} -</b> ${i.end_join_date}</p>
                <p class="days"><span>운영일 </span><b>${i.start_date} -</b> ${i.end_date}</p>
                <p class="conte">${i.teach_name}</p>
                <p class="more">MORE <img src="/resources/homepage/${homepage.context_path}/img/more-bg.png" alt="상세보기 이동"></p>
              </div>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
    <div class="culture-search-result-count">
		<span class="">찾고계시는 검색 결과가 총 <b>${count}</b>건 이있습니다.</span>
		<span class="more-box"><a href="/libculture/module/culture/teach.do?menu_idx=1">더보기 +</a></span>
    </div>
  </div>
</div>