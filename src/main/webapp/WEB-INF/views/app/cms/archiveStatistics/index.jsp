<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
    $(function () {
        var sysDate = new Date();
        var year = sysDate.getFullYear();
        var month = sysDate.getMonth() + 1;
        //년도 초기화
        for (var i = 2016; i <= year; i++) {
            var selectedAttr = '';
            if (i == year) {
                selectedAttr = 'selected="selected"';
            }

            $('select#year').append('<option ' + selectedAttr + ' value="' + i + '">' + i + '년</option>');
        }
        // 월 초기화
        for (var j = 1; j < 13; j++) {
            var valueMonth = j < 10 ? '0' + j : j;
            var selectedAttr = '';
            if (j == month) {
                selectedAttr = 'selected="selected"';
            }

            $('select#month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
        }

        $('input#search_date').datepicker();

        $('#searchBtn').on('click', function (e) {
            e.preventDefault();
            $('div#accessTable').load('accessTable.do?' + serializeCustom($('#archiveStatistics')), function (response, status, xhr) {
            });
        });


        $('select#year, select#month').hide();
        $('select#year, select#month').attr('disabled', true);
        $('select#date_type').on('change', function () {
            var type = $(this).val();
            if (type == 'TIME') {
                $('input#search_date').show();
                $('input#search_date').removeAttr('disabled');

                $('select#year, select#month').hide();
                $('select#year, select#month').attr('disabled', true);
            } else if (type == 'DAY' || type == 'WEEK') {
                $('select#year, select#month').show();
                $('select#year, select#month').removeAttr('disabled');

                $('input#search_date').hide();
                $('input#search_date').attr('disabled', true);
            } else if (type == 'MONTH') {
                $('select#year').show();
                $('select#year').removeAttr('disabled');

                $('select#month').hide();
                $('select#month').attr('disabled', true);
                $('input#search_date').hide();
                $('input#search_date').attr('disabled', true);
            }
        });

    });
</script>
<div class="container-box">
    <div class="page-header">
        <div>원분 DB 통계</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form modelAttribute="archiveStatistics" action="/cms/archiveStatistics/index.do" method="post" cssClass="btn-wrapper">
                <form:hidden path="homepage_id"/>
                <c:choose>
                    <c:when test="${member.admin}">
                        <form:select path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                            <option disabled>홈페이지 선택</option>
                            <option value="ALL" selected="selected">전체</option>
                            <c:forEach var="i" varStatus="status" items="${homepageList}">
                                <option value="${i.homepage_id}">${i.homepage_name}</option>
                            </c:forEach>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
                    </c:otherwise>
                </c:choose>
                <form:select path="date_type" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                    <option disabled>날짜 분류 선택</option>
                    <option value="TIME">시간별</option>
                    <option value="DAY">일별</option>
                    <option value="WEEK">요일별</option>
                    <option value="MONTH">월별</option>
                </form:select>
                <div class="btn-wrapper">
                    <form:input type="text" path="search_date" class="custom-date ui-calendar"/>
                    <form:select class="custom-seleect" style="width:200px; padding: 10px 43px 10px 12px;" path="month"></form:select>
                </div>
                <div id="searchBtn" class="icon-btn black">
                    <img src="/resources/cms/img/main/search.svg" alt="">
                    <div>검색</div>
                </div>
            </form:form>
        </div>

        <div id="accessTable"></div>
    </div>
</div>