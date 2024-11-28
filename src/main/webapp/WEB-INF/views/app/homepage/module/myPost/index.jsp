<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld" %>
<script>
    $(document).ready(function() {
        <%--페이징--%>
        $('div#board_paging a').on('click', function(e) {
            e.preventDefault();
            $('#viewPage').attr('value', $(this).attr('keyValue'));
            var param = serializeCustom($('form#myPost'));
            doGetLoad('index.do', param);
        });

        <%--검색--%>
        $('a#board_btn_search').on('click', function(e) {
            e.preventDefault();
            $('#viewPage').attr('value', '1');
            var param = serializeCustom($('form#myPost'));
            doGetLoad('index.do', param);
        });

        $('input#search_text').keyup(function(e) {
            e.preventDefault();
            if(e.keyCode == 13) {
                $('#viewPage').attr('value', '1');
                var param = serializeCustom($('form#myPost'));
                doGetLoad('index.do', param);
            }
        });

        <%--도서관 선택--%>
        $('select#homepage_id').on('change', function() {
            $('#myPost select#manage_idx').val('');
            $('#myPost select#manage_idx option.all').prop('selected', true);
            $('#myPost #search_text').val('');
            $('#myPost #rowCount').val('');
            $('#myPost #viewPage').val(1);
            doGetLoad('index.do', serializeCustom($('form#myPost')));
        });

        <%--게시판 선택--%>
        $('select#manage_idx').on('change', function() {
            var url = 'index.do';
            $('#myPost #viewPage').val(1);
            $('#myPost #rowCount').val('');
            var formData = serializeCustom($('form#myPost'));
            doGetLoad(url, formData);
        });

        <%--글 개수 선택--%>
        $('select#rowCount').on('change', function() {
            var url = 'index.do';
            $('#myPost #viewPage').val(1);
            var formData = serializeCustom($('form#myPost'));
            doGetLoad(url, formData);
        });

        <%--상세보기--%>
        $('a.board_window_btn').on('click', function(e) {
            var context_path = $(this).attr('keyValue1');
            var param = '&menu_idx=' + $(this).attr('keyValue2');
            param += '&manage_idx=' + $(this).attr('keyValue3');
            param += '&board_idx=' + $(this).attr('keyValue4');
            window.open('/' + context_path + '/board/view.do?' + param, 'boardManage', 'width=1500,height=800,scrollbars=1');
            e.preventDefault();
        });

    });
</script>
<style>
    .container {
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* 왼쪽 정렬 */
        margin: 10px; /* 왼쪽 여백 조정 */
    }

    .select-section {
        display: flex;
        align-items: center;
        gap: 10px; /* selectbox 간 간격 */
        margin-bottom: 10px; /* 검색 결과와의 간격 */
    }

    .result-section {
        margin-top: 10px;
    }

    .selectmenu {
        padding: 5px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .selectmenu:focus {
        border-color: #007bff;
        outline: none;
    }
</style>

<form:form modelAttribute="myPost" action="index.do" method="get">
    <form:hidden path="menu_idx"/>
    <div class="container">
        <div class="select-section">
            <span>도서관 선택 :</span>
            <form:select path="homepage_id" class="selectmenu" style="width:200px;">
                <c:forEach items="${libraryList}" varStatus="status" var="i">
                    <c:choose>
                        <c:when test="${i.homepage_id eq 'h32'}">
                            <form:option value="${i.homepage_id}">전체도서관</form:option>
                        </c:when>
                        <c:otherwise>
                            <form:option value="${i.homepage_id}">${i.homepage_name}</form:option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </form:select>

            <span>게시판 선택 :</span>
            <form:select path="manage_idx" class="selectmenu" style="width:150px;">
                <form:option value="0">전체 게시판</form:option>
                <c:forEach items="${boardList}" var="i" varStatus="status">
                    <form:option value="${i.manage_idx}">${i.menu_name}</form:option>
                </c:forEach>
            </form:select>
        </div>
        <div class="result-section">
            검색 결과 : ${paging.totalDataCount}건
            <form:select path="rowCount" class="selectmenu" style="width:120px;">
                <form:option value="10">10개씩 보기</form:option>
                <form:option value="20">20개씩 보기</form:option>
                <form:option value="30">30개씩 보기</form:option>
                <form:option value="${paging.totalDataCount}">전체 보기</form:option>
            </form:select>
        </div>
    </div>

    <div class="wrapper-bbs">
        <div class="table-wrap">
            <table class="bbs center">
                <colgroup>
                    <col width="40px"/>
                    <col width="135px"/>
                    <col width="30%"/>
                    <col width="15%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>번호</th>
                    <th>도서관명</th>
                    <th>글 제목</th>
                    <th>게시판</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>처리상태</th>
                </tr>
                </thead>
                <tbody id="board_tbody">
                <c:forEach var="i" varStatus="status" items="${myPostList}">
                    <tr>
                        <td>${paging.listRowNum - status.index}</td>
                        <td class="center">${i.homepage_name}</td>
                        <td class="important left">
                            <a href="#" class="board_window_btn" keyValue1="${i.context_path}" keyValue2="${i.menu_idx}" keyValue3="${i.manage_idx}" keyValue4="${i.board_idx}">${i.title}</a>
                        </td>
                        <td class="center">${i.menu_name}</td>
                        <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                        <td>${i.view_count}</td>
                        <c:choose>
                            <c:when test="${i.request_state eq 4}">
                                <td>답변완료</td>
                            </c:when>
                            <c:otherwise>
                                <td></td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
                </tbody>
                <c:if test="${fn:length(myPostList) < 1}">
                    <table class="bbs center">
                        <tr>
                            <td width="100%" style="background:#f8fafb;">작성한 글이 존재하지 않습니다.</td>
                        </tr>
                    </table>
                </c:if>
            </table>
        </div>
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

    <div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
        <fieldset>
            <label class="blind" for="search_type">검색</label>
            <form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
                <form:option value="title">글제목</form:option>
            </form:select>
            <form:input path="search_text" id="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어" cssStyle="width:200px;"/>
            <a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
        </fieldset>
    </div>

</form:form>
