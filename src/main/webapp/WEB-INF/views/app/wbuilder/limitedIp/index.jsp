<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        $('a#dialog-add').on('click', function (event) {
            $('#dialog-1').load('edit.do?editMode=ADD', function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            event.preventDefault();
        });

        $('a#dialog-modify').on('click', function (event) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&limitedIp_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            event.preventDefault();
        });

        $('a#delete').on('click', function (event) {
            if (confirm('해당 접근가능 IP 설정을 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#limitedIp_idx').val($(this).attr('keyValue'));
                if (doAjaxPost($('#limitedIp_index'))) {
                    location.reload();
                }
            }

            event.preventDefault();
        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>홈페이지 접근불가능 IP</div>
    </div>

    <form:form action="save.do" id="limitedIp_index" method="post" modelAttribute="limitedIp" onsubmit="return false;">
        <form:hidden id="editMode_index" path="editMode"/>
        <form:hidden id="limitedIp_idx" path="limitedIp_idx"/>
    </form:form>

    <div class="main-content" style="flex-direction: column">
        <div class="table-action-wrapper">
            <div class="center">
                <p class="total-count">총 ${fn:length(limitedIpList)}건</p>
            </div>

            <c:if test="${authC}">
                <a href="" class="icon-btn navy" id="dialog-add" >
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>접근불가능IP 추가</div>
                </a>
            </c:if>
        </div>

        <table class="custom-table">
            <thead>
            <tr>
                <th style="width: 5%">순번</th>
                <th>IP</th>
                <th>사용여부</th>
                <th>설명</th>
                <th>등록일</th>
                <th>등록 ID</th>
                <th>기능</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(limitedIpList) < 1}">
                <tr>
                    <td colspan="7">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:if>
            <c:forEach items="${limitedIpList}" var="i" varStatus="status">
                <tr>
                    <td class="num">${status.count}</td>
                    <td>${i.limited_ip}</td>
                    <td>${i.use_yn}</td>
                    <td>${i.remark}</td>
                    <td>
                        <fmt:formatDate pattern="yyyy.MM.dd" value="${i.add_date}"/>
                    </td>
                    <td>${i.add_id}</td>
                    <td>
                        <c:if test="${authU}">
                            <a class="custom-btn" href="" id="dialog-modify" keyValue="${i.limitedIp_idx}">수정</a>
                        </c:if>
                        <c:if test="${authD}">
                            <a class="custom-btn" href="" id="delete" keyValue="${i.limitedIp_idx}">삭제</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="dialog-common" id="dialog-1" title="접근불가능 IP등록/수정"></div>