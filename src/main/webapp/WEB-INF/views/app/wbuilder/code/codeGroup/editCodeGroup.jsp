<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('#dialog-1').dialog({ //모달창 기본 스크립트 선언
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
                        if (doAjaxPost($('#codeGroup'))) {
                            $(this).dialog('destroy');
// 						if ($('form#codeGroup > input#editMode').val() == 'MODIFY') {
// 							$('#tree1').tree('updateNode', current_node, {name:$('form#codeGroup > input#group_name').val()});
// 						}
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
            width: 460,
            height: 450
        });
    });

</script>
<form:form action="saveCodeGroup.do" id="codeGroup" method="post" modelAttribute="code" onsubmit="return false;">
    <form:hidden path="editMode"/>
    <form:hidden path="homepage_id"/>
    <form:hidden path="mode"/>
    <table class="popup-table">
        <tbody>
            <tr>
                <th>코드그룹 ID <span style="color: red">*</span></th>
                <td class="txt-left">
                    <c:choose>
                        <c:when test="${code.editMode eq 'MODIFY'}">
                            ${code.group_id}
                            <form:hidden path="group_id"/>
                        </c:when>
                        <c:otherwise>
                            <form:input cssClass="custom-input" path="group_id" />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>코드그룹명 <span style="color: red">*</span></th>
                <td class="txt-left">
                    <form:input cssClass="custom-input" path="group_name"/>
                </td>
            </tr>
            <tr>
                <th style="vertical-align: middle;">홈페이지 사용 <span style="color: red">*</span></th>
                <td class="txt-left">
                    <form:select path="homepage_yn" cssClass="custom-select">
                        <form:option value="Y">YES</form:option>
                        <form:option value="N">NO</form:option>
                    </form:select>
                    <br/>
                    <p class="caption">* 각 홈페이지에서도 사용하는 경우 YES</p>
                </td>
            </tr>
            <tr>
                <th>설명</th>
                <td class="txt-left">
                    <form:input cssClass="custom-input" path="remark"/>
                </td>
            </tr>
        </tbody>
    </table>
</form:form>