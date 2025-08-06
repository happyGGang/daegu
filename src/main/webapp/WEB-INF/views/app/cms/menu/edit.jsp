<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        //input change (메뉴명 입력 시 메뉴 경로에 자동으로 출력 됨)
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

        //메뉴 유형 선택 시 추가 옵션 (cont2.jsp)
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
        $('.selectmenu').select2({
            //셀렉트 메뉴에 검색 기능 사용 안함
            minimumResultsForSearch: Infinity
        });

        //HTML 등록/수정 dialog
        $('a#modal_HTML, a#module-html').on('click', function (event) {
            $('#dialog_HTML').load('edit_html.do?homepage_id=' + $('input#homepage_id_1').val() + '&menu_idx=${menu.menu_idx}', function (response, status, xhr) {
                $('div#dialog_HTML').dialog('open');
            });

            $('.injected').remove();

            event.preventDefault();
        });

        //게시판 등록/수정 dialog
        $('a#modal_BOARD').on('click', function (event) {
            $('#dialog_BOARD').load('edit_board.do?homepage_id=' + $('input#homepage_id_1').val() + '&menu_idx=${menu.menu_idx}&rowCount=1000', function (response, status, xhr) {
                $('div#dialog_BOARD').dialog('open');
            });

            event.preventDefault();
        });

        //게시판 등록/수정 dialog
        $('a#modal_MODULE').on('click', function (event) {
            $('#dialog_MODULE').load('edit_module.do?homepage_id=' + $('input#homepage_id_1').val() + '&menu_idx=${menu.menu_idx}&module_type=SITE', function (response, status, xhr) {
                $('div#dialog_MODULE').dialog('open');
            });

            event.preventDefault();
        });

        $('a#save').on('click', function (e) {
            if (confirm('저장 하시겠습니까?')) {
                jQuery.ajaxSettings.traditional = true;
                if ($('[name="menu_type"]:checked').val() == 'PROGRAM') {
                    $('#menu_url_param').val($('#moduleLinkParam').val());
                } else if ($('[name="menu_type"]:checked').val() == 'LINK') {
                    $('#link_url').val($('#input_link').val());
                } else if ($('[name="menu_type"]:checked').val() == 'LINK_OUTER') {
                    $('#link_url').val($('#input_link_outer').val());
                }

                var option = {
                    url: "/cms/menu/save.do",
                    type: "POST",
                    data: $("#menuEdit").serialize(),
                    success: function (response) {
                        if (response.valid) {
                            if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
                                alert(response.message);
                                doGetLoad('/cms/menu/index.do', 'homepage_id=' + $('#menuEdit #homepage_id').val());
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
                $("#menuEdit").ajaxSubmit(option);
            }

            e.preventDefault();
        });

        $('a.select-manager-btn').on('click', function (e) {
            e.preventDefault();
            $('div#dialog_manager').load('managerView.do?homepage_id=' + $('input#homepage_id_1').val(), function (response, status, xhr) {
                $('div#dialog_manager').dialog('open');
            });
        });

        $('a.delete-manager-btn').on('click', function (e) {
            e.preventDefault();
            $('input#manager_idx').val('0');
            $('input#manager_dept').val('');
            $('input#manager_name').val('');
            $('input#manager_phone').val('');
        })

        <%-- 권한설정 --%>
        $('a#authGroup').on('click', function (e) {
            e.preventDefault();
            $('div#dialog_auth').load('authGroupView.do?menu_idx=${menu.menu_idx}&module_idx=' + $('input#manage_idx').val() + '&homepage_id=' + $('input#homepage_id_1').val(), function (response, status, xhr) {
                $('div#dialog_auth').dialog('open');
            });
        });

        $('a.preview-btn').on('click', function (e) {
            //e.preventDefault();
            if ($('input[name="menu_type"]:checked').val() == 'HTML') {
                window.open("/${homepage.context_path}/html.do?menu_idx=${menu.menu_idx}");
            } else if ($('input[name="menu_type"]:checked').val() == 'BOARD') {
                window.open("/${homepage.context_path}/board/index.do?menu_idx=${menu.menu_idx}&manage_idx=${boardManage.manage_idx}");
            } else if ($('input[name="menu_type"]:checked').val() == 'PROGRAM') {
                window.open("/${homepage.context_path}${moduleMngt.link_url}?menu_idx=${menu.menu_idx}" + $('#moduleLinkParam').val());
            } else if ($('input[name="menu_type"]:checked').val() == 'LINK') {
                window.open("${menu.link_url}");
            } else if ($('input[name="menu_type"]:checked').val() == 'LINK_OUTER') {
                window.open("${menu.link_url}");
            }
        });


    });
</script>
<div id="editDisable" class="disableBox">
    <%-- disable 상태로 변경 --%>
    <c:if test="${menu.editMode eq 'FIRST'}">
        <div class="mask"></div>
    </c:if>

    <div class="tree-area-title">
        <img alt="" src="/resources/cms/img/main/tag.png">
        <div>메뉴 상세정보</div>
    </div>

    <form:form id="menuEdit" modelAttribute="menu" action="save.do" method="post" onsubmit="return false;" enctype="multipart/form-data">
        <form:hidden path="homepage_id"/>
        <form:hidden path="menu_idx"/>
        <form:hidden path="manage_idx"/>
        <form:hidden path="parent_menu_idx"/>
        <form:hidden path="group_idx"/>
        <form:hidden path="editMode"/>
        <form:hidden path="link_url"/>
        <form:hidden path="menu_url_param"/>

        <table class="menu-detail-table">
            <tbody>
            <tr>
                <th>메뉴 경로</th>
                <td>
                    <c:choose>
                        <c:when test="${menu.parent_menu_idx eq 0}">
                            <div class="path">
                                최상위 <img alt="" src="/resources/cms/img/main/arrow.svg"> <span class="menuName"></span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="path">
                                최상위 <img alt="" src="/resources/cms/img/main/arrow.svg"> ${parentMenu.menu_full_path_name} <img alt="" src="/resources/cms/img/main/arrow.svg"> <span class="menuName"></span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>메뉴 ID</th>
                <td>
                    <c:choose>
                        <c:when test="${menu.editMode eq 'MODIFY'}">${menu.menu_idx}</c:when>
                        <c:otherwise>
                            <p class="caption">※ 자동으로 메뉴 ID가 등록됩니다.</p>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr class="group first">
                <th>메뉴명</th>
                <td><form:input path="menu_name" cssClass="custom-input menuName" maxlength=""/></td>
            </tr>
            <tr>
                <th>메뉴명 표시</th>
                <td>
                    <div class="custom-checkbox">
                        <form:checkbox path="include_menu_name_yn" value="Y" />
                        <label for="check_0">사용함</label>
                    </div>
                    <p class="caption">※ 체크 해제 시 홈페이지에서 콘텐츠 상단의 메뉴명이 출력되지 않습니다.</p>
                </td>
            </tr>
            <c:if test="${menu.parent_menu_idx eq 0 }">
                <tr>
                    <th>메뉴 이미지</th>
                    <td>
                        <input type="file" name="menu_img_file"/> <br/>
                    </td>
                </tr>
                <tr>
                    <th>현재 이미지</th>
                    <td>
                        <c:if test="${menu.menu_img ne null and menu.menu_img ne '' }">
                            <img alt="${menu.menu_img}" src="/data/menu/${menu.homepage_id}/${menu.menu_img}">
                        </c:if>
                    </td>
                </tr>
            </c:if>
            <tr class="group">
                <th>메뉴 노출</th>
                <td>
                    <form:select path="view_yn" cssClass="custom-select">
                        <form:option value="Y">YES</form:option>
                        <form:option value="N">NO</form:option>
                    </form:select>
                    <p class="caption">※ NO 선택 시 홈페이지 메뉴 목록에서 출력되지 않습니다.(URL로 직접 접근은 가능합니다.)</p>
                </td>
            </tr>
            <tr class="group">
                <th>메뉴 노출(모바일)</th>
                <td>
                    <form:select path="mobile_view_yn" cssClass="custom-select">
                        <form:option value="Y">YES</form:option>
                        <form:option value="N">NO</form:option>
                    </form:select>
                    <p class="caption">※ NO 선택 시 홈페이지(모바일) 메뉴 목록에서 출력되지 않습니다.(URL로 직접 접근은 가능합니다.)</p>
                </td>
            </tr>
            <tr class="group last">
                <th>사용 여부</th>
                <td>
                    <form:select path="use_yn" cssClass="custom-select">
                        <form:option value="Y">YES</form:option>
                        <form:option value="N">NO</form:option>
                    </form:select>
                    <p class="caption">※ NO 선택 시 메뉴에 접근이 불가능합니다.</p>
                </td>
            </tr>
            <tr>
                <th>출력 순서</th>
                <td>
                    <form:input path="print_seq" cssStyle="width:4%" cssClass="custom-input"/>
                </td>
            </tr>
            <tr>
                <th>메뉴 유형</th>
                <td class="menuTypeBox">
                    <div class="btn-wrapper">
                        <div class="radio btn-wrapper">
                            <form:radiobutton id="menu_type_NONE" path="menu_type" value="NONE"/>
                            <label for="menu_type_NONE">기능 없음</label>
                        </div>
                        <div class="radio wrapper btn-wrapper">
                            <form:radiobutton id="menu_type_HTML" path="menu_type" value="HTML"/>
                            <label for="menu_type_HTML" class="html">HTML</label>
                        </div>
                        <div class="radio wrapper btn-wrapper">
                            <form:radiobutton id="menu_type_BOARD" path="menu_type" value="BOARD"/>
                            <label for="menu_type_BOARD" class="bbs">게시판</label>
                        </div>
                        <div class="radio wrapper btn-wrapper">
                            <form:radiobutton id="menu_type_PROGRAM" path="menu_type" value="PROGRAM"/>
                            <label for="menu_type_PROGRAM" class="module">프로그램 모듈 선택</label>
                        </div>
                        <div class="radio wrapper btn-wrapper">
                            <form:radiobutton id="menu_type_LINK" path="menu_type" value="LINK"/>
                            <label for="menu_type_LINK" class="link">내부 링크</label>
                        </div>
                        <div class="radio wrapper btn-wrapper">
                            <form:radiobutton id="menu_type_LINK_OUTER" path="menu_type" value="LINK_OUTER"/>
                            <label for="menu_type_LINK_OUTER" class="link">외부 링크</label>
                        </div>
                    </div>

                    <div class="menuType none"></div>
                    <div class="menuType html">
                        <c:choose>
                            <c:when test="${menu.editMode eq 'MODIFY'}">
                                <a href="" class="custom-btn sky" id="modal_HTML">HTML 등록/수정</a>
                                <div id="dialog_HTML" class="dialog-common" title="HTML 등록/수정"></div>
                            </c:when>
                            <c:otherwise>
                                <p class="caption">※ 메뉴를 먼저 등록 후 HTML 편집이 가능합니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="menuType bbs">
                        <a href="" class="custom-btn sky" id="modal_BOARD" style="margin: 5px 0">
                            <div>게시판 종류 선택</div>
                        </a>
                        <div id="dialog_BOARD" class="dialog-common" title="게시판 선택"></div>
                        <div class="guide-line" style="background:#f6f9ff;">
                            <table class="popup-table">
                                <colgroup>
                                    <col width="15%"/>
                                    <col />
                                </colgroup>
                                <tr>
                                    <th>게시판번호</th>
                                    <td id="edit_manageIdx">${boardManage.manage_idx}</td>
                                </tr>
                                <tr>
                                    <th>게시판명</th>
                                    <td id="edit_boardName">${boardManage.board_name}</td>
                                </tr>
                                <tr>
                                    <th>게시판 유형</th>
                                    <td id="edit_boardType">${boardManage.board_type}</td>
                                </tr>
                            </table>
                        </div>

                    </div>
                    <div class="menuType module">
                        <a href="" class="custom-btn sky" id="modal_MODULE" style="margin: 5px 0">
                            <div>모듈 선택</div>
                        </a>
                        <div id="dialog_MODULE" class="dialog-common" title="모듈 선택"></div>
                        <div class="guide-line" style="background:#f6f9ff;">
                            <table class="popup-table">
                                <colgroup>
                                    <col width="15%"/>
                                    <col />
                                </colgroup>
                                <tr>
                                    <th>모듈번호</th>
                                    <td id="edit_moduleIdx">${moduleMngt.module_idx}</td>
                                </tr>
                                <tr>
                                    <th>모듈명</th>
                                    <td id="edit_moduleName">${moduleMngt.module_name}</td>
                                </tr>
                                <tr>
                                    <th>모듈링크</th>
                                    <td id="edit_moduleLink">${moduleMngt.link_url}</td>
                                </tr>
                                <tr>
                                    <th>링크변수</th>
                                    <td id="edit_moduleLinkParam"><input id="moduleLinkParam" type="text" class="text"
                                                                         value="${menu.menu_url_param}"></td>
                                </tr>
                                <tr class="moduleHtml" style="${moduleManage.module_idx eq 25?'':'display:none'}">
                                    <th>HTML</th>
                                    <td>
                                        <a href="" class="btn btn1" id="module-html">HTML 등록/수정</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="menuType link1">
                        <div class="btn-wrapper" style="margin-top: 5px">
                            <div>URL</div>
                            <input id="input_link" type="text" class="custom-input" value="${menu.menu_type eq 'LINK'? menu.link_url : ''}"/>
                        </div>
                    </div>
                    <div class="menuType link2">
                        <p class="caption" style="margin-top: 5px">※ 링크 URL주소를 입력합니다. 외부 링크는 새창으로 열립니다.</p>
                        <div class="btn-wrapper" style="margin-top: 5px">
                            <div>URL</div>
                            <input id="input_link_outer" type="text" class="custom-input" value="${menu.menu_type eq 'LINK_OUTER'? menu.link_url : ''}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>메뉴 권한</th>
                <td>
                    <c:choose>
                        <c:when test="${menu.editMode eq 'ADD'}">
                            <p class="caption">※ 메뉴 생성 이후 권한을 설정할 수 있습니다.</p>
                        </c:when>
                        <c:otherwise>
                            <a href="" class="icon-btn black" id="authGroup">권한그룹 설정</a>
                        </c:otherwise>
                    </c:choose>
                    <div id="dialog_auth" class="dialog-common" title="권한설정"></div>
                </td>
            </tr>
            <tr class="group last">
                <th>담당자 정보</th>
                <td colspan="3">
                    <div class="btn-wrapper">
                        <div class="btn-wrapper">
                            <label>부서</label>
                            <form:input path="manager_dept" maxlength="20" size="20" cssClass="custom-input" readonly="true"/>
                        </div>

                        <div class="btn-wrapper">
                            <label>이름</label>
                            <form:input path="manager_name" maxlength="10" size="10" cssClass="custom-input" readonly="true"/>
                        </div>

                        <div>
                            <label>전화번호</label>
                            <form:input path="manager_phone" maxlength="13" size="13" cssClass="custom-input" readonly="true"/>
                        </div>

                        <form:hidden path="manager_idx"/>
                        <a class="custom-btn select-manager-btn">담당자선택</a>
                        <c:if test="${menu.manager_idx > 0}">
                            <a class="icon-btn">
                                <img src="/resources/cms/img/main/delete.svg" alt="">
                                <div>담당자 제외</div>
                            </a>
                        </c:if>
                    </div>

                    <div id="dialog_manager" class="dialog-common" title="담당자 선택"></div>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
    <c:if test="${menu.editMode eq 'MODIFY'}">
        <div class="button">
            <div class="left">
                <a href="#" class="btn btn3 preview-btn"><i class="fa fa-eye"></i><span>미리보기</span></a>
            </div>
            <div class="right">
                마지막 수정일 : <fmt:formatDate value="${menu.modify_date}" pattern="yyyy-MM-dd"/>
            </div>
        </div>
    </c:if>
    <div class="btn-wrapper  left">
        <c:if test="${authC or authU}">
            <a class="icon-btn gray" href="">
                <img alt="" src="/resources/cms/img/main/cancel.svg">
                <div>취소</div>
            </a>
        </c:if>
        <c:if test="${authC or authU}">
            <a class="icon-btn navy" href="" id="save">
                <img alt="" src="/resources/cms/img/main/save.svg">
                <div>저장하기</div>
            </a>
        </c:if>
    </div>
        <div class="tree-area-title">
            <img alt="" src="/resources/cms/img/main/tag.png">
            <div>메뉴 설정 안내</div>
        </div>
    <ul class="guide-line">
        <li>메뉴별 상세설정 변경은 메뉴명을 클릭하여 오른쪽 화면에서 변경할 수 있습니다.</li>
        <li><span style="color:#E4302A;!important">메뉴를 편집한 후에 저장하기 버튼을 클릭해야 변경된 내용이 반영됩니다.</span></li>
        <li><span style="color:#E4302A;!important">홈페이지 속도를 위해 메뉴정보는 캐시로 관리되며 실제 반영까지 10분정도 소요될 수 있습니다.</span></li>
    </ul>
</div>

