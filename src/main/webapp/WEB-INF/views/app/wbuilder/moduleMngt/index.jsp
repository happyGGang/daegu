<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            $('#moduleMngtListForm').submit();
        });

        $('a#dialog-add').on('click', function (e) {
            var module_type = $('select#module_type option:selected').val();
            $('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&module_type=' + module_type, function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });
        $('a.dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&module_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a.delete-btn').on('click', function (e) {
            if (confirm('해당 모듈을 삭제 하시겠습니까?')) {
                $('#hiddenForm #module_idx').val($(this).attr('keyValue'));
                if (doAjaxPost($('#hiddenForm'))) {
                    location.reload();
                }
            }
            e.preventDefault();
        });

        $('a.dialog-terms').on('click', function (e) {
            e.preventDefault();
            $('#dialog-2').load('moduleTerms.do?module_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-2').dialog('open');
            });
        });

        $('a.dialog-auth').on('click', function (e) {
            e.preventDefault();
            $('#dialog-3').load('editAuth.do?module_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-3').dialog('open');
            });
        });

        $('select#rowCount, select#module_type').change(function (e) {
            $('#viewPage').val(1);
            $('#moduleMngtListForm').submit();
        });

    });
</script>
<form:form action="save.do" id="hiddenForm" modelAttribute="moduleMngt">
    <form:hidden path="editMode" value="DELETE"/>
    <form:hidden path="module_idx"/>
</form:form>

<div class="container-box">
    <div class="page-header">
        <div>모듈관리</div>
    </div>
    <div class="main-content">
        <form:form action="index.do" id="moduleMngtListForm" modelAttribute="moduleMngt" style="width:100%;">
            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 ${moduleMngtListCount}건</p>
                    <form:select path="rowCount" class="custom-filter" style="width:130px;">
                        <form:option value="10">10개씩 보기</form:option>
                        <form:option value="20">20개씩 보기</form:option>
                        <form:option value="30">30개씩 보기</form:option>
                        <form:option value="${moduleMngtListCount}">전체 보기</form:option>
                    </form:select>

                    <p class="total-count" style="margin-right: 6px">구분</p>
                    <form:select class="custom-filter" path="module_type">
                        <form:option value="CMS" label="CMS"/>
                        <form:option value="SITE" label="SITE"/>
                    </form:select>
                </div>

                <c:if test="${authC}">
                    <a class="icon-btn navy" href="#" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>등록</div>
                    </a>
                </c:if>
            </div>


            <table class="custom-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>구분</th>
                        <th>모듈명</th>
                        <th>모듈설명</th>
                        <th>링크URL</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${moduleMngtList}" var="i" varStatus="status">
                    <tr>
                        <td>${paging.listRowNum - status.index}</td>
                        <td>${i.module_type}</td>
                        <td>${i.module_name}</td>
                        <td>${i.remark}</td>
                        <td>${i.link_url}</td>
                        <td>
                            <c:if test="${moduleMngt.module_type eq 'SITE'}">
                                <%-- <a class="custom-btn dialog-terms" href="" keyValue="${i.module_idx}">약관등록</a> --%>
                            </c:if>
                            <%-- <a class="custom-btn dialog-auth" href="" keyValue="${i.module_idx}">권한설정</a> --%>
                            <c:if test="${authU}">
                                <a class="custom-btn dialog-modify" href="" keyValue="${i.module_idx}">수정</a>
                            </c:if>
                            <c:if test="${authD}">
                                <a class="custom-btn delete-btn" href="" keyValue="${i.module_idx}">삭제</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${moduleMngtListCount eq 0}">
                    <tr>
                        <td colspan="6">조회된 자료가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <jsp:include flush="false" page="/WEB-INF/views/app/cms/common/paging.jsp">
                <jsp:param name="formId" value="#moduleMngtListForm"/>
            </jsp:include>

            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="MODULE_NAME">모듈명</form:option>
                    </form:select>
                    <form:input path="search_text" cssClass="custom-search"/>
                    <div id="search_btn" class="icon-btn black">
                        <img alt="" src="/resources/cms/img/main/search.svg">
                        <div>검색</div>
                    </div>
                </fieldset>
            </div>
        </form:form>
    </div>
</div>


<div class="dialog-common" id="dialog-1" title="모듈 정보"></div>
<div class="dialog-common" id="dialog-2" title="모듈 약관 리스트"></div>
<div class="dialog-common" id="dialog-3" title="모듈 권한정보"></div>