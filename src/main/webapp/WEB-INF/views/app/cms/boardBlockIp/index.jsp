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
            $('#dialog-1').load('edit.do?editMode=MODIFY&block_ip=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            event.preventDefault();
        });

        $('a#delete').on('click', function (event) {
            if (confirm('게시판 차단 IP 설정을 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#block_ip_index').val($(this).attr('keyValue'));
                if (doAjaxPost($('#boardBlockIp_index'))) {
                    location.reload();
                }
            }

            event.preventDefault();
        });
    });
</script>

<div class="container-box">
    <form:form id="boardBlockIp_index" modelAttribute="boardBlockIp" action="save.do" method="post" onsubmit="return false;">
        <form:hidden id="editMode_index" path="editMode"/>
        <form:hidden id="block_ip_index" path="block_ip"/>
    </form:form>

    <div class="page-header">
        <div>게시판 IP 차단</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="table-action-wrapper">
            <p class="total-count">총 ${fn:length(boardBlockIpList)}건</p>

            <a href="" class="icon-btn navy" id="dialog-add">
                <img src="/resources/cms/img/main/plus.svg" alt="">
                <div>차단IP 추가</div>
            </a>
        </div>

        <div class="table-wrap">
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>순번</th>
                        <th>IP</th>
                        <th>차단여부</th>
                        <th>설명</th>
                        <th>등록일</th>
                        <th>등록ID</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(boardBlockIpList) < 1}">
                    <tr>
                        <td colspan="7">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" varStatus="status" items="${boardBlockIpList}">
                    <tr>
                        <td class="num">${status.count}</td>
                        <td>${i.block_ip}</td>
                        <td>${i.use_yn}</td>
                        <td>${i.remark}</td>
                        <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                        <td>${i.add_id}</td>
                        <td>
                            <c:if test="${authU}">
                                <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.block_ip}">수정</a>
                            </c:if>
                            <c:if test="${authD}">
                                <a href="" class="custom-btn" id="delete" keyValue="${i.block_ip}">삭제</a>
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