<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function(){
        <%--검색--%>
        $('button#search_btn').on('click', function(e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#member_index').serialize());
        });

        <%--사용자등록--%>
        $('a#dialog-add').on('click', function(e) {
            e.preventDefault();
            $('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
                $('#dialog-1').dialog('open');
            });
        });

        <%--사용자수정--%>
        $('a.dialog-modify').on('click', function(e) {
            e.preventDefault();
            $('#dialog-1').load('edit.do?editMode=MODIFY&member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
                $('#dialog-1').dialog('open');
            });
        });

        <%--사용자삭제--%>
        $('a.delete').on('click', function(e) {
            e.preventDefault();
            if(confirm('해당 사용자(' + $(this).attr('keyValue') + ')를 정보를 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#member_id_index').val($(this).attr('keyValue'));
                if(doAjaxPost($('#member_index'))) {
                    location.reload();
                }
            }
        });

        <%--그룹설정--%>
        $('a.grouping').on('click', function(e) {
            e.preventDefault();
            $('#dialog-3').load('grouping_ajax.do?member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
                $('#dialog-3').dialog('open');
            });
        });

        <%--10개씩보기--%>
        $('select#rowCount').change(function(e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#member_index').serialize());
        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>사용자 관리</div>
    </div>
    <div class="main-content">
        <form:form id="member_index" modelAttribute="member" action="save.do" method="post" onsubmit="return false;" style="width:100%;">
            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 ${memberListCount}건</p>
                    <form:select path="rowCount" class="custom-filter" style="width:130px;">
                        <form:option value="10">10개씩 보기</form:option>
                        <form:option value="20">20개씩 보기</form:option>
                        <form:option value="30">30개씩 보기</form:option>
                        <form:option value="50">50개씩 보기</form:option>
                        <form:option value="100">100개씩 보기</form:option>
                        <form:option value="${memberListCount}">전체 보기</form:option>
                    </form:select>
                </div>

                <a href="" class="icon-btn navy" id="dialog-add" >
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>사용자 등록</div>
                </a>
            </div>

            <form:hidden id="member_id_index" path="member_id"/>
            <form:hidden id="editMode_index" path="editMode"/>
            <form:hidden path="search_auth"/>
            <form:hidden path="search_auth_name"/>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th width="5%">순번</th>
                        <th>사용자 ID</th>
                        <th>사용자명</th>
                        <th>전화번호</th>
                        <th>사용자 타입</th>
                        <th>등록일자</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${fn:length(memberList) < 1}">
                        <tr>
                            <td colspan="7">데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="i" varStatus="status" items="${memberList}">
                        <tr>
                            <td>${paging.listRowNum - status.index}</td>
                            <td>${i.member_id}</td>
                            <td>${i.member_name}</td>
                            <td>${i.phone}</td>

                            <td>${i.link_member_yn eq 'Y' ? 'LAS 연결회원':''}</td>
                            <td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/> </td>
                            <td>
                                <a href="#" class="custom-btn dialog-modify" id="dialog-modify-${i.member_id}" keyValue="${i.member_id}">수정</a>
                                <a href="#" class="custom-btn delete" keyValue="${i.member_id}">삭제</a>
                                <a href="#" class="custom-btn sky grouping" keyValue="${i.member_id}">그룹설정</a>
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
                        <form:option value="MEMBER_NAME">사용자명</form:option>
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

<div id="dialog-1" class="dialog-common" title="사용자 정보"></div>
<div id="dialog-2" class="dialog-common" title=""></div>
<div id="dialog-3" class="dialog-common" title="그룹설정"></div>