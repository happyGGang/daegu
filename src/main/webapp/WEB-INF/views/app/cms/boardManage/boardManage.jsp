<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function () {
        //모달창 링크 버튼
        $('a#dialog-add').on('click', function (e) {
            if ($('#homepage_id_1').val() == '') {
                alert('홈페이지를 선택해주세요.');
                return false;
            }
            $('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('select#homepage_id_1').on('change', function (e) {
            if ($(this).val() != '') {
                $('#homepage_id_1').val($(this).val());
                $('#boardManage2').submit();
            }

            e.preventDefault();
        });

        $('a#dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&manage_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#dialog-field').on('click', function (e) {
            $('#dialog-2').load('/cms/boardManage/fieldManage/index.do?homepage_id=' + $('#homepage_id_1').val() + '&manage_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-2').dialog('open');
            });

            e.preventDefault();
        });

        $('a#delete').on('click', function (e) {
            if (confirm('선택된  게시판을 삭제 하시겠습니까?')) {
                $('input#popup_idx_1').val($(this).attr('keyValue'));

                $.ajax({
                    url: 'delete.do',
                    async: false,
                    data: serializeObject($('#popup_1')),
                    method: 'POST',
                    dataType: 'json',
                    success: function (data) {
                        data = eval(data);
                        if (data.valid) {
                            alert(data.result);
                            doGetLoad('index.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val());
                        }
                    }
                });
            }

            e.preventDefault();
        });

        $('button#search_btn').on('click', function (e) {
            $('#viewPage').attr('value', 1);
            doGetLoad('index.do?' + $('#boardManage').serialize());
            e.preventDefault();
        });


        $('a.board_window_btn').on('click', function (e) {
            var param = 'homepage_id=' + $(this).attr('keyValue1');
            param += '&manage_idx=' + $(this).attr('keyValue2');
            if ($(this).attr('keyValue3') != '0') {
                param += '&menu_idx=' + $(this).attr('keyValue3');
            }
            window.open('/${homepageContextPath}/board/index.do?' + param, 'boardManage', 'width=1500,height=800,scrollbars=1');
            e.preventDefault();
        });

        $('select#rowCount').change(function (e) {
            $('input#viewPage').attr('value', 1);
            $('select#board_type').attr('value', '');
            $('input#search_text').attr('value', '');
            doGetLoad('index.do', serializeCustom($('#boardManage')));
        });
    });
</script>

<div class="container-box">
    <form:form modelAttribute="boardManage" id="boardManage2" action="index.do">
        <form:hidden id="homepage_id_1" path="homepage_id"/>
    </form:form>

    <div id="editDisable" class="disableBox">
        <div class="page-header">
            <div>게시판 관리</div>
        </div>

        <div class="main-content" style="flex-direction: column">
            <c:if test="${boardManage.editMode eq 'FIRST'}">
                <div class="mask"></div>
            </c:if>

            <form:form modelAttribute="boardManage" action="index.do" method="get">
                <form:hidden path="homepage_id"/>
                <form:hidden path="editMode"/>

                <div class="table-action-wrapper">
                    <div class="center">
                        <p class="total-count">총 ${paging.totalDataCount}건, 홈페이지 ID : ${boardManage.homepage_id}</p>
                        <form:select path="rowCount" class="custom-filter" style="width:150px;">
                            <form:option value="10">10개씩 보기</form:option>
                            <form:option value="20">20개씩 보기</form:option>
                            <form:option value="30">30개씩 보기</form:option>
                            <form:option value="${paging.totalDataCount}">전체 보기</form:option>
                        </form:select>
                    </div>

                    <a href="" class="icon-btn navy" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>게시판 등록</div>
                    </a>
                </div>
                <div class="table-wrap">
                    <div class="msg">&nbsp;</div>
                    <table class="bbs custom-table">
                        <thead>
                        <tr>
                            <th>순번</th>
                            <th>게시판명</th>
                            <th>게시판IDX</th>
                            <th>게시판 유형</th>
                            <th>사용여부</th>
                            <th>등록일</th>
                            <th>기능</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach var="i" varStatus="status" items="${boardManageList}">
                            <tr>
                                <td class="num">${paging.listRowNum - status.index}</td>
                                <td><a href="" class="board_window_btn" keyValue1="${i.homepage_id}"
                                                    keyValue2="${i.manage_idx}" keyValue3="${i.menu_idx}">${i.board_name}</a>
                                </td>
                                <td class="num">${i.manage_idx}</td>
                                <td>${i.board_type}</td>
                                <td>${i.board_use_yn eq 'Y'?'사용함':'사용안함'}</td>
                                <td class="num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                                <td>
                                    <c:if test="${authU}">
                                        <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.manage_idx}">수정</a>
                                    </c:if>
                                    <c:if test="${(fn:indexOf(i.board_skin, 'CUSTOM') > -1) and (i.homepage_id eq boardManage.homepage_id)}">
                                        <a href="" class="custom-btn" id="dialog-field" keyValue="${i.manage_idx}">필드</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${fn:length(boardManageList) < 1}">
                        <table class="bbs center">
                            <tr style="height:100%;">
                                <td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
                            </tr>
                        </table>
                    </c:if>

                    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                        <jsp:param name="formId" value="#boardManage"/>
                    </jsp:include>

                    <div class="table-search-bar">
                        <fieldset class="search-bar">
                            <div class="btn-wrapper">
                                <form:select path="board_type" cssClass="custom-filter">
                                    <form:option value="">게시판 유형</form:option>
                                    <c:forEach var="i" varStatus="status" items="${boardTypes}">
                                        <form:option value="${i.code_name}">${i.remark}</form:option>
                                    </c:forEach>
                                </form:select>
                                <form:select path="search_type" cssClass="custom-filter">
                                    <form:option value="board_name">게시판명</form:option>
                                </form:select>
                            </div>

                            <form:input path="search_text" cssClass="custom-search"/>
                            <div id="search_btn" class="icon-btn black">
                                <img alt="" src="/resources/cms/img/main/search.svg">
                                <div>검색</div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="게시판 정보"></div>

<div id="dialog-2" class="dialog-common" title="필드 정보"></div>

<div id="dialog-searchLayer" class="dialog-common11" title="관리자 변경 검색"></div>

