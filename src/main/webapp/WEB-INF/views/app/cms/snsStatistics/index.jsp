<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
    $(function () {
        $('input#startDate').datepicker({
            dateFormat: 'yymmdd',
            maxDate: $('input#endDate').val(),
            onClose: function (selectedDate) {
                $('input#endDate').datepicker('option', 'minDate', selectedDate);
            }
        }).datepicker("setDate", '${snsStatistics.startDate}');
        $('input#endDate').datepicker({
            dateFormat: 'yymmdd',
            minDate: $('input#startDate').val(),
            onClose: function (selectedDate) {
                $('input#startDate').datepicker('option', 'maxDate', selectedDate);
            }
        }).datepicker("setDate", '${snsStatistics.endDate}');

        $('input#startDate').datepicker("option", "dateFormat", 'yymmdd');
        $('input#endDate').datepicker("option", "dateFormat", 'yymmdd');

        $('a#excelDownload').on('click', function (e) {
            if ($('#homepage_id').val()) {
                $('#search').attr('action', 'excelDownload.do').submit();
                $('#search').attr('action', 'index.do')
            }
            e.preventDefault();
        });

        $('a#csvDownload').on('click', function (e) {
            if ($('#homepage_id').val()) {
                $('#search').attr('action', 'csvDownload.do').submit();
                $('#search').attr('action', 'index.do')
            }
            e.preventDefault();
        });

    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>SNS 공유 통계</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form id="search" modelAttribute="snsStatistics" action="/cms/snsStatistics/index.do" cssClass="btn-wrapper">
                <c:choose>
                    <c:when test="${member.admin}">
                        <form:select path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                            <option disabled>홈페이지 선택</option>
                            <c:forEach var="i" varStatus="status" items="${homepageList}">
                                <option value="${i.homepage_id}"
                                        <c:if test="${snsStatistics.homepage_id eq i.homepage_id}">selected="selected"</c:if>>${i.homepage_name}</option>
                            </c:forEach>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden path="homepage_id"/>
                    </c:otherwise>
                </c:choose>

                <form:input type="text" path="startDate" class="custom-date ui-calendar"/>
                <p id="tilde" class="total-count">~</p>
                <form:input type="text" path="endDate" class="custom-date ui-calendar"/>

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

        <table id="resultTableData" class="chartData custom-table">
            <thead>
                <tr>
                    <th width="400">메뉴명</th>
                    <th>트위터</th>
                    <th>페이스북</th>
                    <th>카카오스토리</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalTwitter" value="0"/>
                <c:set var="totalFacebook" value="0"/>
                <c:set var="totalKakaostory" value="0"/>
                <c:forEach items="${statisticsList}" var="i">
                    <c:set var="totalTwitter" value="${totalTwitter + i.twitter}"/>
                    <c:set var="totalFacebook" value="${totalFacebook + i.facebook}"/>
                    <c:set var="totalKakaostory" value="${totalKakaostory + i.kakaostory}"/>
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${i.menu_level eq 2}">&nbsp; &nbsp; &nbsp; &nbsp;</c:when>
                                <c:when test="${i.menu_level eq 3}">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</c:when>
                                <c:when test="${i.menu_level eq 4}">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</c:when>
                                <c:when test="${i.menu_level eq 5}">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</c:when>
                            </c:choose>
                                ${i.menu_name}
                        </td>
                        <td>${i.twitter}</td>
                        <td>${i.facebook}</td>
                        <td>${i.kakaostory}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td colspan="3" class="center">전체 트위터 수 : ${totalTwitter}, 전체 페이스북 수 : ${totalFacebook}, 전체 카카오스토리 수
                        : ${totalKakaostory}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>