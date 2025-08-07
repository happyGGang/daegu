<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function () {
        //모달창 링크 버튼
        $('a#dialog-add').on('click', function (event) {
            $('#dialog-1').load('edit.do?editMode=ADD', function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            event.preventDefault();
        });

        $('a#dialog-modify').on('click', function (event) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&regex_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            event.preventDefault();
        });

        $('a#delete').on('click', function (event) {
            if (confirm('정규표현식 설정을 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#regex_idx_index').val($(this).attr('keyValue'));
                if (doAjaxPost($('#boardRegexFilter_index'))) {
                    location.reload();
                }
            }

            event.preventDefault();
        });
    });
</script>

<div class="container-box">
    <form:form id="boardRegexFilter_index" modelAttribute="boardRegexFilter" action="save.do" method="post"
               onsubmit="return false;">
        <form:hidden id="editMode_index" path="editMode"/>
        <form:hidden id="regex_idx_index" path="regex_idx"/>
    </form:form>

    <div class="page-header">
        <div>게시글 정규식 차단</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="table-action-wrapper">
            <p class="total-count">총 ${fn:length(boardRegexFilterList)}건</p>

            <c:if test="${authC}">
                <a href="" class="icon-btn navy" id="dialog-add">
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>정규표현식 추가</div>
                </a>
            </c:if>
        </div>

        <div class="table-wrap">
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>순번</th>
                        <th>정규표현식</th>
                        <th>사용여부</th>
                        <th>설명</th>
                        <th>등록일</th>
                        <th>등록ID</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(boardRegexFilterList) < 1}">
                    <tr>
                        <td colspan="7">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" varStatus="status" items="${boardRegexFilterList}">
                    <tr>
                        <td class="num">${status.count}</td>
                        <td>${i.regex_str}</td>
                        <td>${i.use_yn}</td>
                        <td>${i.remark}</td>
                        <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                        <td>${i.add_id}</td>
                        <td>
                            <c:if test="${authU}">
                                <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.regex_idx}">수정</a>
                            </c:if>
                            <c:if test="${authD}">
                                <a href="" class="custom-btn" id="delete" keyValue="${i.regex_idx}">삭제</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <ul class="guide-line">
            <li>
                테이블 하단에 설명 문구를 출력합니다.
            </li>
        </ul>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="게시판 차단 IP등록/수정"></div>