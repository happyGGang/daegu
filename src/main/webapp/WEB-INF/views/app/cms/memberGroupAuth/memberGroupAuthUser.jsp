<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    var list = $('tbody#authGroupList tr');
    $(document).ready(function () {
        //테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
        $('table tr:first-child').addClass('first');
        $('table tr').each(function () {
            $(this).children('th:first-child,td:first-child').addClass('first');
            $(this).children('th:last-child,td:last-child').addClass('last');
        });

        <%--저장--%>
        $('a#save').on('click', function (e) {
            e.preventDefault();
            doAjaxPost($('form#memberGroupAuth'));
        });


        <%--체크박스선택--%>
        $('input.checkAll').on('click', function () {
            var $myTr = $(this).parents('tr');
            $($myTr).find('input:checkbox').prop('checked', $(this).is(':checked'));
        });

        $('input.checkBoard, input.checkAccess').on('click', function () {
            var type = $(this).data('checktype');
            $('input.' + type).prop('checked', $(this).is(':checked'));
        });

        <%-- 체크박스 선택 끝 --%>

        $('input#masterCheck').on('click', function () {
            $('input:checkbox').not(':disabled').prop('checked', $(this).is(':checked'));
        });

        <%--구분값 변경(CMS, SITE)--%>
        $('select#moduleType').on('change', function () {
            $('#authLayer').load('memberGroupAuth.do?editMode=ADD&member_group_idx=${memberGroupAuth.member_group_idx}&moduleType=' + $(this).val());
        });
        <%--구분값 변경(CMS, SITE)--%>

        <%--홈페이지 변경--%>
        $('select#homepage_id').on('change', function () {
            doAjaxLoad('#authLayer', 'memberGroupAuth.do', $('form#memberGroupAuth').serialize());
        });
        <%--구분값 변경(CMS, SITE)--%>

        <%--모듈권한설정--%>
        $('a.setModuleAuth').on('click', function (e) {
            e.preventDefault();
            var param = 'menu_idx=' + $(this).data('menu-idx');
            param += '&module_idx=' + $(this).data('module-idx');
            param += '&auth_group_id=' + $(this).data('auth_group_id');
            param += '&moduleType=SITE';
            param += '&member_group_idx=' + $('input#member_group_idx').val();
            param += '&site_id=' + $('#homepage_id').val();

            $('#dialog-1').load('editAuthGroupModule_ajax.do?' + param, function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });
        });

        $('input#masterCheckR, input#masterCheckU, input#masterCheckC, input#masterCheckD').on('click', function () {
            $('input.' + $(this).attr('id')).prop('checked', $(this).is(':checked'));
        });
    });
</script>
<style>
    .width200 {
        width: 200px;
    }
</style>
<form:form modelAttribute="memberGroupAuth" method="POST" action="save.do">
    <form:hidden path="member_group_idx"/>
    <div id="editDisable" class="disableBox">
    <%-- disable 상태로 변경 --%>
    <c:if test="${memberGroupAuth.editMode eq 'FIRST'}">
        <div class="mask"></div>
    </c:if>
    <div class="table-action-wrapper">
        <div class="center">
            <c:choose>
                <c:when test="${!(memberGroup.user_group_yn eq 'Y' or memberGroup.guest_group_yn eq 'Y')}">
                    <p class="total-count">구분</p>
                    <form:select path="moduleType" cssClass="custom-filter">
                        <form:option value="CMS" label="관리자페이지"/>
                        <form:option value="SITE" label="이용자페이지"/>
                    </form:select>
                </c:when>
                <c:otherwise>
                    <form:hidden path="moduleType"/>
                </c:otherwise>
            </c:choose>

            <p class="total-count">
                홈페이지 :
                <c:choose>
                    <c:when test="${fn:length(siteList) > 1}">
                        <form:select path="homepage_id" cssClass="custom-filter">
                            <c:forEach items="${siteList}" var="i">
                                <form:option value="${i.homepage_id}" label="${i.homepage_name}"></form:option>
                            </c:forEach>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${siteList}" var="i">
                            ${i.homepage_name}
                        </c:forEach>
                        <form:hidden path="homepage_id"/>
                    </c:otherwise>
                </c:choose>
            </p>

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
                        <th class="width200">메뉴명</th>
                        <th class="width200">모듈명</th>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
                                <input id="masterCheck" type="checkbox"/>
                                <label class="btn-wrapper" for="masterCheck">전체</label>
                            </div>
                        </th>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
                                <input id="masterCheckR" type="checkbox"/>
                                <label class="btn-wrapper" for="masterCheckR">조회</label>
                            </div>
                        </th>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
                                <input id="masterCheckC" type="checkbox"/>
                                <label class="btn-wrapper" for="masterCheckC">등록</label>
                            </div>
                        </th>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
                                <input id="masterCheckU" type="checkbox"/>
                                <label class="btn-wrapper" for="masterCheckU">수정</label>
                            </div>
                        </th>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px;">
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
                        <td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" varStatus="status" items="${menuList}" begin="1">
                    <tr>
                        <th class="width200"><span style="padding-left: ${(i.menu_level-2)*16}px;">${i.menu_name}</span>
                        </th>
                        <th class="width200"><span><c:if
                                test="${i.menu_type eq 'BOARD'}">게시판 - </c:if>${i.moduleName} </span></th>
                        <c:choose>
                            <c:when test="${not empty i.moduleName}">
                                <td>
                                    <div class="btn-wrapper">
                                        <input type="checkbox" class="checkAll" id="checkAll_${status.index}">
                                        <label for="checkAll_${status.index}">전체</label>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-wrapper">
                                        <form:checkbox path="authCodeList" id="checkR_${status.index}"
                                                       value="${i.menu_idx}_${i.manage_idx}_R" class="masterCheckR"/>
                                        <label for="checkR_${status.index}">조회</label>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-wrapper">
                                        <form:checkbox path="authCodeList" id="checkC_${status.index}"
                                                       value="${i.menu_idx}_${i.manage_idx}_C" class="masterCheckC"/>
                                        <label for="checkC_${status.index}">등록</label>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-wrapper">
                                        <form:checkbox path="authCodeList" id="checkU_${status.index}"
                                                       value="${i.menu_idx}_${i.manage_idx}_U" class="masterCheckU"/>
                                        <label for="checkU_${status.index}">수정</label>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-wrapper">
                                        <form:checkbox path="authCodeList" id="checkD_${status.index}"
                                                       value="${i.menu_idx}_${i.manage_idx}_D" class="masterCheckD"/>
                                        <label for="checkD_${status.index}">삭제</label>
                                    </div>
                                </td>
                                <td>
                                    <c:if test="${i.menu_type eq 'BOARD' or i.menu_type eq 'PROGRAM' }">
                                        <c:if test="${not empty i.auth_group_id and (authC or authU or authD)}">
                                            <a href="#" class="custom-btn setModuleAuth"
                                               data-auth_group_id="${i.auth_group_id}" data-module-idx="${i.manage_idx}"
                                               data-menu-idx="${i.menu_idx}">모듈권한설정</a>
                                        </c:if>
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
<div class="alert">
    <!-- 		<ul> -->
    <!-- 			<li>여러개 나오는 설명 문구를 출력합니다.</li> -->
    <!-- 			<li>목록을 선택하시면 상세정보를 볼 수 있습니다.</li> -->
    <!-- 		</ul> -->
</div>
</div>
<div id="dialog-1" class="dialog-common" title="모듈권한설정"></div>