<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<link href="/resources/cms/css/reset.css" rel="stylesheet" type="text/css"/>
<link href="/resources/cms/css/font.css" rel="stylesheet" type="text/css"/>
<link href="/resources/cms/css/common.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
    $(function () {
        $.event.special.inputchange = {
            setup: function () {
                var self = this, val;
                $.data(this, 'timer', window.setInterval(function () {
                    val = self.value;
                    if ($.data(self, 'cache') != val) {
                        $.data(self, 'cache', val);
                        $(self).trigger('inputchange');
                    }
                }, 20));
            },
            teardown: function () {
                window.clearInterval($.data(this, 'timer'));
            },
            add: function () {
                $.data(this, 'cache', this.value);
            }
        };
        var txt = $('input.menuName').val();
        $('span.menuName').text(txt);
        $('input.menuName').on('inputchange', function () {
            var txt = $(this).val();
            $('span.menuName').text(txt);
        });

        // $('input#print_seq').spinner({
        //     min: 0,
        //     max: 2500,
        //     step: 1,
        //     start: 1000
        // });

        $('.menuType').each(function (i) {
            var i = i + 1;
            $(this).attr('id', 'menuType' + i);
        });
        $('.menuTypeBox .radio input').each(function (i) {
            var i = i + 1;
            $(this).on('click', function () {
                $('.menuType').hide();
                $('#menuType' + i).show();
            });
            if ($(this).prop('checked')) {
                $('.menuType').hide();
                $('#menuType' + i).show();
            }
        });

        $('a#save').on('click', function (e) {
            if (confirm('저장 하시겠습니까?')) {
                jQuery.ajaxSettings.traditional = true;
                var option = {
                    url: 'save.do',
                    type: "POST",
                    data: $("#menuEdit").serialize(),
                    success: function (response) {
                        if (response.valid) {
                            if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
                                alert(response.message);
                                location.reload();
                            }
                        } else {
                            for (var i = 0; i < response.result.length; i++) {
                                alert(response.result[i].code);
                                $('#' + response.result[i].field).focus();
                                break;
                            }
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
                    }
                };
                $('#menuEdit').ajaxSubmit(option);
            }

            e.preventDefault();
        });

        $('a#modal_editAuth').on('click', function (e) {
            $('div#dialog_editAuth').load('editAuth.do?menu_idx=' + $('input#menu_idx').val(), function (response, status, xhr) {
                $('div#dialog_editAuth').dialog('open');
            });

            e.preventDefault();
        });

        <c:if test="${adminMenu.editMode eq 'MODIFY'}">
        if ('${adminMenu.menu_type}' == 'module') {
            $('tr#menuTypeContainer').hide();
            $('tr#menuTypeModule').show();
        }
        </c:if>

        $('select#menu_type').on('change', function () {
            if ($(this).val() == 'module') {
                $('tr#menuTypeContainer').hide();
                $('tr#menuTypeModule').show();
            } else {
                $('tr#menuTypeContainer').show();
                $('tr#menuTypeModule').hide();
            }
        });

        $('input[name=access_homepage_id_arr]').on('click', function () {
            $('input#access_homepage_all').prop('checked', ($('input[name=access_homepage_id_arr]:checked').length == 0));
        });

        $('input#access_homepage_all').on('click', function () {
            $('input[name=access_homepage_id_arr]').each(function () {
                $(this).prop('checked', false);
            })
        });
    });
</script>

<div class="disableBox" id="editDisable">
<c:if test="${adminMenu.editMode eq 'FIRST'}">
    <div class="mask"></div>
</c:if>

<div class="tree-area-title">
    <img alt="" src="/resources/cms/img/main/tag.png">
    <div>메뉴 상세정보</div>
</div>

