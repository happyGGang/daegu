<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
                        if (doAjaxPost($('#moduleMngtForm'))) {
                            location.reload();
                        }
                    }
                }, {
                    text: "취소",
                    "class": 'icon-btn gary',
                    click: function () {
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 500,
            height: 500
        });

        $('.ui-calendar').each(function () {
            $(this).datepicker({
                //기본달력
            });
        });
    });

</script>
<form:form action="save.do" id="moduleMngtForm" method="post" modelAttribute="moduleMngt">
    <form:hidden path="homepage_id"/>
    <form:hidden path="module_idx"/>
    <form:hidden path="editMode"/>
    <table class="popup-table">
        <tbody>
            <tr>
                <th>구분</th>
                <td class="txt-left">
                    <form:select class="custom-select" path="module_type">
                        <form:option label="SITE" value="SITE"/>
                        <form:option label="CMS" value="CMS"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>모듈명</th>
                <td class="txt-left">
                    <form:input class="custom-input" path="module_name"/>
                </td>
            </tr>
            <tr>
                <th>모듈설명</th>
                <td class="txt-left">
                    <form:input class="custom-input" path="remark"/>
                </td>
            </tr>
            <tr>
                <th>링크 URL</th>
                <td class="txt-left">
                    <form:input class="custom-input" path="link_url"/>
                </td>
            </tr>
            <tr>
                <th>링크파라미터</th>
                <td class="txt-left">
                    <form:input class="custom-input" path="link_param"/>
                </td>
            </tr>
            <tr>
                <th>약관선택</th>
                <td class="txt-left">
                    <form:select class="custom-select" path="terms_group_id" >
                        <form:option label="--없음--" value=""></form:option>
                        <form:options itemLabel="code_name" itemValue="code_id" items="${termsCodeList}"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>모듈권한선택</th>
                <td class="txt-left">
                    <form:select class="custom-select" path="auth_group_id">
                        <form:option label="--없음--" value=""></form:option>
                        <form:options itemLabel="auth_group_name" itemValue="auth_group_id" items="${authCodeList}"/>
                    </form:select>
                </td>
            </tr>
        </tbody>
    </table>
</form:form>
