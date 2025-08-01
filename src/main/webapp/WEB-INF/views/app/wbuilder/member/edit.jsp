<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        if (doAjaxPost($('#member'))) {
                            $(this).dialog('destroy');
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
            width: 700,
            height: 800
        });

        if ('${member.auth_id_list}' != '') {
            var arr = '${member.auth_id_list}'.split(',');
            $.each(arr, function (i, v) {
                $('option#auth_' + v).prop('selected', true);
            });
        }

        $('a#linkMemberSearch').on('click', function (e) {
            $.get('getLinkMember.do?member_id=' + $('#member input#member_id:visible').val(), function (response) {
                console.log(response);
                if (response.data.length > 0) {

                    $('#member #link_member_yn').val('Y');
                    $('#member #member_name').val(response.data[0]["NAME"]);
                    $('#member #member_pw').val('111111');

                    if (response.data[0]["HANDPHONE"] != null) {
                        var phone = response.data[0]["HANDPHONE"].split("\-");
                        $('#member #cell_phone1').val(phone[0]);
                        $('#member #cell_phone2').val(phone[1]);
                        $('#member #cell_phone3').val(phone[2]);
                    }

                    if (response.data[0]["E_MAIL"] != null) {
                        var email = response.data[0]["E_MAIL"].split("\@");
                        $('#member #email1').val(email[0]);
                        $('#member #email2').val(email[1]);
                    }

                } else {
                    alert('검색한 사용자 없습니다.');
                }
            });
            e.preventDefault();
        });

        $('#member_id:visible').on('change', function (e) {
            if ($('#member #link_member_yn').val() == 'Y') {
                $('#member #link_member_yn').val('N');
                $('#member #member_name').val('');
                $('#member #member_pw').val('');
                $('#member #cell_phone1').val('');
                $('#member #cell_phone2').val('');
                $('#member #cell_phone3').val('');
                $('#member #email1').val('');
                $('#member #email2').val('');
            }
            e.preventDefault();
        });


    });

</script>
<form:form action="save.do" method="post" modelAttribute="member" onsubmit="return false;">
    <form:hidden path="editMode"/>
    <form:hidden path="link_member_yn" value="N"/>
    <c:if test="${!member.admin or (member.editMode eq 'MODIFY')}">
        <form:hidden path="member_id"/>
    </c:if>
    <table class="popup-table">
        <tbody>
        <tr>
            <th>사용자 ID</th>
            <td>
                <div class="center">
                    <c:choose>
                        <c:when test="${member.editMode eq 'ADD'}">
                            <form:input cssClass="custom-search" cssStyle="width:178px;" maxlength="20" path="member_id"/>
                            <a class="icon-btn black" href="" id="linkMemberSearch" style="margin-left: 4px">
                                <img src="/resources/cms/img/main/search.svg" alt="">
                                <div>일반사용자검색</div>
                            </a>
                        </c:when>
                        <c:otherwise>
                            ${member.member_id}
                        </c:otherwise>
                    </c:choose>
                </div>
            </td>
        </tr>
        <tr>
            <th>사용자명</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" maxlength="20" path="member_name"/>
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td class="txt-left">
                <form:password cssClass="custom-input" cssStyle="width:178px;" maxlength="20" path="member_pw"/>
            </td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td class="txt-left">
                <form:select cssClass="custom-select" path="phone1">
                    <form:options itemLabel="code_name" itemValue="code_id" items="${phoneCode}"/>
                </form:select>
                -
                <form:input cssClass="custom-input" cssStyle="width:40px;" maxlength="4" path="phone2"/>
                -
                <form:input cssClass="custom-input" cssStyle="width:40px;" maxlength="4" path="phone3"/>
            </td>
        </tr>
        <tr>
            <th>휴대전화번호</th>
            <td class="txt-left">
                <form:select cssClass="custom-select" path="cell_phone1">
                    <form:options itemLabel="code_name" itemValue="code_id" items="${cellPhoneCode}"/>
                </form:select>
                -
                <form:input cssClass="custom-input" cssStyle="width:40px;" maxlength="4" path="cell_phone2"/>
                -
                <form:input cssClass="custom-input" cssStyle="width:40px;" maxlength="4" path="cell_phone3"/>
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td class="txt-left">
                <form:input cssClass="custom-input" cssStyle="width:100px;" maxlength="20" path="email1"/>
                @
                <form:input cssClass="custom-input" cssStyle="width:100px;" maxlength="20" path="email2"/>
            </td>
        </tr>
        <tr style="display: none;">
            <th>등록일</th>
            <td class="txt-left">
                <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.add_date}"/>
            </td>
        </tr>
        <tr style="display: none;">
            <th>비밀번호 변경일</th>
            <td class="txt-left">
                <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.pw_change_date}"/>
            </td>
        </tr>
        <tr style="display: none;">
            <th>마지막 로그인</th>
            <td class="txt-left">
                <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.last_login}"/>
            </td>
        </tr>
        </tbody>
    </table>
    <c:if test="${member.editMode eq 'ADD'}">
        <table class="popup-table" style="margin-top: 20px">
            <thead>
                <tr><th colspan="3">권한</th></tr>
            </thead>
            <tbody id="groupList">
            <c:forEach begin="1" items="${getMemberGroupList}" var="i" varStatus="status">
                <c:if test="${i.user_group_yn ne 'Y' and i.guest_group_yn ne 'Y' }">
                    <tr>
                        <c:set value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0 ? 'th' : 'td'}"
                               var="isSite"></c:set>
                        <c:set value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0}" var="_isSite"></c:set>
                        <${isSite}>
                        <c:if test="${!_isSite}">
                            <form:checkbox id="checkAll${status.index}" path="authGroupIdxList"
                                           value="${i.member_group_idx}"/>
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
    </c:if>
    </c:forEach>
    </tbody>
    </table>
    </c:if>
</form:form>