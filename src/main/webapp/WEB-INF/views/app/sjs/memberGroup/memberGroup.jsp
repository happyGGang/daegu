<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    var list = $('tbody#authGroupList tr');
    $(document).ready(function () {
        $('a#saveAuthority').on('click', function (e) {
            e.preventDefault();
            doAjaxPost($('form#memberGroup'));
        });

        $('a#dialog-modify').on('click', function (e) {
            e.preventDefault();
            $('#dialog-2').load('edit_ajax.do?editMode=MODIFY&member_group_idx=${memberGroup.member_group_idx}&auth_id=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-2').dialog('open');
            });
        });

        $('a#auth_delete').on('click', function (e) {
            e.preventDefault();

            if (confirm('해당 권한을 삭제 하시겠습니까?')) {
                $.ajax({
                    url: 'save.do?editMode=DELETE&member_group_idx=${memberGroup.member_group_idx}&auth_id=' + $(this).attr('keyValue'),
                    async: true,
                    method: 'POST',
                    success: function (data) {
                        alert(data.message);
                        $('#authLayer').load('auth.do?editMode=ADD&member_group_idx=${memberGroup.member_group_idx}');
                    }
                });
            }
        });

        $('input[name=relationList]').on('click', function () {
            var $myTr = $(this).parents('tr');
            var myLevel = parseInt($($myTr).data('level'));
            var currIdx = $(list).index($($myTr));
            var $nextTr = $($myTr).nextAll('[data-level=' + myLevel + ']:first');
            var nextIdx = $(list).index($($nextTr));

            for (var i = currIdx + 1; i < nextIdx; i++) {
                var $el = $(list).get(i);
                if (parseInt($($el).data('level')) > myLevel) {
                    $($el).find('input:checkbox').prop('checked', $(this).is(':checked'));
                }
            }

            var checkAll = true;
            var parentGroupidx = $(this).data('parentgroupidx');

            $('input[name=relationList][data-parentGroupIdx=' + parentGroupidx + ']').each(function () {
                if (!$(this).is(':checked')) {
                    $('input:checkbox[value=' + parentGroupidx + ']').prop('checked', false);
                    checkAll = false;
                    return false;
                }
            });

            if (checkAll) {
                if (!$('input:checkbox[value=' + parentGroupidx + ']').is(':checked')) {
                    $('input:checkbox[value=' + parentGroupidx + ']').prop('checked', true);
                }
            } else {
                var hasParent = false;
                var myParent = $('input:checkbox[value=' + parentGroupidx + ']');
                var parentGroupidxTmp = $(myParent).data('parentgroupidx');
                var myParentTmp = $('input:checkbox[value=' + parentGroupidxTmp + ']');
                var myParentTmpLength = myParentTmp.length;

                if (myParentTmpLength > 0) {
                    hasParent = true;
                    myParentTmp.prop('checked', false);
                }

                while (hasParent) {
                    myParent = $('input:checkbox[value=' + parentGroupidxTmp + ']');
                    parentGroupidxTmp = myParent.data('parentgroupidx');
                    myParentTmp = $('input:checkbox[value=' + parentGroupidxTmp + ']');
                    myParentTmpLength = myParentTmp.length;

                    if (myParentTmpLength > 0) {
                        hasParent = true;
                        myParentTmp.prop('checked', false);
                    } else {
                        hasParent = false;
                    }
                }
            }
        });

        $('.custom-tab > li > a').on('click', function (e) {
            selectedTab = $(this).data('tab');
            $('.custom-tab > li').removeClass('active');
            $(this).parent().addClass('active');

            $('div.table-wrap').toggle();
            $('a#saveAuthority').toggle();
        });

        if (selectedTab == 'R') {
            $('a#tabLi2').click();
        }

        $('a#editGroup_add').on('click', function (e) {
            e.preventDefault();
            <c:choose>
                <c:when test="${memberGroup.admin_group_yn eq 'Y' or memberGroup.user_group_yn eq 'Y' or memberGroup.guest_group_yn eq 'Y'}">
                    alert('기본 그룹에는 하위그룹을 생성할 수 없습니다. 사이트명을 클릭 후 하위그룹 생성이 가능합니다.');
                </c:when>
                <c:otherwise>
                    $('#dialog-1').load('edit_ajax.do?editMode=ADD&parent_member_group_idx=${memberGroup.member_group_idx}', function (response, status, xhr) {
                    try {
                    $('#dialog-1').attr('title', '권한그룹 등록');
                    $('#dialog-1').dialog('open');
                } catch (e) {
                }
                });
                </c:otherwise>
            </c:choose>
        });

        $('a#editGroup_modify').on('click', function (e) {
            e.preventDefault();
            <c:choose>
                <c:when test="${memberGroup.default_group_yn eq 'Y'}">
                    alert('기본그룹은 수정할 수 없습니다.');
                </c:when>
                <c:otherwise>
                    if (beforeSelected_node.id == null) {
                    alert('수정할 권한그룹을 선택하세요.');
                } else {
                    if (beforeSelected_node.id == 'ROOT') {
                    alert('최상위 그룹은 수정할 수 없습니다.');
                } else {
                    $('#dialog-1').load('edit_ajax.do?editMode=MODIFY&member_group_idx=${memberGroup.member_group_idx}', function (response, status, xhr) {
                    $('#dialog-1').attr('title', '권한그룹 수정');
                    $('#dialog-1').dialog('open');
                });
                }
                }
                </c:otherwise>
            </c:choose>
        });

        $('a#editGroup_delete').on('click', function (e) {
            e.preventDefault();
            <c:choose>
                <c:when test="${memberGroup.default_group_yn eq 'Y'}">
                    alert('기본그룹은 삭제할 수 없습니다.');
                </c:when>
                <c:otherwise>
                    if (beforeSelected_node.id == null) {
                        alert('삭제할 권한그룹을 선택하세요.');
                    } else {
                        if (beforeSelected_node.id == 'ROOT') {
                        alert('권한그룹 모음은 삭제할 수 없습니다.');
                    } else {
                        if (confirm('삭제 하시겠습니까?')) {
                        $.ajax({
                        url: 'save.do?editMode=DELETE&member_group_idx=${memberGroup.member_group_idx}',
                        async: true,
                        method: 'POST',
                        success: function (data) {
                            alert(data.message);
                        if (data.valid) {
                            location.reload();
                        }
                    }
                });
                }
                }
                }
                </c:otherwise>
            </c:choose>
        });
    });
