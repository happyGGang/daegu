<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('#dialog-1').dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            width: 400,
            height: 350,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
                $(this).empty();
                $('#dialog-1').dialog('destroy');
            },
            buttons: [
                {
                    text: "저장",
                    class: 'icon-btn navy',
                    click: function () {
                        if (doAjaxPost($('#memberGroupOne'))) {
                            $(this).dialog('destroy');
                            treeOnLoad();
                            $('#authLayer').load('memberGroup_ajax.do?editMode=FIRST');
                        }
                    }
                },
                {
                    text: "취소",
                    class: 'icon-btn gary',
                    click: function () {
                        $(this).empty();
                        $(this).dialog('destroy');
                    }
                }
            ]
        });
    });
</script>

<form:form action="save.do" id="memberGroupOne" method="post" modelAttribute="memberGroup" onsubmit="return false;">
    <form:hidden path="parent_member_group_idx"/>
    <form:hidden path="member_group_idx"/>
    <form:hidden path="editMode"/>
    <table class="popup-table">
        <tbody>
        <tr >
            <th>상위권한그룹</th>
            <td>
                ${parentMemberGroup.member_group_name}
            </td>
        </tr>
        <tr>
            <th>권한그룹명 <span style="color: red">*</span></th>
            <td>
                <form:input cssClass="custom-input" path="member_group_name"/>
            </td>
        </tr>
        <tr>
            <th>설명</th>
            <td>
                <form:input cssClass="custom-input" path="remark"/>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>