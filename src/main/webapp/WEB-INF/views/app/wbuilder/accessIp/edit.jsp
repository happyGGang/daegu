<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('.dialog-common').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
            },
            buttons: [
                {
                    text: "저장",
                    "class": 'icon-btn navy',
                    click: function () {
                        if (doAjaxPost($('#accessIp'))) {
                            $(this).dialog('destroy');
                            location.reload();
                        }
                    }
                }, {
                    text: "취소",
                    "class": 'icon-btn gary',
                    click: function () {
                        $(this).empty();
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 500,
            height: 430
        });
    });

</script>
<form:form action="save.do" method="post" modelAttribute="accessIp" onsubmit="return false;">
    <form:hidden path="editMode"/>
    <form:hidden path="access_idx"/>
    <table class="popup-table">
        <tbody>
        <tr>
            <th style="vertical-align: middle;">접근가능 IP</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" maxlength="20" path="access_ip"/>
                <p class="caption">예) 192.168.1.1</p>
            </td>
        </tr>
        <tr>
            <th>허용여부</th>
            <td class="txt-left">
                <form:select path="use_yn" cssClass="custom-select">
                    <form:option value="Y">YES</form:option>
                    <form:option value="N">NO</form:option>
                </form:select>
            </td>
        </tr>
        <tr>
            <th>설명</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" maxlength="30" path="remark"/>
            </td>
        </tr>
        <tr>
            <th>등록일</th>
            <td class="txt-left" style="vertical-align: middle;">
                <c:choose>
                    <c:when test="${accessIp.editMode eq 'MODIFY'}">
                        <fmt:formatDate pattern="yyyy.MM.dd" value="${accessIp.add_date}"/>
                    </c:when>
                    <c:otherwise>
                        자동으로 등록됩니다.
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>