<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
    $(function () {
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            $('#siteListForm').submit();
        });


        $('a#dialog-add').on('click', function (e) {
            if ($('#homepage_id_1').val() == '') {
                alert('홈페이지정보가 없습니다.');
            } else {
                $('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function (response, status, xhr) {
                    $('#dialog-1').dialog('open');
                });
            }

            e.preventDefault();
        });
        $('a#dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&recommend_site_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#delete-btn').on('click', function (e) {
            if (confirm('해당 추천사이트를 삭제 하시겠습니까?')) {
                $('#hiddenForm #recommend_site_idx').val($(this).attr('keyValue'));
                if (doAjaxPost($('#hiddenForm'))) {
                    location.reload();
                }
            }
            e.preventDefault();
        });

        $('select#homepage_id_1').on('change', function (e) {
            if ($(this).val() != '') {
                $('input#homepage_id_1').val($(this).val());
                $('#siteListForm').submit();
            }

            e.preventDefault();
        });

        $('select#rowCount').on('change', function (e) {
            $('#viewPage').val(1);
            $('#siteListForm').submit();
        });
    });
</script>

<div class="container-box">
    <form:form id="hiddenForm" modelAttribute="recommendSite" action="save.do">
        <form:hidden path="editMode" value="DELETE"/>
        <form:hidden path="homepage_id"/>
        <form:hidden path="recommend_site_idx"/>
    </form:form>

    <div class="page-header">
        <div>추천사이트 관리</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <form:form id="siteListForm" modelAttribute="recommendSite" action="index.do">
            <form:hidden id="homepage_id_1" path="homepage_id"/>
            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 ${siteListCount}건</p>
                    <form:select path="rowCount" class="custom-filter" style="width:120px;">
                        <form:option value="10">10개씩 보기</form:option>
                        <form:option value="20">20개씩 보기</form:option>
                        <form:option value="30">30개씩 보기</form:option>
                        <form:option value="100">100개씩 보기</form:option>
                        <form:option value="200">200개씩 보기</form:option>
                    </form:select>
                </div>

                <c:if test="${authC}">
                    <a href="" class="icon-btn navy" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>등록</div>
                    </a>
                </c:if>
            </div>
            <!-- 교육소식 관리 table -->
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>사이트명</th>
                        <th>사이트설명</th>
                        <th>링크</th>
                        <th>출력순서</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" varStatus="status" items="${siteList}">
                    <tr>
                        <td>${recommendSite.listRowNum - status.index}</td>
                        <td>${i.recommend_site_name}</td>
                        <td>${i.recommend_site_desc}</td>
                        <td>${i.link_target}</td>
                        <td>${i.print_seq}</td>
                        <td>
                            <c:if test="${authU}">
                                <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.recommend_site_idx}">수정</a>
                            </c:if>
                            <c:if test="${authD}">
                                <a href="" class="custom-btn" id="delete-btn" keyValue="${i.recommend_site_idx}">삭제</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${siteListCount eq 0}">
                    <tr>
                        <td colspan="6">조회된 자료가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                <jsp:param name="formId" value="#siteListForm"/>
            </jsp:include>

            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="recommend_site_name">사이트명</form:option>
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

<div id="dialog-1" class="dialog-common" title="추천사이트 정보"></div>