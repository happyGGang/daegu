<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
    $(function () {
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            $('#newsListForm').submit();
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
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&news_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#delete-btn').on('click', function (e) {
            if (confirm('해당 뉴스를 삭제 하시겠습니까?')) {
                $('form#hiddenForm input#news_idx').val($(this).attr('keyValue'));

                $.ajax({
                    url: 'delete.do',
                    async: false,
                    data: serializeObject($('#hiddenForm')),
                    method: 'POST',
                    success: function (data) {
                        if (data.valid) {
                            alert(data.message);
                            location.reload();
                        } else {
                            if (data.message != null) {
                                alert(data.message);
                            } else {
                                alert(data.result);
                            }
                        }
                    }
                });
            }

            e.preventDefault();
        });

        $('select#homepage_id_1').on('change', function (e) {
            if ($(this).val() != '') {
                $('input#homepage_id_1').val($(this).val());
                $('#newsListForm').submit();
            }

            e.preventDefault();
        });

        $('select#use_yn, select#rowCount').on('change', function (e) {
            $('#viewPage').val(1);
            $('#newsListForm').submit();
        });
    });
</script>
<div class="container-box">
    <form:form id="hiddenForm" modelAttribute="news" action="save.do">
        <form:hidden path="editMode" value="DELETE"/>
        <form:hidden path="homepage_id"/>
        <form:hidden path="news_idx"/>
    </form:form>

    <div class="page-header">
        <div>배너 관리</div>
    </div>
    <div class="main-content" style="flex-direction: column">
        <form:form id="newsListForm" modelAttribute="news" action="index.do">
            <form:hidden id="homepage_id_1" path="homepage_id"/>

            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 ${newsListCount}건, 홈페이지 ID : ${news.homepage_id}</p>
                    <div class="btn-wrapper">
                        <form:select path="use_yn" class="custom-filter">
                            <option value="">사용여부선택</option>
                            <form:option value="Y">사용함</form:option>
                            <form:option value="N">사용안함</form:option>
                        </form:select>
                        <form:select path="rowCount" class="custom-filter" style="width:120px;">
                            <form:option value="10">10개씩 보기</form:option>
                            <form:option value="20">20개씩 보기</form:option>
                            <form:option value="30">30개씩 보기</form:option>
                            <form:option value="100">100개씩 보기</form:option>
                            <form:option value="200">200개씩 보기</form:option>
                        </form:select>
                    </div>
                </div>

                <c:if test="${authC}">
                    <a href="" class="icon-btn navy" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>뉴스 등록</div>
                    </a>
                </c:if>
            </div>
            <table class="custom-table">
                <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>소제목</th>
                    <th>내용</th>
                    <th>등록일</th>
                    <th>사용여부</th>
                    <th>출력순서</th>
                    <th>기능</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="i" varStatus="status" items="${newsList}">
                    <tr>
                        <td>${news.listRowNum - status.index}</td>
                        <td>${i.news_name}</td>
                        <td>${i.sub_news_name}</td>
                        <td>${i.contents}</td>
                        <td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
                        <td>${i.use_yn eq 'Y' ? '사용함' : '사용안함'}</td>
                        <td>${i.print_seq}</td>
                        <td>
                            <c:if test="${authU}">
                                <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.news_idx}">수정</a>
                            </c:if>
                            <c:if test="${authD}">
                                <a href="" class="custom-btn" id="delete-btn" keyValue="${i.news_idx}">삭제</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${newsListCount eq 0}">
                    <tr>
                        <td colspan="8">조회된 자료가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                <jsp:param name="formId" value="#newsListForm"/>
            </jsp:include>

            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="news_name">타이틀</form:option>
                        <form:option value="sub_news_name">소제목</form:option>
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


<div id="dialog-1" class="dialog-common" title="뉴스 정보"></div>