<form:form action="save.do" id="menuEdit" method="post" modelAttribute="adminMenu" onsubmit="return false;">
    <form:hidden path="menu_idx"/>
    <form:hidden path="manage_idx"/>
    <form:hidden path="parent_menu_idx"/>
    <form:hidden path="group_idx"/>
    <form:hidden path="editMode"/>
    <table class="menu-detail-table">
        <thead></thead>
        <tbody>
        <tr>
            <th>메뉴 경로</th>
            <td>
                <c:choose>
                    <c:when test="${adminMenu.parent_menu_idx eq 0}">
                        <div class="path">
                            최상위 <img alt="" src="/resources/cms/img/main/arrow.svg"> <span class="menuName"></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="path">
                            최상위 <img alt="" src="/resources/cms/img/main/arrow.svg">
                                ${parentAdminMenu.menu_full_path_name} <img alt=""
                                                                            src="/resources/cms/img/main/arrow.svg">
                            <span class="menuName"></span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>메뉴 ID</th>
            <td>
                <c:choose>
                    <c:when test="${adminMenu.editMode eq 'MODIFY'}">${adminMenu.menu_idx}</c:when>
                    <c:otherwise>
                        <p class="info">자동으로 메뉴 ID가 등록됩니다. </p>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr class="group first">
            <th>메뉴명</th>
            <td>
                <form:input cssClass="custom-input" cssStyle="width:98%" maxlength="20" path="menu_name"/>
                <div class="caption">※ 최대 20자까지 입력할 수 있습니다.</div>
            </td>
        </tr>
        <tr>
            <th>사용 홈페이지</th>
            <td>
                <div class="custom-checkbox">
                    <input id="access_homepage_all" type="checkbox" ${(adminMenu.editMode eq 'ADD' or
                            fn:length(adminMenu.access_homepage_id_arr) < 1) ? 'checked' : ''}>
                    <label for="access_homepage_all">전체</label>
                </div>
                <c:forEach items="${homepageList}" var="i" varStatus="status">
                    <c:if test="${not empty i.homepage_alias}">
                        <div class="custom-checkbox">
                            <form:checkbox label="${i.homepage_alias}" path="access_homepage_id_arr"
                                           value="${i.homepage_id}"/>
                        </div>
                    </c:if>
                    <c:if test="${empty i.homepage_alias}">
                        <div class="custom-checkbox">
                            <form:checkbox label="${i.homepage_name}" path="access_homepage_id_arr"
                                           value="${i.homepage_id}"/>
                        </div>
                    </c:if>
                    <c:if test="${status.count % 8 eq 0}"><br></c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th>메뉴명 표시</th>
            <td>
                <div class="custom-checkbox">
                    <input checked="checked" id="check_0" type="checkbox"/>
                    <label for="check_0">사용함</label>
                </div>
                <div class="caption">※ 체크 해제 시 홈페이지에서 콘텐츠 상단의 메뉴명이 출력되지 않습니다.</div>
            </td>
        </tr>
        <tr class="group">
            <th>메뉴 노출</th>
            <td>
                <form:select cssClass="custom-select" path="view_yn">
                    <form:option value="Y">YES</form:option>
                    <form:option value="N">NO</form:option>
                </form:select>
                <div class="caption">※ NO 선택 시 홈페이지 메뉴 목록에서 출력되지 않습니다. (URL로 직접 접근은 가능합니다.)</div>
            </td>
        </tr>
        <tr class="group last">
            <th>사용 여부</th>
            <td>
                <form:select cssClass="custom-select" path="use_yn">
                    <form:option value="Y">YES</form:option>
                    <form:option value="N">NO</form:option>
                </form:select>
                <div class="caption">※ NO 선택 시 메뉴에 접근이 불가능합니다.</div>
            </td>
        </tr>
        <tr>
            <th>최고관리자 전용</th>
            <td>
                <form:select cssClass="custom-select" path="admin_access_yn">
                    <form:option value="Y">YES</form:option>
                    <form:option value="N">NO</form:option>
                </form:select>
            </td>
        </tr>
        <tr>
            <th>출력 순서</th>
            <td>
                <form:input cssClass="custom-input" cssStyle="width:4%" path="print_seq"/>
            </td>
        </tr>
        <tr>
            <th>메뉴 유형</th>
            <td>
                <form:select cssClass="custom-select" path="menu_type">
                    <form:option value="container">내부링크</form:option>
                    <form:option value="module">모듈</form:option>
                    <form:option value="_blank">외부링크</form:option>
                </form:select>
                <div class="caption">※ 외부 링크의 경우 새창으로 연결됩니다.</div>
            </td>
        </tr>
        <tr id="menuTypeContainer">
            <th>링크 주소</th>
            <td>
                <form:input cssClass="custom-input" cssStyle="width:98%" maxlength="200" path="menu_url"/>
                <div class="caption">※ 예) /cms/homepage/index.do</div>
            </td>
        </tr>
        <tr id="menuTypeModule" style="display: none;">
            <th>모듈선택</th>
            <td>
                <form:select cssClass="selectmenu-search" cssStyle="width:98%" itemLabel="module_name"
                             itemValue="module_idx" items="${moduleList}" path="module_idx">
                </form:select>
            </td>
        </tr>
        <tr style="display: none;">
            <th>폴더 아이콘</th>
            <td>
                <form:radiobutton label="일반형" path="css_type" value="fa-desktop"/>&nbsp;
                <form:radiobutton label="폴더형" path="css_type" value="fa-folder-open"/>&nbsp;
                <form:radiobutton label="통계형" path="css_type" value="fa-bar-chart"/>
            </td>
        </tr>
        <tr>
            <th>메뉴설명</th>
            <td>
                <form:input cssClass="custom-input" cssStyle="width:98%;" maxlength="200" path="menu_desc"/>
            </td>
        </tr>


        <!--      여기부터          -->
        <tr style="display: none;">
            <th>메뉴 접근 권한</th>
            <td>
                <div class="permissionBox">
                        <c:set value="" var="group_id"/>
                    <table>
                        <c:forEach items="${authList}" var="i" varStatus="status">
                        <c:if test="${group_id ne i.auth_group_id}">
                        <c:if test="${!status.first}">
            </td>
        </tr>
        </c:if>
            <c:set value="${i.auth_group_id}" var="group_id"/>
        <tr>
            <th style="width:70px">${i.auth_group_name}</th>
            <td>
                </c:if>
                <tag:menuAuthCheckbox auth_id_array="${menuAuthArray}" id="auth_${status.index}" name="auth_id_array"
                                      value="${i.auth_id}"/>
                <label for="auth_${status.index}" style="cursor:pointer;">${i.auth_name}</label>&nbsp;&nbsp;
                <c:if test="${status.last}">
            </td>
        </tr>
        </c:if>
        </c:forEach>
    </table>
    </div>
    </td>
    </tr>
    </tbody>
    </table>
</form:form>
<!-- 여기까지 줄정리 필요 -->


<div class="btn-wrapper left">
    <c:if test="${member.admin}">
        <a class="icon-btn gray" href="">
            <img alt="" src="/resources/cms/img/main/cancel.svg">
            <div>취소</div>
        </a>
        <a class="icon-btn navy" href="" id="save">
            <img alt="" src="/resources/cms/img/main/save.svg">
            <div>저장하기</div>
        </a>
    </c:if>
</div>
<br/><br/>
<div class="tree-area-title">
    <img alt="" src="/resources/cms/img/main/tag.png">
    <div>메뉴 설정 안내</div>
</div>
<ul class="guide-line">
    <li>메뉴 권한은 수정시에만 반영이 됩니다. 신규메뉴일 경우 생성후 권한 설정 하시기 바랍니다.</li>
    <li>메뉴별 상세설정 변경은 메뉴명을 클릭하여 오른쪽 화면에서 변경할 수 있습니다.</li>
    <li><span style="color:#E4302A;!important">메뉴를 편집한 후에 저장하기 버튼을 클릭해야 변경된 내용이 반영됩니다.</span></li>
</ul>
<div class="dialog-common" id="dialog_editAuth" title="그룹관리"></div>
</div>