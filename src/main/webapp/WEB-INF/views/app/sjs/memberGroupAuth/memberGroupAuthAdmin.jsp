<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    var list = $('tbody#authGroupList tr');
    $(document).ready(function () {
        $('table tr:first-child').addClass('first');
        $('table tr').each(function () {
            $(this).children('th:first-child,td:first-child').addClass('first');
            $(this).children('th:last-child,td:last-child').addClass('last');
        });

        $('a#save').on('click', function (e) {
            e.preventDefault();
            doAjaxPost($('form#memberGroupAuth'));
        });

        $('input.checkAll').on('click', function () {
            var $myTr = $(this).parents('tr');
            $($myTr).find('input:checkbox').prop('checked', $(this).is(':checked'));
        });

        $('input#masterCheck').on('click', function () {
            $('input:checkbox:visible').not(':disabled').prop('checked', $(this).is(':checked'));
        });

        $('select#moduleType').on('change', function () {
            $('#authLayer').load('memberGroupAuth.do?editMode=ADD&member_group_idx=${memberGroupAuth.member_group_idx}&moduleType=' + $(this).val());
        });

        $('a.setModuleAuth').on('click', function (e) {
            e.preventDefault();
            var param = 'menu_idx=' + $(this).data('menu-idx');
            param += '&module_idx=' + $(this).data('module-idx');
            param += '&moduleType=' + $('select#moduleType option:selected').val();
            param += '&member_group_idx=' + $('input#member_group_idx').val();

            $('#dialog-1').load('editAuthGroupModule_ajax.do?' + param, function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });
        });

        $('input#masterCheckR, input#masterCheckU, input#masterCheckC, input#masterCheckD').on('click', function () {
            $('input.' + $(this).attr('id')).prop('checked', $(this).is(':checked'));
        });

    });
</script>

<form:form action="save.do" method="POST" modelAttribute="memberGroupAuth">
    <form:hidden path="member_group_idx"/>
    <form:hidden path="homepage_id"/>
    <div class="disableBox" id="editDisable">
        <c:if test="${memberGroupAuth.editMode eq 'FIRST'}">
            <div class="mask"></div>
        </c:if>
        <div class="table-action-wrapper">
            <div class="center">
                <p class="total-count">구분</p>
                <form:select cssClass="custom-filter" path="moduleType">
                    <form:option label="관리자페이지" value="CMS"/>
                    <form:option label="이용자페이지" value="SITE"/>
                </form:select>
            </div>
            <a class="icon-btn navy" href="#" id="save">
                <img src="/resources/cms/img/main/save.svg" alt="">
                <div>저장</div>
            </a>
        </div>


        <div class="table-wrap">
            <div class="table-scroll">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th style="width: 20%">메뉴명</th>
                            <th style="width: 20%">모듈명</th>
                            <th>
                                <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
                                    <input id="masterCheck" type="checkbox"/>
                                    <label class="btn-wrapper" for="masterCheck">전체</label>
                                </div>
                            </th>

                            <th>
                                <div style="display: flex; align-content: center; justify-content: center; gap: 4px">
                                    <input id="masterCheckR" type="checkbox"/>
                                    <label class="btn-wrapper" for="masterCheckR">조회</label>
                                </div>
                            </th>

                            <th>
                                <div style="display: flex; align-content: center; justify-content: center; gap: 4px">
                                    <input id="masterCheckC" type="checkbox"/>
                                    <label class="btn-wrapper" for="masterCheckC">등록</label>
                                </div>
                            </th>

                            <th>
                                <div style="display: flex; align-content: center; justify-content: center; gap: 4px">
                                    <input id="masterCheckU" type="checkbox"/>
                                    <label class="btn-wrapper" for="masterCheckU">수정</label>
                                </div>
                            </th>

                            <th>
                                <div style="display: flex; align-content: center; justify-content: center; gap: 4px">
                                    <input id="masterCheckD" type="checkbox"/>
                                    <label class="btn-wrapper" for="masterCheckD">삭제</label>
                                </div>
                            </th>

                            <th>모듈권한설정</th>
                        </tr>
                    </thead>
                    <tbody id="authGroupList">
                    <c:if test="${fn:length(menuList) < 1}">
                        <tr style="height:100%">
                            <td style="background:#F8FAFB;">데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach begin="1" items="${menuList}" var="i" varStatus="status">
                        <tr>
                            <th class="width200"><span
                                    style="padding-left: ${(i.menu_level-2)*16}px;">${i.menu_name}</span></th>
                            <th class="width200"><span>${i.moduleName}</span></th>
                            <c:choose>
                                <c:when test="${not empty i.moduleName}">
                                    <td>
                                        <div class="btn-wrapper">
                                            <input class="checkAll" id="checkAll_${status.index}" type="checkbox">
                                            <label for="checkAll_${status.index}">전체</label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-wrapper">
                                            <form:checkbox class="masterCheckR" id="checkR_${status.index}" path="authCodeList" value="${i.menu_idx}_${i.module_idx}_R"/>
                                            <label for="checkR_${status.index}">조회</label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-wrapper">
                                            <form:checkbox class="masterCheckC" id="checkC_${status.index}" path="authCodeList" value="${i.menu_idx}_${i.module_idx}_C"/>
                                            <label for="checkC_${status.index}">등록</label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-wrapper">
                                            <form:checkbox class="masterCheckU" id="checkU_${status.index}" path="authCodeList" value="${i.menu_idx}_${i.module_idx}_U"/>
                                            <label for="checkU_${status.index}">수정</label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-wrapper">
                                            <form:checkbox class="masterCheckD" id="checkD_${status.index}" path="authCodeList" value="${i.menu_idx}_${i.module_idx}_D"/>
                                            <label for="checkD_${status.index}">삭제</label>
                                        </div>
                                    </td>
                                    <td>
                                        <c:if test="${not empty i.auth_group_id and (authC or authU or authD)}">
                                            <a class="btn btn4 setModuleAuth" data-menu-idx="${i.menu_idx}" data-module-idx="${i.module_idx}" href="#">모듈권한설정</a>
                                        </c:if>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
</form:form>
<div class="alert"></div>
</div>

<div class="dialog-common" id="dialog-1" title="모듈권한정보"></div>