<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
    $(function () {
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            $('#categoryLayer').load('category.do', serializeCustom($('#categoryListForm')));
        });


        $('a.dialog-add').on('click', function (e) {
            if ($('#homepage_id_1').val() == '') {
                alert('홈페이지정보가 없습니다.');
                return false;
            }
            if ($('#categoryListForm #group_idx').val() == 0) {
                alert('중분류을 선택해주세요.');
                return false;
            } else {
                $('#dialog-2').load('edit.do?editMode=ADD&' + serializeCustom($('#categoryListForm')), function (response, status, xhr) {
                    $('#dialog-2').dialog('open');
                });
            }

            e.preventDefault();
        });
        $('a.dialog-modify').on('click', function (e) {
            $('#dialog-2').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&group_idx=' + $(this).attr('keyValue2') + '&category_idx=' + $(this).attr('keyValue3') + '&large_category_idx=' + $('select#large_category_idx').val(), function (response, status, xhr) {
                $('#dialog-2').dialog('open');
            });

            e.preventDefault();
        });

        $('a.delete-btn').on('click', function (e) {
            e.preventDefault();
            if (confirm('해당 소분류를 삭제 하시겠습니까?')) {
                $('#hiddenCategoryForm #homepage_id').val($(this).attr('keyValue1'));
                $('#hiddenCategoryForm #group_idx').val($(this).attr('keyValue2'));
                $('#hiddenCategoryForm #category_idx').val($(this).attr('keyValue3'));
                if (doAjaxPost($('#hiddenCategoryForm'))) {
                    $('a.group_' + $(this).attr('keyValue2')).click();
                }
            }
        });

        $('select#teach_type').on('change', function () {
            doGetLoad('index.do', $('form#categoryListForm').serialize());
        });
    });
</script>

<c:if test="${auth.editMode eq 'FIRST'}">
    <div class="mask"></div>
</c:if>
<form:form action="save.do" id="hiddenCategoryForm" modelAttribute="category">
    <form:hidden path="editMode" value="DELETE"/>
    <form:hidden path="homepage_id"/>
    <form:hidden path="large_category_idx"/>
    <form:hidden path="group_idx"/>
    <form:hidden path="category_idx"/>
</form:form>
<form:form action="category.do" id="categoryListForm" modelAttribute="category" onsubmit="return false;">
    <form:hidden path="large_category_idx"/>
    <form:hidden path="group_idx"/>
    <form:hidden path="homepage_id"/>
    <div class="tree-area-title">
        <img alt="" src="/resources/cms/img/main/tag.png">
        <div>소분류정보
            <c:if test="${not empty categoryGroupOne}"> (${categoryGroupOne.group_name})</c:if>
        </div>
    </div>
    <div class="table-action-wrapper" >
            <p class="total-count">총 ${categoryListCount}건</p>
            <c:if test="${authC}">
                <a class="icon-btn navy" href="" id="dialog-add">
                    <img alt="" src="/resources/cms/img/main/plus.svg">
                    <div>등록</div>
                </a>
            </c:if>
    </div>
    <!-- 교육소식 관리 table -->
    <table class="custom-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>소분류명</th>
            <th>신청제한단위</th>
            <th>신청제한수</th>
            <th>기능</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${categoryList}" var="i" varStatus="status">
            <tr>
                <td>${category.listRowNum - status.index}</td>
                <td>${i.category_name}</td>
                <td>
                    <c:if test="${i.req_limit_yn eq 'Y'}">
                        <c:choose>
                            <c:when test="${i.req_limit_type eq '1'}">
                                1년
                            </c:when>
                            <c:when test="${i.req_limit_type eq '6'}">
                                6개월
                            </c:when>
                            <c:when test="${i.req_limit_type eq '3'}">
                                3개월
                            </c:when>
                        </c:choose>
                    </c:if>
                </td>
                <td>${i.req_limit_count}</td>
                <%--
                <td>${i.print_seq}</td>
                --%>
                <%--
                <td>${i.use_yn}</td>
                --%>
                <td>
                    <c:if test="${authU}">
                        <a class="btn dialog-modify" href="" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"
                           keyValue3="${i.category_idx}">수정</a>
                    </c:if>
                    <c:if test="${authD}">
                        <a class="btn delete-btn" href="" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"
                           keyValue3="${i.category_idx}">삭제</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${categoryListCount eq 0}">
            <tr>
                <td colspan="5">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <jsp:include flush="false" page="/WEB-INF/views/app/cms/common/paging_ajax.jsp">
        <jsp:param name="formId" value="#categoryListForm"/>
        <jsp:param name="layerId" value="#categoryLayer"/>
        <jsp:param name="pagingUrl" value="category.do"/>
    </jsp:include>
    <div class="table-search-bar">
        <fieldset class="search-bar">
            <form:select path="search_type" cssClass="custom-filter">
                <form:option value="CATEGORY_NAME">소분류명</form:option>
                <form:option value="USE_YN">사용여부</form:option>
            </form:select>
            <form:input path="search_text" cssClass="custom-search"/>
            <div id="search_btn" class="icon-btn black">
                <img alt="" src="/resources/cms/img/main/search.svg">
                <div>검색</div>
            </div>
        </fieldset>
    </div>
</form:form>

<div class="dialog-common" id="dialog-2" title="소분류 정보"></div>