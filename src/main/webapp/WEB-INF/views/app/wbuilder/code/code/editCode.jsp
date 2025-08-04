<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('#dialog-2').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
                $(this).empty();
                $('body > div.ui-dialog').remove();
            },
            buttons: [
                {
                    text: "저장",
                    "class": 'icon-btn navy',
                    click: function () {
                        if (doAjaxPost($('#code'))) {
                            $(this).dialog('destroy');
                            $(current_node).click();
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

        $("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 400,
            height: 450
        });
    });

</script>
<form:form action="save.do" method="post" modelAttribute="code" onsubmit="return false;">
    <form:hidden path="editMode"/>
    <form:hidden path="group_id"/>
    <form:hidden path="homepage_id"/>
    <table class="popup-table">
        <tbody>
        <tr>
            <th>코드그룹 ID</th>
            <td class="txt-left" style="vertical-align: middle;">${code.group_id}</td>
        </tr>
        <tr>
            <th>코드 ID <span style="color: red">*</span></th>
            <td class="txt-left">
                <c:choose>
                    <c:when test="${code.editMode eq 'MODIFY'}">
                        ${code.code_id}
                        <form:hidden path="code_id"/>
                    </c:when>
                    <c:otherwise>
                        <form:input cssClass="custom-input" maxlength="4" path="code_id"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>코드명 <span style="color: red">*</span></th>
            <td class="txt-left">
                <form:input cssClass="custom-input" maxlength="20" path="code_name"/>
            </td>
        </tr>
        <tr>
            <th>설명</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" maxlength="100" path="remark"/>
            </td>
        </tr>
        <tr>
            <th>사용여부</th>
            <td class="txt-left">
                <form:select cssClass="custom-select" path="use_yn">
                    <form:option value="Y">예</form:option>
                    <form:option value="N">아니오</form:option>
                </form:select>
            </td>
        </tr>
        <tr>
            <th>정렬순서</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" path="print_seq"/>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>