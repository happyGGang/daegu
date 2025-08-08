<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
    $(function () {
        //달력(통계 기간 선택 오류 방지)
        $('input#dateStart').datepicker({
            maxDate: $('input#dateEnd').val(),
            onClose: function (selectedDate) {
                $('input#dateEnd').datepicker('option', 'minDate', selectedDate);
            }
        });
        $('input#dateEnd').datepicker({
            minDate: $('input#dateStart').val(),
            onClose: function (selectedDate) {
                $('input#dateStart').datepicker('option', 'maxDate', selectedDate);
            }
        });

        function initGraph() {
            //그래프 관련 (x축 값의 개수에 맞게 width값 자동 계산, 마우스 오버 시 addClass)
            $('.graph').each(function () {
                var gN = $(this).children('li').length;
                var gW = 100 / gN;
                $(this).children('li').each(function (e) {
                    $(this).css('width', gW + '%');
                    $(this).on('mouseover', function () {
                        $(this).addClass('on');
                    });
                    $(this).on('mouseleave', function () {
                        $(this).removeClass('on');
                    });
                });

                //가장 큰 수 addClass most
                var gaugeH = $(this).find('.gauge').map(function () {
                        return $(this).height();
                    }).get(),
                    maxH = Math.max.apply(null, gaugeH);
                $(this).addClass('a' + maxH);
                $(this).find('.gauge').each(function () {
                    var thisH = $(this).height();
                    if (thisH == maxH) {
                        $(this).addClass('most');
                    }
                });
            });
        }

        $('#searchBtn').on('click', function (e) {
            if ($('#homepageId').val()) {
                $('table#accessTableData').load('menuAccessTable.do?homepage_id=' + $('#homepageId').val() + '&start_date=' + $('#dateStart').val() + '&end_date=' + $('#dateEnd').val() + '&date_type=' + $('#dateType').val() + '&search_type=' + $('#searchType').val(), function (response, status, xhr) {
                });
            }
            e.preventDefault();
        });

        $('a#excelDownload').on('click', function (e) {
            if ($('#homepageId').val()) {
                $('#homepageName').val($('#homepageId option:selected').text());
                $('#menuAccessSearch').attr('action', '/cms/menuAccess/excelDownload.do');
                $('#menuAccessSearch').submit();
            }
            e.preventDefault();
        });

        $('a#csvDownload').on('click', function (e) {
            if ($('#homepageId').val()) {
                $('#homepageName').val($('#homepageId option:selected').text());
                $('#menuAccessSearch').attr('action', '/cms/menuAccess/csvDownload.do');
                $('#menuAccessSearch').submit();
            }
            e.preventDefault();
        });

    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>메뉴 접속사</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form id="menuAccessSearch" modelAttribute="menuAccess" action="/cms/menuAccess/excelDownload.do" method="post" cssClass="btn-wrapper">
                <form:hidden id="homepageName" path="homepage_name"/>

                <div class="btn-wrapper">
                    <c:choose>
                        <c:when test="${member.admin}">
                            <form:select id="homepageId" path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                                <option disabled selected="selected">홈페이지 선택</option>
                                <c:forEach var="i" varStatus="status" items="${homepageList}">
                                    <option value="${i.homepage_id}">${i.homepage_name}</option>
                                </c:forEach>
                            </form:select>
                        </c:when>
                        <c:otherwise>
                            <form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
                        </c:otherwise>
                    </c:choose>


                    <form:input type="text" id="dateStart" path="start_date" class="custom-date ui-calendar"/>
                    <p id="tilde" class="caption">~</p>
                    <form:input type="text" id="dateEnd" path="end_date" class="custom-date ui-calendar"/>

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
                </div>
            </form:form>
        </div>

        <br/>
        <table id="accessTableData" class="chartData custom-table">
            <thead>
                <tr>
                    <th width="200">메뉴명</th>
                    <th colspan="2">접속자 수</th>
                    <th colspan="2">백분율</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>합계</th>
                    <td colspan="2"><em></em></td>
                    <td colspan="2"><em></em></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>