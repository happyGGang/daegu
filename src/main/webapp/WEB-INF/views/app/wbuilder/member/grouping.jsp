<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
    $(function () {
        $('div#dialog-3').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
                $('body > .ui-dialog').remove();
            },
            buttons: [
                {
                    text: "저장",
                    "class": 'icon-btn navy',
                    click: function () {
                        if (doAjaxPost($('#memberGrouping'))) {
                            $(this).dialog('destroy');
                        }
                    }
                }, {
                    text: "취소",
                    "class": 'icon-btn gray',
                    click: function () {
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $("div#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 600,
            height: 600
        });

        $('#checkAll').on('click', function () {
            $('tbody input:checkbox').prop('checked', $(this).prop('checked'));
        });

    });

</script>
<form:form action="saveGroup.do" id="memberGrouping" modelAttribute="member" onsubmit="return false;">
    <form:hidden path="member_id"/>
    <table class="popup-table">
        <thead>
        <tr>
            <th><input id="checkAll" type="checkbox"></th>
            <th>그룹명</th>
            <th>설명</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach begin="1" items="${getMemberGroupList}" var="i" varStatus="status">
            <tr>
                <c:set value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0 ? 'th' : 'td'}"
                       var="isSite"></c:set>
                <c:set value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0}" var="_isSite"></c:set>
                <${isSite}>
                <c:if test="${!_isSite}">
                    <form:checkbox id="checkAll${status.index}" path="authGroupIdxList" value="${i.member_group_idx}"/>
                </c:if>
            </
            ${isSite}>
            <${isSite} style="text-align: left;"><label for="checkAll${status.index}"
                                                        style="padding-left:${(i.member_group_depth-1)*15}px;">${i.member_group_name}</label>
        </
        ${isSite}>
        <${isSite} style="text-align: left;"><label for="checkAll${status.index}">${i.remark}</label></
        ${isSite}>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</form:form>