</script>


<style>
    #authGroupList tr td:last-child, #authGroupList tr th:last-child {display: none;}
</style>

<div class="disableBox" id="editDisable">
    <c:if test="${memberGroup.editMode eq 'FIRST'}">
        <div class="mask"></div>
    </c:if>
    <ul class="custom-tab">
        <li class="active"><a data-tab="D" href="#" id="tabLi1" keyValue="table1">기본 정보</a></li>
        <li class=""><a data-tab="R" href="#" id="tabLi2" keyValue="table2">그룹관계 설정</a></li>
    </ul>
    <form:form action="saveRelation.do" method="POST" modelAttribute="memberGroup">
        <form:hidden path="member_group_idx"/>
        <div class="table-wrap" id="table1" title="기본정보">
            <div class="btn-wrapper left">
                <c:if test="${memberGroup.admin_group_yn eq 'N' and memberGroup.user_group_yn eq 'N' and memberGroup.guest_group_yn eq 'N'}">
                    <a class="icon-btn green" href="" id="editGroup_add">
                        <img alt="" src="/resources/cms/img/main/plus.svg">
                        <div>그룹 신규등록</div>
                    </a>
                </c:if>
                <c:if test="${memberGroup.member_group_idx eq 0}">
                    <a class="icon-btn green" href="" id="editGroup_add">
                        <img alt="" src="/resources/cms/img/main/plus.svg">
                        <div>그룹 신규등록</div>
                    </a>
                </c:if>
                <c:if test="${memberGroup.member_group_idx > 0 and memberGroup.default_group_yn ne 'Y'}">
                    <a class="icon-btn gray" href="" id="editGroup_modify">수정</a>
                    <a class="icon-btn red" href="" id="editGroup_delete">
                        <img alt="" src="/resources/cms/img/main/delete.svg">
                        <div>삭제</div>
                    </a>
                </c:if>
            </div>
            <table class="custom-table">
                <colgroup>
                    <col width="33%"/>
                    <col width="33%"/>
                    <col width="33%"/>
                </colgroup>
                <thead>

                
                </thead>
                <tbody>
                <tr>
                    <td>${parentMemberGroup.member_group_name eq null ? (memberGroup.member_group_idx eq 0 ? '-':'CMS')
                        : parentMemberGroup.member_group_name}
                    </td>
                    <td>${memberGroup.member_group_name eq null ? 'CMS' : memberGroup.member_group_name}</td>
                    <td>${memberGroup.remark eq null ? 'CMS' : memberGroup.remark}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="table-wrap" id="table2" style="display: none;" title="그룹관계설정">
            <div class="btn-wrapper left">
                <a class="icon-btn navy" href="#" id="saveAuthority" style="display: none">
                    <img alt="" src="/resources/cms/img/main/save.svg">
                    <div>저장</div>
                </a>
            </div>
            <div class="table-scroll">
                <table class="custom-table">
                    <colgroup>
                        <col width="25%"/>
                        <col width="75%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 4px">
                                <input type="checkbox">
                                <label class="btn-wrapper">그룹명</label>
                            </div>
                        </th>
                        <th>설명</th>
                    </tr>
                    </thead>
                    <tbody id="authGroupList">
                    <c:if test="${fn:length(memberGroupList) < 1}">
                        <tr>
                            <td>데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${memberGroupList}" var="i" varStatus="status">
                        <c:set value="${i.member_group_idx eq memberGroup.member_group_idx }" var="_self"></c:set>
                        <c:if test="${i.member_group_idx eq memberGroup.member_group_idx }">
                            <c:set value="${i.member_group_depth}" var="_myLevel"></c:set>
                        </c:if>
                    </c:forEach>
                    <c:forEach begin="1" items="${memberGroupList}" var="i" varStatus="status">
                        <tr class="table-left" data-level="${i.member_group_depth}"
                            data-parentGroupIdx="${i.parent_member_group_idx}">
                            <c:set value="${i.parent_member_group_idx eq 0 ? 'th' : 'td'}" var="isSite"></c:set>
                            <${isSite}>
                            <span class="center" style="padding-left: ${(i.member_group_depth-1)*15}px;">
                                        <c:choose>
                                            <c:when test="${!(i.parent_member_group_idx < 0 or _self or status.first or (status.count == 2) or (i.member_group_depth <= _myLevel))}">
                                                <form:checkbox
                                                        cssStyle="margin-right:5px;"
                                                        data-level="${i.member_group_depth}"
                                                        data-parentGroupIdx="${i.parent_member_group_idx}"
                                                        label="${i.member_group_name}"
                                                        path="relationList"
                                                        value="${i.member_group_idx}"/>
                                            </c:when>

                                            <c:otherwise>
                                                <span style="padding-left: 15px;">${i.member_group_name}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                        </
                        ${isSite}>
                        <${isSite}>${i.remark}
                    </
                    ${isSite}>
                    <${isSite}>
                    <c:if test="${isSite eq 'td'}"></c:if>
                    </
                    ${isSite}>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </form:form>
</div>

<div class="dialog-common" id="dialog-1" title="권한그룹"></div>