<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub-form-reset.css"/>
<script type="text/javascript">
  $(function() {

    $('div#board_paging a').on('click', function(e) {
      $('#viewPage').attr('value', $(this).attr('keyValue'));
      var param = serializeCustom($('form#teach'));
      doGetLoad('applyHistory.do', param);
      e.preventDefault();
    });

    $('a#board_btn_search').on('click', function(e) {
      e.preventDefault();
      $('#viewPage').attr('value', '1');
      var param = serializeCustom($('form#teach'));
      doGetLoad('applyHistory.do', param);
    });

    $('#search_student_status').on('change',function(e){
      e.preventDefault();
      $('#viewPage').attr('value', '1');
      var param = serializeCustom($('form#teach'));
      doGetLoad('applyHistory.do', param);
    });

    $('input#search_text_board').keyup(function(e) {
      e.preventDefault();
      if(e.keyCode == 13) {
        $('#viewPage').attr('value', '1');
        var param = serializeCustom($('form#teach'));
        doGetLoad('applyHistory.do', param);
      }
    });
  });
</script>

<style>
	input[type="text"]{width:auto;height:41px;font-family:'SCoreDream';border-radius:4px;border:1px solid #ccd2dc;}
	input[type="text"]::placeholder{font-family:'SCoreDream';}
	select{padding:6px 5px !important;}
	.search-form__button{display:inline-block;}

	@media screen and (max-width: 1024px) {
		.search-form__input{min-width:40%;}
	}

	@media screen and (max-width: 768px) {
		.search-form__input{min-width:30%;}
	}

	@media screen and (max-width: 600px) {
		.search-form__input{margin-left:0;font-size:14px;}
		.search-form__button{margin-top:5px;margin-left:0;height:42px;line-height:42px;}
	}
</style>

<form:form modelAttribute="teach" action="applyHistory.do" method="get" onsubmit="return false;">
<form:hidden path="menu_idx"></form:hidden>
<div class="myDashboard-culturebox">
    <div class="myDashboard-culturebox-searchbox">
        <div class="myDashboard-culturebox-searchbox-innerbox">
			<form:select path="search_student_status" class="search-form__select">
				<form:option value="">전체</form:option>
				<form:option value="참여">참여</form:option>
				<form:option value="후보">후보</form:option>
				<form:option value="수료">수료</form:option>
				<form:option value="미수료">미수료</form:option>
				<form:option value="취소">취소</form:option>
			</form:select>

            <form:select path="search_type" cssClass="search-form__select">
                <form:option value="TEACH_NAME">행사명</form:option>
            </form:select>

            <form:input path="search_text" id="search_text_board" cssClass="search-form__input" accesskey="s" title="검색어" placeholder="검색어를 입력하세요" />
            <a href="#" class="search-form__button" id="board_btn_search">검색</a>
        </div>
    </div>
</div>

<div class="result-count">
    검색 결과 총 <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건
</div>

<div class="myDashboard-culturebox">
    <div class="myDashboard-culturebox-title">
        <h5>나의 문화 활동 상세내역</h5>
    </div>
    <div class="">
        <table>
            <thead>
            <tr>
                <th style="width:12%">번호</th>
                <th style="width:15%">도서관</th>
                <th style="width:20%">행사명</th>
                <th style="width:20%">신청일시</th>
                <th style="width:20%">취소일시</th>
                <th style="width:13%">상태</th>
            </tr>
            </thead>
            <tbody>
                <c:if test="${fn:length(applyList) < 1}">
                    <tr>
                        <td colspan="6">등록된 신청이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" items="${applyList}" varStatus="status">
                    <tr>
                        <td>${teach.listRowNum - status.index}</td>
                        <td>${i.homepage_name}</td>
                        <td>${i.teach_name}</td>
                        <td>${i.add_date}</td>
                        <td>${i.cancel_date}</td>
                        <td>
                            ${i.student_status_name}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
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