<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('a#excelDownload').on('click', function (e) {
            e.preventDefault();
            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }
            $('#homepageName').val($('#homepageId option:selected').text());
            $('#boardFileAccessSearch').attr('action', 'excelDownload.do');
            $('#boardFileAccessSearch').submit();
            $('#boardFileAccessSearch').attr('action', 'index.do');
        });

        $('a#csvDownload').on('click', function (e) {
            e.preventDefault();
            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }
            $('#homepageName').val($('#homepageId option:selected').text());
            $('#boardFileAccessSearch').attr('action', 'csvDownload.do');
            $('#boardFileAccessSearch').submit();
            $('#boardFileAccessSearch').attr('action', 'index.do');
        });

        $('button#searchBtn').on('click', function (e) {

            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }

            doGetLoad('index.do', $('form#boardFileAccessSearch').serialize());
        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>게시판 (첨부파일)통계</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form id="boardFileAccessSearch" modelAttribute="boardFileAccess" action="index.do" method="post" onclick="return false;" cssClass="btn-wrapper">
                <form:hidden id="homepageName" path="homepage_name"/>

                <c:choose>
                    <c:when test="${member.admin}">
                        <form:select id="homepageId" path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                            <option disabled selected="selected">홈페이지 선택</option>
                            <c:forEach var="i" varStatus="status" items="${homepageList}">
                                <option value="${i.homepage_id}"
                                        <c:if test="${i.homepage_id eq boardFileAccess.homepage_id }">selected="selected"</c:if>>${i.homepage_name}</option>
                            </c:forEach>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden id="homepageId" path="homepage_id" value="${boardFileAccess.homepage_id}"/>
                    </c:otherwise>
                </c:choose>

                <div id="searchBtn" class="icon-btn black">
                    <img src="/resources/cms/img/main/search.svg" alt="">
                    <div>검색</div>
                </div>
                <a href="#" id="excelDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/excel.svg" alt="">
                    <div>엑셀저장</div>
                </a>
                <a href="#" id="csvDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/csv.svg" alt="">
                    <div>CSV저장</div>
                </a>
            </form:form>
        </div>

        <br>
        <div class="tree-area-title">
            <img alt="" src="/resources/cms/img/main/tag.png">
            <div>게시판 첨부파일 현황</div>
        </div>
        <table id="accessTableData" class="chartData custom-table">
            <thead>
            <tr>
                <th width="50%;">메뉴명</th>
                <th>다운 수</th>
                <th>백분율</th>
            </tr>
            </thead>
            <c:forEach var="i" varStatus="status" items="${boardList}">
                <c:if test="${status.first}">
                    <c:set var="total_count" value="${i.count }"/>
                </c:if>
                <c:if test="${!status.first}">
                    <tr>
                        <td>${i.board_name}</td>
                        <td>${i.count}</td>
                        <td>
                            <c:if test="${i.count == 0}">
                                0
                            </c:if>
                            <c:if test="${i.count != 0}">
                                <fmt:formatNumber value="${i.count / total_count * 100}" pattern="0.00"/>
                            </c:if>
                            %
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            <tr>
                <th>합계</th>
                <td><em>${total_count}</em></td>
                <td>
                    <em>
                        <c:if test="${total_count == 0}">
                            0
                        </c:if>
                        <c:if test="${total_count != 0}">
                            100
                        </c:if>
                        %
                    </em>
                </td>
            </tr>
        </table>

    </div>
</div>
