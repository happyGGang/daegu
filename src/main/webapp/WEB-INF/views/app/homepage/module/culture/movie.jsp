<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script type="text/javascript">
  $(function() {
    $(window).resize(function() {
      $('.bbs_gallery img').height($('.bbs_gallery img').width() * 0.6);
    }).trigger('resize');

    $('div#board_paging a').on('click', function(e) {
      $('#viewPage').attr('value', $(this).attr('keyValue'));
      var param = serializeCustom($('form#board'));
      doGetLoad('movie.do', param);
      e.preventDefault();
    });

    $('a#board_btn_search').on('click', function(e) {
      e.preventDefault();
      $('#viewPage').attr('value', '1');
      var param = serializeCustom($('form#board'));
      doGetLoad('movie.do', param);
    });

    $('input#search_text_board').keyup(function(e) {
      e.preventDefault();
      if(e.keyCode == 13) {
        $('#viewPage').attr('value', '1');
        var param = serializeCustom($('form#board'));
        doGetLoad('movie.do', param);
      }
    });

  });

</script>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="movie.do" method="get" onsubmit="return false;">
    <input type="hidden" id ="homepage_id" value ="${homepage.homepage_id}"/>
    <jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
    <div class="wrapper-bbs">
        <div class="button btn-group inline">
            <span class="bbs-result" style="margin-right:10px;">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
        </div>
        <div class="table-wrap">
            <ul class="bbs_gallery" id="board_tbody">
                <c:forEach var="i" varStatus="status" items="${boardList}">
                    <c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
                    <li>
                        <div class="thumb">
                            <c:choose>
                                <c:when test="${i.preview_img ne null}">
                                    <c:choose>
                                        <c:when test="${fn:contains(i.preview_img, 'http')}">
                                            <a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}">
                                                <img src="${i.preview_img}" alt="${i.title}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';"/>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}">
                                                <img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" alt="${i.title}"/>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}"><img src="/resources/homepage/${homepage.context_path}/img/book_noimg.png" alt="${i.title}"></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="info">
                            <a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}">${i.title}</a>
                            <div class="meta">
                                <c:choose>
                                    <c:when test="${boardManage.anonymize_yn eq 'Y'}">
                                        <c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="user_name" value="${i.user_name}"/>
                                    </c:otherwise>
                                </c:choose>
                                    ${i.secret_yn ne 'Y'? user_name:'비공개'}
                                <span class="txt-bar"></span>
                                <abbr class="published"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></abbr>
                                <span class="txt-bar"></span>
                                <abbr class="published"><fmt:formatNumber value="${i.view_count}" pattern="#,###"/> </abbr>

                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <form:hidden path="viewPage"/>

        <div id="board_paging" class="dataTables_paginate">
            <c:if test="${paging.firstPageNum > 0}">
                <a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
            </c:if>
            <c:if test="${paging.prevPageNum > 0}">
                <a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
            </c:if>
            <span>
            <c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
                <c:choose>
                    <c:when test="${i eq paging.viewPage}">
                        <a href="" class="paginate_button current" keyValue="${i}">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="" class="paginate_button" keyValue="${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${paging.nextPageNum > 0}">
                <a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
            </c:if>
            <c:if test="${paging.totalPageCount ne paging.lastPageNum}">
                <a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
            </c:if>
                </span>
        </div>

        <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
            <fieldset>
                <label class="blind" for="search_type">검색조건</label>
                <form:select path="search_type" cssClass="selectmenu new_select_box" cssStyle="width:110px;">
                    <form:option value="title+content">제목+내용</form:option>
                    <form:option value="title">제목</form:option>
                    <form:option value="content">내용</form:option>
                </form:select>
                <form:input path="search_text" id="search_text_board" cssClass="text new_text01" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
                <label for="search_text_board" class="blind">검색어</label>
                <a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
            </fieldset>
        </div>
    </div>
</form:form>