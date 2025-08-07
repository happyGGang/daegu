<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function () {
        <%--검색--%>
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#member_index').serialize());
        });

        <%--사용자삭제--%>
        $('a.delete').on('click', function (e) {
            e.preventDefault();
            if (confirm('해당 사용자(' + $(this).attr('keyValue') + ')의 계정 잠금을 해제하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#member_id_index').val($(this).attr('keyValue'));
                if (doAjaxPost($('#member_index'))) {
                    location.reload();
                }
            }
        });

        <%--10개씩보기--%>
        $('select#rowCount').change(function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#member_index').serialize());
        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>계정잠금 관리</div>
    </div>

    <div class="main-content">
        <form:form id="member_index" modelAttribute="member" action="save.do" method="post" onsubmit="return false;" cssStyle="width: 100%">
            <div class="table-action-wrapper">
                <p class="total-count">총 ${accountLockCount}건</p>
                <form:select path="rowCount" class="custom-filter" style="width:150px;">
                    <form:option value="10">10개씩 보기</form:option>
                    <form:option value="20">20개씩 보기</form:option>
                    <form:option value="30">30개씩 보기</form:option>
                    <form:option value="50">50개씩 보기</form:option>
                    <form:option value="${accountLockCount}">전체 보기</form:option>
                </form:select>
            </div>

            <form:hidden id="member_id_index" path="member_id"/>
            <form:hidden id="editMode_index" path="editMode"/>
            <form:hidden path="search_auth"/>
            <form:hidden path="search_auth_name"/>

            <table class="custom-table">
                <thead>
                <tr>
                    <th>순번</th>
                    <th>로그인 타입</th>
                    <th>사용자ID</th>
                    <th>실패 횟수</th>
                    <th>일시</th>
                    <th>IP</th>
                    <th>기능</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(accountLockList) < 1}">
                    <tr>
                        <td colspan="7">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" varStatus="status" items="${accountLockList}">
                    <tr>
                        <td>${paging.listRowNum - status.index}</td>
                        <td>${i.login_type}</td>
                        <td>${i.member_id}</td>
                        <td>${i.count}</td>
                        <td>${i.last_fail_date}</td>
                        <td>${i.last_fail_ip}</td>
                        <td>
                            <a href="#" class="cutom-btn delete" keyValue="${i.member_id}">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                <jsp:param name="formId" value="#member_index"/>
                <jsp:param name="pagingUrl" value="index.do"/>
            </jsp:include>

            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="MEMBER_ID">사용자ID</form:option>
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

